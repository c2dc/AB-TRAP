# AB-TRAP: building invisibility shields to protect network devices
The AB-TRAP framework is applicable to the development of Network Intrusion Detection Systems (NIDS), it enables the use of updated network traffic and considers operational concerns to enable the complete deployment of the solution. It is a five-step framework consisting of (i) the generation of the attack dataset, (ii) the bonafide dataset, (iii) training of machine learning models, (iv) realization of the models, and (v) the performance evaluation of the realized model after deployment.

This repository contains all the necessary files to rebuilt this project. 

- [Content of this repository](#content-of-this-repository)
- [Pre-requisites](#pre-requisites)
- [Contribute to the framework](#contribute)
- [How to cite](#how-to-cite)

## Content of this repository
* `/1. [A]ttack dataset`: contains the instructions and the required code to generate the `attack dataset` considering both LAN and Internet environment;
* `/2. [B]onafide dataset`: contains the instructions and the required code to generate the `bonafide dataset` based on the [MAWILab dataset](http://www.fukuda-lab.org/mawilab/index.html);
* `/3. [T]raining models`: contains the Jupyter Notebooks to pre-process the data, and generate the ML models (LAN and Internet cases);
* `/4. [R]ealiz[A]tion`: contains the source code to obtain the machine learning models to be embedded on the target devices, both in the kernel-space using LKM (LAN case), and user-space with Python language (Internet case);
* `/5. [P]erformance Evaluation`: contains the instructions to evaluate the Performance of machine learning models in the target device;

## Pre-requisites
For the host computer, it is required Python language with the dependencies listed in `requirements.txt`.

You can setup the environment with Python packet manager (pip):

```
$ pip install -r requirements.txt
```

The target computer used on this work were both [Raspberry Pi 3](https://www.raspberrypi.org/products/raspberry-pi-3-model-b/), and [Raspberry Pi 4](https://www.raspberrypi.org/products/raspberry-pi-4-model-b/).

## Contribute to the framework
To contribute with the framework, you can use the Issues and Pull Requests from Github platform.

## How to cite
```

```