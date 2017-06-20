#!/bin/sh

echo "Install usb-net-cfg.sh..."
sudo cp usb-net-cfg.sh /etc/init.d/
sudo chmod +x /etc/init.d/usb-net-cfg.sh
sudo update-rc.d usb-net-cfg.sh defaults
echo "Done!"

