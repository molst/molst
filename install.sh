#sudo dnf upgrade
mkdir ~/.inst
sudo dnf -y install gvim # vim with X11 support (for clipboard cut+paste)
sudo dnf -y install rxvt-unicode
sudo dnf -y install i3
sudo dnf -y install i3status
sudo dnf -y install i3lock
sudo dnf -y install zsh
sudo dnf -y install colordiff
sudo dnf -y install ranger
sudo dnf -y install w3m w3m-img
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
vim +PluginInstall +qall 
(cd ~/.inst && git clone git@github.com:hbin/top-programming-fonts.git && cd top-programming-fonts && chmod ugo+x install.sh && ./install.sh)
(cd ~/.inst && git clone git@github.com:solarized/xresources.git)

sudo dnf -y install xbacklight
