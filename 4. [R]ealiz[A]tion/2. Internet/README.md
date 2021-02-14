# Realization of the Internet model

## Requirements
- Python modules: fnfqueue and scapy
- Machine learning models: extracted from step #3 (training phase)

## How it works
The IDS application on the user space will be performed using the IPTables queue functionality (NFQUEUE), once the filter rule is met instead of directly drop/accept the packet on kernel space, it will send the packet to the user space to deal with the packet.

`$ iptables -A OUTPUT <filter here> -j NFQUEUE --queue-num 1`
