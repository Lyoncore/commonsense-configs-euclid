#! /bin/sh
### BEGIN INIT INFO
# Provides:          usb-net-cfg.sh
# Required-Start:    $all
# Required-Stop:
# Should-Start:      glibc
# Default-Start:     2 3 4 5
# Default-Stop:
# Short-Description: Set USB0 ethernet IP
# Description:       Set IP to 192.168.1.1
#                    
### END INIT INFO

PATH=/sbin:/bin

. /lib/init/vars.sh
. /lib/lsb/init-functions

do_start () {
	[ -e /sys/class/net/usb0 ] || exit 1
	ifconfig usb0 192.168.1.1
	ES=$?
	exit $?
}

do_status () {
	ifconfig usb0
	ES=$?
	if [ $ES -eq 0 ] ; then
		return 0
	else
		return 4
	fi
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
	# No-op
	;;
  status)
	do_status&
	exit $?
	;;
  *)
	echo "Usage: usb-net-cfg [start|stop]" >&2
	exit 3
	;;
esac

:
