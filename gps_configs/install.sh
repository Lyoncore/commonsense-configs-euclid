sudo cp -r ./usr/bin/* /usr/bin/
sudo chmod 777 /usr/bin/gnssCG2000
sudo chmod 777 /usr/bin/gnssStelp
sudo cp ./usr/lib/* /usr/lib/
sudo cp -r ./etc/gnss /etc/
sudo mkdir -p /var/log/gnss
sudo chmod 777 /var/log/gnss/
sudo cp ./cg2100_control.sh /etc/init.d/
sudo chmod 755 /etc/init.d/cg2100_control.sh
sudo cp ./get*.sh ~/ 
chmod 755 ~/get_nmea.sh
chmod 755 ~/get_satellite.sh

