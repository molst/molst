cd ~

#sudo dnf update --refresh
#sudo dnf install dnf-plugin-system-upgrade
#sudo dnf system-upgrade download --releasever=23
#sudo dnf system-upgrade reboot

sudo dnf -y install gvim # vim with X11 support (for clipboard cut+paste)
sudo dnf -y install rxvt-unicode
sudo dnf -y install i3
sudo dnf -y install i3status
sudo dnf -y install i3lock
sudo dnf -y install zsh
sudo dnf -y install colordiff
sudo dnf -y install ranger
sudo dnf -y install w3m w3m-img

git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf && ~/.fzf/install
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

mkdir ~/.inst
vim +PluginInstall +qall 
(cd ~/.inst && git clone git@github.com:hbin/top-programming-fonts.git && cd top-programming-fonts && chmod ugo+x install.sh && ./install.sh)
(cd ~/.inst && git clone git@github.com:solarized/xresources.git)

#tap clicks and such
sudo cp ~/.sysinst/50-synaptics.conf /etc/X11/xorg.conf.d

sudo cp ~/.sysinst/google-chrome.repo /etc/yum.repos.d
sudo dnf -y install google-chrome-stable

wget -O - "https://www.dropbox.com/download?plat=lnx.x86_64" | tar xzf -




#####################################
#### Power related installations ####
#####################################

sudo dnf -y install xbacklight
sudo dnf -y install tlp tlp-rdw powertop

sudo sed -i 's/^SATA_LINKPWR_ON_BAT.*$/SATA_LINKPWR_ON_BAT=max_performance/' /etc/default/tlp #avoid file system corruption with btrfs

#ThinkPad specific power saving tools
#http://linrunner.de/en/tlp/docs/tlp-linux-advanced-power-management.html
sudo dnf -y install --nogpgcheck http://repo.linrunner.de/fedora/tlp/repos/releases/tlp-release-1.0-0.noarch.rpm
sudo dnf -y install --nogpgcheck http://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-stable.noarch.rpm

#Enable screen lock after suspend
sudo cp ~/.sysinst/resume@.service /etc/systemd/system
systemctl enable resume@molst.service
