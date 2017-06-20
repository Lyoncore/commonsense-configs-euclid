#!/bin/sh

### BEGIN INIT INFO
# Provides:          cg2100_control.sh
# Required-Start:    
# Required-Stop:     
# Default-Start:     2 3 4 5
# Default-Stop:      0 1 6
# Short-Description: cg2100 control
# Description:       CG2K hsw daemon init script
### END INIT INFO

NAME=cg2k
LOGDIR=/var/log/gnss

do_start()
{
	if [ ! -d "/sys/class/gpio/gpio415" ]; then
		echo "cg2100_control.sh do_start" >& 2
		chmod 777 /sys/class/gpio/export
		echo 415 > /sys/class/gpio/export
		chmod 777 /sys/class/gpio/gpio415/*
		echo out > /sys/class/gpio/gpio415/direction

		if [ ! -d $LOGDIR ]; then
			mkdir -p $LOGDIR
			chmod 777 $LOGDIR
		fi
		chmod 777 /dev/ttyS5
	fi

	/usr/bin/gnssCG2000 &
}

do_stop()
{
	killall -9 /usr/bin/gnssCG2000
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
                echo "Usage: cg2100_control.sh [start|stop]" >&2
                exit 3
                ;;
esac
