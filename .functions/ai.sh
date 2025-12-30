# --- AI ENVIRONMENT VARS ---
export OPENAI_API_BASE="http://localhost:4000/v1" # Point Aider to LiteLLM
export OPENAI_API_KEY="sk-local-ai"               # Fake key for Aider/LiteLLM
export AIDER_MODEL="cheap"                        # Default Aider to DeepSeek

# --- UTILITY: Start the Engine ---
function ai-start() {
    echo "🚀 Starting LiteLLM Proxy..."
    # Checks if config exists
    if [ ! -f ~/.config/ai/litellm-config.yaml ]; then
        echo "❌ Config not found at ~/.config/ai/litellm-config.yaml"
        return 1
    fi
    # Runs in background, logs to litellm.log
    nohup litellm --config ~/.config/ai/litellm-config.yaml --port 4000 > ~/.config/ai/litellm.log 2>&1 &
    echo "✅ LiteLLM running on port 4000 (PID: $!)"
}

# --- WORKFLOW ALIASES ---

# 1. Design: Natural Language -> Design Doc
function ai-design() {
    mkdir -p docs
    echo "🧠 Architecting (Genius Mode)..."
    
    # Context-aware prompting
    prompt="Here is my current codebase structure:
    $(files-to-prompt . -e .git -e node_modules -e docs -e __pycache__ --cxml 2>/dev/null || echo "New Project")
    
    Request: $1"
    
    echo "$prompt" | llm -m genius -t architect > docs/design.md
    echo "✅ Design saved to docs/design.md"
}

# 2. Plan: Design Doc -> TODO List
function ai-plan() {
    if [ ! -f docs/design.md ]; then
        echo "❌ No docs/design.md found."
        return 1
    fi
    echo "📋 Generating TODOs (Pro Mode)..."
    cat docs/design.md | llm -m pro -t planner > docs/TODOS.md
    echo "✅ Checklist saved to docs/TODOS.md"
}

# 3. Execute: Implement a specific TODO item
# Usage: ai-do 10 "Watch out for edge case X"
function ai-do() {
    task_id="$1"
    context="${2:-No extra context}"
    
    # Load project rules if they exist
    rules=$(cat .ai-rules 2>/dev/null || echo "")
    
    echo "🤖 Calling Aider (Cheap/DeepSeek)..."
    
    # We explicitly tell Aider to use 'cheap' (DeepSeek)
    aider \
      --model openai/cheap \
      --read docs/design.md \
      --read docs/TODOS.md \
      --message "Project Rules: $rules
      
      Look at docs/TODOS.md. Implement Task #$task_id. 
      Context: $context. 
      
      When done, edit docs/TODOS.md to check off item #$task_id ([x])."
}

# 4. Review: Code Review Staged Changes
function ai-review() {
    echo "🧐 Conducting Code Review (Pro Mode)..."
    git diff --cached | llm -m pro -t code-review
}

# 5. Fix: Auto-fix based on input (from pipe or arg)
function ai-fix() {
    input="${1:-$(cat)}"
    echo "🚑 Applying Fixes (Cheap Mode)..."
    aider --model openai/cheap --message "Fix the following issues: $input"
}

# 6. Sync: Code -> Design Doc
function ai-sync-docs() {
    echo "🔄 Syncing Code -> Design (Genius Mode)..."
    combined_input="OLD DESIGN:
    $(cat docs/design.md)
    
    CURRENT CODE:
    $(files-to-prompt src/ --cxml 2>/dev/null)"
    
    echo "$combined_input" | llm -m genius -t doc-updater > docs/design.md
    echo "✅ docs/design.md updated."
}

# 7. Commit: Staged Changes -> Commit
function ai-commit() {
    if git diff --cached --quiet; then
        echo "❌ No staged changes."
        return 1
    fi
    msg=$(git diff --cached | llm -m local "Write a conventional commit message (type: subject). Output ONLY the message.")
    git commit -e -m "$msg"
}

# --- THE AUTONOMOUS LOOP ---

# Usage: ai-sprint [max_tasks]
# Example: ai-sprint 5 (Does the next 5 tasks)
# Example: ai-sprint (Does all tasks until failure or completion)
function ai-sprint() {
    max_tasks=${1:-999}
    count=0
    
    # 1. Detect Test Command (Safety Check)
    # Looks for a .ai-tests file, otherwise defaults to pytest
    test_cmd=$(cat .ai-tests 2>/dev/null || echo "pytest")
    
    # Verify the test command actually exists/runs to avoid infinite loops of "command not found"
    echo "🔍 Verifying test environment..."
    if ! eval "$test_cmd --help" &> /dev/null; then
        echo "❌ Error: Test command '$test_cmd' is not executable or not found."
        echo "👉 Create a '.ai-tests' file with your test command (e.g., 'npm test' or 'pytest')."
        return 1
    fi

    echo "🚀 Starting Sprint (Max tasks: $max_tasks)"
    echo "🧪 Test Command: $test_cmd"

    while [ $count -lt $max_tasks ]; do
        # 2. Find the next unchecked task
        # We look for lines starting with numbers and [ ]
        # Regex: Start of line, digits, dot, space, [ ]
        next_task_line=$(grep -m 1 -E "^[0-9]+\. \[ \]" docs/TODOS.md)
        
        if [ -z "$next_task_line" ]; then
            echo "🎉 All tasks in docs/TODOS.md are complete!"
            break
        fi

        # Extract ID and Description
        task_id=$(echo "$next_task_line" | grep -oE "^[0-9]+")
        task_desc=$(echo "$next_task_line" | sed -E 's/^[0-9]+\. \[ \] //')
        
        echo "---------------------------------------------------"
        echo "🤖 STARTING TASK #$task_id: $task_desc"
        echo "---------------------------------------------------"

        # 3. The Aider Command (The "Safe" Loop)
        # --test-cmd: Runs the test after changes. If it fails, Aider attempts to fix the code automatically.
        # --auto-commits: Commits only if tests pass.
        # --yes: Don't wait for user confirmation (Autonomous mode).
        
        rules=$(cat .ai-rules 2>/dev/null || echo "")

        aider \
          --model openai/cheap \
          --read docs/design.md \
          --read docs/TODOS.md \
          --test-cmd "$test_cmd" \
          --auto-commits \
          --yes \
          --message "Project Rules: $rules
          
          OBJECTIVE: Implement Task #$task_id: '$task_desc'
          
          STRATEGY:
          1. Create or update a test file to test this specific feature.
          2. Run the tests (they should fail).
          3. Implement the code.
          4. Run the tests (they must pass).
          5. Update docs/TODOS.md and mark item #$task_id as [x].
          
          CRITICAL: Do not break existing functionality."

        # 4. Verify Success
        # We check if the TODO file was actually updated.
        # If the task is STILL [ ], then Aider failed or got stuck. We must abort.
        if grep -q "^$task_id\. \[ \]" docs/TODOS.md; then
            echo "🛑 SPRINT HALTED."
            echo "❌ Aider failed to complete Task #$task_id (Tests likely failed and couldn't be fixed)."
            echo "👉 Check the git logs and fix manually before continuing."
            return 1
        fi

        echo "✅ Task #$task_id Complete."
        ((count++))
    done
}