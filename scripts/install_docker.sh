#!/bin/bash
set -ex

curl -sSL https://get.docker.com/ubuntu/ | sh
sudo gpasswd -a vagrant docker
