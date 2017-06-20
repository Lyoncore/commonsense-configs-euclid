#!/bin/bash

#set -x 
#set -e

echo "Install fan_control.sh..."
sudo cp fan_control.sh /etc/init.d/
sudo chmod a+x /etc/init.d/fan_control.sh
sudo update-rc.d fan_control.sh defaults >& /dev/null
echo "Done!"

