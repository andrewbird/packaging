#!/bin/sh

set -e

git clone https://github.com/stsp/dj64dev.git dj64dev.git
(
  cd dj64dev.git
  mk-build-deps --install --root-cmd sudo --tool "apt-get -o Debug::pkgProblemResolver=yes --no-install-recommends -y"
  make deb
)

ls -ltr *.deb

if [ "$(pwd)" = "/" ] ; then
	sudo apt install -y -f ./dj*64*.deb
fi
