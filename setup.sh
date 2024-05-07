#!/bin/bash

sudo apt update
sudo apt upgrade

sudo apt -y install git build-essential vim ca-certificates curl gnupg gcc cmake

# General command line tools
sudo apt -y intall htop bat tmux ripgrep fd-find zsh stow glances
chsh -s $(which zsh)

# -- fix bat conflit
mkdir -p ~/.local/bin
ln -s /usr/bin/batcat ~/.local/bin/bat

# -- ohmyzsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# -- fzf
FZF_VERSION=$(curl -s "https://api.github.com/repos/junegunn/fzf/releases/latest" | grep -Po '"tag_name": "\K[^"]*')
curl -Lo fzf.tar.gz "https://github.com/junegunn/fzf/releases/download/${FZF_VERSION}/fzf-${FZF_VERSION}-linux_amd64.tar.gz"
tar xf fzf.tar.gz fzf
sudo install fzf /usr/local/bin
rm fzf.tar.gz

# -- lazygit
LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
tar xf lazygit.tar.gz lazygit
sudo install lazygit /usr/local/bin
rm lazygit.tar.gz

# -- docker
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh

# -- neovim
curl -sL https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.tar.gz |
	sudo tar -xzf - --strip-components=1 --overwrite -C /usr

# Programming tools
# -- python pyenv
curl https://pyenv.run | sh

# -- node nvm
NVM_VERSION=$(curl -s "https://api.github.com/repos/nvm-sh/nvm/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
curl -o- "https://raw.githubusercontent.com/nvm-sh/nvm/${NVM_VERSION}/install.sh" | sh

# -- choosenim
curl https://nim-lang.org/choosenim/init.sh -sSf | sh
