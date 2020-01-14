#!/usr/bin/env bash
set -euo pipefail

VERSION=0.0.4

tar vzcf "sensu-plugins-loki-${VERSION}.tgz" bin
