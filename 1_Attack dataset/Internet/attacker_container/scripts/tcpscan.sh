#!/bin/bash

# The comments below try to explain the details of this script
#
# [!] zmap requires to each destination port be defined by one command-line
#
#


echo "Starting scanning: "
date

target="targets" # file with targets IP

hping_pckt_count="1000"	# required for hping3
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
while IFS= read -r IP
do

	subnet="${IP}/32"	# for zmap and masscan
	IP_masscan="${IP}/32"	# target IP for masscan

	echo "$IP"
	echo -n "01" >/dev/udp/${IP}/12000	
	sleep 5
	echo "> nmap TCP SYN Scan (dst_ip: ${IP})"

	nmap -sS -Pn -n ${IP}
	echo -n "STOP" >/dev/udp/${IP}/12000
	sleep 5	

	echo -n "02" >/dev/udp/${IP}/12000
	sleep 5
	echo "> nmap TCP Connect Scan (dst_ip: ${IP})"

	nmap -sT -Pn -n ${IP}
	echo -n "STOP" >/dev/udp/${IP}/12000
	sleep 5

	echo -n "03" >/dev/udp/${IP}/12000
	sleep 5
	echo "> nmap TCP NULL Scan (dst_ip: ${IP})"

	nmap -sN -Pn -n ${IP}
	echo -n "STOP" >/dev/udp/${IP}/12000
	sleep 5

	echo -n "04" >/dev/udp/${IP}/12000
	sleep 5
	echo "> nmap TCP XMAS Scan (dst_ip: ${IP})"

	nmap -sX -Pn -n ${IP}
	echo -n "STOP" >/dev/udp/${IP}/12000
	sleep 5

	echo -n "05" >/dev/udp/${IP}/12000
	sleep 5
	echo "> nmap TCP FIN Scan (dst_ip: ${IP})"

	nmap -sF -Pn -n ${IP}
	echo -n "STOP" >/dev/udp/${IP}/12000
	sleep 5

	echo -n "06" >/dev/udp/${IP}/12000
	sleep 5
	echo "> nmap TCP ACK Scan (dst_ip: ${IP})"

	nmap -sA -Pn -n ${IP}
	echo -n "STOP" >/dev/udp/${IP}/12000
	sleep 5

	echo -n "07" >/dev/udp/${IP}/12000
	sleep 5
	echo "> nmap TCP Window Scan (dst_ip: ${IP})"

	nmap -sW -Pn -n ${IP}
	echo -n "STOP" >/dev/udp/${IP}/12000
	sleep 5

	echo -n "08" >/dev/udp/${IP}/12000
	sleep 5
	echo "> nmap TCP Maimon Scan (dst_ip: ${IP})"

	nmap -sM -Pn -n ${IP}
	echo -n "STOP" >/dev/udp/${IP}/12000
	sleep 5

	###################################
	# unicornscan
	###################################

	echo -n "09" >/dev/udp/${IP}/12000
	sleep 5
	echo "> unicornscan TCP SYN Scan (dst_ip: ${IP})"

	unicornscan -Iv -mT -R $repeat_unicornscan ${IP}
	echo -n "STOP" >/dev/udp/${IP}/12000
	sleep 5

	echo -n "10" >/dev/udp/${IP}/12000
	sleep 5
	echo "> unicornscan TCP Connect Scan (dst_ip: ${IP})"

	unicornscan -Iv -msf -R $repeat_unicornscan ${IP}
	echo -n "STOP" >/dev/udp/${IP}/12000
	sleep 5

	echo -n "11" >/dev/udp/${IP}/12000
	sleep 5
	echo "> unicornscan TCP NULL Scan (dst_ip: ${IP})"

	unicornscan -Iv -mTs -R $repeat_unicornscan ${IP}
	echo -n "STOP" >/dev/udp/${IP}/12000
	sleep 5

	echo -n "12" >/dev/udp/${IP}/12000
	sleep 5
	echo "> unicornscan TCP XMAS Scan (dst_ip: ${IP})"

	unicornscan -Iv -mTsFPU -R $repeat_unicornscan ${IP}
	echo -n "STOP" >/dev/udp/${IP}/12000
	sleep 5

	echo -n "13" >/dev/udp/${IP}/12000
	sleep 5
	echo "> unicornscan TCP FULL XMAS Scan (dst_ip: ${IP})"

	unicornscan -Iv -mTFSRPAU -R $repeat_unicornscan ${IP}
	echo -n "STOP" >/dev/udp/${IP}/12000
	sleep 5

	echo -n "14" >/dev/udp/${IP}/12000
	sleep 5
	echo "> unicornscan TCP FIN Scan (dst_ip: ${IP})"

	unicornscan -Iv -mTsF -R $repeat_unicornscan ${IP}
	echo -n "STOP" >/dev/udp/${IP}/12000
	sleep 5

	echo -n "15" >/dev/udp/${IP}/12000
	sleep 5
	echo "> unicornscan TCP ACK Scan (dst_ip: ${IP})"

	unicornscan -Iv -mTsA -R $repeat_unicornscan ${IP}
	echo -n "STOP" >/dev/udp/${IP}/12000
	sleep 5

	###################################
	# hping3
	###################################

	echo -n "16" >/dev/udp/${IP}/12000
	sleep 5
	echo "> hping3 TCP SYN Scan (dst_ip: ${IP})"

	hping3 ${IP} --fast -c $hping_pckt_count -V -p ++1 -S
	echo -n "STOP" >/dev/udp/${IP}/12000
	sleep 5

	echo -n "17" >/dev/udp/${IP}/12000
	sleep 5
	echo "> hping3 TCP NULL Scan (dst_ip: ${IP})"

	hping3 ${IP} --fast -c $hping_pckt_count -V -p ++1 -Y
	echo -n "STOP" >/dev/udp/${IP}/12000
	sleep 5

	echo -n "18" >/dev/udp/${IP}/12000
	sleep 5
	echo "> hping3 TCP XMAS Scan (dst_ip: ${IP})"

	hping3 ${IP} --fast -c $hping_pckt_count -V -p ++1 -UPF
	echo -n "STOP" >/dev/udp/${IP}/12000
	sleep 5

	echo -n "19" >/dev/udp/${IP}/12000
	sleep 5
	echo "> hping3 TCP FIN Scan (dst_ip: ${IP})"

	hping3 ${IP} --fast -c $hping_pckt_count -V -p ++1 -F
	echo -n "STOP" >/dev/udp/${IP}/12000
	sleep 5

	echo -n "20" >/dev/udp/${IP}/12000
	sleep 5
	echo "> hping3 TCP ACK Scan (dst_ip: ${IP})"

	hping3 ${IP} --fast -c $hping_pckt_count -V -p ++1 -A
	echo -n "STOP" >/dev/udp/${IP}/12000
	sleep 5

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
	echo -n "21" >/dev/udp/${IP}/12000
	sleep 5
	echo "> zmap TCP SYN scan to network: ${subnet} "
	echo ">> zmap port /0"

	zmap -B 1M -p 0 -n 256 --probes=250 $subnet #-i $attacker_interface #--gateway-mac=$router1_mac
	echo ">> zmap SSH port 22"
	zmap -B 1M -p 22 -n 256 --probes=250 $subnet #-i $attacker_interface #--gateway-mac=$router1_mac
	echo ">> zmap HTTP port 80"
	zmap -B 1M -p 80 -n 256 --probes=250 $subnet #-i $attacker_interface #--gateway-mac=$router1_mac
	echo ">> zmap HTTPS port 443"
	zmap -B 1M -p 443 -n 256 --probes=250 $subnet #-i $attacker_interface #--gateway-mac=$router1_mac
	echo -n "STOP" >/dev/udp/${IP}/12000
	sleep 5

	###################################
	# masscan
	###################################
	# -p port range
	###################################
	echo -n "22" >/dev/udp/${IP}/12000
	sleep 5
	echo "> masscan scan to network: ${subnet}"
	masscan -p0-500 $IP_masscan #-e $attacker_interface --router-ip 172.16.0.254 # required to set interface and router ip to work in VM environment
	echo -n "STOP" >/dev/udp/${IP}/12000
	sleep 5
done < "$target"
	
echo "> Finishing scan"

