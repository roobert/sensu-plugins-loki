#!/usr/bin/env bash
set -euo pipefail

VERSION=$1

bundle install --path=lib/ --binstubs=bin/ --standalone
tar vzcf "sensu-plugins-loki-${VERSION}.tgz" bin lib
