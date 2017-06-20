#! /bin/bash


echo "install sensorhub_daemon.sh"
sudo cp sensorhub_daemon.sh /etc/init.d
sudo chmod +x /etc/init.d/sensorhub_daemon.sh
sudo update-rc.d sensorhub_daemon.sh defaults >& /dev/null
echo "done"
