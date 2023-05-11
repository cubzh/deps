#!/bin/bash
set -e

# Set directory
SCRIPTPATH=`realpath .`

${SCRIPTPATH}/clean.sh
${SCRIPTPATH}/build.sh arm

${SCRIPTPATH}/clean.sh 
${SCRIPTPATH}/build.sh arm64

${SCRIPTPATH}/clean.sh
${SCRIPTPATH}/build.sh x86

${SCRIPTPATH}/clean.sh
${SCRIPTPATH}/build.sh x86_64
