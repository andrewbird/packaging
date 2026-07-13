#!/bin/sh

TARGET_DISTRO="$1"
TARGET_ARCH="$2"

set -e

git clone https://github.com/stsp/dj64dev.git dj64dev.git
(
  cd dj64dev.git
  if [ "$TARGET_ARCH" = "armhf" ] ; then
    sed -i -e 's/gcc-i686-linux-gnu/bash/g' \
           -e 's/binutils-i686-linux-gnu/clang, llvm, lld/g' \
           -e '/Package: dj32-dev/{n;s/Architecture: any/Architecture: amd64/;}' debian/control

    sed -i 's,--with-sysroot32=/usr/lib/${DEB_HOST_MULTIARCH}/i386-pc-dj32,--disable-32bit,g' debian/rules
  fi
  mk-build-deps --install --root-cmd sudo --tool "apt-get -o Debug::pkgProblemResolver=yes --no-install-recommends -y"
  make deb
)

ls -ltr *.deb

if [ "$(pwd)" = "/" ] ; then
	sudo apt install -y -f ./libdjdev*.deb ./libdjstub*.deb ./dj*.deb
fi
