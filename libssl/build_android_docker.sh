#!/bin/bash

set -e

# ------------------------------
# Variables
# ------------------------------
SCRIPT_PATH=`realpath .`

# ------------------------------
# 
# ------------------------------
docker run --rm -ti \
-v ${SCRIPT_PATH}:/project \
-w /project \
voxowl/android-sdk ./build_android.sh
