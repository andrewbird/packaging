#!/bin/sh

TARGET_DISTRO="$1"
TARGET_ARCH="$2"

set -e

git clone https://github.com/stsp/dj64dev.git dj64dev.git
(
  cd dj64dev.git
  if [ "$TARGET_ARCH" = "armhf" ] ; then
    sed -i 's/binutils-i686-linux-gnu/clang, llvm, lld/g' debian/control
  fi
  mk-build-deps --install --root-cmd sudo --tool "apt-get -o Debug::pkgProblemResolver=yes --no-install-recommends -y"
  make deb
)

ls -ltr *.deb

if [ "$(pwd)" = "/" ] ; then
	sudo apt install -y -f ./dj*64*.deb
fi
