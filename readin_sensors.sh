#!/bin/bash
sudo modprobe w1-gpio
sudo modprobe w1-therm

comment1="#auto input serials"
serial1=`ls -ld /sys/bus/w1/devices/w1_bus_master1/*/ | head -2 | awk '{print $9}' | cut -f7 -d/ | head -1`
serial1Probed=`cat /home/pi/Desktop/tempsensor_dual.py | grep -c $serial1`
serial1="temp_sensor_1 = '/sys/bus/w1/devices/$serial1/w1_slave'"

serial2=`ls -ld /sys/bus/w1/devices/w1_bus_master1/*/ | head -2 | awk '{print $9}' | cut -f7 -d/ | tail -1`
serial2Probed=`cat /home/pi/Desktop/tempsensor_dual.py | grep -c $serial2`
serial2="temp_sensor_2 = '/sys/bus/w1/devices/$serial2/w1_slave'"


if [ $serial1Probed -eq 0 ]
then
    oldSensor1Present=`cat /home/pi/Desktop/tempsensor_dual.py | grep -c "temp_sensor_1 = '/sys/bus/w1/devices"`
    if [ $oldSensor1Present -eq 1 ]
    then
        removeLine="temp_sensor_1 "
        sed -i "/$removeLine/d" /home/pi/Desktop/tempsensor_dual.py
        sed -i "s@$comment1@$comment1\n$serial1@" /home/pi/Desktop/tempsensor_dual.py
    else
        sed -i "s@$comment1@$comment1\n$serial1@" /home/pi/Desktop/tempsensor_dual.py
    fi
fi
if [ $serial2Probed -eq 0 ]
then
    oldSensor2Present=`cat /home/pi/Desktop/tempsensor_dual.py | grep -c "temp_sensor_2 = '/sys/bus/w1/devices"`
    if [ $oldSensor2Present -eq 1 ]
    then
        removeLine="temp_sensor_2 "
        sed -i "/$removeLine/d" /home/pi/Desktop/tempsensor_dual.py
        sed -i "s@$serial1@$serial1\n$serial2@" /home/pi/Desktop/tempsensor_dual.py
    else
        sed -i "s@$serial1@$serial1\n$serial2@" /home/pi/Desktop/tempsensor_dual.py
    fi
fi

