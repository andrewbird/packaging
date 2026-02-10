#!/bin/sh

TARGET_DISTRO="$1"
TARGET_ARCH="$2"

set -e

git clone https://github.com/dosemu2/dosemu2.git dosemu2.git
(
  cd dosemu2.git
  git fetch origin pull/2769/head:pr2769
  git switch pr2769
  if [ "$TARGET_ARCH" = "armhf" ] ; then
    sed -i -e 's/binutils-i686-linux-gnu/llvm, lld/g' debian/control
  fi
  mk-build-deps --install --root-cmd sudo --tool "apt-get -o Debug::pkgProblemResolver=yes --no-install-recommends -y"
  make deb
)

# We don't need to install. It would probably fail as it seems to access the 
# /proc filesystem which currently we don't mount.
#if [ "$(pwd)" = "/" ] ; then
#	sudo apt install -y -f ./dosemu2*.deb
#fi
