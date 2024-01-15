from archlinux
run echo 'Server = https://mirror.osbeck.com/archlinux/$repo/os/$arch' >  /etc/pacman.d/mirrorlist
run pacman-key --init
run pacman --noconfirm -Sy archlinux-keyring
run pacman --noconfirm -Syu git gcc make ruby2.7 sudo vim which
