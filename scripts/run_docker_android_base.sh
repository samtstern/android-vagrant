#!/bin/sh
sudo docker run -ti --privileged \
    -v /dev/bus/usb:/dev/bus/usb \
    "samtstern/android-base" \
    /bin/bash
