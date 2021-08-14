# Testbed for attack packets generation on Internet

This testbed was made and tested on the host configuration
- Ubuntu Linux 18.04.4 LTS
- Docker 19.03.6

## Using/Reproducing this testbed
A cloud infrastructure with targets must be set to reproduce this

To operate using Docker
```
$ cd attacker_container
$ docker build --tag attacker .

```

## Available scripts

From ```attacker_container/scripts/```:

- *tcpscan.sh* - Shell script to perform tcp probing attacks to the target machines with ```nmap```, ```zmap```, ```masscan```, ```hping3```, and ```unicornscan```
- *targets* - list of target IPs (one per line)

## /targets folder
This folder contain the script to configure the cloud instance (each "honeypot"). Currently it create a UDP service to allow remote start/stop of [tcpdump](https://www.tcpdump.org). 
This approach is used to support automatic labeling of generated pcap files (a single file for each attack).

At to run the service on background on each instance:
```
$ sudo nohup python3 udp_server.py &
```

# Generate **attack** dataset
The ```pcap``` files generate on each cloud instance must be downloaded to the same folder of ```generate_dataset.py``` (or subfolders) then this Python script will automatically process all files, and label it with the correct attack. The final dataset will be generated in the same folder of the script with the name **attack_dataset.csv**.

