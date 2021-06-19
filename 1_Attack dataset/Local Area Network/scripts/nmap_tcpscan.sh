#!/bin/bash

echo "Username: "
 whoami
echo "IP: 172.16.0.2" 
echo "Started on: "
 date
echo "Current folder of the script:"
 pwd  
#echo "pfSense IP 192.168.1.1"
echo "Victim IP 10.10.10.10"
echo "Host IP 10.10.10.11"
echo "IDS IP 10.10.10.12"

#VM interface
interface="eth1"

#Portscan Target IP
IP="10.10.10.10"

#IP List
LIST="10.10.10.1-139"

#Target Subnet
NET="10.10.10.0/24"

#Fake IPs - for decoy (-D) and spoof (-S)
IPL1="10.10.10.129"
IPL2="10.10.10.130"
IPL3="10.10.10.131"

#Fake MAC
MACL="00:0c:29:87:1f:01"

#IP Zombie - for Idle Scan (-sI)
IPZ="172.16.0.201"

#Script data
echo "IPs (fakes): $IPL1, $IPL2, $IPL3"
echo "Target Subnet: $NET"


#----------------------------------------------------------------------------------------------#
ip addr del 172.16.0.2/24 dev $interface
ip addr add 172.16.0.100/24 dev $interface
ip route add 10.10.10.0/24 via 172.16.0.254
echo "Descobrir servidores e dispositivos: "
nmap -sP $NET
nmap -vvv -sP $LIST
#----------------------------------------------------------------------------------------------#

#----------------------------------------------------------------------------------------------#
ip addr del 172.16.0.100/24 dev $interface
ip addr add 172.16.0.101/24 dev $interface
ip route add 10.10.10.0/24 via 172.16.0.254
echo "Mais informacoes sobre um host ou lista de hosts: "
nmap -vvv $LIST
nmap -f -vvv $LIST
#----------------------------------------------------------------------------------------------#

#----------------------------------------------------------------------------------------------#
ip addr del 172.16.0.101/24 dev $interface
ip addr add 172.16.0.102/24 dev $interface
ip route add 10.10.10.0/24 via 172.16.0.254
echo "Verificacao completa: "
nmap -sT $IP
nmap -f -sT $IP
#----------------------------------------------------------------------------------------------#

#----------------------------------------------------------------------------------------------#
ip addr del 172.16.0.102/24 dev $interface
ip addr add 172.16.0.103/24 dev $interface
ip route add 10.10.10.0/24 via 172.16.0.254
echo "Verificacao rapida: "
nmap -F $IP
nmap -f -F $IP
#----------------------------------------------------------------------------------------------#

#----------------------------------------------------------------------------------------------#
ip addr del 172.16.0.103/24 dev $interface
ip addr add 172.16.0.104/24 dev $interface
ip route add 10.10.10.0/24 via 172.16.0.254
echo "Verificacao de versoes: "
nmap -sV $IP
nmap -f -sV $IP
#----------------------------------------------------------------------------------------------#

#----------------------------------------------------------------------------------------------#
ip addr del 172.16.0.104/24 dev $interface
ip addr add 172.16.0.105/24 dev $interface
ip route add 10.10.10.0/24 via 172.16.0.254
echo "Reason do estado atual das portas: "
nmap --reason $IP
nmap -f --reason $IP
#----------------------------------------------------------------------------------------------#

#----------------------------------------------------------------------------------------------#
ip addr del 172.16.0.105/24 dev $interface
ip addr add 172.16.0.106/24 dev $interface
ip route add 10.10.10.0/24 via 172.16.0.254
echo "Apenas as portas abertas (possivelmente): "
nmap --open $IP
nmap -f --open $IP
#----------------------------------------------------------------------------------------------#

#----------------------------------------------------------------------------------------------#
ip addr del 172.16.0.106/24 dev $interface
ip addr add 172.16.0.107/24 dev $interface
ip route add 10.10.10.0/24 via 172.16.0.254
echo "Analisar portas mais comuns: "
nmap --top-ports 10 $IP
nmap -f --top-ports 10 $IP
#----------------------------------------------------------------------------------------------#

#----------------------------------------------------------------------------------------------#
ip addr del 172.16.0.107/24 dev $interface
ip addr add 172.16.0.108/24 dev $interface
ip route add 10.10.10.0/24 via 172.16.0.254
echo "Evitar inspecao de pacotes. " 
echo "Dividir o cabeçalho TCP em diversos pacotes: "
nmap -f -vvv $IP
#----------------------------------------------------------------------------------------------#

