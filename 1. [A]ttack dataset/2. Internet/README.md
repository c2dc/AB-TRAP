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

