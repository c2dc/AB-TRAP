from socket import *
import subprocess
import os
from datetime import datetime

RECORDING_TIME = 1200   # in seconds
SAMPLE_RATE = 1         # in seconds

server_port = 11000
server_socket = socket(AF_INET, SOCK_DGRAM)
server_socket.bind(('', server_port))

print (">> Server running...")
print (">> Flushing IPTables rules")
os.system('iptables -F')

while True:

    msg, client_addr = server_socket.recvfrom(2048)
    model_name = msg.decode('utf-8')
    #print(">> Received message from: ", client_address[0])

    accept_model = ['knn', 'rf', 'dt', 'lr', 'xgb', 'mlp', 'nb', 'svm']
    
    if model_name in accept_model:
        print(">> *** Recognized model ({0}) ***".format(model_name))
        run_iperf = subprocess.Popen(['iperf3', '-s', '-D'])
        print(">> Running IPerf3 as a Daemons (PID={0})".format(str(run_iperf.pid)))

        print(">> Create IPTables rule for NFQueue (Queue=1)")
        os.system("iptables -A INPUT -p tcp -j NFQUEUE --queue-num 1")


        run_ids = subprocess.Popen(['../../venv/bin/python', 'userspace_ids.py', str(model_name)], stdout=subprocess.PIPE)
        print(">> Running IDS with {0} model (PID={1})".format(model_name, str(run_ids.pid)))
        
        run_sar = subprocess.Popen(['sar', '-r', 'ALL', '-n', 'ALL', '-u', 'ALL', '-o', str(model_name), str(SAMPLE_RATE), str(RECORDING_TIME)], stdout=subprocess.PIPE)
        print(">> Running sar to capture sysstat data (PID={0})".format(str(run_sar.pid)))
        
    if model_name == "STOP":
        try:
            print(">> Stopped PID:", str(run_ids.pid), str(run_iperf.pid), str(run_sar.pid))
            run_iperf.terminate()
            run_ids.terminate()
            run_sar.terminate()
        except:
            print(">> Error to terminate process")