#----------------------------------------------------------------------------------------------#
#MTU (Maximum Transmission Unit) 
#Informar tamanhos fixos de MTU, os quais devem ser multiplus de 8 (8, 16, 24, 32, etc.).
ip addr del 172.16.0.108/24 dev $interface
ip addr add 172.16.0.109/24 dev $interface
ip route add 10.10.10.0/24 via 172.16.0.254
echo "Tamanhos fixados de MTU: "
nmap --mtu 24 $IP
nmap -f --mtu 24 $IP
#----------------------------------------------------------------------------------------------#

#----------------------------------------------------------------------------------------------#
#Falsificação de pacotes. Utilização de endereços de outros hosts (laranjas)
ip addr del 172.16.0.109/24 dev $interface
ip addr add 172.16.0.110/24 dev $interface
ip route add 10.10.10.0/24 via 172.16.0.254
echo "IP falsos - aleatorios: "
nmap -D RND:5 $IP
nmap -f -D RND:5 $IP
echo "IP falsos - especificos: "
nmap -D $IPL1,$IPL2,$IPL3 $IP
nmap -f -D $IPL1,$IPL2,$IPL3 $IP
echo "IP falsos - IP de origem: "
nmap -S $IPL1 -e $interface $IP
nmap -f -S $IPL1 -e $interface $IP
echo "IP Zombie: "
nmap -sI $IPZ $IP
nmap -f -sI $IPZ $IP
#----------------------------------------------------------------------------------------------#

#----------------------------------------------------------------------------------------------#
#Verificação com múltiplas origens (falsas)
ip addr del 172.16.0.110/24 dev $interface
ip addr add 172.16.0.111/24 dev $interface
ip route add 10.10.10.0/24 via 172.16.0.254
echo "Multiplas origens falsas: "
nmap -n -D $IPL1,IPL2,IPL3 $IP
#----------------------------------------------------------------------------------------------#

#----------------------------------------------------------------------------------------------#
#Scan de alvo protegido por um firewall (ignorar ping)
ip addr del 172.16.0.111/24 dev $interface
ip addr add 172.16.0.112/24 dev $interface
ip route add 10.10.10.0/24 via 172.16.0.254
echo "Ignorar ping: "
nmap -Pn $IP
nmap -f -Pn $IP
#----------------------------------------------------------------------------------------------#

#----------------------------------------------------------------------------------------------#
#Scan de alvo protegido por um firewall (UDP ping)
ip addr del 172.16.0.112/24 dev $interface
ip addr add 172.16.0.113/24 dev $interface
ip route add 10.10.10.0/24 via 172.16.0.254
echo "UDP ping: "
nmap -PU $IP
nmap -f -PU $IP
nmap -f -Pn -PU $IP
#----------------------------------------------------------------------------------------------#

#----------------------------------------------------------------------------------------------#
#Scan de alvo protegido por um firewall (TCP ACK (PA) e TCP Syn (PS))
ip addr del 172.16.0.113/24 dev $interface
ip addr add 172.16.0.114/24 dev $interface
ip route add 10.10.10.0/24 via 172.16.0.254
echo "TCP ACK (PA) e TCP Syn (PS): "
nmap -PS $IP
nmap -f -PS $IP
nmap -f -Pn -PS $IP
#----------------------------------------------------------------------------------------------#

#----------------------------------------------------------------------------------------------#
#Scan de alvo protegido por um firewall (TTCP SYN)
ip addr del 172.16.0.114/24 dev $interface
ip addr add 172.16.0.115/24 dev $interface
ip route add 10.10.10.0/24 via 172.16.0.254
echo "TTCP SYN"
nmap -sS $IP
nmap -f -sS $IP
nmap -f -Pn -sS $IP
#----------------------------------------------------------------------------------------------#

#----------------------------------------------------------------------------------------------#
ip addr del 172.16.0.115/24 dev $interface
ip addr add 172.16.0.116/24 dev $interface
ip route add 10.10.10.0/24 via 172.16.0.254
echo "Verificar protocolos suportados: "
nmap -sO $IP
nmap -f -sO $IP
nmap -f -Pn -sO $IP
#----------------------------------------------------------------------------------------------#

