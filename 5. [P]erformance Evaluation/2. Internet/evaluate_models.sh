#!/bin/bash

# run this script to evaluate the models in the remote target

TARGET="10.42.0.134"	# Raspberry Pi IP
TIME_TO_EVALUATE="1200" # Time in seconds

echo "> Using K-Nearest Neighbors (kNN) model for IDS"
echo -n "knn" >/dev/udp/${TARGET}/11000
sleep 5
iperf3 -c ${TARGET} -t ${TIME_TO_EVALUATE}
sleep 5
echo -n "STOP" >/dev/udp/${TARGET}/11000
sleep 10

echo "> Using Random Forest (RF) model for IDS"
echo -n "rf" >/dev/udp/${TARGET}/11000
sleep 5
iperf3 -c ${TARGET} -t ${TIME_TO_EVALUATE}
sleep 5
echo -n "STOP" >/dev/udp/${TARGET}/11000
sleep 10

echo "> Using Decision Tree (DT) model for IDS"
echo -n "dt" >/dev/udp/${TARGET}/11000
sleep 5
iperf3 -c ${TARGET} -t ${TIME_TO_EVALUATE}
sleep 5
echo -n "STOP" >/dev/udp/${TARGET}/11000
sleep 10

echo "> Using Logistic Regression (LR) model for IDS"
echo -n "lr" >/dev/udp/${TARGET}/11000
sleep 5
iperf3 -c ${TARGET} -t ${TIME_TO_EVALUATE}
sleep 5
echo -n "STOP" >/dev/udp/${TARGET}/11000
sleep 10

echo "> Using XGBoost (XGB) model for IDS"
echo -n "xgb" >/dev/udp/${TARGET}/11000
sleep 5
iperf3 -c ${TARGET} -t ${TIME_TO_EVALUATE}
sleep 5
echo -n "STOP" >/dev/udp/${TARGET}/11000
sleep 10

echo "> Using Multi-Layer Perceptron (MLP) model for IDS"
echo -n "mlp" >/dev/udp/${TARGET}/11000
sleep 5
iperf3 -c ${TARGET} -t ${TIME_TO_EVALUATE}
sleep 5
echo -n "STOP" >/dev/udp/${TARGET}/11000
sleep 10

echo "> Using Naive Bayes (NB) model for IDS"
echo -n "nb" >/dev/udp/${TARGET}/11000
sleep 5
iperf3 -c ${TARGET} -t ${TIME_TO_EVALUATE}
sleep 5
echo -n "STOP" >/dev/udp/${TARGET}/11000
sleep 10

echo "> Using Support Vector Machine (SVM) model for IDS"
echo -n "svm" >/dev/udp/${TARGET}/11000
sleep 5
iperf3 -c ${TARGET} -t ${TIME_TO_EVALUATE}
sleep 5
echo -n "STOP" >/dev/udp/${TARGET}/11000
sleep 10

