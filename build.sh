#!/usr/bin/env bash
set -euo pipefail

VERSION=$1

tar vzcf "sensu-plugins-loki-${VERSION}.tgz" bin lib
