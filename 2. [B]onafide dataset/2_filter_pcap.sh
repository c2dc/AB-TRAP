#!/bin/sh

#
# This script will filter out the anomalous and suspicious packet from all splited output_*.pcap files
# and output as output_*filtered.pcap
#
# Filter rule is obtained from 0_extract_filter.py
#
# tshark -r input_file.pcap -w output_file.pcap -Y filter_rule
#

RULES="`cat filter_rule.txt`"

for i in output_*.pcap; do
	tshark -r ${i%.*}.pcap -w ${i%.*}filtered.pcap -Y "$RULES"
done


