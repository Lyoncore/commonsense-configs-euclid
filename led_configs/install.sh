#!/bin/bash

echo "Install led_control.sh..."
sudo cp led_control.sh /etc/init.d/
sudo chmod a+x /etc/init.d/led_control.sh
sudo update-rc.d led_control.sh defaultsi >& /dev/null
echo "Done!"

