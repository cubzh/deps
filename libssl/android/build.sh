#!/bin/bash
set -e

# ==================================================
# FUNCTIONS
# ==================================================
arch_is_invalid() {
    local valid=( arm arm64 x86 x86_64 )
    local value=$1
    for elem in "${valid[@]}"; do
        [[ $value == $elem ]] && return 1
    done
    return 0
}
# ==================================================

if [ "$#" -ne 1 ]; then
    echo "❌ Illegal number of parameters ($#). Expected 1."
fi

TARGET_ARCH=${1}

if arch_is_invalid "${TARGET_ARCH}"; then
    echo "❌ Architecture NOT supported: ${TARGET_ARCH}. Exiting."
    exit 1
fi

echo "=================================================="
echo "⚙️  Building OpenSSL for Android > ${TARGET_ARCH} <"
echo "=================================================="

set -x

# Set directory
SCRIPTPATH=`realpath .`

# If OPENSSL_DIR is not set, then fallback to a default value
OPENSSL_DIR=${OPENSSL_DIR:-"../openssl"}

# Find the toolchain for your build machine
toolchains_path=$(python3 toolchains_path.py --ndk ${ANDROID_NDK_HOME})

# Configure the OpenSSL environment, refer to NOTES.ANDROID in OPENSSL_DIR
# Set compiler clang, instead of gcc by default
CC=clang

# Add toolchains bin directory to PATH
PATH=$toolchains_path/bin:$PATH

# Set the Android API levels
# ANDROID_API=21

# Set the target architecture
# Can be android-arm, android-arm64, android-x86, android-x86 etc
architecture=android-${TARGET_ARCH}

# Create the make file
cd ${OPENSSL_DIR}
# ./Configure ${architecture} -D__ANDROID_API__=$ANDROID_API
./Configure ${architecture}

# Build
make

# Copy the outputs
OUTPUT_INCLUDE=$SCRIPTPATH/output/include
OUTPUT_LIB=$SCRIPTPATH/output/lib/${TARGET_ARCH}
mkdir -p $OUTPUT_INCLUDE
mkdir -p $OUTPUT_LIB
cp -RL include/crypto $OUTPUT_INCLUDE
cp -RL include/internal $OUTPUT_INCLUDE
cp -RL include/openssl $OUTPUT_INCLUDE
cp libcrypto.so $OUTPUT_LIB
cp libcrypto.a $OUTPUT_LIB
cp libssl.so $OUTPUT_LIB
cp libssl.a $OUTPUT_LIB
