# android-vagrant
Experimental Vagrant setup to install a minimal Linux VM with the Android SDK, Android Studio, and adb debugging over USB.  Designed to work on Mac, Windows, and Linux.

## Prerequisites
Before you begin, you will need to download the following applications:

  * [Vagrant](http://www.vagrantup.com/downloads.html)
  * [VirtualBox](https://www.virtualbox.org/wiki/Downloads)

## Install
Navigate to the directory where you cloned this repository and run `vagrant up`.  This will kick off a fairly lengthy process that downloads and installs the following:

  * 64-bit Ubuntu VM
  * Xubuntu Desktop
  * Docker

Once this process completes, you should run `vagrant halt` to shut down the VM.  This shutdown is only required the first time you provision the VM.

## Running the VM
Run `vagrant up`.  You should see a VirtualBox window with a login prompt.  Select the "vagrant" user and enter the password "vagrant" when prompted.

From your host machine, run `vagrant ssh` inside the `android-vagrant` directory.  This will connect you to the VM.  You could also press `Ctrl+Alt+t` inside the VM to bring up a Terminal, but using ssh on the host machine has performance benefits.

So far the VM doesn't do anything interesting!  This is because all of the real functionality is in docker containers.  The next section describes how to run the container you want.

## Running Docker
There are a few docker images described in the `android-vagrant/docker` folder:

* `android-base` - contains Java, the Android SDK, and all of the extras and tools (Google Play Services, adb, aapt, etc.)
* `android-studio` - based on `android-base` that contains Android Studio and allows you to run Android Studio graphically in the vagrant VM.

To build a docker image  and run a container, execute the following commands in your vagrant ssh session:

	cd /vagrant/docker/$DOCKER_IMAGE
	sh build.sh
	sh run.sh
	
That will build the docker image and then run a container with the proper options (such as USB forwarding, X11 display, etc).


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

## Importing and Exporting
If you made it this far you have probably been at your computer a while watching dependencies download, SDKs build, packages install, dockers dock, etc.  If you never want to have to do that again, even on another machine, you can import/export the current state of your VM using the `management/import.sh` and `management/export.sh` scripts.  Run these from the root folder of the repository (probably `android-vagrant`).

`management/export.sh` will create a folder adjacent to your `Vagrantfile` called `archive` that contains the VirtualBox VM and some vagrant metadata.  If you delete your VM (using `vagrant destroy`) and then run `import.sh`, you will find that it has been restored exactly as you left it!
