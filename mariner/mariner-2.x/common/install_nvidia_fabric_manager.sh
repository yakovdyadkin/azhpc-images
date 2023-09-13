#!/bin/bash
set -ex

# Set NVIDIA fabricmanager version
nvidia_fabricmanager_metadata=$(jq -r '.nvidia."'"$DISTRIBUTION"'".fabricmanager' <<< $COMPONENT_VERSIONS)
nvidia_fabricmanager_version=$(jq -r '.version' <<< $nvidia_fabricmanager_metadata)

dnf install -y https://packages.microsoft.com/cbl-mariner/2.0/prod/nvidia/x86_64/Packages/n/nvidia-fabric-manager-$nvidia_fabricmanager_version.cm2.x86_64.rpm
$COMMON_DIR/write_component_version.sh "nvidia_fabricmanager" $nvidia_fabricmanager_version
