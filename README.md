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

* `samtstern/android-base` - contains Java, the Android SDK, and all of the extras and tools (Google Play Services, adb, aapt, etc.)
* `samtstern/android-studio` - based on `samtsternandroid-base` that contains Android Studio and allows you to run Android Studio graphically in the vagrant VM.

To build a docker image, run one of the `build_docker_*_.sh` scripts in the `/vagrant/scripts` folder.

To run a docker image that you built, run `sh run_docker.sh $CONTAINER_NAME $CMD`, replacing `$CONTAINER_NAME` with the name of the container to run, and `$CMD` (optional) with a command to run.  Example:

	# Run `adb devices` in the base android image
	run_docker.sh "samtstern/android-base" "adb devices"
	
	# Run the android studio image
	run_docker.sh "samtstern/android-studio"

Note: the images are hosted on docker hub, so `samtstern/android-studio` can be built without first building `samtstern/android-base`, however due to network performance issues in VirtualBox it is usually faster to build the `samtstern/android-base` image locally and then build the `samtstern/android-studio` image.


## USB Debugging
Connect your Android device to your computer using a USB cable.  Make sure you have [enabled USB debugging](http://developer.android.com/tools/device.html#setting-up) on your device.  From the VM menu, select **Devices > USB Devices > [your device]**.  This will connect your device to the VM over USB.  Run `adb devices` to confirm that it is connected.

If you accept the debugging dialog on your phone, then your device's status will change from `unauthorized` to `device` and you are ready for debugging.  

If you have problems connecting with `adb`, run:

 	sudo /Android/Sdk/platform-tools/adb kill-server && \
 	sudo /Android/Sdk/platform-tools/adb start-server && \
 	adb devices
 	
to restart the `adb` server.

## Sharing Code and Files
The `/vagrant` directory (don't confuse this with `/home/vagrant`, which is `$HOME`) in the VM is synchronized with the directory containing the `Vagrantfile` on your host machine.  If you create Android Studio projects in the VM's `/vagrant` directory, they will be synchronized to your host machine for later editing/sharing.  Any files written in other directories will be stored only on the VM and will not be available from the host machine.

**Note:** Docker images **do not persist files between runs**, unless the file is mapped to an external, persistent directory.  The `run_docker.sh` script maps the `/vagrant` directory inside the container to the VM (and the VM maps it to the host machine), so save all code in that directory.

## Importing and Exporting VMs
If you made it this far you have probably been at your computer a while watching dependencies download, SDKs build, packages install, dockers dock, etc.  If you never want to have to do that again, even on another machine, you can import/export the current state of your VM using the `management/import.sh` and `management/export.sh` scripts.  Run these from the root folder of the repository (probably `android-vagrant`).

`management/export.sh` will create a folder adjacent to your `Vagrantfile` called `archive` that contains the VirtualBox VM and some vagrant metadata.  If you delete your VM (using `vagrant destroy`) and then run `import.sh`, you will find that it has been restored exactly as you left it!
