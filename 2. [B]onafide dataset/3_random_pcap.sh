#!/bin/bash

#
# Usage: 
#		./3_random_pcap.sh
#		It will select random $smaller_number packets on output_*filtered.pcap file and save
#		on output*small.pcap file (after 2_filter_pcap.sh)
#
# Reference: 
#		https://stackoverflow.com/questions/47067272/how-to-get-random-packets-from-a-pcap-file
#


large_number=2000000 # max number of packets
smaller_number=75000 # number of packets to retrieve

for i in output_*filtered.pcap; do
	selected_pkt_numbers=$(shuf -i 0-"$large_number" -n "$smaller_number")
	for j in `seq 0 512 $smaller_number`; do
	    endrange=$((j+512))
	    if [ "$endrange" -gt "$smaller_number" ]; then
	        endrange=$smaller_number
	    fi
	    # Selects numbers $j to $endrange from the generated random numbers:
	    echo "$j - $endrange"
	    pkt_numbers=$(echo $selected_pkt_numbers | awk -v start="$j" -v end="$endrange" '{ out=""; for (i=start+1; i<=end; i++) out=out" "$i; print out}')
    	    editcap -r ${i%.*}.pcap ${i%.*}small-$j.pcap $pkt_numbers # generate pcap with sample
	done

	mergecap -w ${i%.*}small.pcap `ls *filteredsmall-*.pcap` # merge samples in single small
	rm *filteredsmall-*.pcap # remove all filteredsmall after merge
done

mergecap -w data/bonafide.pcap `ls *small.pcap`
rm *small.pcap # remove all small after normal merge
