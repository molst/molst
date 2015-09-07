molst machine setup

# All steps

  1. Install Fedora (btrfs, /boot/efi (512 MiB), /boot (512 MiB), / (rest)). Add a swap partition of same size as RAM if hibernate is to be used.
  1. Enable prio for F1-F12 in BIOS
  1. ```(cd ~ && git clone https://github.com/molst/molst.git molstt && cp -r molstt/* . && rm -rf molstt && ./install.sh)```
  1. logout+login

put user file: .config/systemd/user/resume.service
systemctl --user enable resume.service

# Notes

  * If an error about 'Sleep verb not supported' is encountered while trying to hibernate with `systemctl hibernate`, this is probably because there is no swap partition to store the whole RAM.
  * In ranger, there is an image preview problem with a workaround https://github.com/hut/ranger/issues/104

# Special directories

*.inst* Created by install.sh. Contains manually installed files and directories, such as cloned git repos. The other dot files and scripts may be dependent on these files, so they should not be deleted.

*.sysinst* Files that are copied to system directories by install.sh. These have no other purpose than backup after install.sh has finished successfully.
