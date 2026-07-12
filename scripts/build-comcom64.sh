#!/bin/sh

TARGET_DISTRO="$1"
TARGET_ARCH="$2"

set -e

git clone https://github.com/dosemu2/comcom64.git comcom64.git
(
  cd comcom64.git
  if [ "$TARGET_ARCH" = "armhf" ] ; then
    sed -i -e 's/dj32-dev/bash/g' \
           -e '/Package: comcom32/{n;s/Architecture: any/Architecture: amd64/;}' debian/control

    sed -i -e 's/all: 64 32/all: 64/g' \
           -e 's/install: install_64 install_32/install: install_64/g' makefile

    rm -f debian/comcom32.install
  fi
  mk-build-deps --install --root-cmd sudo --tool "apt-get -o Debug::pkgProblemResolver=yes --no-install-recommends -y"
  debian/rules build
  fakeroot debian/rules binary
)

if [ "$(pwd)" = "/" ] ; then
	sudo apt install -y -f ./comcom64*.deb
fi
