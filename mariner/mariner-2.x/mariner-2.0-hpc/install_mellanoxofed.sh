#!/bin/bash
set -ex

mofed_metadata=$(jq -r '.mofed."'"$DISTRIBUTION"'"' <<< $COMPONENT_VERSIONS)
mofed_version=$(jq -r '.version' <<< $mofed_metadata)
mofed_sha256=$(jq -r '.sha256' <<< $mofed_metadata)
tarball="MLNX_OFED_SRC-$mofed_version-fc32-x86_64.tgz"
#mofed_download_url=https://content.mellanox.com/ofed/MLNX_OFED-$mofed_version/$tarball
mofed_download_url=https://azhpcstor.blob.core.windows.net/azhpc-images-store/${tarball}
mofed_folder=$(basename $mofed_download_url .tgz)
kernel_without_arch="${KERNEL%.*}"

$COMMON_DIR/download_and_verify.sh $mofed_download_url $mofed_sha256
tar zxvf $tarball

./$mofed_folder/install.pl --kernel $kernel_without_arch --kernel-sources /usr/src/linux-headers-$kernel_without_arch --all --without-openmpi --builddir /opt
$COMMON_DIR/write_component_version.sh "mofed" $mofed_version

# Updating initramfs
dracut -f

# Restarting openibd
/etc/init.d/openibd restart

# exclude opensm from updates
sed -i "$ s/$/ opensm*/" /etc/dnf/dnf.conf

# cleanup downloaded files
rm -rf *.tgz
rm -rf -- */
