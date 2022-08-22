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
insert_config .zshrc ~/dotfiles/zsh/zshrc ~/.zshrc
insert_config .gitconfig ~/dotfiles/git/gitconfig ~/.gitconfig

insert_config .tmux.conf ~/dotfiles/tmux/tmux.conf ~/.tmux.conf
insert_config .tmux.conf.local ~/dotfiles/tmux/tmux.conf.local ~/.tmux.conf.local

insert_config .vimrc ~/dotfiles/nvim/vimrc ~/.vimrc
insert_config init.vim ~/dotfiles/nvim/init.vim ~/.config/nvim/init.vim
insert_config coc-settings.json ~/dotfiles/nvim/coc-settings.json ~/.config/nvim/coc-settings.json
insert_config coc.vim ~/dotfiles/nvim/coc.vim ~/.config/nvim/coc.vim

insert_config .alacritty.yml ~/dotfiles/alacritty/alacritty.yml ~/.alacritty.yml

insert_config sshconfig ~/dotfiles/ssh/config ~/.ssh/config
