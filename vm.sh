#!/bin/bash

# You can specify a vm like windows 10 or get the vm name from input argument
# VMNAME='win10'
VMNAME="$1"

# checking if the vm is already running
tmp=$(virsh --connect qemu:///system list --all | grep "$VMNAME " | awk '{ print $3}')
if ([ "x$tmp" == "x" ] || [ "x$tmp" != "xrunning" ])
then
    echo "VM does not exist or is shut down!"
    # In that case we start the vm
    virsh --connect qemu:///system start $VMNAME
else
    echo "VM is running!"
fi

# In normal cases this would directly start the gui for the n-th system 
# but I use it as a gui menu, because when the n-th system isn't running
# it shows you a menu for choosing a currently running vm
virt-viewer --connect qemu:///system 13 
