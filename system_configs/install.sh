#!/bin/sh

# auto login ubuntu
sudo cp -f -v etc/lightdm/lightdm.conf /etc/lightdm/

# sudoers ubuntu
sudo cp -f -v etc/sudoers.d/euclid /etc/sudoers.d

# networ interfaces
sudo cp -f -v etc/network/interfaces /etc/network/interfaces

# dhcpd config
sudo cp -f -v etc/dhcp/dhcpd.conf /etc/dhcp/dhcpd.conf
