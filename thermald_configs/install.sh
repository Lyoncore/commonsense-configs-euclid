#!/bin/sh
pid=`pgrep thermald`
echo "pid="$pid
sudo kill $pid
sudo update-rc.d fan_control.sh remove
sudo systemctl disable thermald.service
sudo cp thermald /usr/sbin/
sudo mkdir -p /usr/local/etc/thermald/
sudo cp thermal-conf.xml /usr/local/etc/thermald/
sudo cp thermald_control.sh /etc/init.d/
sudo chmod 755 /etc/init.d/thermald_control.sh
cp show_temp.sh /home/euclid/
chmod 777 /home/euclid/show_temp.sh
sudo update-rc.d thermald_control.sh defaults
echo "done"
