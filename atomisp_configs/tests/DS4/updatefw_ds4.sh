#!/bin/bash

echo "Finding dev nodes"

FILES=/sys/class/video4linux/video*

ds4_1_port=""
ds4_2_port=""
ds4_1_cam=""
ds4_2_cam=""

for f in $FILES
do
	devlink="$(readlink -f ${f}/device)"
	if [ ! -z "$(echo "$devlink" | grep "0000\:00\:14\.0")" ]; then
		usbport="$(echo "$devlink" | cut -d/ -f7)"

		if [ -z "${ds4_1_port}" ] && [ ! -z "${usbport}" ]; then
			ds4_1_port=${usbport}
			ds4_1_cam="/dev/$(cat ${f}/uevent | grep DEVNAME | cut -d= -f2)"
		elif [ ! "${ds4_2_port}" == "${usbport}" ] && [ ! "${ds4_1_port}" == "${usbport}" ]; then
			ds4_2_port=${usbport}
			ds4_2_cam="/dev/$(cat ${f}/uevent | grep DEVNAME | cut -d= -f2)"
		fi
	fi
done

if [ -z "${ds4_1_cam}" ] && [ -z "${ds4_2_cam}" ]; then
	echo "ERROR: one of the cameras is missing! Exiting."
	exit
fi

echo "usb devices found: "
if [ ! -z "${ds4_1_cam}" ]; then
	echo "    DS4-1: ${ds4_1_port}, ${ds4_1_cam}"
	FWUpdateR200 -d ${ds4_1_cam} -p /lib/firmware/ds4fw/ -force
fi

if [ ! -z "${ds4_2_cam}" ]; then
	echo "    DS4-2: ${ds4_2_port}, ${ds4_2_cam}"
	FWUpdateR200 -d ${ds4_2_cam} -p /lib/firmware/ds4fw/ -force
fi

echo "Done!"
