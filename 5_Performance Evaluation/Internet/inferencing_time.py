import timeit
import random
from joblib import load
from pandas import DataFrame
import numpy as np
import json

models = ['knn', 'rf', 'dt', 'lr', 'xgb', 'mlp', 'nb', 'svm']

features = ['ip.id', 'ip.flags.df', 'ip.ttl', 'ip.len', 'ip.dsfield', 'tcp.srcport', 'tcp.seq', 'tcp.len', 'tcp.hdr_len',
           'tcp.flags.fin', 'tcp.flags.syn', 'tcp.flags.reset', 'tcp.flags.push', 'tcp.flags.ack', 'tcp.flags.urg',
           'tcp.flags.cwr', 'tcp.window_size', 'tcp.urgent_pointer', 'tcp.options.mss_val']

preprocess = load(open("../../4_RealizAtion/Internet/Models/preprocessor.pkl", "rb"))

models_inference_time = {}
for model in models:
    models_inference_time[model] = { 'inference_time' : [] }

# create 20 random packets
for i in range(0,20):
    # generating random attributes
    pkt = [random.random() for i in range(0,len(features))]

    for model in models:
        print("> Running sample {} from {}".format(i, model))

        pickle_model = load(open("../../4_RealizAtion/Internet/Models/"+model+".pkl","rb"))

        df = DataFrame([pkt], columns=features)

        if model == "xgb":
            cols = pickle_model.get_booster().feature_names
            df = df[cols]

        X = preprocess.transform(df)
        X = DataFrame(X, columns=features)

        inference_time = timeit.timeit('pickle_model.predict(X)', setup="from __main__ import pickle_model, X", number=1000)

        # append a new inference time in the dict
        models_inference_time[model]['inference_time'].extend(inference_time)

for model in models:
    average = np.mean(models_inference_time[model]['inference_time'])
    stddev = np.std(models_inference_time[model]['inference_time'])
    print(">> The average inference time taken by {} is {:.2f} ms ({:.2f})".format(model, average, stddev))

with open("./results/inferencing_time.json", "wb") as f:
    json.dump(models_inference_time, f, indent=4)