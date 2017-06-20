#!/bin/sh

### BEGIN INIT INFO
# Provides:          thermald_control.sh
# Required-Start:    
# Required-Stop:     
# Default-Start:     2 3 4 5
# Default-Stop:      0 1 6
# Short-Description: thermald control
# Description:       This file use for thermald control
### END INIT INFO

do_start () {
	echo "thermald control do_start" >&2
	echo 0 > /sys/class/pwm/pwmchip0/export
	echo 10000 > /sys/class/pwm/pwmchip0/pwm0/period
	echo 1 > /sys/class/pwm/pwmchip0/pwm0/enable
	thermald --no-daemon
}

do_stop () {
	echo "thermald control do_stop" >&2
	echo 0 > /sys/class/pwm/pwmchip0/pwm0/duty_cycle
	echo 0 > /sys/class/pwm/pwmchip0/pwm0/enable
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
		echo "Usage: thermald_control.sh [start|stop]" >&2
		exit 3
		;;
esac



