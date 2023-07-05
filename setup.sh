#!/bin/bash

insert_config() {
	if [ -f $3 ]
	then
		read -r -p "Do you want to replace $1 ? [Y/n]" response
		response=${response,,}
		if [[ $response =~ ^(yes|y| ) ]] || [[ -z $response ]]; then
			rm $3
		else
			printf "\e[93m$1 skipped\e[0m\n"
		fi
	fi
	if [ ! -f $3 ]
	then
		ln -s $2 $3
		printf "\e[32m$1 linked\e[0m\n"
	fi
}

mkdir -p ~/.config/nvim/colors
mkdir -p ~/.config/nvim/lua
mkdir -p ~/.config/kitty

insert_config .zshrc ~/dotfiles/zsh/zshrc ~/.zshrc

insert_config lazygit.yml ~/dotfiles/git/lazygit.yml ~/.config/lazygit/config.yml

# Nvim
git clone --depth 1 https://github.com/wbthomason/packer.nvim\
 ~/.local/share/nvim/site/pack/packer/start/packer.nvim
insert_config .vimrc ~/dotfiles/nvim/vimrc ~/.vimrc
insert_config plugins.lua ~/dotfiles/nvim/lua/plugins.lua ~/.config/nvim/lua/plugins.lua
insert_config init.lua ~/dotfiles/nvim/init.lua ~/.config/nvim/init.lua
insert_config lsp.lua ~/dotfiles/nvim/lua/lsp.lua ~/.config/nvim/lua/lsp.lua
insert_config tree.lua ~/dotfiles/nvim/lua/tree.lua ~/.config/nvim/lua/tree.lua

insert_config sshconfig ~/dotfiles/ssh/config ~/.ssh/config

# Kitty
insert_config kitty.conf ~/dotfiles/kitty/kitty.conf ~/.config/kitty/kitty.conf
insert_config current-theme.conf ~/dotfiles/kitty/current-theme.conf ~/.config/kitty/current-theme.conf
