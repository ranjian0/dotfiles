# dotfiles setup

## Clone the dotfiles repo

```shell
git clone git@github.com:ranjian0/dotfiles.git
```

## Run the setup.sh script to install all tools

```shell
cd dotfiles 
chmod +x setup.sh 
./setup.sh
```

## Stow the config

```shell
stow .
```

## Run the post setup script

```shell
chmod +x postsetup.sh 
./postsetup.sh 
```
