#!/bin/bash
set -ex

curl -sSL https://get.docker.com/ubuntu/ | sh
sudo gpasswd -a vagrant docker
docker build -t android-base /vagrant/docker/android-base
docker build -t android-studio /vagrant/docker/android-studio
