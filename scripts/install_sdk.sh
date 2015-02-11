SDK_LINK="http://dl.google.com/android/android-sdk_r24.0.2-linux.tgz"
TAR_LOC="/home/vagrant/android-sdk.tgz"
SDK_LOC="/home/vagrant/Android/Sdk"

# Download SDK
if ! [ -e $TAR_LOC ]
then
	echo "Downloading SDK to $TAR_LOC"
	wget $SDK_LINK -O $TAR_LOC
else
	echo "SDK already downloaded to $TAR_LOC"
fi

# Unzip SDK
if ! [ -e $SDK_LOC ]
then
  echo "Unzipping SDK to $SDK_LOC"
  mkdir -p $SDK_LOC
  tar -xvf $TAR_LOC -C $SDK_LOC --strip-components=1
else
  echo "SDK detected at $SDK_LOC"
fi

# Auto-install Android SDK Component
sdk_install() {
    echo y | $SDK_LOC/tools/android update sdk --no-ui --all --filter $1
}

sdk_install build-tools-21.1.2
sdk_install platform-tools
sdk_install android-21
sdk_install extra-android-support
sdk_install extra-google-google_play_services
sdk_install extra-google-m2repository
sdk_install extra-android-m2repository
sdk_install source-21
sdk_install addon-google_apis-google-21
sdk_install sys-img-x86-addon-google_apis-google-21

# Set SDK Permissions
echo "Setting SDK permissions"
sudo chown -R vagrant: "/home/vagrant/Android"
