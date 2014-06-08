#!/usr/bin/env python
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
