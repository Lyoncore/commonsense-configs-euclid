#!/bin/sh

### BEGIN INIT INFO
# Provides:          fan_control.sh
# Required-Start:    
# Required-Stop:     
# Default-Start:     2 3 4 5
# Default-Stop:      0 1 6
# Short-Description: fan pwm control
# Description:       This file use for fan pwm control
### END INIT INFO

do_start () {
	echo "fan control do_start" >&2
	echo 0 > /sys/devices/pci0000\:00/80862288\:00/pwm/pwmchip0/export
	echo 1 > /sys/devices/pci0000\:00/80862288\:00/pwm/pwmchip0/pwm0/enable
}

do_stop () {
	echo "fan control do_stop" >&2
	echo 100 > /sys/devices/pci0000\:00/80862288\:00/pwm/pwmchip0/pwm0/period
	echo 0 > /sys/devices/pci0000\:00/80862288\:00/pwm/pwmchip0/pwm0/duty_cycle
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
		do_stop
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



