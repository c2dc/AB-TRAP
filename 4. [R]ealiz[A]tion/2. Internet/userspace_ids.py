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
            l3 = IP(packet.payload)
            l4 = TCP(packet.payload)

            ip_id = l3.id
            ip_flag_df = l3.flags.DF & 1
            ip_ttl = l3.ttl
            ip_len = l3.len
            ip_dsfield = l3.tos

            tcp_dport = l4.dport
            tcp_seq = l4.seq
            tcp_len = len(l4.payload)
            tcp_hdr_len = len(l4)
            # bitwise operation on the flags to retrieve the value
            tcp_flag_fin = l4.flags.F & 1
            tcp_flag_syn = l4.flags.S & 1
            tcp_flag_rst = l4.flags.R & 1
            tcp_flag_push = l4.flags.P & 1
            tcp_flag_ack = l4.flags.A & 1
            tcp_flag_urg = l4.flags.U & 1
            tcp_flag_cwr = l4.flags.C & 1
            tcp_window_size = l4.window
            tcp_urgent_pointer = l4.urgptr
            #tcp_options_mss_val = l4.options[0][1] or 0
            
            if l3.src == "192.168.0.1" and l3.dst == "192.168.0.2":
                packet.accept()
            else:
                print(tcp_dport, tcp_seq, tcp_len, tcp_hdr_len, tcp_flag_fin, tcp_flag_syn, tcp_flag_rst,
                        tcp_flag_push, tcp_flag_ack, tcp_flag_urg, tcp_flag_cwr, tcp_window_size,
                        tcp_urgent_pointer)
                packet.drop()

    except fnfqueue.BufferOverflowException:
        print("buffer error")

conn.close()


