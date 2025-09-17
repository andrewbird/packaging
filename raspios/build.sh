#!/bin/sh
cat /etc/issue
uname -a
id -a
apt install -y -f file sudo build-essential devscripts debhelper git
file /bin/ls

# Force meson from backports
apt install -y wget
wget https://ftp.debian.org/debian/pool/main/m/meson/meson_1.7.0-1_all.deb
apt install -y -f $(pwd)/meson_1.7.0-1_all.deb
