# Reproducing the LAN performance evaluation

## Set the Local Network Connection between the devices

### On target device

```
$ ifconfig eth1 172.16.25.1 netmask 255.255.255.224
```

### On Host device

```
$ ifconfig eth1 172.16.25.2 netmask 255.255.255.224

$ ping 172.16.25.1

```

## On target device

### Loading the IDS as LKM

After cloning this repository:

```
$ cd AB-TRAP/

$ cd 4_RealizAtion/Local_Area_Network/

$ make

$ sudo insmod dt.ko

```

After evaluation to remove LKM:

```
$ sudo rmmod dt
```

### Once the LKM is loaded

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

_Output file separated by ;_

### Jupyter Notebook

Uses the provided ```Performance Evaluation.ipynb``` on this repository to retrieve the required parameters, in our case:

- **%memused** - Percentage of used memory
- **%sys** - Percentage of CPU utilization that occurred while executing at the system level (kernel). Note that this field does NOT include time spent servicing hardware or software interrupts.

Reference: https://linux.die.net/man/1/sar

