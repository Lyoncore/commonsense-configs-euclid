#!/bin/bash

sudo cp * /lib/firmware/brcm/

sudo cp grandom.sh /etc/init.d/
sudo update-rc.d /etc/init.d/grandom.sh defaults
