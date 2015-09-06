molst machine setup

# All steps

  1. Install Fedora (btrfs, /boot/efi (512 MiB), /boot (512 MiB), / (rest)). Add a swap partition of same size as RAM if hibernate is to be used.
  1. Enable prio for F1-F12 in BIOS
  1. ```(cd ~ && git clone https://github.com/molst/molst.git molstt && cp -r molstt/* . && rm -rf molstt && ./install.sh)```
  1. logout+login

# Notes

  * If an error about 'Sleep verb not supported' is encountered while trying to hibernate with `systemctl hibernate`, this is probably because there is no swap partition to store the whole RAM.
