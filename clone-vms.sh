#!/bin/bash
NODES=( 
    "m0" 
    "w0" 
    "w1" 
)

BASE_IMG="z_images_ubuntu18.04"
for i in "${NODES[@]}"
do
    echo "creating clone for ${i} from ${BASE_IMG}."
    virt-clone \
        --original $BASE_IMG \
        --name $i \
        --file /home/josh/d/vm/disks/${i}.qcow2
done