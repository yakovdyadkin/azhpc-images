#!/bin/bash
set -ex

# Setup Mariner Extended packages repo
curl https://packages.microsoft.com/cbl-mariner/2.0/prod/extended/x86_64/config.repo > ./mariner-extended-prod.repo
cp ./mariner-extended-prod.repo /etc/yum.repos.d/

# Setup microsoft packages repository for moby
# Download the repository configuration package
curl https://packages.microsoft.com/config/rhel/8/prod.repo > ./microsoft-prod.repo
# Copy the generated list to the sources.list.d directory
cp ./microsoft-prod.repo /etc/yum.repos.d/

yum repolist

../common/install_utils.sh
