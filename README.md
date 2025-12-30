# AB-TRAP: building invisibility shields to protect network devices
The AB-TRAP framework is applicable to the development of Network Intrusion Detection Systems (NIDS), it enables the use of updated network traffic and considers operational concerns to enable the complete deployment of the solution. It is a five-step framework consisting of (i) the generation of the attack dataset, (ii) the bonafide dataset, (iii) training of machine learning models, (iv) realization of the models, and (v) the performance evaluation of the realized model after deployment.

This repositories contains the examples for both Local Area Network (LAN), and the Internet environment taking advantage of virtualization (virtual machines and containers) to support the dataset generation.

This repository contains all the necessary files to rebuilt this project.

- [Content of this repository](#content-of-this-repository)
- [Pre-requisites](#pre-requisites)
- [Contribute to the framework](#contribute)
- [How to cite](#how-to-cite)

## Content of this repository
* `/1_Attack dataset`: contains the instructions and the required code to generate the `attack dataset` considering both LAN and Internet environment;
* `/2_Bonafide dataset`: contains the instructions and the required code to generate the `bonafide dataset` based on the [MAWILab dataset](http://www.fukuda-lab.org/mawilab/index.html);
* `/3_Training models`: contains the Jupyter Notebooks to pre-process the data, and generate the ML models (LAN and Internet cases);
* `/4_RealizAtion`: contains the source code to obtain the machine learning models to be embedded on the target devices, both in the kernel-space using LKM (LAN case), and user-space with Python language (Internet case);
* `/5_Performance Evaluation`: contains the instructions to evaluate the Performance of machine learning models in the target device;

## Pre-requisites
For the host computer, it is required Python language with the dependencies listed in `requirements.txt`.

You can setup the environment with Python packet manager (pip):

```
$ pip install -r requirements.txt
```

The target computer used on this work is the [Raspberry Pi 4](https://www.raspberrypi.org/products/raspberry-pi-4-model-b/).

## Contribute to the framework
To contribute with the framework, you can use the Issues and Pull Requests from Github platform.

## How to cite

```
@ARTICLE{9501960,  
  author={De Carvalho Bertoli, Gustavo and Pereira Júnior, Lourenço Alves and Saotome, Osamu and Dos Santos, Aldri L. 
        and Verri, Filipe Alves Neto and Marcondes, Cesar Augusto Cavalheiro and Barbieri, Sidnei and Rodrigues, Moises S. 
        and Parente De Oliveira, José M.},  
  journal={IEEE Access},   
  title={An End-to-End Framework for Machine Learning-Based Network Intrusion Detection System},   
  year={2021},  
  volume={9},  
  number={},  
  pages={106790-106805},  
  doi={10.1109/ACCESS.2021.3101188}
}
```

## NeurIPS 2021 Lightning Talk

Bridging the gap to real-world for network intrusion detection systems with a data-centric approach.  
_Data-Centric AI Workshop, NeurIPS 2021._

[Video](https://neurips.cc/virtual/2021/38226) | [Related Paper](https://arxiv.org/abs/2110.13655)
