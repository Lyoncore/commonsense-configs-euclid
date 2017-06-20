#!/bin/sh

echo "Install bt-enable.sh..."
sudo mkdir /lib/firmware/bluetooth
sudo cp bcm43341b0.hcd /lib/firmware/bluetooth
sudo cp brcm_patchram_plus /usr/bin
sudo cp bt-enable.sh /etc/init.d/
sudo cp 10-bt-enable.rules /etc/udev/rules.d
sudo chmod +x /usr/bin/brcm_patchram_plus
sudo chmod +x /etc/init.d/bt-enable.sh
sudo update-rc.d bt-enable.sh defaults
echo "Done!"

