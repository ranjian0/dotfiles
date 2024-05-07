alias work="cd ~/Development"

alias aptu="sudo apt update && sudo apt -y upgrade"
alias apti="sudo apt install"
alias aptr="sudo apt -y remove"
alias apts="apt list | fzf --height 60% --reverse --info inline --border"
alias aptsi="apt list --installed| fzf --height 60% --reverse --info inline --border"

alias pipi="pip install"
alias pipr="pip uninstall -y"
alias pipclean="pip freeze | cut -d "@" -f1 | xargs pip uninstall -y"
alias venv="virtualenv venv && source venv/bin/activate"

alias ni="npm install"
