#!/bin/sh
TARGET_DISTRO="$1"
TARGET_ARCH="$2"

cat /etc/issue
uname -a
id -a
apt install -y -f file sudo build-essential devscripts debhelper git
file /bin/ls

if [ "${TARGET_DISTRO}" = "bookworm" ] ; then
  # Force meson from backports
  sudo apt install -y wget
  wget https://ftp.debian.org/debian/pool/main/m/meson/meson_1.7.0-1_all.deb
  sudo apt install -y -f $(pwd)/meson_1.7.0-1_all.deb
fi
