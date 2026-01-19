#!/bin/sh

set -e

TARGET_DISTRO="$1"
TARGET_ARCH="$2"

if [ "${TARGET_DISTRO}" = "trixie" ] ; then
  echo "Version included in Debian is suitable"
else
  git clone https://github.com/stsp/djstub.git djstub.git
  (
    cd djstub.git
    mk-build-deps --install --root-cmd sudo --tool "apt-get -o Debug::pkgProblemResolver=yes --no-install-recommends -y"
    debian/rules build
    fakeroot debian/rules binary
  )

  ls -ltr *.deb

  if [ "$(pwd)" = "/" ] ; then
    sudo apt install -y -f ./djstub*.deb
  fi
fi
