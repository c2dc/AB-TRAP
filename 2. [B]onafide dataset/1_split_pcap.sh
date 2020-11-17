#!/bin/bash

#
# Usage: 
#		./1_split_pcap.sh input_file.pcap packets_per_file
#
#		It will split input_file.pcap in multiple output_files according to the specified number of 
#		packets_per_file
#

editcap -c $2 $1 output.pcap
