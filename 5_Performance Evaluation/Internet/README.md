# Reproducing the performance evaluation

## On target device

1. Clone repository

`$ git clone https://github.com/gubertoli/AB-TRAP.git`

2. Setup environment

```
$ cd AB-TRAP
$ python -m venv venv
$ source venv/bin/activate
$ pip install -r requirements.txt
```

3. Merge kNN model

```
$ cd 4_RealizAtion/Internet/Models/
$ cat knn.pkl.part-a? > knn.pkl
```

4. Create link to Models and IDS script

```
$ cd ../../../5_Performance\ Evaluation/Internet/
$ ln -s ../../4_RealizAtion/Internet/Models/
$ ln -s ../../4_RealizAtion/Internet/userspace_ids.py
```

5. Run UDP Server to evaluate models

`AB-TRAP/5_Performance Evaluation/Internet$ sudo ../../venv/bin/python udp_server.py`

## On host computer

Run the test script:

```
AB-TRAP/5_Performance Evaluation/Internet$ chmod +x evaluate_models.sh
AB-TRAP/5_Performance Evaluation/Internet$ sudo ./evaluate_models.sh
```

## Converting the output of sar/sysstat to CSV

`$ sadf --iface=eth0 -d -h -- -r ALL -n ALL -u ALL output_file > output.csv`

_The output file is separated by ";"_
