#!/bin/bash

set -ex

PKG="${1}"
VERSION="${2}"
ZIPFILE="${PKG}-${VERSION}.zip"
ORIG_TARBALL="../${PKG}_${VERSION}.orig.tar.xz"

[ ! -f "${ORIG_TARBALL}" ] || exit 0

rm -rf "${PKG}"*
rm -rf "${PKG}-${VERSION}"
rm -f "${ZIPFILE}"

wget -c -t 1 -T 5 "https://github.com/h2database/h2database/archive/version-${VERSION}.zip" -O "${ZIPFILE}" || exit 1

unzip "${ZIPFILE}" || exit 1

rm -f "${ZIPFILE}"

mv "${PKG}"* "${PKG}-${VERSION}"

rm -rf "${PKG}-${VERSION}"/h2/service
rm -rf "${PKG}-${VERSION}"/h2/src/docsrc
rm -rf "${PKG}-${VERSION}"/h2/src/installer
rm -rf "${PKG}-${VERSION}"/h2/src/test
rm -rf "${PKG}-${VERSION}"/h2/src/tools
rm -rf "${PKG}-${VERSION}"/h2/src/main/META-INF
rm -f "${PKG}-${VERSION}"/h2/build.*

tar -cJf "${ORIG_TARBALL}" --exclude-vcs "${PKG}-${VERSION}" || exit 1

rm -rf "${PKG}-${VERSION}"
rm -f "${ZIPFILE}"