#----------------------------------------------------------------------------------------------#
ip addr del 172.16.0.116/24 dev $interface
ip addr add 172.16.0.117/24 dev $interface
ip route add 10.10.10.0/24 via 172.16.0.254
echo "Scan de host utilizando servicos UDP: "
nmap -sU $IP
nmap -f -sU $IP
nmap -f -Pn -sU $IP
#----------------------------------------------------------------------------------------------#

#----------------------------------------------------------------------------------------------#
#TCP Null para enganar o firewall e obter uma resposta 
ip addr del 172.16.0.117/24 dev $interface
ip addr add 172.16.0.118/24 dev $interface
ip route add 10.10.10.0/24 via 172.16.0.254
echo "TCP Null: "
nmap -sN $IP
nmap -f -sN $IP
nmap -f -Pn -sN $IP
#----------------------------------------------------------------------------------------------#

#----------------------------------------------------------------------------------------------#
#TCP Fin varredura no firewall 
ip addr del 172.16.0.118/24 dev $interface
ip addr add 172.16.0.119/24 dev $interface
ip route add 10.10.10.0/24 via 172.16.0.254
echo "TCP Fin: "
nmap -sF $IP
nmap -f -sF $IP
nmap -f -Pn -sF $IP
#----------------------------------------------------------------------------------------------#

#----------------------------------------------------------------------------------------------#
ip addr del 172.16.0.119/24 dev $interface
ip addr add 172.16.0.120/24 dev $interface
ip route add 10.10.10.0/24 via 172.16.0.254
echo "Verificar falhas no firewall: "
nmap -sN $IP
nmap -f -sN $IP
nmap -f -Pn -sN $IP
nmap -sF $IP
nmap -f -sF $IP
nmap -f -Pn -sF $IP
nmap -sX $IP
nmap -f -sX $IP
nmap -f -Pn -sX $IP
nmap -sA $IP  #EVADING WAF/IPS USING ACK SCAN 
nmap -f -sA› $IP
nmap -f -Pn -sA› $IP
nmap -sW $IP
nmap -f -sW $IP
nmap -f -Pn -sW $IP
#----------------------------------------------------------------------------------------------#

#----------------------------------------------------------------------------------------------#
ip addr del 172.16.0.120/24 dev $interface
ip addr add 172.16.0.121/24 dev $interface
ip route add 10.10.10.0/24 via 172.16.0.254
echo "Falsificar o endereco MAC de origem: "
nmap --spoof-mac $MACL $IP
nmap -f --spoof-mac $MACL $IP
nmap -f -Pn --spoof-mac $MACL $IP
echo "MAC de um fornecedor: "
nmap --spoof-mac 3Com $IP
nmap -f --spoof-mac 3Com $IP
nmap -f -Pn --spoof-mac 3Com $IP
nmap -sT --spoof-mac CISCO $IP -p 80 #BYPASSING FIREWALL BY SPOOFING MAC ADDRESS IN NMAP
nmap -sT -Pn --spoof-mac CISCO $IP -p 80 #BYPASSING FIREWALL BY SPOOFING MAC ADDRESS IN NMAP
echo "MAC aleatorio: " 
nmap --spoof-mac 0 $IP
nmap -f --spoof-mac 0 $IP
nmap -f -Pn --spoof-mac 0 $IP
#----------------------------------------------------------------------------------------------#

#----------------------------------------------------------------------------------------------#
ip addr del 172.16.0.121/24 dev $interface
ip addr add 172.16.0.122/24 dev $interface
ip route add 10.10.10.0/24 via 172.16.0.254
echo "Falsificar a endereco porta de origem: "
nmap --source-port 80 $IP
nmap -f --source-port 80 $IP
nmap -f -Pn --source-port 80 $IP
nmap $IP -p 80 --source-port 53 #HARDCODED ORIGINATING PORTS IN FIRWALL RULES
#----------------------------------------------------------------------------------------------#

#----------------------------------------------------------------------------------------------#
ip addr del 172.16.0.122/24 dev $interface
ip addr add 172.16.0.123/24 dev $interface
ip route add 10.10.10.0/24 via 172.16.0.254
echo "Anexar dados aleatorios: " #EVADING FIREWALLS BY SENDING CUSTOM SIZE PACKETS
nmap --data-length 83 $IP
nmap --data-length 44 $IP
nmap --data-length 128 $IP
nmap --data-length 32 $IP
nmap -f --data-length 83 $IP
nmap -f -Pn --data-length 64 $IP
nmap -f -Pn --data-length 0 $IP
nmap $IP -p 80 --data-length 40
#----------------------------------------------------------------------------------------------#

