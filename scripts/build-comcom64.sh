#!/bin/sh

set -e

git clone https://github.com/dosemu2/comcom64.git comcom64.git
(
  cd comcom64.git
  mk-build-deps --install --root-cmd sudo --tool "apt-get -o Debug::pkgProblemResolver=yes --no-install-recommends -y"
  debian/rules build
  fakeroot debian/rules binary
)

if [ "$(pwd)" = "/" ] ; then
	sudo apt install -y -f ./comcom64*.deb
fi
