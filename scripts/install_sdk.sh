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

# Install platform 21
echo y | $SDK_LOC/tools/android update sdk --no-ui --all --filter build-tools-21.1.2
echo y | $SDK_LOC/tools/android update sdk --no-ui --all --filter platform-tools
echo y | $SDK_LOC/tools/android update sdk --no-ui --all --filter android-21
echo y | $SDK_LOC/tools/android update sdk --no-ui --all --filter extra-android-support
echo y | $SDK_LOC/tools/android update sdk --no-ui --all --filter extra-google-google_play_services
echo y | $SDK_LOC/tools/android update sdk --no-ui --all --filter extra-google-m2repository
echo y | $SDK_LOC/tools/android update sdk --no-ui --all --filter extra-android-m2repository

# Set SDK Permissions
echo "Setting SDK permissions"
sudo chown -R vagrant: "/home/vagrant/Android"