#----------------------------------------------------------------------------------------------#
#Integridade não verificada
ip addr del 172.16.0.123/24 dev $interface
ip addr add 172.16.0.124/24 dev $interface
ip route add 10.10.10.0/24 via 172.16.0.254
echo "Bad Checksums: "
nmap --badsum $IP
nmap -f --badsum $IP
nmap -f -Pn --badsum $IP
#----------------------------------------------------------------------------------------------#

#----------------------------------------------------------------------------------------------#
ip addr del 172.16.0.124/24 dev $interface
ip addr add 172.16.0.125/24 dev $interface
ip route add 10.10.10.0/24 via 172.16.0.254
echo "Procurar host em ordem aleatoria: "
nmap --randomize-hosts $LIST
nmap -f --randomize-hosts $LIST
nmap -f -Pn --randomize-hosts $LIST
#----------------------------------------------------------------------------------------------#

#----------------------------------------------------------------------------------------------#
ip addr del 172.16.0.125/24 dev $interface
ip addr add 172.16.0.126/24 dev $interface
ip route add 10.10.10.0/24 via 172.16.0.254
echo "Exibe saidas instaladas e caminhos percorridos: "
nmap --iflist
nmap -f --iflist
nmap -f -Pn --iflist
#----------------------------------------------------------------------------------------------#

#----------------------------------------------------------------------------------------------#
ip addr del 172.16.0.126/24 dev $interface
ip addr add 172.16.0.127/24 dev $interface
ip route add 10.10.10.0/24 via 172.16.0.254
echo "firewall-bypass: " #https://nmap.org/nsedoc/scripts/firewall-bypass.html
nmap --script=firewall-bypass $IP
nmap -f --script=firewall-bypass $IP
nmap -f -Pn --script=firewall-bypass $IP
nmap -nmap --script=firewall-bypass --script-args firewall-bypass.helper="ftp", firewall-bypass.targetport=22 $IP
#----------------------------------------------------------------------------------------------#

#----------------------------------------------------------------------------------------------#
ip addr del 172.16.0.127/24 dev $interface
ip addr add 172.16.0.128/24 dev $interface
ip route add 10.10.10.0/24 via 172.16.0.254
echo "firewalk: " #https://nmap.org/nsedoc/scripts/firewalk.html
nmap --script=firewalk --traceroute $IP
nmap -f --script=firewalk --traceroute $IP
nmap -f -Pn --script=firewalk --traceroute $IP
nmap --script=firewalk --traceroute --script-args=firewalk.max-retries=1 $IP
nmap --script=firewalk --traceroute --script-args=firewalk.probe-timeout=400ms $IP
nmap --script=firewalk --traceroute --script-args=firewalk.max-probed-ports=7 $IP
#----------------------------------------------------------------------------------------------#

#----------------------------------------------------------------------------------------------#
ip addr del 172.16.0.128/24 dev $interface
ip addr add 172.16.0.129/24 dev $interface
ip route add 10.10.10.0/24 via 172.16.0.254
echo "http-methods: " #https://nmap.org/nsedoc/scripts/http-methods.html
nmap --script=http-methods $IP
nmap -f --script=http-methods $IP
nmap -f -Pn --script=http-methods $IP
nmap --script=http-methods --script-args http-methods.url-path='/website' $IP
#----------------------------------------------------------------------------------------------#

#----------------------------------------------------------------------------------------------#
ip addr del 172.16.0.129/24 dev $interface
ip addr add 172.16.0.130/24 dev $interface
ip route add 10.10.10.0/24 via 172.16.0.254
echo "rpcinfo: " #https://nmap.org/nsedoc/scripts/rpcinfo.html
nmap --script=rpcinfo $IP
nmap -f --script=rpcinfo $IP
nmap -f -Pn --script=rpcinfo $IP
#mount.version, nfs.version, rpc.protocol
#----------------------------------------------------------------------------------------------#

#----------------------------------------------------------------------------------------------#
ip addr del 172.16.0.130/24 dev $interface
ip addr add 172.16.0.131/24 dev $interface
ip route add 10.10.10.0/24 via 172.16.0.254
echo "banner: " #https://nmap.org/nsedoc/scripts/banner.html
nmap -sV --script=banner $IP
nmap -f --script=banner $IP
nmap -f -Pn --script=banner $IP
#----------------------------------------------------------------------------------------------#

