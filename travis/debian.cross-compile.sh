#!/bin/sh
# Copyright (c) 2018-2020 Petr Vorel <pvorel@suse.cz>
set -ex

if [ -z "$ARCH" ]; then
	echo "missing \$ARCH!" >&2
	exit 1
fi

case "$ARCH" in
arm64) gcc_arch="aarch64";;
ppc64el) gcc_arch="powerpc64le";;
*) echo "unsupported arch: '$1'!" >&2; exit 1;;
esac

dpkg --add-architecture $ARCH
apt update

apt install -y --no-install-recommends \
	gcc-${gcc_arch}-linux-gnu \
	libc6-dev-${ARCH}-cross \
	libtirpc-dev:$ARCH
