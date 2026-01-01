#!/bin/sh

set -e

git clone https://github.com/stsp/SmallerC.git smallerc.git
(
  cd smallerc.git
  mk-build-deps --install --root-cmd sudo --tool "apt-get -o Debug::pkgProblemResolver=yes --no-install-recommends -y"
  ./build_deb.sh
)

if [ "$(pwd)" = "/" ] ; then
	sudo apt install -y -f ./smallerc*.deb
fi

