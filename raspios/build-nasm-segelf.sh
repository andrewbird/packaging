#!/bin/sh

set -e

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
