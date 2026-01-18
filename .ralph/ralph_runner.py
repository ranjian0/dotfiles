#!/usr/bin/env python3
import os
import sys
import subprocess
import re
import json
import shlex
from typing import Optional, Tuple, List

# --- CONFIGURATION ---


class Colors:
    HEADER = "\033[95m"
    OKBLUE = "\033[94m"
    OKCYAN = "\033[96m"
    OKGREEN = "\033[92m"
    WARNING = "\033[93m"
    FAIL = "\033[91m"
    ENDC = "\033[0m"


def log(msg, type="INFO"):
    if type == "INFO":
        print(f"{Colors.OKBLUE}[INFO]{Colors.ENDC} {msg}")
    elif type == "SUCCESS":
        print(f"{Colors.OKGREEN}[SUCCESS]{Colors.ENDC} {msg}")
    elif type == "WARN":
        print(f"{Colors.WARNING}[WARN]{Colors.ENDC} {msg}")
    elif type == "ERROR":
        print(f"{Colors.FAIL}[ERROR]{Colors.ENDC} {msg}")
    elif type == "SYSTEM":
        print(f"{Colors.HEADER}[SYSTEM]{Colors.ENDC} {msg}")


# --- AGENT PROMPTS ---

AGENTS = {
    "ralph-analyst": """---
name: ralph-analyst
description: Requirements Analyst
mode: primary
tools:
  read: true
  write: true
---
You are a Senior Technical Analyst.
1. Read `ideas.txt`.
2. Identify ambiguity (database choice, auth, hosting, libraries).
3. Create `questions.md` with 10-15 hard technical questions.
4. Do not be nice; be rigorous.
5. **IMPORTANT:** You must use the `write` tool to save the file. Do not just print the questions.
""",
    "ralph-architect": """---
name: ralph-architect
description: Chief Technology Officer
mode: primary
tools:
  read: true
  write: true
---
You are a Visionary CTO.
1. Read `ideas.txt` and `questions.md`.
2. Create `specs/main.md`.
3. In this spec, answer every question definitively. Make specific tech stack choices.
4. Do not ask the user. You have authority.
**CRITICAL**: Create a `devbox.json` file that provides the development environment.
- Include ALL necessary languages (go, rust, python, node).
- Include ALL build tools (cmake, gcc, make).
- Use the devbox.json format with packages array.
Example devbox.json:
```json
{
  "packages": ["python310", "go", "rust", "nodejs", "cmake", "gcc", "make"]
}
```
""",
    "ralph-planner": """---
name: ralph-planner
description: Technical Project Manager
mode: primary
tools:
  read: true
  write: true
  bash: true
---
You are a Technical Project Manager.
1. Read `specs/main.md`.
2. Initialize the project boilerplate (git init, npm init, etc) if missing.
3. Create `IMPLEMENTATION_PLAN.md`.

CRITICAL: You must use EXACTLY this format for tasks. Every task needs a verification command.

Format:
- [ ] [ID:001] <Task Description> || VERIFY: <Command>

Example:
- [ ] [ID:001] Setup Git || VERIFY: git status
- [ ] [ID:002] Create Utils || VERIFY: test -f src/utils.js
- [ ] [ID:003] Auth Tests || VERIFY: npm test tests/auth.test.js

Make the tasks granular. Steps must be verifiable via CLI.
**NOTE**: Assume the environment defined in `devbox.json` is active.
""",
    "ralph-builder": """---
name: ralph-builder
description: Ralph Builder
mode: primary
tools:
  bash: true
  edit: true
  read: true
  write: true
  glob: true
---
You are a Senior Engineer.
1. You are assigned a specific task ID.
2. Do NOT edit `IMPLEMENTATION_PLAN.md`. The system handles that.
3. Write code in `src/` and tests in `tests/` (or equivalent).
4. Your goal is to pass the specific verification command provided in the prompt.
5. If you fail, fix the code and try again.
""",
}

# --- CORE SYSTEM ---