#----------------------------------------------------------------------------------------------#
ip addr del 172.16.0.131/24 dev $interface
ip addr add 172.16.0.132/24 dev $interface
ip route add 10.10.10.0/24 via 172.16.0.254
echo "ajp-methods: " #https://nmap.org/nsedoc/scripts/ajp-methods.html
nmap -p 8009 $IP --script=ajp-methods
nmap -f $IP --script=ajp-methods
nmap -f -Pn $IP --script=ajp-methods
nmap $IP --script=ajp-methods
#----------------------------------------------------------------------------------------------#

#----------------------------------------------------------------------------------------------#
ip addr del 172.16.0.132/24 dev $interface
ip addr add 172.16.0.133/24 dev $interface
ip route add 10.10.10.0/24 via 172.16.0.254
echo "ms-sql-info: " #https://nmap.org/nsedoc/scripts/ms-sql-info.html
nmap -p 445 --script=ms-sql-info $IP
nmap --script=ms-sql-info $IP
nmap -f --script=ms-sql-info $IP
nmap -f -Pn --script=ms-sql-info $IP
nmap -p 1433 --script=ms-sql-info --script-args=mssql.instance-port=1433 $IP
#----------------------------------------------------------------------------------------------#

#----------------------------------------------------------------------------------------------#
ip addr del 172.16.0.133/24 dev $interface
ip addr add 172.16.0.134/24 dev $interface
ip route add 10.10.10.0/24 via 172.16.0.254
echo "http-vhosts: " #https://nmap.org/nsedoc/scripts/http-vhosts.html
nmap --script=http-vhosts -p 80,8080,443 $IP
nmap --script=http-vhosts $IP
nmap -f --script=http-vhosts $IP
nmap -f -Pn --script=http-vhosts $IP
#----------------------------------------------------------------------------------------------#

#----------------------------------------------------------------------------------------------#
ip addr del 172.16.0.134/24 dev $interface
ip addr add 172.16.0.135/24 dev $interface
ip route add 10.10.10.0/24 via 172.16.0.254
echo "http-headers: " #https://nmap.org/nsedoc/scripts/http-headers.html
nmap -sV --script=http-headers $IP
nmap -f --script=http-headers $IP
nmap -f -Pn --script=http-headers $IP
#----------------------------------------------------------------------------------------------#

#----------------------------------------------------------------------------------------------#
ip addr del 172.16.0.135/24 dev $interface
ip addr add 172.16.0.136/24 dev $interface
ip route add 10.10.10.0/24 via 172.16.0.254
echo "http-method-tamper: " #https://nmap.org/nsedoc/scripts/http-method-tamper.html
nmap -sV --script=http-method-tamper $IP
nmap -f --script=http-method-tamper $IP
nmap -f -Pn --script=http-method-tamper $IP
nmap -p80 --script=http-method-tamper --script-args 'http-method-tamper.paths={/protected/db.php,/protected/index.php}' $IP
#----------------------------------------------------------------------------------------------#

#----------------------------------------------------------------------------------------------#
ip addr del 172.16.0.136/24 dev $interface
ip addr add 172.16.0.137/24 dev $interface
ip route add 10.10.10.0/24 via 172.16.0.254
echo "db2-das-info: " #https://nmap.org/nsedoc/scripts/db2-das-info.html
nmap -sV --script=db2-das-info $IP
nmap -f --script=db2-das-info $IP
nmap -f -Pn --script=db2-das-info $IP
#----------------------------------------------------------------------------------------------#

#----------------------------------------------------------------------------------------------#
ip addr del 172.16.0.137/24 dev $interface
ip addr add 172.16.0.138/24 dev $interface
ip route add 10.10.10.0/24 via 172.16.0.254
echo "enip-info: " #https://nmap.org/nsedoc/scripts/enip-info.html
nmap --script=enip-info -sU -p 44818 $IP
nmap --script=enip-info -sU $IP
nmap --script=enip-info -f $IP
nmap --script=enip-info -f -Pn $IP
#----------------------------------------------------------------------------------------------#

