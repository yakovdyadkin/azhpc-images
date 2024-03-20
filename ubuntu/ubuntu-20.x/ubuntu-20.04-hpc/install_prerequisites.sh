#!/bin/bash
set -ex

# Don't allow the kernel to be updated
apt-mark hold linux-azure

# upgrade pre-installed components
apt update
# apt upgrade -y # test to see if this fixes lustre

# jq is needed to parse the component versions from the requirements.json file
apt install -y jq