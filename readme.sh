#!/bin/bash

#----------------------------------------
#
# use readme.sh to install all configs
#
#----------------------------------------

#set -x
#set -e

atomisp_path="atomisp_configs"
audio_path="audio_configs"
fan_path="fan_configs"
bt_path="bt_configs"
gps_path="gps_configs"
led_path="led_configs"
sensor_path="sensorhub_configs"
sys_path="system_configs"
thermald_path="thermald_configs"
rndis_path="rndis_configs"
wifi_path="wifi_configs"

#----------------install atomisp_configs--------------
echo "Install atomisp_configs..."
pushd $atomisp_path >& /dev/null

echo "Installing /lib/firmware/shisp_2401a0_v21.bin"
sudo chmod 755 shisp_2401a0_v21.bin
sudo cp shisp_2401a0_v21.bin /lib/firmware/

echo "Installing udev rules"
sudo chmod 755 99-uctl-dev.rules
sudo cp 99-uctl-dev.rules /etc/udev/rules.d/

echo "Installing new MM FW update tool along with FW version"
sudo cp tests/MM/stm_old/stm32l051_ctrl /usr/bin/
sudo chmod a+x /usr/bin/stm32l051_ctrl
if [ ! -e "/lib/firmware/mmfw" ]; then
	sudo mkdir /lib/firmware/mmfw
fi
sudo cp tests/MM/FW/DS4_1T_MM_FW.With_Header.bin /lib/firmware/mmfw/
sudo cp tests/MM/updatefw_mm.sh /usr/bin/
sudo chmod a+x /usr/bin/updatefw_mm.sh

echo "Installing rc.local change to expose DS4 power control"
sudo cp ./etc/rc.local /etc/rc.local
sudo chmod 755 /etc/rc.local

echo "Installing ov7251 conf"
sudo chmod 755 etc/ov7251.conf
sudo cp etc/ov7251.conf /etc/

echo "Installing DS4 FW update tool along with FW version"
sudo cp tests/DS4/FWUpdateR200 /usr/bin/
sudo chmod a+x /usr/bin/FWUpdateR200
sudo cp tests/DS4/libDSAPI.so /usr/lib/
if [ ! -e "/lib/firmware/ds4fw" ]; then
	sudo mkdir /lib/firmware/ds4fw
fi
sudo cp tests/DS4/*Firmware* /lib/firmware/ds4fw/
sudo cp tests/DS4/updatefw_ds4.sh /usr/bin/
sudo chmod a+x /usr/bin/updatefw_ds4.sh

pushd ../ >& /dev/null
echo "Done!"

#----------------install audio_configs--------------
echo "Install audio_configs..."
pushd $audio_path >& /dev/null
sudo ./audio_play.sh
pushd ../ >& /dev/null
echo "Done!"


#----------------install fan_configs--------------
#echo "Install fan_configs..."
#pushd $fan_path >& /dev/null
#sudo cp fan_control.sh /etc/init.d/
#sudo chmod a+x /etc/init.d/fan_control.sh
#sudo update-rc.d fan_control.sh defaults >& /dev/null
#pushd ../ >& /dev/null
#echo "Done!"


#----------------install bt_configs---------------
echo "Install bt_configs..."
pushd $bt_path >& /dev/null
sudo mkdir /lib/firmware/bluetooth
sudo cp bcm43341b0.hcd /lib/firmware/bluetooth
sudo cp brcm_patchram_plus /usr/bin
sudo cp bt-enable.sh /etc/init.d/
sudo cp 10-bt-enable.rules /etc/udev/rules.d
sudo chmod +x /usr/bin/brcm_patchram_plus
sudo chmod +x /etc/init.d/bt-enable.sh
sudo update-rc.d bt-enable.sh defaults
pushd ../ >& /dev/null
echo "Done!"


#----------------install gps_configs---------------
echo "install gps_configs..."
pushd $gps_path >& /dev/null
sudo cp -r ./usr/bin/* /usr/bin/
sudo chmod 777 /usr/bin/gnssCG2000
sudo chmod 777 /usr/bin/gnssStelp
sudo cp ./usr/lib/* /usr/lib/
sudo cp -r ./etc/gnss /etc/
sudo mkdir -p /var/log/gnss
sudo chmod 777 /var/log/gnss/
sudo cp ./cg2100_control.sh /etc/init.d/
sudo cp ./get_nmea.sh ~/
sudo cp ./get_satellite.sh ~/
pushd ../ >& /dev/null
echo "done"


#----------------install led_configs---------------
echo "Install led_configs..."
pushd $led_path >& /dev/null
sudo cp led_control.sh /etc/init.d/
sudo chmod a+x /etc/init.d/led_control.sh
sudo update-rc.d led_control.sh defaults >& /dev/null
pushd ../ >& /dev/null
echo "Done!"


#----------------install sensorhub_configs---------------
echo "install sensorhub_configs..."
pushd $sensor_path >& /dev/null
sudo cp sensorhub_daemon.sh /etc/init.d
sudo chmod +x /etc/init.d/sensorhub_daemon.sh
sudo update-rc.d sensorhub_daemon.sh defaults >& /dev/null
pushd ../ >& /dev/null
echo "done"


#----------------install system_configs---------------
echo "install system_configs..."
pushd $sys_path >& /dev/null
# auto login ubuntu
sudo cp -f -v etc/lightdm/lightdm.conf /etc/lightdm/ >& /dev/null

# sudoers ubuntu
sudo cp -f -v etc/sudoers.d/euclid /etc/sudoers.d >& /dev/null

# networ interfaces
sudo cp -f -v etc/network/interfaces /etc/network/interfaces >& /dev/null

# dhcpd config
sudo cp -f -v etc/dhcp/dhcpd.conf /etc/dhcp/dhcpd.conf >& /dev/null

pushd ../ >& /dev/null
echo "done"


#----------------install thermald_configs---------------
echo "install thermald_configs..."
pid=`pgrep thermald`
echo "pid="$pid
sudo kill $pid
sudo systemctl disable thermald.service
sudo mkdir -p /usr/local/etc/thermald/
sudo cp thermald_configs/thermal-conf.xml /usr/local/etc/thermald/
sudo cp thermald_configs/thermald_control.sh /etc/init.d/
sudo chmod 755 /etc/init.d/thermald_control.sh
cp thermald_configs/show_temp.sh /home/euclid/
chmod 777 /home/euclid/show_temp.sh
sleep 1
sudo cp thermald_configs/thermald /usr/sbin/
sudo update-rc.d thermald_control.sh defaults
echo "done"


#----------------install rndis_configs---------------
echo "Install rndis_configs..."
pushd $rndis_path >& /dev/null
sudo cp usb-net-cfg.sh /etc/init.d/
sudo chmod +x /etc/init.d/usb-net-cfg.sh
sudo update-rc.d usb-net-cfg.sh defaults >& /dev/null
pushd ../ >& /dev/null
echo "done"


#----------------install wifi_configs---------------
echo "Install wifi_configs..."
pushd $wifi_path >& /dev/null
sudo cp * /lib/firmware/brcm/
pushd ../ >& /dev/null
echo "done"


#---------------------------------------------------
echo "close ubuntu apport"
need_close=`cat /etc/default/apport | grep enabled=`
sed -i "s/$need_close/enabled=0/g" /etc/default/apport
echo "done"


