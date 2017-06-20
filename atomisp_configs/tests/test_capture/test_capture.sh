#!/bin/bash

yavta_fullpath=$(pwd)/yavta
raw2pgm_fullpath=$(pwd)/raw2pgm

if [ ! -f ${yavta_fullpath} ]; then
	echo "ERROR: yavta tool not found on local directory. Exiting."
	exit
fi

if [ ! -f ${raw2pgm_fullpath} ]; then
	echo "ERROR: raw2pgm tool not found on local directory. Exiting."
	exit
fi

echo "Finding dev nodes"

FILES=/sys/class/video4linux/video*

fe1_cam=""
fe2_cam=""

for f in $FILES
do
	devname="$(cat ${f}/name)"
	if [ "$devname" == "ATOMISP ISP CAPTURE output" ]; then
		devpath="/dev/$(cat ${f}/uevent | grep DEVNAME | cut -d= -f2)"
		devnumber=$(cat ${f}/uevent | grep MINOR | cut -d= -f2)
	
		#echo "Found:"
		#echo "  Path: $devpath"
		#echo "  Number: $devnumber"

		if [ -z ${fe1_cam} ]; then
			fe1_cam=$devnumber
		elif [ -z ${fe2_cam} ]; then
			fe2_cam=$devnumber
		fi
	fi
done

if [ -z ${fe1_cam} ] || [ -z ${fe2_cam} ]; then
	echo "ERROR: AtomISP capture interfaces not found"
	exit
fi

# Test if desired input is there
if [ ! -z "$(${yavta_fullpath} /dev/video${fe1_cam} --enum-inputs | grep "ov7251" | grep "Input 0")" ]; then
	echo "Compatible 'ATOMISP ISP CAPTURE output' v4l2 device nodes with ov7251 input found at:"
	echo "  fe1: /dev/video${fe1_cam}"

	echo "Capturing from Fisheye Camera 1..."
	${yavta_fullpath} /dev/video${fe1_cam} -c1 -n1 -i0 -u -I -fSBGGR10 -s640x480 -FFE1.raw

	echo "Checking if it's not blank..."
	if [ ! -z "$(md5sum FE1.raw | grep b9fb96aaeaa125c0ca726ab4afe4647a)" ]; then
		echo "ERROR: Failed to get proper fisheye image from FE1. Continuing anyways."
	else
		echo "Converting to PGM"
		${raw2pgm_fullpath} -IFE1.raw -s640x480 -OFE1.pgm
	fi
	rm FE1.raw
fi

if [ ! -z "$(${yavta_fullpath} /dev/video${fe2_cam} --enum-inputs | grep "ov7251" | grep "Input 1")" ]; then
	echo "Compatible 'ATOMISP ISP CAPTURE output' v4l2 device nodes with ov7251 input found at:"
	echo "  fe2: /dev/video${fe2_cam}"

	echo "Capturing from Fisheye Camera 2..."
	${yavta_fullpath} /dev/video${fe2_cam} -c1 -n1 -i1 -u -I -fSBGGR10 -s640x480 -FFE2.raw

	echo "Checking if it's not blank..."
	if [ ! -z "$(md5sum FE2.raw | grep b9fb96aaeaa125c0ca726ab4afe4647a)" ]; then
		echo "ERROR: Failed to get proper fisheye image from FE2. Continuing anyways."
	else
		echo "Converting to PGM"
		${raw2pgm_fullpath} -IFE2.raw -s640x480 -OFE2.pgm
	fi
	rm FE2.raw
fi

echo "Done!"
