#!/bin/bash

# The comments below try to explain the details of this script
#
# [!] Vagrant provisioning with shell script is by default executed with privileged rights (root)
#
# [!] zmap requires to each destination port be defined by one command-line
#
# [!] To support dataset labeling, each attack will have specific source IP (applicable to attacker box)
#
#                     $ sudo ip addr del 172.16.0.2/24 dev eth1
#                     $ sudo ip addr add 172.16.0.3/24 dev eth1
#

# Remember to disable host machine firewall (in Ubuntu 'ufw disable')
# Current kalilinux/rolling version 2020.1.2 do not have zmap and unicornscan as baseline, so it is required to install
apt-get update
apt-get install zmap unicornscan -y
sed -i '/10.0.0.0/d' /etc/zmap/blacklist.conf # remove target IP from zmap's blacklist

echo "Starting scanning: "
date

IP="10.10.10.10"	# target IP
IP_masscan="10.10.10.10/24"	# target IP for masscan
hping_pckt_count="1000"	# required for hping3
subnet="10.10.10.0/24"	# for zmap and masscan
attacker_interface="eth1"
router1_mac="08:00:27:19:30:05"
repeat_unicornscan="3" # normally about 300

###################################
# nmap
###################################
# -Pn (do not ping hosts first)
# -n (no DNS resolution)
# -f (fragmentation)
###################################

echo "> nmap TCP SYN Scan (src_ip: 172.16.0.3 / dst_ip: ${IP})"
ip addr del 172.16.0.2/24 dev $attacker_interface
ip addr add 172.16.0.3/24 dev $attacker_interface
ip route add 10.10.10.0/24 via 172.16.0.254
nmap -sS -Pn -n $IP

echo "> nmap TCP Connect Scan (src_ip: 172.16.0.4 / dst_ip: ${IP})"
ip addr del 172.16.0.3/24 dev $attacker_interface
ip addr add 172.16.0.4/24 dev $attacker_interface
ip route add 10.10.10.0/24 via 172.16.0.254
nmap -sT -Pn -n $IP

echo "> nmap TCP NULL Scan (src_ip: 172.16.0.5 / dst_ip: ${IP})"
ip addr del 172.16.0.4/24 dev $attacker_interface
ip addr add 172.16.0.5/24 dev $attacker_interface
ip route add 10.10.10.0/24 via 172.16.0.254
nmap -sN -Pn -n $IP

echo "> nmap TCP XMAS Scan (src_ip: 172.16.0.6 / dst_ip: ${IP})"
ip addr del 172.16.0.5/24 dev $attacker_interface
ip addr add 172.16.0.6/24 dev $attacker_interface
ip route add 10.10.10.0/24 via 172.16.0.254
nmap -sX -Pn -n $IP

echo "> nmap TCP FIN Scan (src_ip: 172.16.0.7 / dst_ip: ${IP})"
ip addr del 172.16.0.6/24 dev $attacker_interface
ip addr add 172.16.0.7/24 dev $attacker_interface
ip route add 10.10.10.0/24 via 172.16.0.254
nmap -sF -Pn -n $IP

echo "> nmap TCP ACK Scan (src_ip: 172.16.0.8 / dst_ip: ${IP})"
ip addr del 172.16.0.7/24 dev $attacker_interface
ip addr add 172.16.0.8/24 dev $attacker_interface
ip route add 10.10.10.0/24 via 172.16.0.254
nmap -sA -Pn -n $IP

echo "> nmap TCP Window Scan (src_ip: 172.16.0.9 / dst_ip: ${IP})"
ip addr del 172.16.0.8/24 dev $attacker_interface
ip addr add 172.16.0.9/24 dev $attacker_interface
ip route add 10.10.10.0/24 via 172.16.0.254
nmap -sW -Pn -n $IP

echo "> nmap TCP Maimon Scan (src_ip: 172.16.0.10 / dst_ip: ${IP})"
ip addr del 172.16.0.9/24 dev $attacker_interface
ip addr add 172.16.0.10/24 dev $attacker_interface
ip route add 10.10.10.0/24 via 172.16.0.254
nmap -sM -Pn -n $IP

###################################
# unicornscan
###################################

echo "> unicornscan TCP SYN Scan (src_ip: 172.16.0.11 / dst_ip: ${IP})"
ip addr del 172.16.0.10/24 dev $attacker_interface
ip addr add 172.16.0.11/24 dev $attacker_interface
ip route add 10.10.10.0/24 via 172.16.0.254
unicornscan -Iv -mT -R $repeat_unicornscan $IP

echo "> unicornscan TCP Connect Scan (src_ip: 172.16.0.12 / dst_ip: ${IP})"
ip addr del 172.16.0.11/24 dev $attacker_interface
ip addr add 172.16.0.12/24 dev $attacker_interface
ip route add 10.10.10.0/24 via 172.16.0.254
unicornscan -Iv -msf -R $repeat_unicornscan $IP

echo "> unicornscan TCP NULL Scan (src_ip: 172.16.0.13 / dst_ip: ${IP})"
ip addr del 172.16.0.12/24 dev $attacker_interface
ip addr add 172.16.0.13/24 dev $attacker_interface
ip route add 10.10.10.0/24 via 172.16.0.254
unicornscan -Iv -mTs -R $repeat_unicornscan $IP

