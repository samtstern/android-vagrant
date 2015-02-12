FROM ubuntu:14.04

ENV HOME="/home/vagrant"
ENV SDK_LINK="http://dl.google.com/android/android-sdk_r24.0.2-linux.tgz"
ENV TAR_LOC="$HOME/android-sdk.tgz"
ENV SDK_LOC="$HOME/Android/Sdk"

# Dependencies
RUN apt-get update && \
    dpkg --add-architecture i386 && \
    apt-get install -y python-software-properties build-essential  zlib1g-dev libncurses5-dev lib32ncurses5-dev && \
    apt-get install -y git wget unzip && \
    apt-get install -y default-jdk

# Download and unzip SDK, then clean up
RUN echo "Downloading SDK to $TAR_LOC" && \
    mkdir -p $HOME && \
    wget $SDK_LINK -O $TAR_LOC  && \
    echo "Unzipping SDK to $SDK_LOC"  && \
    mkdir -p $SDK_LOC  && \
    tar -xvf $TAR_LOC -C $SDK_LOC --strip-components=1 && \
    echo "Cleaning up" && \
    rm $TAR_LOC

# Install Android SDK components
RUN echo y | $SDK_LOC/tools/android update sdk --no-ui --all --filter build-tools-21.1.2 && \
    echo y | $SDK_LOC/tools/android update sdk --no-ui --all --filter platform-tools && \
    echo y | $SDK_LOC/tools/android update sdk --no-ui --all --filter android-21 && \
    echo y | $SDK_LOC/tools/android update sdk --no-ui --all --filter extra-android-support && \
    echo y | $SDK_LOC/tools/android update sdk --no-ui --all --filter extra-google-google_play_services && \
    echo y | $SDK_LOC/tools/android update sdk --no-ui --all --filter extra-google-m2repository && \
    echo y | $SDK_LOC/tools/android update sdk --no-ui --all --filter extra-android-m2repository && \
    echo y | $SDK_LOC/tools/android update sdk --no-ui --all --filter source-21 && \
    echo y | $SDK_LOC/tools/android update sdk --no-ui --all --filter addon-google_apis-google-21 && \
    echo y | $SDK_LOC/tools/android update sdk --no-ui --all --filter sys-img-x86-addon-google_apis-google-21

# 1000 is the default vagrant uid/gid
RUN export uid=1000 gid=1000 && \
    mkdir -p $HOME && \
    mkdir -p /etc/sudoers.d && \
    echo "vagrant:x:${uid}:${gid}:Vagrant,,,:/home/vagrant:/bin/bash" >> /etc/passwd && \
    echo "vagrant:x:${uid}:" >> /etc/group && \
    echo "vagrant ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/vagrant && \
    chmod 0440 /etc/sudoers.d/vagrant && \
    chown ${uid}:${gid} -R $HOME

# Set SDK Permissions
RUN echo "Setting SDK permissions" && \
    chown -R vagrant: "$HOME/Android"

# ADB is 32-bit
RUN apt-get update && \
    apt-get install -y libncurses5:i386 libstdc++6:i386 zlib1g:i386

# Path
ENV PATH=$PATH:$HOME/Android/Sdk/tools
ENV PATH=$PATH:$HOME/Android/Sdk/platform-tools

USER vagrant
