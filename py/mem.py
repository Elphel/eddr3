#!/usr/bin/env python
import mmap
import sys
import struct
PAGE_SIZE=4096
endian="<" # little, ">" for big
if len(sys.argv)<2:
    print "Usage: ", sys.argv[0]+" address [data]"
    exit (0)
addr=int(sys.argv[1],16) & 0xfffffffc
data=0
writeMode=len(sys.argv)>2
if (writeMode):
    data=int(sys.argv[2],16)
with open("/dev/mem", "r+b") as f:
    page_addr=addr & (~(PAGE_SIZE-1))
    page_offs=addr-page_addr
    if (page_addr>=0x80000000):
        page_addr-= (1<<32)
    mm = mmap.mmap(f.fileno(), PAGE_SIZE, offset=page_addr)
    if writeMode:
        packedData=struct.pack(endian+"L",data)
        d=struct.unpack(endian+"L",packedData)[0]
        mm[page_offs:page_offs+4]=packedData
        print ("0x%08x <== 0x%08x (%d)"%(addr,d,d))
    else:
        data=struct.unpack(endian+"L",mm[page_offs:page_offs+4])
        d=data[0]
        print ("0x%08x ==> 0x%08x (%d)"%(addr,d,d))
    mm.close()
