#!/usr/bin/env python
# -*- coding: utf-8 -*-
# Copyright (C) 2013, Elphel.inc.
# Dump a range of memory locations (physical)
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
import mmap
import sys
import struct
PAGE_SIZE=4096
endian="<" # little, ">" for big
if len(sys.argv)<=1:
    print "Usage: ", sys.argv[0]+" start_address end_address"
    exit (0)
start_addr=int(sys.argv[1],16) & 0xfffffffc
if len(sys.argv)>2:
    end_addr=int(sys.argv[2],16) & 0xfffffffc
else:
    end_addr=start_addr
data=0
writeMode=len(sys.argv)>2
with open("/dev/mem", "r+b") as f:
    for addr in range (start_addr,end_addr+4,4):
        page_addr=addr & (~(PAGE_SIZE-1))
        if (addr == start_addr) or ((addr & 0x3f) == 0):
	      print ("\n0x%08x:"%addr),
        page_offs=addr-page_addr
        if (page_addr>=0x80000000):
            page_addr-= (1<<32)
        mm = mmap.mmap(f.fileno(), PAGE_SIZE, offset=page_addr)
        data=struct.unpack(endian+"L",mm[page_offs:page_offs+4])
        d=data[0]
        print ("%08x"%d),
        mm.close()
