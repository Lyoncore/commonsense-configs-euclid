#! /bin/bash
sudo rm -rf  /usr/share/alsa/ucm/cherrytrailcrau
./audio_config.sh
sleep 1
sudo cp fw_sst_22a8.bin /lib/firmware/intel/
sleep 1
