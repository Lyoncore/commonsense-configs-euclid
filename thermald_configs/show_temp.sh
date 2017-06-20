while [ true ]; do
	echo ""
	echo ""
	echo ""
	echo ""
	echo "CPU state"
	cat /sys/class/thermal/cooling_device0/cur_state
	cat /sys/class/thermal/cooling_device1/cur_state
	cat /sys/class/thermal/cooling_device2/cur_state
	cat /sys/class/thermal/cooling_device3/cur_state
	echo ""
	echo "CPU frequency"
	cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_cur_freq
	cat /sys/devices/system/cpu/cpu1/cpufreq/scaling_cur_freq
	cat /sys/devices/system/cpu/cpu2/cpufreq/scaling_cur_freq
	cat /sys/devices/system/cpu/cpu3/cpufreq/scaling_cur_freq
	echo ""
	echo "CPU temp"
	cat  /sys/devices/platform/coretemp.0/hwmon/hwmon3/temp2_input
	cat /sys/devices/platform/coretemp.0/hwmon/hwmon3/temp3_input
	cat /sys/devices/platform/coretemp.0/hwmon/hwmon3/temp4_input
	cat /sys/devices/platform/coretemp.0/hwmon/hwmon3/temp5_input
	echo ""
	echo "Fan speed"
	cat /sys/class/pwm/pwmchip0/pwm0/duty_cycle
	sleep 3
done;
