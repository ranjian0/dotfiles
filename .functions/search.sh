# some cool fzf search tools

# -- find files and directories
# sf - search files
function sf() {
	fdfind --type file |
		fzf --prompt 'Files> ' \
			--header 'CTRL-T: Switch between Files/Directories' \
			--bind 'ctrl-t:transform:[[ ! $FZF_PROMPT =~ Files ]] &&
              echo "change-prompt(Files> )+reload(fdfind --type file)" ||
              echo "change-prompt(Directories> )+reload(fdfind --type directory)"' \
			--preview '[[ $FZF_PROMPT =~ Files ]] && bat --color=always {} || tree -C {}'
}

# -- find text in files
# sfg - search files grep
function sfg() {
	# 1. Search for text in files using Ripgrep
	# 2. Interactively narrow down the list using fzf
	# 3. Open the file in Vim
	rg --color=always --line-number --no-heading --smart-case "${*:-}" |
		fzf --ansi \
			--color "hl:-1:underline,hl+:-1:underline:reverse" \
			--delimiter : \
			--preview 'bat --color=always {1} --highlight-line {2}' \
			--preview-window 'up,60%,border-bottom,+{2}+3/3,~3' \
			--bind 'enter:become(nvim {1} +{2})'
}

# -- search manpages
function sman() {
	batman="man {1} | col -bx | bat --language=man --plain --color always --theme=\"Monokai Extended\""
	man -k . | sort |
		awk -v cyan=$(tput setaf 6) -v blue=$(tput setaf 4) -v res=$(tput sgr0) -v bld=$(tput bold) '{ $1=cyan bld $1; $2=res blue;} 1' |
		fzf \
			-q "$1" \
			--ansi \
			--tiebreak=begin \
			--prompt=' Man > ' \
			--preview-window '70%,rounded,<50(up,85%,border-bottom)' \
			--preview "${batman}" \
			--header 'Alt+C: CHT.SH, Alt+M: Man, Alt+T: TLDR' \
			--bind "enter:execute(man {1})" \
			--bind "alt-c:+change-preview(curl -s 'https://cht.sh/{1}')+change-prompt(ﯽ Cheat > )" \
			--bind "alt-m:+change-preview(${batman})+change-prompt( Man > )" \
			--bind "alt-t:+change-preview(tldr --color=always {1})+change-prompt(ﳁ TLDR > )"
	# zle reset-prompt
}

# kill processes - list only the ones you can kill. Modified the earlier script.
function skill() {
	local pid
	if [ "$UID" != "0" ]; then
		pid=$(ps -f -u $UID | sed 1d | fzf -m | awk '{print $2}')
	else
		pid=$(ps -ef | sed 1d | fzf -m | awk '{print $2}')
	fi

	if [ "x$pid" != "x" ]; then
		echo $pid | xargs kill -${1:-9}
	fi
}

function semoji() {
	curl -sSL 'https://git.io/JXXO7' | fzf
}

function sgbt() {
	local tags branches target
	branches=$(
		git --no-pager branch --all \
			--format="%(if)%(HEAD)%(then)%(else)%(if:equals=HEAD)%(refname:strip=3)%(then)%(else)%1B[0;34;1mbranch%09%1B[m%(refname:short)%(end)%(end)" |
			sed '/^$/d'
	) || return
	tags=$(
		git --no-pager tag | awk '{print "\x1b[35;1mtag\x1b[m\t" $1}'
	) || return
	target=$(
		(
			echo "$branches"
			echo "$tags"
		) |
			fzf --no-hscroll --no-multi -n 2 \
				--ansi --preview="git --no-pager log -150 --pretty=format:%s '..{2}'"
	) || return
	git checkout $(awk '{print $2}' <<<"$target")
}
