#!/bin/bash
set -ex

# dependencies for spack installation
# Ref: https://spack.readthedocs.io/en/latest/getting_started.html
# dnf group install "Development Tools" -y
# Group unavailable in so installing required individual packages
tdnf install -y build-essential \
    gdb \
    git \
    lmdb-devel \
    patchutils  

tdnf install -y curl \
    findutils \
    gcc-gfortran \
    gnupg2 \
    iproute \
    python3-pip \
    unzip

## Environment setup for Component installations using Spack
# Create a directory to setup an environment
mkdir -p $HPC_ENV

# Clone Spack into HPC Directory
git clone -c feature.manyFiles=true https://github.com/spack/spack.git $HPC_ENV/spack
spack_branch=$(jq -r '.spack."'"$DISTRIBUTION"'".branch' <<< $COMPONENT_VERSIONS)
pushd $HPC_ENV/spack
git checkout $spack_branch
popd

# Set environment variables
source_spack_env=". $HPC_ENV/spack/share/spack/setup-env.sh"
eval $source_spack_env
# Preserve Spack environment on reboots
echo $source_spack_env | tee -a /etc/bashrc

# Write spack to component versions
spack_version=$(spack --version | cut -d ' ' -f 1)
$COMMON_DIR/write_component_version.sh "spack" $spack_version

# Create an environment/ container in /opt
spack env create -d $HPC_ENV
echo "spack env activate $HPC_ENV" | tee -a /etc/bashrc
