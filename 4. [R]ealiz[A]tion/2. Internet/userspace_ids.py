import fnfqueue
from scapy.all import *

queue = 1

conn = fnfqueue.Connection()

try:
    q = conn.bind(queue)
    q.set_mode(0xffff, fnfqueue.COPY_PACKET)
except PermissionError:
    print("Access denied; Do I have root rights or the needed capabilities?")
    sys.exit(-1)

while True:
    try:
        for packet in conn:
            p = IP(packet.payload)
            if p.src == "192.168.0.1" and p.dst == "192.168.0.2":
                packet.accept()
            else:
                packet.drop()

    except fnfqueue.BufferOverflowException:
        print("buffer error")

conn.close()
