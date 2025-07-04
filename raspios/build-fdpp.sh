#!/bin/sh

set -e

git clone https://github.com/dosemu2/fdpp.git fdpp.git
(
  cd fdpp.git
  mk-build-deps --install --root-cmd sudo --tool "apt-get -o Debug::pkgProblemResolver=yes --no-install-recommends -y"
  ./build_deb.sh
)

if [ "$(pwd)" = "/" ] ; then
	sudo apt install -y -f ./fdpp*.deb
fi
