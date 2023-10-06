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

dnf repolist

# Install Kernel dependencies
dnf install -y  kernel-headers \
                kernel-devel

# Install Python 3
dnf install -y python3

# Only python 3.9 available in Mariner 2.0
# symlinks didn't work
# ln -fs python3.9 /usr/bin/python3.6
# ln -fs python3.9-config /usr/bin/python3.6-config
# ln -fs pydoc3.9 /usr/bin/pydoc3.6

# install pssh
# pssh_metadata=$(jq -r '.pssh."'"$DISTRIBUTION"'"' <<< $COMPONENT_VERSIONS)
# pssh_version=$(jq -r '.version' <<< $pssh_metadata)
# pssh_sha256=$(jq -r '.sha256' <<< $pssh_metadata)
# pssh_download_url="https://dl.fedoraproject.org/pub/epel/8/Everything/aarch64/Packages/p/pssh-$pssh_version.el8.noarch.rpm"
# $COMMON_DIR/download_and_verify.sh $pssh_download_url $pssh_sha256

# dnf install -y  pssh-$pssh_version.el8.noarch.rpm
# rm -f pssh-$pssh_version.el8.noarch.rpm

dnf install -y python3-devel \
    gtk2 \
    glibc-devel \
    libudev-devel \
    selinux-policy-devel \
    fuse-libs \
    libnl3-devel \
    rpm-build \
    make \
    mariner-rpm-macros \
    tk \
    binutils-devel \
    munge \
    numactl-devel \
    environment-modules \
    pam-devel \
    ed \
    pciutils
    
## Disable kernel updates
echo "exclude=kernel* kmod*" | tee -a /etc/dnf/dnf.conf

# Disable dependencies on kernel core
sed -i "$ s/$/ shim*/" /etc/dnf/dnf.conf
sed -i "$ s/$/ grub2*/" /etc/dnf/dnf.conf

## Install dkms from the EPEL repository
wget -r --no-parent -A "dkms-*.el8.noarch.rpm" https://dl.fedoraproject.org/pub/epel/8/Everything/x86_64/Packages/d/
dnf localinstall -y ./dl.fedoraproject.org/pub/epel/8/Everything/x86_64/Packages/d/dkms-*.el8.noarch.rpm

## Install subunit and subunit-devel from EPEL repository
wget -r --no-parent -A "subunit-*.el8.x86_64.rpm" https://dl.fedoraproject.org/pub/epel/8/Everything/x86_64/Packages/s/
dnf localinstall -y ./dl.fedoraproject.org/pub/epel/8/Everything/x86_64/Packages/s/subunit-[0-9].*.el8.x86_64.rpm
dnf localinstall -y ./dl.fedoraproject.org/pub/epel/8/Everything/x86_64/Packages/s/subunit-devel-[0-9].*.el8.x86_64.rpm

# Remove rpm files
rm -rf ./dl.fedoraproject.org/

# Install common dependencies
$COMMON_DIR/install_utils.sh

# copy kvp client file
$COMMON_DIR/copy_kvp_client.sh

rm -rf ./packages.microsoft.com/