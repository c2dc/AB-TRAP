import pyshark
import pandas as pd


df = pd.DataFrame(pd.np.empty((0, 41)))     # 41 empty columns

def retrieve_attributes(packet):
	pkt_to_list = []

    # List of the attributes to be retrieved from each packet (wireshark.org/docs/dfref/)
    
	attributes = [
	["frame_info", "encap_type"],    #
	["frame_info", "time"],          #
	["frame_info", "time_epoch"],    #
	["frame_info", "number"],        # 
	["frame_info", "len"],           # 
	["frame_info", "cap_len"],       # 
        ["eth", "type"],            # Ethernet Type
        ["ip", "version"],          # Internet Protocol (IP) Version
	["ip", "hdr_len"],          # IP header length (IHL)
	["ip", "tos"],		    # IP Type of Service (TOS)
	["ip", "id"],               # Identification
	["ip", "flags"],            # IP flags
        ["ip", "flags.rb"],             # Reserved bit flag
        ["ip", "flags.df"],             # Don't fragment flag
        ["ip", "flags.mf"],             # More fragments flag
	["ip", "frag_offset"],      # Fragment offset
	["ip", "ttl"],              # Time to live
	["ip", "proto"],            # Protocol (e.g. tcp == 6)
	["ip", "checksum"],         # Header checksum (qualitative)
	["ip", "src"],		    # Source IP Address
	["ip", "dst"],		    # Destination IP Address
        ["ip", "len"],              # Total length
        ["ip", "dsfield"],          # Differentiated Services Field       
        
	["tcp", "srcport"],	    # TCP source port
	["tcp", "dstport"],	    # TCP Destination port        
	["tcp", "seq"],             # Sequence number
        ["tcp", "ack"],             # Acknowledgment number
	["tcp", "len"],             # TCP segment length
        ["tcp", "hdr_len"],         # Header length
        ["tcp", "flags"],           # Flags
        ["tcp", "flags.fin"],           # FIN flag
        ["tcp", "flags.syn"],           # SYN flag
        ["tcp", "flags.reset"],         # RST flag
        ["tcp", "flags.push"],          # PUSH flag
        ["tcp", "flags.ack"],           # ACK flag
        ["tcp", "flags.urg"],           # URG flag
        ["tcp", "flags.cwr"],           # Congestion Window Reduced (CWR) flags
	["tcp", "window_size"],	    # Window Size
	["tcp", "checksum"],	    # Checksum
	["tcp", "urgent_pointer"],  # Urgent pointer
        ["tcp", "options.mss_val"]  # Maximum Segment Size
	]

	columns = []
	for i in attributes:
		columns.append(str(i[0])+"."+str(i[1]))
	
	global df
	df.columns = columns

	for i in attributes:
		# try-except used for packet attribute validation, if not available, fill with ""
		try:
			pkt_to_list.append(getattr(getattr(packet, i[0]), i[1]))
		except:
			pkt_to_list.append("")

	df.loc[len(df)] = pkt_to_list # row of packet attributes on last position of the dataframe


def main():   
	pcap_file = "router0_output.pcap"
	cap = pyshark.FileCapture(pcap_file, display_filter="tcp")	# filtering out just tcp packets
	cap.apply_on_packets(retrieve_attributes)
	cap.close()
	
	print(df.head())
	print(df.shape)
	df.to_csv('./data/malicious_dataset.csv', index=None, header=True)


if __name__ == "__main__":
	main()

