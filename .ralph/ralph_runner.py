#!/usr/bin/env python3
import os
import sys
import subprocess
import re
import json
from typing import Optional, Tuple

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
**CRITICAL**: Create a `flake.nix` file that provides the development environment.
- Include ALL necessary languages (go, rust, python, node).
- Include ALL build tools (cmake, gcc, make).
- Use the `nixpkgs` input.
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
**NOTE**: Assume the environment defined in `flake.nix` is active.
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
        """Wraps the OpenCode CLI, handling Nix environment automatically."""

        # Base command elements
        base_cmd = ["opencode", "run", "--agent", agent, prompt]

        # Check if we should use Nix (and if we aren't forced to avoid it)
        # We NEVER run the architect inside Nix, because they are the one fixing it.
        use_nix = (
            os.path.exists("flake.nix") and not force_raw and agent != "ralph-architect"
        )

        if use_nix:
            # We must escape the prompt because we are passing it inside a shell string
            safe_prompt = prompt.replace("'", "'\\''")

            opencode_cmd = f"opencode run --agent {agent} '{safe_prompt}'"
            full_cmd = f'nix develop --command bash -c "{opencode_cmd}"'

            log(f"Running in Nix: {agent}", "INFO")
            try:
                subprocess.run(full_cmd, shell=True, check=True)
            except subprocess.CalledProcessError:
                log(f"Agent {agent} crashed inside Nix.", "ERROR")
                raise  # Re-raise to trigger higher-level handling
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

    def verify_command(self, cmd):
        # Run verification inside the isolated environment
        if os.path.exists("flake.nix"):
            # Escape single quotes for the bash string
            safe_cmd = cmd.replace("'", "'\\''")
            nix_cmd = f"nix develop --command bash -c '{safe_cmd}'"
            return subprocess.run(nix_cmd, shell=True, capture_output=True, text=True)
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
        # We loop here until a valid flake.nix is generated
        first_run = True
        error_log = ""

        while True:
            # Condition to exit phase 2: specs exist AND flake exists AND flake is valid
            if os.path.exists(self._path("specs", "main.md")) and os.path.exists(
                "flake.nix"
            ):
                # Test validity
                log("Validating Nix Environment...", "SYSTEM")
                # Ensure it's in git or nix flakes will fail
                subprocess.run(["git", "add", "flake.nix"], check=False)

                check = subprocess.run(
                    ["nix", "develop", "--command", "echo", "ok"],
                    capture_output=True,
                    text=True,
                )

                if check.returncode == 0:
                    log("✅ Environment Verified.", "SUCCESS")
                    break
                else:
                    log("❌ Environment Invalid. Forcing Architect to fix.", "WARN")
                    error_log = f"Your previous `flake.nix` failed to load. \n\n ERROR: \n {check.stderr} \n\n Fix the syntax error. Ensure variables are in scope."
                    first_run = False

            # Run Agent
            log("Phase 2: Architect is working...", "SYSTEM")
            os.makedirs(self._path("specs"), exist_ok=True)

            prompt = "Read ideas.txt. Create specs/main.md and a valid flake.nix."
            if not first_run:
                prompt = f"FIX THE BUILD. {error_log}"

            # Force Raw mode so Architect doesn't crash trying to enter the broken shell
            self.run_opencode("ralph-architect", prompt, force_raw=True)

            # If we just ran, loop back to validate
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

        while True:
            task = self.get_next_task()

            if not task:
                if os.path.exists(self._path(self.plan_file)):
                    log("🎉 All tasks completed! System exiting.", "SUCCESS")
                    break
                else:
                    log("Plan file missing. Planner failed.", "ERROR")
                    sys.exit(1)

            t_id, t_desc, t_verify = task

            print("\n" + "=" * 60)
            log(f"LOCKED TARGET: {t_id}", "SYSTEM")
            log(f"TASK: {t_desc}")
            log(f"PROOF REQUIRED: {t_verify}")
            print("=" * 60 + "\n")

            # 1. Run Agent
            prompt = (
                f"Implementing Task {t_id}: '{t_desc}'. "
                f"Do not edit {self.plan_file}. "
                f"Verification command that must pass: '{t_verify}'. "
                f"{self.feedback}"
            )

            self.run_opencode("ralph-builder", prompt)

            # 2. Authority Check
            log("⚖️  System is judging work...", "SYSTEM")

            # Check verification first
            result = self.verify_command(t_verify)

            if result.returncode == 0:
                log("✅ Verification Passed.", "SUCCESS")

                if self.git_status_check():
                    self.git_commit(f"Ralph: {t_id} - {t_desc}")
                else:
                    log("No new changes (task pre-satisfied).", "INFO")

                self.mark_task_done(t_id)
                self.feedback = ""
            else:
                log("❌ Verification Failed.", "ERROR")

                # Check for progress
                if not self.git_status_check():
                    log("Agent made no changes AND failed. Forcing retry.", "WARN")
                    self.feedback = f"SYSTEM REJECTION: You made no file changes and the command '{t_verify}' failed. Implement the code."
                else:
                    err_out = result.stderr if result.stderr else result.stdout
                    print(f"{Colors.FAIL}OUTPUT: {err_out[-500:]}{Colors.ENDC}")

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
