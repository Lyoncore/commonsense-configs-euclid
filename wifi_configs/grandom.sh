#!/bin/sh

### BEGIN INIT INFO
# Provides:          grandom.sh
# Required-Start:    
# Required-Stop:     
# Default-Start:     2 3 4 5
# Default-Stop:      0 1 6
# Short-Description: generate random ssid
# Description:       This file use for generating random ssid
### END INIT INFO

do_start () {
        echo "generate random ssid do_start" >& 2
        if [ -f "/etc/NetworkManager/system-connections/ap-test" ]; then
		random_num=`date +%s | cut -c 6-10`
		need_replace=`cat /etc/NetworkManager/system-connections/ap-test | grep ssid=`
		sed -i "s/$need_replace/ssid=EUCLID_$random_num/g" /etc/NetworkManager/system-connections/ap-test
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
                #no-op
                ;;
        status)
                echo "Error: argument '$1' not supported" >&2
                exit 3
                ;;
        *)
                echo "Usage: grandom.sh [start|stop]" >&2
                exit 3
                ;;
esac

