#!/bin/bash

set -e

function version() {
  awk '/^Version/ {print $2}' SPECS/chromedriver.spec
}

function build() {
  rm -rf BUILD BUILDROOT RPMS SRPMS || true
  wget https://chromedriver.storage.googleapis.com/$(version)/chromedriver_linux64.zip -O SOURCES/chromedriver-$(version).zip
  rpmbuild --define "_topdir $(git rev-parse --show-toplevel)" -bb SPECS/chromedriver.spec
  mv RPMS/x86_64/chromedriver-*.rpm .
}

build
