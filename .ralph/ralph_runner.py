#!/usr/bin/env python3
import os
import sys
import subprocess
import re
import argparse
from typing import Optional, Tuple

# --- CONFIGURATION ---

class Colors:
    HEADER = '\033[95m'
    OKBLUE = '\033[94m'
    OKCYAN = '\033[96m'
    OKGREEN = '\033[92m'
    WARNING = '\033[93m'
    FAIL = '\033[91m'
    ENDC = '\033[0m'

def log(msg, type="INFO"):
    if type == "INFO": print(f"{Colors.OKBLUE}[INFO]{Colors.ENDC} {msg}")
    elif type == "SUCCESS": print(f"{Colors.OKGREEN}[SUCCESS]{Colors.ENDC} {msg}")
    elif type == "WARN": print(f"{Colors.WARNING}[WARN]{Colors.ENDC} {msg}")
    elif type == "ERROR": print(f"{Colors.FAIL}[ERROR]{Colors.ENDC} {msg}")
    elif type == "SYSTEM": print(f"{Colors.HEADER}[SYSTEM]{Colors.ENDC} {msg}")

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
"""
}

# --- CORE SYSTEM ---

class RalphSystem:
    def __init__(self):
        # Resolve to absolute path to avoid ambiguity
        self.plan_file = "IMPLEMENTATION_PLAN.md"
        self.feedback = ""
                    
        log(f"Ralph Started!", "SYSTEM")

    def _path(self, *paths):
        """Helper to construct absolute paths based on project root."""
        return os.path.join(".", *paths)

    def ensure_agents(self):
        """Generates the agent definition files dynamically."""
        agent_dir = self._path(".opencode", "agent")
        os.makedirs(agent_dir, exist_ok=True)
        
        for name, content in AGENTS.items():
            path = os.path.join(agent_dir, f"{name}.md")
            with open(path, "w") as f:
                f.write(content)
            # No log here to keep UI clean, but files are ensured

    def run_opencode(self, agent: str, prompt: str):
        """Wraps the OpenCode CLI, setting CWD explicitly."""
        cmd = ["nix", "develop", "--command", 
               "opencode", "run", "--agent", agent, "--model", "zai-coding-plan/glm-4.7", prompt]
        try:
            # check=True raises CalledProcessError on non-zero exit
            # cwd=self.root_dir ensures opencode operates in the project folder
            subprocess.run(cmd, shell=True, check=True)
        except subprocess.CalledProcessError:
            log(f"Agent {agent} crashed.", "ERROR")
            sys.exit(1)
        except FileNotFoundError:
            log("Command 'opencode' not found. Is it installed?", "ERROR")
            sys.exit(1)

    def verify_command(self, cmd):
        # Run verification inside the isolated environment
        nix_cmd = f"nix develop --command bash -c '{cmd}'"
        return subprocess.run(nix_cmd, shell=True, capture_output=True, text=True)

    def phase_1_analysis(self):
        if not os.path.exists(self._path("ideas.txt")):
            log(f"ideas.txt not found in {self.root_dir}", "ERROR")
            sys.exit(1)
            
        if not os.path.exists(self._path("questions.md")):
            log("Phase 1: Analyst is reviewing ideas...", "SYSTEM")
            self.run_opencode("ralph-analyst", "Read ideas.txt. You MUST use the 'write' tool to save a file named 'questions.md' containing the technical questions. Do not output them to chat.")
        else:
            log("Skipping Phase 1 (questions.md exists)")

    def phase_2_architect(self):
        if not os.path.exists(self._path("specs", "main.md")) or not os.path.exists("flake.nix"):
            log("Phase 2: CTO is designing architecture...", "SYSTEM")
            os.makedirs(self._path("specs"), exist_ok=True)
            # Run this *outside* nix develop first to bootstrap the flake
            subprocess.run(["opencode", "run", "--agent", "ralph-architect", 
                          "Read ideas.txt. Create specs and a valid flake.nix for this project."])
        else:
            log("Skipping Phase 2 (specs/main.md exists)")

    def phase_3_planning(self):
        if not os.path.exists(self._path(self.plan_file)):
            log("Phase 3: Planner is creating the roadmap...", "SYSTEM")
            self.run_opencode("ralph-planner", "Read specs/main.md. Initialize project. Create IMPLEMENTATION_PLAN.md.")
        else:
            log("Skipping Phase 3 (Plan exists)")

    def get_next_task(self) -> Optional[Tuple[str, str, str]]:
        try:
            with open(self._path(self.plan_file), "r") as f:
                content = f.read()
        except FileNotFoundError:
            return None

        # Regex matches: - [ ] [ID:XYZ] Description || VERIFY: cmd
        pattern = r'- \[ \] \[(ID:.*?)\] (.*?) \|\| VERIFY: (.*)'
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
        # We use cwd=self.root_dir to ensure git acts on the right repo
        subprocess.run(["git", "add", "."], check=True, cwd=self.root_dir)
        subprocess.run(["git", "commit", "-m", message], check=True, cwd=self.root_dir)

    def git_reset(self):
        # Danger: This is hard reset. Ensure root_dir is correct!
        subprocess.run(["git", "reset", "--hard"], check=True, cwd=self.root_dir)
        subprocess.run(["git", "clean", "-fd"], check=True, cwd=self.root_dir)

    def git_status_check(self) -> bool:
        """Returns True if there are uncommitted changes."""
        res = subprocess.run(
            ["git", "status", "--porcelain"], 
            capture_output=True, 
            text=True, 
            cwd=self.root_dir
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
            
            print("\n" + "="*60)
            log(f"LOCKED TARGET: {t_id}", "SYSTEM")
            log(f"TASK: {t_desc}")
            log(f"PROOF REQUIRED: {t_verify}")
            print("="*60 + "\n")

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
            
            # Run Verification Command
            result = self.verify_command(t_verify)
            if result.returncode == 0:
                log("✅ Verification Passed.", "SUCCESS")
                # Only commit if there are actually changes
                if self.git_status_check():
                    self.git_commit(f"Ralph: {t_id} - {t_desc}")
                else:
                    log("No new changes to commit (task was likely pre-satisfied).", "INFO")

                self.mark_task_done(t_id)
                self.feedback = "" 
            else:
                log("❌ Verification Failed.", "ERROR")
                # Handle empty stderr
                if not self.git_status_check():
                    log("Agent made no changes AND verification failed. Forcing retry.", "WARN")
                    self.feedback = "SYSTEM REJECTION: You made no file changes and the verification command failed. You must write code to satisfy the task."
                else:
                    # They tried, but failed. Revert.
                    err_out = result.stderr if result.stderr else result.stdout
                    print(f"{Colors.FAIL}OUTPUT: {err_out[-500:]}{Colors.ENDC}")
                    
                    log("Reverting changes...", "WARN")
                    self.git_reset()
                    
                    self.feedback = (
                        f"SYSTEM REJECTION: Your code failed the verification command: '{t_verify}'.\n"
                        f"EXIT CODE: {result.returncode}\n"
                        f"OUTPUT LOG:\n{err_out[-1000:]}\n\n"
                        "I have reverted your changes. Try again."
                    )

if __name__ == "__main__":
    ralph = RalphSystem()
    
    # 1. Bootstrapping
    ralph.ensure_agents()
    
    # 2. Requirements & Specs
    ralph.phase_1_analysis()
    ralph.phase_2_architect()
    
    # 3. Planning
    ralph.phase_3_planning()
    
    # 4. Execution
    ralph.phase_4_execution_loop()