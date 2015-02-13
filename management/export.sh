#!/bin/bash
mkdir archive

vagrant package \
    --output archive/package.box \
    --vagrantfile management/Vagrantfile \
    --include docker,scripts
