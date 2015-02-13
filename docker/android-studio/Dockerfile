FROM samtstern/android-base

USER root

ENV HOME="/home/vagrant"
ENV STUDIO_LINK="https://dl.google.com/dl/android/studio/ide-zips/1.0.1/android-studio-ide-135.1641136-linux.zip"
ENV ZIP_LOC="$HOME/android-studio.zip"
ENV STUDIO_LOC="$HOME/android-studio"

# Download and Unzip Android Studio, then delete the zip
RUN echo "Downloading Android Studio" && \
    mkdir -p $HOME && \
    wget $STUDIO_LINK -O $ZIP_LOC && \
    echo "Unzipping Android Studio" && \
    unzip -d $STUDIO_LOC $ZIP_LOC && \
    echo "Cleaning up..." && \
    rm $ZIP_LOC

# 1000 is the default vagrant uid/gid
RUN export uid=1000 gid=1000 && \
    mkdir -p $HOME && \
    echo "vagrant:x:${uid}:${gid}:Vagrant,,,:/home/vagrant:/bin/bash" >> /etc/passwd && \
    echo "vagrant:x:${uid}:" >> /etc/group && \
    echo "vagrant ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/vagrant && \
    chmod 0440 /etc/sudoers.d/vagrant && \
    chown ${uid}:${gid} -R /home/vagrant

# Install extra Android SDK components
ENV ANDROID_SDK_COMPONENTS=platform-tools,build-tools-21.1.2,android-21,extra-android-support
RUN echo y | ${ANDROID_HOME}/tools/android update sdk --no-ui --all --filter "${ANDROID_SDK_COMPONENTS}"

# Run Android Studio
USER vagrant
CMD sh $HOME/android-studio/android-studio/bin/studio.sh & /bin/bash
