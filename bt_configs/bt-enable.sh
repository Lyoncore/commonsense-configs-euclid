#! /bin/sh
### BEGIN INIT INFO
# Provides:          bt-enable.sh
# Required-Start:    $all
# Required-Stop:
# Should-Start:
# Default-Start:     2 3 4 5
# Default-Stop:
# Short-Description:
# Description:
#
### END INIT INFO

PATH=/sbin:/bin:/usr/bin:/usr/sbin

. /lib/init/vars.sh
. /lib/lsb/init-functions

do_change () {

	value=`cat /sys/class/rfkill/rfkill0/state`

	if [ $value -eq 1 ]; then
		rfkill unblock bluetooth
	fi
}

do_stop () {
	#echo "lyx--- stop `date`" >> /home/ubuntu/test_bt.txt


	id=`ps aux|grep brcm_pat | grep -v grep|awk '{print $2}'`
	kill $id
	echo 0 > /sys/class/rfkill/rfkill0/state
}


do_start () {
	#echo "lyx--- start `date`" >> /home/ubuntu/test_bt.txt

	id=`ps aux|grep brcm_pat | grep -v grep|awk '{print $2}'`
        kill $id

	echo 1 > /sys/class/rfkill/rfkill0/state
	echo 0 > /sys/class/rfkill/rfkill0/state
	echo 1 > /sys/class/rfkill/rfkill0/state

	sleep 1

        BLU_MAC=`cat /var/lib/bluetooth/bluetooth-mac.txt`
        if [ ! $BLU_MAC ]; then
	    NUM0=`cat /proc/sys/kernel/random/uuid | cut -b 1-2`
	    NUM1=`cat /proc/sys/kernel/random/uuid | cut -b 1-2`
	    NUM2=`cat /proc/sys/kernel/random/uuid | cut -b 1-2`
            BLU_MAC=11:22:33:$NUM0:$NUM1:$NUM2
            echo $BLU_MAC > /var/lib/bluetooth/bluetooth-mac.txt
        fi

        brcm_patchram_plus -d --enable_hci --bd_addr $BLU_MAC --no2bytes --tosleep 200000 --patchram /lib/firmware/bluetooth/bcm43341b0.hcd -baudrate 3000000 /dev/ttyS4 & 
}

do_status () {
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
	do_stop&
	do_start&
	;;
  stop)
	do_stop&
	;;
  change)
	do_change&
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
