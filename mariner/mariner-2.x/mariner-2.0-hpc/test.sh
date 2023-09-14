#!/bin/bash
set -ex

# set properties
source ./set_properties.sh

kernel_with_dots=$($KERNEL | sed 's/_/./g')

echo $KERNEL