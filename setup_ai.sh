#!/bin/bash

echo "🚀 Starting AI Stack Installation..."

# 1. Install uv if not present
if ! command -v uv &> /dev/null; then
    echo "📦 Installing uv..."
    curl -LsSf https://astral.sh/uv/install.sh | sh
    source $HOME/.cargo/env
else
    echo "✅ uv is already installed."
fi

# 2. Install Tools using uv
echo "📦 Installing LiteLLM (Proxy)..."
uv tool install litellm --with "litellm[proxy]"

echo "📦 Installing LLM (The CLI)..."
uv tool install llm

echo "📦 Installing Aider (The Coder)..."
uv tool install aider-chat

echo "📦 Installing Files-to-Prompt (Context helper)..."
uv tool install files-to-prompt

# 3. Install LLM Plugins (Required for compatibility)
# Note: We don't strictly need llm-ollama if we route everything through LiteLLM,
# but it's good to have as a backup.
echo "🔌 Installing LLM plugins..."
llm install llm-ollama

echo "🎉 Tool Installation Complete!"
echo "👉 Next step: Edit ~/.config/ai/litellm-config.yaml with your API keys."

echo "⚙️  Configuring 'llm' CLI templates..."

# 1. Save System Prompts (Templates)
llm --system "You are a Senior Software Architect. Output a detailed technical design document in Markdown. Include: High Level Architecture, Data Models, API Endpoints, and File Structure." --save architect
llm --system "You are a Technical Project Manager. Read the design document provided. Output a granular Markdown checklist in 'docs/TODOS.md' format. Group tasks logically. Items must be actionable." --save planner
llm --system "You are a Security Researcher. Analyze the code diff for vulnerabilities (OWASP Top 10, Injection, Secret Leaks). Output a bulleted list of issues. If clean, say 'No major vulnerabilities found'." --save sec-audit
llm --system "You are a Staff Engineer. Review the code diff for: Logic errors, Code Style, Performance issues, and Redundancy. Be concise and harsh but fair." --save code-review
llm --system "You are a Documentation Maintainer. Read the provided code and the old design document. Output a fully updated design document that reflects the ACTUAL implementation details of the code." --save doc-updater
llm --system "You are a TDD Expert. When given a task, you MUST: 1. Create/Update a unit test that fails for the requested feature. 2. Implement the feature. 3. Ensure all tests pass. 4. Only then mark the task as done." --save tdd-coder

echo "✅ Templates saved."

# 2. Configure 'llm' to use LiteLLM Proxy
# We need to tell 'llm' that 'genius', 'cheap', etc. exist at localhost:4000
echo "🔗 linking 'llm' to LiteLLM..."

# Find the user data dir for llm
LLM_DIR=$(llm paths --data)
CONFIG_FILE="$LLM_DIR/extra-openai-models.yaml"

# Create the mapping file
cat <<EOF > "$CONFIG_FILE"
- model_id: genius
  model_name: genius
  api_base: "http://localhost:4000/v1"
  api_key_name: litellm_key
- model_id: pro
  model_name: pro
  api_base: "http://localhost:4000/v1"
  api_key_name: litellm_key
- model_id: cheap
  model_name: cheap
  api_base: "http://localhost:4000/v1"
  api_key_name: litellm_key
- model_id: local
  model_name: local
  api_base: "http://localhost:4000/v1"
  api_key_name: litellm_key
EOF

# Set the fake key
llm keys set litellm_key --value "sk-local-ai"

echo "✅ Configuration complete. 'llm -m genius' will now hit Gemini via LiteLLM."