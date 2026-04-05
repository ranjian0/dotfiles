alias work="cd ~/Development"

alias apu="sudo apt update && sudo apt -y upgrade"
alias api="sudo apt install"
alias aptr="sudo apt -y remove"
alias apts="apt list | fzf --height 60% --reverse --info inline --border"
alias aptsi="apt list --installed| fzf --height 60% --reverse --info inline --border"

#alias pi="uv add"
#alias pu="uv remove"
alias pipclean="uv pip freeze | cut -d "@" -f1 | xargs uv pip uninstall -y"
alias venv="uv venv && source .venv/bin/activate"

alias ni="npm install"
alias oc="opencode"
alias ol="ollama"

alias ow="nohup open-webui serve > /dev/null 2>&1 & echo 'Open WebUI started in background.'"
alias ow-kill="pkill -f 'open-webui serve' && echo 'Open WebUI stopped.'"

alias cc="claude --dangerously-skip-permissions"
alias cc-gpt="ANTHROPIC_AUTH_TOKEN=ollama ANTHROPIC_BASE_URL=http://localhost:11434 claude --model gpt-oss:20b --dangerously-skip-permissions"
alias cc-glm-47='ANTHROPIC_AUTH_TOKEN=${ZAI_API_KEY} ANTHROPIC_BASE_URL=https://api.z.ai/api/anthropic API_TIMEOUT_MS=3000000 claude --model glm-4.7 --dangerously-skip-permissions'
alias cc-glm-5='ANTHROPIC_AUTH_TOKEN=${ZAI_API_KEY} ANTHROPIC_BASE_URL=https://api.z.ai/api/anthropic API_TIMEOUT_MS=3000000 claude --model glm-5 --dangerously-skip-permissions'
alias cc-local='ANTHROPIC_AUTH_TOKEN=sk-lm-Ma1IOsOx:28HxZes7WNSyGpIDgp3q ANTHROPIC_BASE_URL=http://192.168.100.23:1234 claude --model google/gemma-4-26b-a4b --dangerously-skip-permissions'
alias homelab="ssh ranjian0@192.168.100.25"
