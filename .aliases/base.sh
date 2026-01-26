alias work="cd ~/Development"

alias apu="sudo apt update && sudo apt -y upgrade"
alias api="sudo apt install"
alias aptr="sudo apt -y remove"
alias apts="apt list | fzf --height 60% --reverse --info inline --border"
alias aptsi="apt list --installed| fzf --height 60% --reverse --info inline --border"

alias pi="uv add"
alias pu="uv remove"
alias pipclean="uv pip freeze | cut -d "@" -f1 | xargs uv pip uninstall -y"
alias venv="uv venv && source .venv/bin/activate"

alias ni="npm install"
alias oc="opencode"
alias ol="ollama"
alias ow="nohup open-webui serve > /dev/null 2>&1 & echo 'Open WebUI started in background.'"
alias ow-kill="pkill -f 'open-webui serve' && echo 'Open WebUI stopped.'"
alias cc="claude --allow-dangerously-skip-permissions"
alias cc-gpt="ANTHROPIC_AUTH_TOKEN=ollama ANTHROPIC_BASE_URL=http://localhost:11434 claude --model gpt-oss:20b --allow-dangerously-skip-permissions"
alias cc-glm-flash="ANTHROPIC_AUTH_TOKEN=ollama ANTHROPIC_BASE_URL=http://localhost:11434 claude --model glm-4.7-flash --allow-dangerously-skip-permissions"
alias cc-glm-47='ANTHROPIC_AUTH_TOKEN=${ZAI_API_KEY} ANTHROPIC_BASE_URL=https://api.z.ai/api/anthropic API_TIMEOUT_MS=3000000 claude --model glm-4.7 --allow-dangerously-skip-permissions'
