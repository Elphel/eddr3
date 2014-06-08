#!/usr/bin/env python
from __future__ import print_function
import sys
if len(sys.argv) < 3 or (sys.argv[1] != "in" and sys.argv[1] != "out") :
    print ("Usage: ", sys.argv[0]+" <in|out> <gpio_number>[<gpio_max_number>]")
    exit (0)
mode = sys.argv[1]
    
gpio_low_n=int(sys.argv[2])
if len(sys.argv)>3:
    gpio_high_n=int(sys.argv[3])
else:
    gpio_high_n=gpio_low_n
print ("exporting as \""+mode+"\":", end=""),    
for gpio_n in range (gpio_low_n, gpio_high_n+1):
    print (" %d"%gpio_n, end="")
print()    
# bash> echo 240 > /sys/class/gpio/export
# bash> echo out > /sys/class/gpio/gpio240/direction
# bash> echo 1 > /sys/class/gpio/gpio240/value
       
for gpio_n in range (gpio_low_n, gpio_high_n+1):
    try:
        with open ("/sys/class/gpio/export","w") as f:
            print (gpio_n,file=f)
    except:
        print ("failed \"echo %d > /sys/class/gpio/export"%gpio_n)
    try:
        with open ("/sys/class/gpio/gpio%d/direction"%gpio_n,"w") as f:
            print (mode,file=f)
    except:
        print ("failed \"echo %s > /sys/class/gpio/gpio%d/direction"%(mode,gpio_n))
            
