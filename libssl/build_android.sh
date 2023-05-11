#!/bin/bash

set -e

# Set directory
SCRIPTPATH=`realpath .`

# 
export ANDROID_NDK_HOME=${ANDROID_NDK_HOME:-"/android/ndk/25.2.9519653"}

# 
LIBSSL_ANDROID_PATH=${SCRIPTPATH}/android
export OPENSSL_DIR=${SCRIPTPATH}/openssl

cd ${LIBSSL_ANDROID_PATH}

./clean.sh
./build.sh arm

./clean.sh 
./build.sh arm64

./clean.sh
./build.sh x86

./clean.sh
./build.sh x86_64
