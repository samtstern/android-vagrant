#!/bin/bash

# File action_set_name is first arg
NAME_FILE=$1

# Get the VM ID
# List all VMs, filter by PARTIAL_NAME, get the UUID column, strip braces
PARTIAL_NAME=$(cat $NAME_FILE)
VM_ID=$(VBoxManage list vms | \
        grep "$PARTIAL_NAME" | \
        awk '{print $2}' | \
        sed 's/[{,}]//g')

echo $VM_ID