class RalphSystem:
    def __init__(self):
        self.plan_file = "IMPLEMENTATION_PLAN.md"
        self.feedback = ""
        log("Ralph Started!", "SYSTEM")

    def _path(self, *paths):
        return os.path.join(".", *paths)

    def ensure_config(self):
        agent_dir = self._path(".opencode")
        os.makedirs(agent_dir, exist_ok=True)
        config_path = os.path.join(agent_dir, "opencode.json")
        if not os.path.exists(config_path):
            with open(config_path, "w") as f:
                json.dump({"permission": "allow"}, f)

    def ensure_agents(self):
        agent_dir = self._path(".opencode", "agent")
        os.makedirs(agent_dir, exist_ok=True)
        for name, content in AGENTS.items():
            path = os.path.join(agent_dir, f"{name}.md")
            with open(path, "w") as f:
                f.write(content)

    def run_opencode(self, agent: str, prompt: str, force_raw: bool = False):
        """Wraps the OpenCode CLI, handling Devbox environment automatically."""

        base_cmd = ["opencode", "run", "--agent", agent, prompt]

        use_devbox = (
            os.path.exists("devbox.json")
            and not force_raw
            and agent != "ralph-architect"
        )

        if use_devbox:
            safe_prompt = shlex.quote(prompt)
            opencode_cmd = f"opencode run --agent {agent} {safe_prompt}"
            full_cmd = ["devbox", "shell", "--", "bash", "-c", opencode_cmd]

            log(f"Running in Devbox: {agent}", "INFO")
            try:
                subprocess.run(full_cmd, check=True)
            except subprocess.CalledProcessError:
                log(f"Agent {agent} crashed inside Devbox.", "ERROR")
                raise
        else:
            log(f"Running Raw (Bootstrap): {agent}", "INFO")
            try:
                subprocess.run(base_cmd, check=True)
            except subprocess.CalledProcessError:
                log(f"Agent {agent} crashed (Raw).", "ERROR")
                raise
            except FileNotFoundError:
                log("Command 'opencode' not found. Is it installed?", "ERROR")
                sys.exit(1)

    def verify_command(self, cmd: str):
        if os.path.exists("devbox.json"):
            safe_cmd = shlex.quote(cmd)
            devbox_cmd = ["devbox", "shell", "--", "bash", "-c", safe_cmd]
            return subprocess.run(devbox_cmd, capture_output=True, text=True)
        else:
            return subprocess.run(cmd, shell=True, capture_output=True, text=True)

    def phase_1_analysis(self):
        if not os.path.exists(self._path("ideas.txt")):
            log("ideas.txt not found.", "ERROR")
            sys.exit(1)

        if not os.path.exists(self._path("questions.md")):
            log("Phase 1: Analyst is reviewing ideas...", "SYSTEM")
            self.run_opencode(
                "ralph-analyst",
                "Read ideas.txt. You MUST use the 'write' tool to save 'questions.md'.",
            )
        else:
            log("Skipping Phase 1 (questions.md exists)")

    def phase_2_architect(self):
        first_run = True
        error_log = ""
        max_architect_retries = 5

        while True:
            if os.path.exists(self._path("specs", "main.md")) and os.path.exists(
                "devbox.json"
            ):
                log("Validating Devbox Environment...", "SYSTEM")

                check = subprocess.run(
                    ["devbox", "shell", "--", "echo", "ok"],
                    capture_output=True,
                    text=True,
                )

                if check.returncode == 0:
                    log("Environment Verified.", "SUCCESS")
                    break
                else:
                    log("Environment Invalid. Forcing Architect to fix.", "WARN")
                    error_log = f"Your previous `devbox.json` failed to load.\n\n ERROR: \n {check.stderr} \n\n Fix the syntax error."
                    first_run = False

            if not first_run and error_log:
                if max_architect_retries <= 0:
                    log(
                        "Max architect retries reached. Skipping environment validation.",
                        "ERROR",
                    )
                    break
                max_architect_retries -= 1

            log("Phase 2: Architect is working...", "SYSTEM")
            os.makedirs(self._path("specs"), exist_ok=True)

            prompt = "Read ideas.txt. Create specs/main.md and a valid devbox.json."
            if not first_run:
                prompt = f"FIX THE BUILD. {error_log}"

            self.run_opencode("ralph-architect", prompt, force_raw=True)
            error_log = ""
            first_run = False

    def phase_3_planning(self):
        if not os.path.exists(self._path(self.plan_file)):
            log("Phase 3: Planner is creating the roadmap...", "SYSTEM")
            self.run_opencode(
                "ralph-planner",
                "Read specs/main.md. Initialize project. Create IMPLEMENTATION_PLAN.md.",
            )
        else:
            log("Skipping Phase 3 (Plan exists)")

    def get_next_task(self) -> Optional[Tuple[str, str, str]]:
        try:
            with open(self._path(self.plan_file), "r") as f:
                content = f.read()
        except FileNotFoundError:
            return None

        pattern = r"- \[ \] \[(ID:.*?)\] (.*?) \|\| VERIFY: (.*)"
        match = re.search(pattern, content)

        if match:
            return (match.group(1), match.group(2).strip(), match.group(3).strip())

        alt_pattern = r"- \[ \]\s*(ID:\d+)\s+(.+?)\s+\|\|\s*VERIFY:\s*(.+)"
        alt_match = re.search(alt_pattern, content)

        if alt_match:
            return (
                alt_match.group(1),
                alt_match.group(2).strip(),
                alt_match.group(3).strip(),
            )

        return None

    def mark_task_done(self, task_id: str):
        plan_path = self._path(self.plan_file)
        with open(plan_path, "r") as f:
            lines = f.readlines()

        with open(plan_path, "w") as f:
            for line in lines:
                if task_id in line and "- [ ]" in line:
                    f.write(line.replace("- [ ]", "- [x]"))
                else:
                    f.write(line)

    def git_commit(self, message: str):
        subprocess.run(["git", "add", "."], check=True)
        subprocess.run(["git", "commit", "-m", message], check=True)

    def git_reset(self):
        subprocess.run(["git", "reset", "--hard"], check=True)
        subprocess.run(["git", "clean", "-fd"], check=True)

    def git_status_check(self) -> bool:
        res = subprocess.run(
            ["git", "status", "--porcelain"], capture_output=True, text=True
        )
        return bool(res.stdout.strip())

    def phase_4_execution_loop(self):
        log("Phase 4: Entering Authoritative Execution Loop", "SYSTEM")
        max_task_retries = 3

        while True:
            task = self.get_next_task()

            if not task:
                if os.path.exists(self._path(self.plan_file)):
                    log("All tasks completed! System exiting.", "SUCCESS")
                    break
                else:
                    log("Plan file missing. Planner failed.", "ERROR")
                    sys.exit(1)

            t_id, t_desc, t_verify = task
            task_retries = 0

            print("\n" + "=" * 60)
            log(f"LOCKED TARGET: {t_id}", "SYSTEM")
            log(f"TASK: {t_desc}")
            log(f"PROOF REQUIRED: {t_verify}")
            print("=" * 60 + "\n")

            while task_retries < max_task_retries:
                prompt = (
                    f"Implementing Task {t_id}: '{t_desc}'. "
                    f"Do not edit {self.plan_file}. "
                    f"Verification command that must pass: '{t_verify}'. "
                    f"{self.feedback}"
                )

                self.run_opencode("ralph-builder", prompt)

                log("System is judging work...", "SYSTEM")

                result = self.verify_command(t_verify)

                if result.returncode == 0:
                    log("Verification Passed.", "SUCCESS")

                    if self.git_status_check():
                        self.git_commit(f"Ralph: {t_id} - {t_desc}")
                    else:
                        log("No new changes (task pre-satisfied).", "INFO")

                    self.mark_task_done(t_id)
                    self.feedback = ""
                    break
                else:
                    task_retries += 1
                    log(
                        f"Verification Failed (attempt {task_retries}/{max_task_retries}).",
                        "ERROR",
                    )

                    if not self.git_status_check():
                        if task_retries >= max_task_retries:
                            log(f"Max retries reached. Skipping task {t_id}.", "ERROR")
                            self.mark_task_done(t_id)
                            self.feedback = ""
                            break
                        log("Agent made no changes. Forcing retry.", "WARN")
                        self.feedback = f"SYSTEM REJECTION: You made no file changes and the command '{t_verify}' failed. Implement the code."
                    else:
                        err_out = result.stderr if result.stderr else result.stdout
                        print(f"OUTPUT: {err_out[-500:]}")

                        if task_retries >= max_task_retries:
                            log(
                                f"Max retries reached. Reverting and skipping task.",
                                "WARN",
                            )
                            self.git_reset()
                            self.mark_task_done(t_id)
                            self.feedback = ""
                            break

                        log("Reverting changes...", "WARN")
                        self.git_reset()

                        self.feedback = (
                            f"SYSTEM REJECTION: Your code failed verification: '{t_verify}'.\n"
                            f"EXIT CODE: {result.returncode}\n"
                            f"OUTPUT LOG:\n{err_out[-1000:]}\n\n"
                            "I have reverted your changes. Try again."
                        )


if __name__ == "__main__":
    ralph = RalphSystem()
    ralph.ensure_config()
    ralph.ensure_agents()
    ralph.phase_1_analysis()
    ralph.phase_2_architect()
    ralph.phase_3_planning()
    ralph.phase_4_execution_loop()
