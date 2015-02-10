#!/bin/bash
BASH_RC="/home/vagrant/.bashrc"
MY_TAG="# -------- VAGRANT --------"

if grep -q "$MY_TAG" "$BASH_RC";
then
	echo "$BASH_RC already configured"
else
	echo "Configuring $BASH_RC"
	echo "$MY_TAG" >> $BASH_RC
	cat /vagrant/scripts/my_bashrc.txt >> $BASH_RC
fi

