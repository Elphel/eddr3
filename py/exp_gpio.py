#!/usr/bin/env python
# -*- coding: utf-8 -*-
# Copyright (C) 2013, Elphel.inc.
# Export range of GPIO (EMIO)registers
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.
#  
__author__ = "Andrey Filippov"
__copyright__ = "Copyright 2014, Elphel, Inc."
__license__ = "GPL"
__version__ = "3.0+"
__maintainer__ = "Andrey Filippov"
__email__ = "andrey@elphel.com"
__status__ = "Development"

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
            