echo "> unicornscan TCP XMAS Scan (src_ip: 172.16.0.14 / dst_ip: ${IP})"
ip addr del 172.16.0.13/24 dev $attacker_interface
ip addr add 172.16.0.14/24 dev $attacker_interface
ip route add 10.10.10.0/24 via 172.16.0.254
unicornscan -Iv -mTsFPU -R $repeat_unicornscan $IP

echo "> unicornscan TCP FULL XMAS Scan (src_ip: 172.16.0.15 / dst_ip: ${IP})"
ip addr del 172.16.0.14/24 dev $attacker_interface
ip addr add 172.16.0.15/24 dev $attacker_interface
ip route add 10.10.10.0/24 via 172.16.0.254
unicornscan -Iv -mTFSRPAU -R $repeat_unicornscan $IP

echo "> unicornscan TCP FIN Scan (src_ip: 172.16.0.16 / dst_ip: ${IP})"
ip addr del 172.16.0.15/24 dev $attacker_interface
ip addr add 172.16.0.16/24 dev $attacker_interface
ip route add 10.10.10.0/24 via 172.16.0.254
unicornscan -Iv -mTsF -R $repeat_unicornscan $IP

echo "> unicornscan TCP ACK Scan (src_ip: 172.16.0.17 / dst_ip: ${IP})"
ip addr del 172.16.0.16/24 dev $attacker_interface
ip addr add 172.16.0.17/24 dev $attacker_interface
ip route add 10.10.10.0/24 via 172.16.0.254
unicornscan -Iv -mTsA -R $repeat_unicornscan $IP

###################################
# hping3
###################################

echo "> hping3 TCP SYN Scan (src_ip: 172.16.0.18 / dst_ip: ${IP})"
ip addr del 172.16.0.17/24 dev $attacker_interface
ip addr add 172.16.0.18/24 dev $attacker_interface
ip route add 10.10.10.0/24 via 172.16.0.254
hping3 $IP -c $hping_pckt_count -V -p ++1 -S

echo "> hping3 TCP NULL Scan (src_ip: 172.16.0.19 / dst_ip: ${IP})"
ip addr del 172.16.0.18/24 dev $attacker_interface
ip addr add 172.16.0.19/24 dev $attacker_interface
ip route add 10.10.10.0/24 via 172.16.0.254
hping3 $IP -c $hping_pckt_count -V -p ++1 -Y

echo "> hping3 TCP XMAS Scan (src_ip: 172.16.0.20 / dst_ip: ${IP})"
ip addr del 172.16.0.19/24 dev $attacker_interface
ip addr add 172.16.0.20/24 dev $attacker_interface
ip route add 10.10.10.0/24 via 172.16.0.254
hping3 $IP -c $hping_pckt_count -V -p ++1 -UPF

echo "> hping3 TCP FIN Scan (src_ip: 172.16.0.21 / dst_ip: ${IP})"
ip addr del 172.16.0.20/24 dev $attacker_interface
ip addr add 172.16.0.21/24 dev $attacker_interface
ip route add 10.10.10.0/24 via 172.16.0.254
hping3 $IP -c $hping_pckt_count -V -p ++1 -F

echo "> hping3 TCP ACK Scan (src_ip: 172.16.0.22 / dst_ip: ${IP})"
ip addr del 172.16.0.21/24 dev $attacker_interface
ip addr add 172.16.0.22/24 dev $attacker_interface
ip route add 10.10.10.0/24 via 172.16.0.254
hping3 $IP -c $hping_pckt_count -V -p ++1 -A

###################################
# zmap
###################################
#  zmap available probe-modules are
#    tcp_synscan, icmp_echoscan,
#    icmp_echo_time, udp, ntp, upnp
#
# -B bandwidth
# -p port
# -n number of hosts
###################################
echo "> zmap TCP SYN scan to network (src_ip: 172.16.0.23): ${subnet} "
echo ">> zmap port /0"
ip addr del 172.16.0.22/24 dev $attacker_interface
ip addr add 172.16.0.23/24 dev $attacker_interface
ip route add 10.10.10.0/24 via 172.16.0.254
zmap -B 1M -p 0 -n 256 --probes=250 $subnet -i $attacker_interface --gateway-mac=$router1_mac
echo ">> zmap SSH port 22"
zmap -B 1M -p 22 -n 256 --probes=250 $subnet -i $attacker_interface --gateway-mac=$router1_mac
echo ">> zmap HTTP port 80"
zmap -B 1M -p 80 -n 256 --probes=250 $subnet -i $attacker_interface --gateway-mac=$router1_mac
echo ">> zmap HTTPS port 443"
zmap -B 1M -p 443 -n 256 --probes=250 $subnet -i $attacker_interface --gateway-mac=$router1_mac


###################################
# masscan
###################################
# -p port range
###################################
echo "> masscan scan to network (src_ip: 172.16.0.24): ${subnet}"
ip addr del 172.16.0.23/24 dev $attacker_interface
ip addr add 172.16.0.24/24 dev $attacker_interface
ip route add 10.10.10.0/24 via 172.16.0.254
masscan -p0-500 $IP_masscan -e $attacker_interface --router-ip 172.16.0.254 # required to set interface and router ip to work in VM environment

echo "> Finishing scan and returning to original interface IP"
ip addr del 172.16.0.24/24 dev $attacker_interface
ip addr add 172.16.0.2/24 dev $attacker_interface
ip route add 10.10.10.0/24 via 172.16.0.254

