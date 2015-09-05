#sudo dnf upgrade
mkdir ~/.inst
sudo dnf -y install vim
sudo dnf -y install rxvt-unicode
sudo dnf -y install i3
sudo dnf -y install i3status
sudo dnf -y install zsh
sudo dnf -y install colordiff
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
vim +PluginInstall +qall 
(cd ~/.inst && git clone git@github.com:hbin/top-programming-fonts.git && cd top-programming-fonts && chmod ugo+x install.sh && ./install.sh)
(cd ~/.inst && git clone git@github.com:solarized/xresources.git)
