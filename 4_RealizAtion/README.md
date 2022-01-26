# Step 4: Realization
The realization step starts from the trained model selected in the previous step and requires implementing a computational system's trained model. 
For devices using embedded Linux is possible to use Linux Kernel Modules (LKM) along with Netfilter for packet filtering.
The approach with LKM and Netfilter processes each packet received in the network interface during its traversal path up to the application layer.

## Requirements
- Python modules: fnfqueue and scapy
- Machine learning models: extracted from step #3 (training phase)
- Makefile (makefile.o)
- LKM sourcecode (dt.c)

## How it works
The sourcecode dt.c will be added as a LKM and will enable the packet filtering within Netfilter.

## Load and Compile the Linux Kernel Module
Create a directory for the files

`$ mkdir dt`

`$ cd dt`

Copy the files dt.c and makefile.o for the new directory you just created.

Once in the directory use the "make" command to enable makefile.o

`$ make`

`$ sudo insmod dt.ko`

Verify the modules:

`$ lsmod | grep dt`
