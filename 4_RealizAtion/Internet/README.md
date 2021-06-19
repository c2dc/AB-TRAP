# Realization of the Internet model

## Requirements
- Python modules: fnfqueue and scapy
- Machine learning models: extracted from step #3 (training phase)

## How it works
The IDS application on the user-space will be performed using the IPTables queue functionality (NFQUEUE), once the filter rule is met instead of directly drop/accept the packet on kernel-space, it will send the packet to the user-space to deal with the packet.

### IPtables setup
`$ sudo iptables -A INPUT <filter here> -j NFQUEUE --queue-num 1`

In our case, for all TCP traffic:

`$ sudo iptables -A INPUT -p tcp -j NFQUEUE --queue-num 1`

To flush the iptables rule:
`$ sudo iptables -F`

### IDS execution
It is required root for IDS:
`$ sudo userspace_ids.py`


