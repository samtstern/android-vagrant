#!/bin/sh
# $1 - container name
# $2 - command to run (optional)
sudo docker run -ti --privileged \
    -e DISPLAY \
    -v /dev/bus/usb:/dev/bus/usb \
    -v /tmp/.X11-unix:/tmp/.X11-unix \
    -v /vagrant:/vagrant \
    $1 $2
