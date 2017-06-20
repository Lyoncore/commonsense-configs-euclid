#!/bin/sh

### BEGIN INIT INFO
# Provides:          sensorhub_daemon.sh
# Required-Start:    
# Required-Stop:     
# Default-Start:     2 3 4 5
# Default-Stop:      0 1 6
# Short-Description: sensorhub daemon
# Description:       This file use to start sensorhub service
### END INIT INFO

do_start () {
	echo "sensorhubd do_start" >&2
	while [ true ]; do
		/usr/bin/sensorhubd;
	done
}

do_stop () {
	echo "sensorhubd do_stop" >&2
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



