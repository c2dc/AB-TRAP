import pyshark
import pandas as pd
import os
import numpy as np
import re

def create_dataframe():
    	# List of the attributes to be retrieved from each packet (wireshark.org/docs/dfref/)
	global attributes
	attributes = [
	["frame_info", "encap_type"],	#
	["frame_info", "time"],		#
	["frame_info", "time_epoch"],	#
	["frame_info", "number"],	# 
	["frame_info", "len"],		# 
	["frame_info", "cap_len"],     	# 
        ["eth", "type"],            	# Ethernet Type
	######################## IP #####################################
        ["ip", "version"],		# Internet Protocol (IP) Version
	["ip", "hdr_len"],		# IP header length (IHL)
	["ip", "tos"],			# IP Type of Service (TOS)
	["ip", "id"],			# Identification
	["ip", "flags"],		# IP flags
        ["ip", "flags.rb"],             # Reserved bit flag
        ["ip", "flags.df"],             # Don't fragment flag
        ["ip", "flags.mf"],             # More fragments flag
	["ip", "frag_offset"],		# Fragment offset
	["ip", "ttl"],			# Time to live
	["ip", "proto"],		# Protocol (e.g. tcp == 6)
	["ip", "checksum"],		# Header checksum (qualitative)
	["ip", "src"],			# Source IP Address
	["ip", "dst"],			# Destination IP Address
        ["ip", "len"],			# Total length
        ["ip", "dsfield"],		# Differentiated Services Field       
        ######################## TCP ####################################
	["tcp", "srcport"],		# TCP source port
	["tcp", "dstport"],		# TCP Destination port        
	["tcp", "seq"],			# Sequence number
        ["tcp", "ack"],			# Acknowledgment number
	["tcp", "len"],			# TCP segment length
        ["tcp", "hdr_len"],		# Header length
        ["tcp", "flags"],		# Flags
        ["tcp", "flags.fin"],           # FIN flag
        ["tcp", "flags.syn"],           # SYN flag
        ["tcp", "flags.reset"],         # RST flag
        ["tcp", "flags.push"],          # PUSH flag
        ["tcp", "flags.ack"],           # ACK flag
        ["tcp", "flags.urg"],           # URG flag
        ["tcp", "flags.cwr"],           # Congestion Window Reduced (CWR) flags
	["tcp", "window_size"],		# Window Size
	["tcp", "checksum"],		# Checksum
	["tcp", "urgent_pointer"],	# Urgent pointer
        ["tcp", "options.mss_val"]	# Maximum Segment Size
	]


	# Headers Definition
	columns = []
	for i in attributes:
		columns.append(str(i[0])+"."+str(i[1]))
	columns.append("label")

	# Create new dataframe
	global df
	df = pd.DataFrame(columns=columns)


def retrieve_attributes(packet):
	pkt_to_list = []

	# Retrieve attributes from pcap file
	global attributes
	for i in attributes:
		# try-except used for packet attribute validation, if not available, fill with ""
		try:
			pkt_to_list.append(getattr(getattr(packet, i[0]), i[1]))
		except:
			pkt_to_list.append("")

	# Define the label for the pcap
	global file_num
	if (file_num == "01"):
		pkt_to_list.append("nmap_syn")
	elif (file_num == "02"):
		pkt_to_list.append("nmap_connect")
	elif (file_num == "03"):
		pkt_to_list.append("nmap_null")
	elif (file_num == "04"):
		pkt_to_list.append("nmap_xmas")
	elif (file_num == "05"):
		pkt_to_list.append("nmap_fin")
	elif (file_num == "06"):
		pkt_to_list.append("nmap_ack")
	elif (file_num == "07"):
		pkt_to_list.append("nmap_window")
	elif (file_num == "08"):
		pkt_to_list.append("nmap_maimon")
	elif (file_num == "09"):
		pkt_to_list.append("unicorn_syn")
	elif (file_num == "10"):
		pkt_to_list.append("unicorn_conn")
	elif (file_num == "11"):
		pkt_to_list.append("unicorn_null")
	elif (file_num == "12"):
		pkt_to_list.append("unicorn_xmas")
	elif (file_num == "13"):
		pkt_to_list.append("unicorn_fxmas")
	elif (file_num == "14"):
		pkt_to_list.append("unicorn_fin")
	elif (file_num == "15"):
		pkt_to_list.append("unicorn_ack")
	elif (file_num == "16"):
		pkt_to_list.append("hping_syn")
	elif (file_num == "17"):
		pkt_to_list.append("hping_null")
	elif (file_num == "18"):
		pkt_to_list.append("hping_xmas")
	elif (file_num == "19"):
		pkt_to_list.append("hping_fin")
	elif (file_num == "20"):
		pkt_to_list.append("hping_ack")
	elif (file_num == "21"):
		pkt_to_list.append("zmap")
	elif (file_num == "22"):
		pkt_to_list.append("masscan")
	else:
		pkt_to_list.append("")

	# row of packet attributes on last position of the dataframe
	global df
	df.loc[len(df)] = pkt_to_list

def main():
	i = 1
	regex = r"\/(\d{2})(_\d+)?.pcap"

	create_dataframe()
	for root, dirs, files in os.walk("."):
		for file in files:
			if file.endswith(".pcap"):
				pcap_file = os.path.join(root, file)
				global file_num
				file_num = re.search(regex, pcap_file).group(1)
				print(pcap_file, file_num)
				cap = pyshark.FileCapture(pcap_file, display_filter="tcp")	# filtering out just tcp packets
				try:				
					cap.apply_on_packets(retrieve_attributes)

					global df
					if i==1:
						df.to_csv('malicious_dataset.csv', index=None, header=True)
						i+=1
					else:
						df.to_csv('malicious_dataset.csv', mode='a', index=None, header=False)
						i+=1
					# clear dataframe
					df = df.iloc[0:0]

					cap.close()
				except:
					print("> pcap with issue:", pcap_file)

if __name__ == "__main__":
	main()

