#!/bin/bash

# README
# ------------------------------
#  
# "OPENSSL_DIR" env var needs to be set
# TODO: "ANDROID_NDK_HOME" env var needs to be set
# 

set -e
set -x

# TODO: use bashsource ?

# If OPENSSL_DIR is not set, then fallback to a default value
OPENSSL_DIR=${OPENSSL_DIR:-"../openssl"}

SCRIPT_PATH=`readlink -f "${BASH_SOURCE:-$0}"`
SCRIPT_DIR=`dirname ${SCRIPT_PATH}`

# Find the toolchain for your build machine
toolchains_path=$(python3 ${SCRIPT_DIR}/toolchains_path.py --ndk ${ANDROID_NDK_HOME})

# Configure the OpenSSL environment, refer to NOTES.ANDROID in OPENSSL_DIR
# Set compiler clang, instead of gcc by default
CC=clang

# Add toolchains bin directory to PATH
PATH=$toolchains_path/bin:$PATH

# clean
cd ${OPENSSL_DIR} 

make clean