#----------------------------------------------------------------------------------------------#
ip addr del 172.16.0.138/24 dev $interface
ip addr add 172.16.0.139/24 dev $interface
ip route add 10.10.10.0/24 via 172.16.0.254
echo "smb-server-stats: " #https://nmap.org/nsedoc/scripts/smb-server-stats.html
nmap --script=smb-server-stats.nse -p445 $IP
nmap -sU -sS --script=smb-server-stats.nse -p U:137,T:139 $IP
nmap --script=smb-server-stats.nse $IP
nmap -f --script=smb-server-stats.nse $IP
nmap -f -Pn --script=smb-server-stats.nse $IP
#----------------------------------------------------------------------------------------------#

#----------------------------------------------------------------------------------------------#
ip addr del 172.16.0.139/24 dev $interface
ip addr add 172.16.0.140/24 dev $interface
ip route add 10.10.10.0/24 via 172.16.0.254
echo "http-waf-detect: " #https://nmap.org/nsedoc/scripts/http-waf-detect.html
nmap -p80 --script http-waf-detect $IP
nmap --script http-waf-detect $IP
nmap -f --script http-waf-detect $IP
nmap -f -Pn --script http-waf-detect $IP
nmap -p80 --script http-waf-detect --script-args="http-waf-detect.aggro,http-waf-detect.uri=/testphp.vulnweb.com/artists.php" $IP
#----------------------------------------------------------------------------------------------#

#----------------------------------------------------------------------------------------------#
ip addr del 172.16.0.140/24 dev $interface
ip addr add 172.16.0.141/24 dev $interface
ip route add 10.10.10.0/24 via 172.16.0.254
echo "http-waf-fingerprint: " #https://nmap.org/nsedoc/scripts/http-waf-fingerprint.html
nmap --script=http-waf-fingerprint $IP
nmap -f --script=http-waf-fingerprint $IP
nmap -f -Pn --script=http-waf-fingerprint $IP
nmap --script=http-waf-fingerprint --script-args http-waf-fingerprint.intensive=1 $IP
#----------------------------------------------------------------------------------------------#

#----------------------------------------------------------------------------------------------#
ip addr del 172.16.0.141/24 dev $interface
ip addr add 172.16.0.142/24 dev $interface
ip route add 10.10.10.0/24 via 172.16.0.254
echo "smb-enum-processes: " #https://nmap.org/nsedoc/scripts/smb-enum-processes.html
nmap --script=smb-enum-processes.nse $IP
nmap -f --script=smb-enum-processes.nse $IP
nmap -Pn --script=smb-enum-processes.nse $IP
nmap --script smb-enum-processes.nse -p445 $IP
nmap -sU -sS --script smb-enum-processes.nse -p U:137,T:139 $IP
#----------------------------------------------------------------------------------------------#

#----------------------------------------------------------------------------------------------#
ip addr del 172.16.0.142/24 dev $interface
ip addr add 172.16.0.143/24 dev $interface
ip route add 10.10.10.0/24 via 172.16.0.254
echo "http-affiliate-id: " #https://nmap.org/nsedoc/scripts/http-affiliate-id.html
nmap --script=http-affiliate-id.nse --script-args http-affiliate-id.url-path=/website $IP
nmap --script=http-affiliate-id.nse $IP
nmap -f --script=http-affiliate-id.nse $IP
nmap -Pn --script=http-affiliate-id.nse $IP
#----------------------------------------------------------------------------------------------#

#----------------------------------------------------------------------------------------------#
ip addr del 172.16.0.143/24 dev $interface
ip addr add 172.16.0.144/24 dev $interface
ip route add 10.10.10.0/24 via 172.16.0.254
echo "cics-info: " #https://nmap.org/nsedoc/scripts/cics-info.html
nmap --script=cics-info $IP
nmap -f --script=cics-info $IP
nmap -f -Pn --script=cics-info $IP
nmap --script=cics-info -p 23 $IP
nmap --script=cics-info --script-args cics-info.commands='logon applid(coolcics)',cics-info.user=test,cics-info.pass=test,cics-info.cemt='ZEMT',cics-info.trans=CICA -p 23 $IP
#----------------------------------------------------------------------------------------------#


#https://nmap.org/nsedoc/categories/discovery.html


echo "> Finishing scan and returning to original interface IP"
ip addr del 172.16.0.144/24 dev $interface
ip addr add 172.16.0.2/24 dev $interface
ip route add 10.10.10.0/24 via 172.16.0.254

