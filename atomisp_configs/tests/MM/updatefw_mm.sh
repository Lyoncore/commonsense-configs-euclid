#!/bin/bash

mm1_dev="/dev/stm32l051-0"
mm2_dev="/dev/stm32l051-1"

if [ -c ${mm1_dev} ]; then
	echo "Updating Motion Module 1 FW"
	stm32l051_ctrl -d ${mm1_dev} -u /lib/firmware/mmfw/DS4_1T_MM_FW.With_Header.bin
fi

if [ -c ${mm2_dev} ]; then
	echo "Updating Motion Module 2 FW"
	stm32l051_ctrl -d ${mm2_dev} -u /lib/firmware/mmfw/DS4_1T_MM_FW.With_Header.bin
fi

echo "Done!"
