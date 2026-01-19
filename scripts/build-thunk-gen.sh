#!/bin/sh

set -e

TARGET_DISTRO="$1"
TARGET_ARCH="$2"

# dj64 need thunk-gen >= 1.5
#if [ "${TARGET_DISTRO}" = "trixie" ] ; then
#  echo "Version included in Debian is suitable"
# else

git clone https://github.com/stsp/thunk_gen.git thunk_gen.git
(
  cd thunk_gen.git
  mk-build-deps --install --root-cmd sudo --tool "apt-get -o Debug::pkgProblemResolver=yes --no-install-recommends -y"
  ./build_deb.sh
)

if [ "$(pwd)" = "/" ] ; then
  sudo apt install -y -f ./thunk-gen*.deb
fi

#fi
