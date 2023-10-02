#!/bin/bash
set -ex

# Set NVIDIA fabricmanager version
nvidia_fabricmanager_metadata=$(jq -r '.nvidia."'"$DISTRIBUTION"'".fabricmanager' <<< $COMPONENT_VERSIONS)
nvidia_fabricmanager_version=$(jq -r '.version' <<< $nvidia_fabricmanager_metadata)

dnf install -y nvidia-fabric-manager-$nvidia_fabricmanager_version
$COMMON_DIR/write_component_version.sh "nvidia_fabricmanager" $nvidia_fabricmanager_version