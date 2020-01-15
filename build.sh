#!/usr/bin/env bash
set -euo pipefail

GIT_REF="${1}"
GIT_REPO="https://github.com/roobert/sensu-plugins-loki"
GEM_NAME="sensu-plugins-loki"
TAG="${GIT_REF}"
WDIR="./bonsai"

if [[ ! -d bonsai ]]; then
   git clone https://github.com/sensu/sensu-go-bonsai-asset.git \
     --branch feature/ruby-plugin-assets bonsai
fi

docker build \
  --build-arg "ASSET_GEM=${GEM_NAME}" \
  --build-arg "GIT_REPO=${GIT_REPO}"  \
  --build-arg "GIT_REF=${GIT_REF}" \
  -t ruby-plugin-debian \
  -f "${WDIR}/ruby-runtime/Dockerfile.debian" .

docker cp \
  "$(docker create --rm ruby-plugin-debian:latest sleep 0):/${GEM_NAME}.tar.gz" \
  "./dist/${GEM_NAME}_${TAG}_debian_linux_amd64.tar.gz"
