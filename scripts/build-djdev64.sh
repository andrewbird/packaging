#!/bin/sh

TARGET_DISTRO="$1"
TARGET_ARCH="$2"

set -e

git clone https://github.com/dosemu2/djdev64.git djdev64.git
(
  cd djdev64.git
  mk-build-deps --install --root-cmd sudo --tool "apt-get -o Debug::pkgProblemResolver=yes --no-install-recommends -y"
  ./build_deb.sh
)

ls -ltr *.deb

if [ "$(pwd)" = "/" ] ; then
	sudo apt install -y -f ./djdev64*.deb ./libdjdev64*.deb ./libdjstub64*.deb
fi
