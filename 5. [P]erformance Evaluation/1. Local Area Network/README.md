# Reproducing the LAN performance evaluation

## On target device

Uses IPerf3 to run as daemon:

```
$ iperf3 -s -D 
```

Also runs [sar](https://linux.die.net/man/1/sar) (sysstat) to record performance parameters:

```
$ sar -r ALL -n ALL -u ALL -o OUTPUT_FILE 1 1200
```

## On host computer
On the attacker/host computer generate traffic using IPerf3 (for 1200 seconds):

```
$ iperf3 -c IP_Raspberry -t 1200
```

## Processing sar output file
To generate a csv file from sar output, uses [sadf](https://linux.die.net/man/1/sadf) with the following syntax:

```
$ sadf --iface=INTERFACE_NAME -d -h -- -r ALL -n ALL -u ALL OUTPUT_FILE > OUTPUT_FILE.csv
```

### Jupyter Notebook

Uses the provided ```Performance Evaluation.ipynb``` on this repository to retrieve the required parameters, in our case:

- **%memused** - Percentage of used memory
- **%sys** - Percentage of CPU utilization that occurred while executing at the system level (kernel). Note that this field does NOT include time spent servicing hardware or software interrupts.

Reference: https://linux.die.net/man/1/sar

