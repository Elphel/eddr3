#!/usr/bin/env python
from __future__ import print_function
import sys
if len(sys.argv) < 2 :
    print ("Usage: ", sys.argv[0]+" <gpio_number>[<gpio_max_number>]")
    exit (0)
gpio_low_n=int(sys.argv[1])
if len(sys.argv)>2:
    gpio_high_n=int(sys.argv[2])
else:
    gpio_high_n=gpio_low_n
print ("gpio %d.%d: "%(gpio_high_n,gpio_low_n), end=""),    
# bash> echo 240 > /sys/class/gpio/export
# bash> echo out > /sys/class/gpio/gpio240/direction
# bash> echo 1 > /sys/class/gpio/gpio240/value
       
for gpio_n in range (gpio_high_n, gpio_low_n-1,-1):
    if gpio_n != gpio_high_n and ((gpio_n-gpio_low_n+1) % 4) == 0:
        print (".",end="")
    try:
        with open ("/sys/class/gpio/gpio%d/value"%gpio_n,"r") as f:
            print (f.read(1),end="")
    except:
        print ("X",end="")
print()            
