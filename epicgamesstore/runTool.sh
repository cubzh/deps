#!/bin/bash

# exit when any command fails
set -e

CUBZH_RELEASE_BUILD_VERSION="0.0.51_115"

SCRIPT_PATH=`readlink -f "${BASH_SOURCE:-$0}"`
SCRIPT_DIR=`dirname ${SCRIPT_PATH}`
# echo "SCRIPT_DIR: ${SCRIPT_DIR}"

# ------------------------------
# Cubzh release paths
# ------------------------------

_CUBZH_RELEASE_DIR="/Users/gaetan/projects/voxowl/particubes-private/distribution/builds"
CUBZH_RELEASE_WINDOWS_ABSPATH="${_CUBZH_RELEASE_DIR}/Cubzh.exe"
CUBZH_RELEASE_MACOS_ABSPATH="${_CUBZH_RELEASE_DIR}/Cubzh.zip"

# ------------------------------
# Epic Games Store
# ------------------------------

# Those are env vars
# CLIENTID=""
# CLIENTSECRET=""
# ORGANIZATION_ID=""
# PRODUCT_ID=""
# ARTIFACT_ID=""

# ------------------------------
# Prepare upload
# ------------------------------

mkdir -p $SCRIPT_DIR/macos
mkdir -p $SCRIPT_DIR/upload
mkdir -p $SCRIPT_DIR/windows

rm -rf $SCRIPT_DIR/macos/*
rm -rf $SCRIPT_DIR/upload/*
rm -rf $SCRIPT_DIR/windows/*

# ------------------------------
# Upload build
# ------------------------------

# Copy release from project to local directory
# Windows
cp $CUBZH_RELEASE_WINDOWS_ABSPATH $SCRIPT_DIR/windows/Cubzh.exe
# macOS
cp $CUBZH_RELEASE_MACOS_ABSPATH $SCRIPT_DIR/macos/Cubzh.zip
unzip -d $SCRIPT_DIR/macos $SCRIPT_DIR/macos/Cubzh.zip
rm $SCRIPT_DIR/macos/Cubzh.zip

# Send Windows build to Epic Games Store
$SCRIPT_DIR/buildpatchtool/tool/Engine/Binaries/Mac/BuildPatchTool \
-OrganizationId="${ORGANIZATION_ID}" \
-ProductId="${PRODUCT_ID}" \
-ArtifactId="${ARTIFACT_ID}" \
-ClientId="${CLIENTID}" \
-ClientSecret="${CLIENTSECRET}" \
-mode=UploadBinary \
-BuildRoot="${SCRIPT_DIR}/windows" \
-CloudDir="${SCRIPT_DIR}/upload" \
-BuildVersion="${CUBZH_RELEASE_BUILD_VERSION}_windows" \
-AppLaunch="Cubzh.exe" \
-AppArgs=""

# cleanup
rm -rf $SCRIPT_DIR/upload/*

# Send macOS build to Epic Games Store
$SCRIPT_DIR/buildpatchtool/tool/Engine/Binaries/Mac/BuildPatchTool \
-OrganizationId="${ORGANIZATION_ID}" \
-ProductId="${PRODUCT_ID}" \
-ArtifactId="${ARTIFACT_ID}" \
-ClientId="${CLIENTID}" \
-ClientSecret="${CLIENTSECRET}" \
-mode=UploadBinary \
-BuildRoot="${SCRIPT_DIR}/macos" \
-CloudDir="${SCRIPT_DIR}/upload" \
-BuildVersion="${CUBZH_RELEASE_BUILD_VERSION}_macos" \
-AppLaunch="Cubzh.app/Contents/MacOS/Cubzh" \
-AppArgs=""
