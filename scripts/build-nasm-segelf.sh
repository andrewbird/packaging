#!/bin/sh

set -e

TARGET_DISTRO="$1"
TARGET_ARCH="$2"

if [ "${TARGET_ARCH}" = "armhf" ] ; then
  echo "Don't need nasm-segelf when using ld.lld"
 else

git clone https://github.com/stsp/nasm-segelf.git nasm-segelf.git
(
  cd nasm-segelf.git
  mk-build-deps --install --root-cmd sudo --tool "apt-get -o Debug::pkgProblemResolver=yes --no-install-recommends -y"
  debian/rules build
  fakeroot debian/rules binary
)

if [ "$(pwd)" = "/" ] ; then
	sudo apt install -y -f ./nasm-segelf*.deb
fi

fi
