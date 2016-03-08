# PI2-temp_sensor_DS18B20
Using a Raspberry Pi to automate temperature sensor readings (multiple sensors using DS18B20)
Crontab entry such as follows is needed:
@reboot /usr/local/sbin/readin_sensors.sh 2>&1

This populates and updates the python script with the current sensors attached to the PI on each reboot (for mass distribution)

Credit to https://www.modmypi.com/blog/ds18b20-one-wire-digital-temperature-sensor-and-the-raspberry-pi for initial code
