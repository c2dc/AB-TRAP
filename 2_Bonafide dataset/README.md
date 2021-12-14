To obtain the **Bonafide Dataset** please perform the following steps (using Python and Shellscript):


# Obtain MAWILab traffic
Download the MAWILab traffic (.gz) and its rules (.csv):

```
$ wget http://mawi.wide.ad.jp/mawi/samplepoint-F/2020/202011101400.pcap.gz
$ wget http://www.fukuda-lab.org/mawilab/v1.1/2020/11/10/20201110_anomalous_suspicious.csv
```

# Extract the Bonafide filter rule
Based on the csv file provided by MAWILab, it is extract the rules to retrieve only the bonafide traffic:

```
$ python 0_extract_filter.py
```

It will generate the ```filter_rule.txt```

# Split the pcap file
Due to the amount of packets, the following step is to split the original pcap file in multiple files to allow the processing in a regular pc:

The input arguments for the shellscript is the name of the file and the amount of packets per split.

```
$ ./1_split_pcap.sh 202011101400.pcap.gz 1500000
```

# Filter the splits

The next step is to process all split pcap files according to ```filter_rule.txt```:

```
$ ./2_filter_pcap.sh
```

# Random sampling

From the filtered splits on the previous step, this step will perform a random sampling of the amount of packets hardcoded in the script in the variable ```smaller_numbers```, and merge all sampled packet as a pcap file in the folder ```data/bonafide.pcap```.

```
$ ./3_random_pcap.sh
```

_NOTE: If you are using this framework not in stateless approach (packet granularity), this step of random sampling must not be performed, because the stateful approach (flow features) would be impacted._

# Generate **Bonafide** dataset

Finally, to generate the **bonafide** dataset as a csv file, perform the following:

```
$ python 4_generate_bonafide_dataset.py
```

It will save the file at: ```data/bonafide_dataset.csv```

__In this step the Python requires Pandas and PyShark packages.__
