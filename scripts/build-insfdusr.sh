#!/bin/sh

set -e

git clone https://github.com/dosemu2/install-freedos.git install-freedos.git
(
  cd install-freedos.git
  mk-build-deps --install --root-cmd sudo --tool "apt-get -o Debug::pkgProblemResolver=yes --no-install-recommends -y"
  make deb
)
