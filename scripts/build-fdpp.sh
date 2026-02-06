#!/bin/sh

TARGET_DISTRO="$1"
TARGET_ARCH="$2"

set -e

git clone https://github.com/dosemu2/fdpp.git fdpp.git
(
  cd fdpp.git
  if [ "$TARGET_ARCH" = "armhf" ] ; then
    sed -i -e 's/binutils-x86-64-linux-gnu/lld, llvm/g'\
           -e 's/nasm-segelf/nasm/g' debian/control
    sed -i -e 's/\bdh_auto_build\b/CROSS_LD=ld.lld USE_LTO=0 &/g' debian/rules
  fi
  mk-build-deps --install --root-cmd sudo --tool "apt-get -o Debug::pkgProblemResolver=yes --no-install-recommends -y"
  ./build_deb.sh
)

if [ "$(pwd)" = "/" ] ; then
	sudo apt install -y -f ./fdpp*.deb
fi
