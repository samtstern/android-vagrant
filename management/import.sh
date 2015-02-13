#!/bin/bash
# $1 - name of the box to use for import
vagrant box add archive/package.box --name $1
vagrant init $1
