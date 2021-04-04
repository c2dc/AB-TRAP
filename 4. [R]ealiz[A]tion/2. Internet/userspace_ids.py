import fnfqueue
from pickle import load
from pandas import DataFrame
from scapy.all import *

queue = 1

conn = fnfqueue.Connection()
preprocess = load(open("Models/preprocessor.pkl", "rb"))
model = load(open("Models/dt.pkl", "rb"))

features = ['ip.id', 'ip.flag.df', 'ip.ttl', 'ip.len', 'ip.dsfield', 'tcp.srcport', 'tcp.seq', 'tcp.len', 'tcp.hdr_len',
            'tcp.flags.fin', 'tcp.flags.syn', 'tcp.flags.rst', 'tcp.flags.push', 'tcp.flags.ack', 'tcp.flags.urg',
            'tcp.flags.cwr', 'tcp.window_size', 'tcp.urgent_pointer', 'tcp.options.mss_val']

try:
    q = conn.bind(queue)
    q.set_mode(0xffff, fnfqueue.COPY_PACKET)
except PermissionError:
    print("Access denied; Do I have root rights or the needed capabilities?")
    sys.exit(-1)

while True:
    try:
        for packet in conn:
            pkt = []
            l3 = IP(packet.payload)
            l4 = TCP(packet.payload)

            pkt.append(l3.id)    #ip_id
            pkt.append(l3.flags.DF & 1)  #ip_flag_df
            pkt.append(l3.ttl)   #ip_ttl
            pkt.append(l3.len)   #ip_len
            pkt.append(l3.tos)     #ip_dsfield

            pkt.append(l4.dport) #tcp_dport !!!!!!
            pkt.append(l4.seq)   #tcp_seq
            pkt.append(len(l4.payload))  #tcp_len
            pkt.append(len(l4))  #tcp_hdr_len

            # bitwise operation on the flags to retrieve the value
            pkt.append(l4.flags.F & 1)   #tcp_flag_fin
            pkt.append(l4.flags.S & 1)   #tcp_flag_syn
            pkt.append(l4.flags.R & 1)   #tcp_flag_rst
            pkt.append(l4.flags.P & 1)   #tcp_flag_push
            pkt.append(l4.flags.A & 1)   #tcp_flag_ack
            pkt.append(l4.flags.U & 1)   #tcp_flag_urg
            pkt.append(l4.flags.C & 1)   #tcp_flag_cwr
            pkt.append(l4.window)        #tcp_window_size
            pkt.append(l4.urgptr)        #tcp_urgent_pointer
            # to retrieve mss_val is required to look for this field in the TCP options
            # normally this field is in the byte format, so the convertion to int from bytes is required
            # if the field MSS is not set, the value is used as zero
            pkt.append(next((int.from_bytes(x[1], byteorder=sys.byteorder) for x in l4.options if x[0] == "MSS"), 0)) #tcp_options_mss_val

            df = DataFrame([pkt], columns=features)
            X = preprocess.transform(df)
            predict = model.predict(X)

            if predict == 0:
                print(predict)
                packet.accept()
            else:
                print(predict)
                packet.drop()

    except fnfqueue.BufferOverflowException:
        print("buffer error")

conn.close()


