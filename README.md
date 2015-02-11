# android-vagrant
Experimental Vagrant setup to install a minimal Linux VM with the Android SDK, Android Studio, and adb debugging over USB.  Designed to work on Mac, Windows, and Linux.

## Prerequisites
Before you begin, you will need to download the following applications:

  * [Vagrant](http://www.vagrantup.com/downloads.html)
  * [VirtualBox](https://www.virtualbox.org/wiki/Downloads)

## Setup
Navigate to the directory where you cloned this repository and run `vagrant up`.  This will kick off a fairly lengthy process that downloads and installs the following:

  * 32-bit Ubuntu VM
  * Xubuntu Desktop
  * Java/JDK
  * Android SDK and Tools
  * Android Studio
  * Android 'extras' (Google Play Services, Android Support Repository, etc)

Once this process completes, you should run `vagrant halt` to shut down the VM.  This shutdown is only required the first time you provision the VM.

## Running
Run `vagrant up`.  You should see a VirtualBox window with a login prompt.  Select the "vagrant" user and enter the password "vagrant" when prompted.  When you reach the desktop, press `Ctrl + Alt + t` to open a Terminal window inside the VM.

The command `run_studio` will start Android Studio.  The first time you run Android Studio select **Custom Setup** and de-select the box that will install the Android Emulator.  The performance of an emulator within the VM is too slow so you should debug with a real device over USB.

## USB Debugging
Connect your Android device to your computer using a USB cable.  Make sure you have [enabled USB debugging](http://developer.android.com/tools/device.html#setting-up) on your device.  From the VM menu, select **Devices > USB Devices > [your device]**.  This will connect your device to the VM over USB.  Run `adb devices` to confirm that it is connected.  If you see output like:

	List of devices attached
	??????????? 	no permissions
	
then you need to run `sh /vagrant/scripts/fix_adb.sh`.  You should then see output like:

	List of devices attached
	TXABC1234		unauthorized
	
if you accept the debugging dialog on your phone, then your device's status will change from `unauthorized` to `device` and you are ready for debugging.

## Sharing Code and Files
The `/vagrant` directory (don't confuse this with `/home/vagrant`, which is `$HOME`) in the VM is synchronized with the directory containing the `Vagrantfile` on your host machine.  If you create Android Studio projects in the VM's `/vagrant` directory, they will be synchronized to your host machine for later editing/sharing.
