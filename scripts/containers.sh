CONTAINERS=/vagrant/container_list

while read container
do
    docker run                           \
        --privileged                     \
        --restart                        \
        -e DISPLAY=$DISPLAY              \
        -v /tmp/.X11-unix:/tmp/.X11-unix \
        -v /dev/bus/usb:/dev/bus/usb     \
        $container
done <$CONTAINERS
