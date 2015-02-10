#!/bin/bash
ADB=/home/vagrant/Android/Sdk/platform-tools/adb

sudo $ADB kill-server
sudo $ADB start-server
$ADB devices
