#!/bin/bash

# Config
OPENSSL_GIT_REPO="https://github.com/gdevillele/openssl.git"
OPENSSL_GIT_BRANCH="OpenSSL_1_1_1-stable-cubzh-patch"

set -e

docker run \
--rm \
-v $(pwd)/openssl:/repo/openssl \
ubuntu:22.04 \
bash -c "set -e; apt update; apt install -y git; mkdir -p /repo/openssl; find /repo/openssl -mindepth 1 -delete; git clone --depth 1 --branch ${OPENSSL_GIT_BRANCH} ${OPENSSL_GIT_REPO} /repo/openssl; exit 0;"
