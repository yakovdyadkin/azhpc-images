#!/bin/bash
set -ex

# Set the driver versions
cuda_metadata=$(jq -r '.cuda."'"$DISTRIBUTION"'"' <<< $COMPONENT_VERSIONS)
cuda_driver_version=$(jq -r '.driver.version' <<< $cuda_metadata)
cuda_samples_version=$(jq -r '.samples.version' <<< $cuda_metadata)
cuda_samples_sha256=$(jq -r '.samples.sha256' <<< $cuda_metadata)

# Install CUDA using spack
# If there is a space crunch for cuda installation clear /tmp/tmp*, /tmp/MLNX* and /tmp/ofed.conf
spack add cuda@$cuda_driver_version
spack concretize -f
spack install
echo 'export PATH=$PATH:/usr/local/cuda/bin' | tee -a /etc/profile
echo 'export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/cuda/lib64' | tee -a /etc/profile

$COMMON_DIR/write_component_version.sh "cuda" $cuda_driver_version

# Install CUDA samples
tarball="v$cuda_samples_version.tar.gz"
cuda_samples_download_url=https://github.com/NVIDIA/cuda-samples/archive/refs/tags/$tarball
$COMMON_DIR/download_and_verify.sh $cuda_samples_download_url $cuda_samples_sha256

tar -xvf $tarball
pushd ./cuda-samples-$cuda_samples_version
make
mv -vT ./Samples /usr/local/cuda/samples
popd

# Install NVIDIA driver
nvidia_driver_metadata=$(jq -r '.nvidia."'"$DISTRIBUTION"'".driver' <<< $COMPONENT_VERSIONS)
nvidia_driver_version=$(jq -r '.version' <<< $nvidia_driver_metadata)
dnf install -y https://packages.microsoft.com/cbl-mariner/2.0/prod/nvidia/x86_64/Packages/c/cuda-$nvidia_driver_version_$KERNEL.rpm 
$COMMON_DIR/write_component_version.sh "nvidia" $nvidia_driver_version

# Install gdrcopy
gdrcopy_version=$(jq -r '.gdrcopy."'"$DISTRIBUTION"'".version' <<< $COMPONENT_VERSIONS)
spack add gdrcopy@$gdrcopy_version
spack concretize -f
spack install
$COMMON_DIR/write_component_version.sh "gdrcopy" $gdrcopy_version

# Install nvidia fabric manager (required for ND96asr_v4)
../common/install_nvidia_fabric_manager.sh
