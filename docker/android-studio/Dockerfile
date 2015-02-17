FROM samtstern/android-base

# Download and Unzip Android Studio
ENV ANDROID_STUDIO_URL https://dl.google.com/dl/android/studio/ide-zips/1.0.1/android-studio-ide-135.1641136-linux.zip
RUN curl -L ${ANDROID_STUDIO_URL} -o /tmp/android-studio-ide.zip && unzip /tmp/android-studio-ide.zip -d /usr/local && rm /tmp/android-studio-ide.zip
ENV ANDROID_STUDIO_HOME /usr/local/android-studio

# Install extra Android SDK
ENV ANDROID_SDK_EXTRA_COMPONENTS extra-google-google_play_services,extra-google-m2repository,extra-android-m2repository,source-21,addon-google_apis-google-21,sys-img-x86-addon-google_apis-google-21
RUN echo y | ${ANDROID_HOME}/tools/android update sdk --no-ui --all --filter "${ANDROID_SDK_EXTRA_COMPONENTS}"

# Create studio user and home volume
RUN useradd -u 1000 -d /home/studio -s /sbin/nologin -m studio
VOLUME /home/studio

# Path
ENV PATH $PATH:${ANDROID_STUDIO_HOME}/bin

# Set Android Studio entrypoint
USER studio
ENTRYPOINT studio.sh
