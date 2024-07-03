#!/bin/bash

set -ex

export WORKDIR=$(pwd)/..
export INSTALL_SCRIPTS_DIR=$(pwd)
mkdir -p "${WORKDIR}"

apt update
apt install -y python3.8 python3.8-distutils libpython3.8-dev python3.8-tk xvfb psmisc telnet

# install and initialize conda
set +e
"${SHELL}" <(curl -L micro.mamba.pm/install.sh)
micromamba create -n eureka -y python=3.8
set -e

pushd "${WORKDIR}" 
    git clone https://github.com/eureka-research/Eureka.git || true
    wget -nc -O /tmp/IsaacGym_Preview_4_Package.tar.gz https://developer.nvidia.com/isaac-gym-preview-4 || true
    tar -xvf /tmp/IsaacGym_Preview_4_Package.tar.gz
    cp -f "${INSTALL_SCRIPTS_DIR}/patches/isaacgym/python/setup.patched.py" "${WORKDIR}/isaacgym/python/setup.py"
popd


micromamba run -n eureka bash install.internal.sh
