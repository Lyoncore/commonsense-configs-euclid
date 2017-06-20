#!/bin/sh

### BEGIN INIT INFO
# Provides:          led_control.sh
# Required-Start:    
# Required-Stop:     
# Default-Start:     2 3 4 5
# Default-Stop:      0 1 6
# Short-Description: green led control
# Description:       This file use for green led control
### END INIT INFO

do_start () {
	echo "led control do_start" >&2
	if [ ! -f "/sys/class/power_supply/bq24192_charger/led1_control" ]; then
		return;
	else
		chmod 777 /sys/class/power_supply/bq24192_charger/led1_control
	fi

	while [ true ]; do
		voltage=`cat /sys/class/power_supply/max170xx_battery/voltage_now`;
		if [ $voltage -gt 3750000 ]; then
			echo 1 > /sys/class/power_supply/bq24192_charger/led1_control;
			sleep 60;
		elif [ $voltage -gt 3600000 ]; then
			echo 1 > /sys/class/power_supply/bq24192_charger/led1_control;
			sleep 10;
		else 
			echo 0 > /sys/class/power_supply/bq24192_charger/led1_control;
			sleep 0.5
			echo 1 > /sys/class/power_supply/bq24192_charger/led1_control;
			sleep 0.5
		fi;
	done
}

do_stop () {
	echo "led control do_stop" >&2
}


case "$1" in
	start|"")
		do_start&
		;;
	restart|reload|force-reload)
		echo "Error: argument '$1' not supported" >&2
		exit 3
		;;
	stop)
		#no-op
		;;
	status)
		echo "Error: argument '$1' not supported" >&2
		exit 3
		;;
	*)
		echo "Usage: fan_control.sh [start|stop]" >&2
		exit 3
		;;
esac



