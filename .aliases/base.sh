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
alias ow="open-webui serve"
