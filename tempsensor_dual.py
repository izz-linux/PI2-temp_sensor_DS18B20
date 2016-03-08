import os
import time

os.system('modprobe w1-gpio')
os.system('modprobe w1-therm')

#auto input serials
temp_sensor_1 = '/sys/bus/w1/devices/28-0116003fc5ff/w1_slave'
temp_sensor_2 = '/sys/bus/w1/devices/28-0116005c0eff/w1_slave'


def temp_raw():

    f = open(temp_sensor_1, 'r')
    lines_1 = f.readlines()
    f.close()
    f2 = open(temp_sensor_2, 'r')
    lines_2 = f2.readlines()
    f2.close()
    return lines_1, lines_2


def read_temp():

    lines_1, lines_2 = temp_raw()
    while lines_1[0].strip()[-3:] != 'YES':
        time.sleep(0.2)
        lines_1, lines_2 = temp_raw()

    while lines_2[0].strip()[-3:] != 'YES':
        time.sleep(0.2)
        lines_1, lines_2 = temp_raw()


    temp_output_1 = lines_1[1].find('t=')
    temp_output_2 = lines_2[1].find('t=')
    if temp_output_1 != -1:
        temp_string = lines_1[1].strip()[temp_output_1+2:]
        temp_c = float(temp_string) / 1000.0
        temp_f = temp_c * 9.0 / 5.0 + 32.0
        print "Sensor 1 has values: " + "(" + str(temp_c) + ", " + str(temp_f) + ")"

    if temp_output_2 != -1:
        temp_string = lines_2[1].strip()[temp_output_2+2:]
        temp_c = float(temp_string) / 1000.0
        temp_f = temp_c * 9.0 / 5.0 + 32.0
        print "Sensor 2 has values: " + "(" + str(temp_c) + ", " + str(temp_f) + ")"


while True:
        read_temp()
        time.sleep(1)

