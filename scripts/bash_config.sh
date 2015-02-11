#!/bin/bash
BASH_RC="/home/vagrant/.bashrc"
SOURCE_LINE="source /vagrant/scripts/my_bashrc.txt"

if grep -q "$SOURCE_LINE" "$BASH_RC";
then
	echo "$BASH_RC already configured"
else
	echo "Configuring $BASH_RC"
	echo "$SOURCE_LINE" >> $BASH_RC
fi
