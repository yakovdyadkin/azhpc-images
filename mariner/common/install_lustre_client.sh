#!/bin/bash
set -ex

LUSTRE_VERSION=2.15.1-29-gbae0abe

source $MARINER_COMMON_DIR/setup_lustre_repo.sh

dnf install -y --disableexcludes=main --refresh amlfs-lustre-client-${LUSTRE_VERSION}-$(uname -r | sed -e "s/\.$(uname -p)$//" | sed -re 's/[-_]/\./g')-1

$COMMON_DIR/write_component_version.sh "lustre" $lustre_version
