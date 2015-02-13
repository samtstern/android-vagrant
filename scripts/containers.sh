CONTAINERS=/vagrant/container_list
RESTART=no  # May be one of no, on-failure, or always.

while read container
do
    docker run                           \
        --privileged                     \
        --restart=$RESTART               \
        -e DISPLAY=$DISPLAY              \
        -v /tmp/.X11-unix:/tmp/.X11-unix \
        -v /dev/bus/usb:/dev/bus/usb     \
        $container
done <$CONTAINERS
