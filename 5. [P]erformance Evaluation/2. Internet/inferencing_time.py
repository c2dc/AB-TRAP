import timeit
from pickle import load
from pandas import DataFrame

models = ['knn', 'rf', 'dt', 'lr', 'xgb', 'mlp', 'nb', 'svm']

features = []

preprocess = load(open("../../4/2/Models/preprocessor.pkl", "rb"))

for model in models:
    pickle_model = load(open("../../4/2/Models/"+model+".pkl","rb"))

    df = DataFrame([pkt], columns=features)

    if model == "xgb":
        cols = pickle_model.get_booster().feature_names
        df = df[cols]

    X = preprocess.transform(df)
    X = DataFrame(X, columns=features)

    print("The inference time taken by {0} is {1}".format(model, timeit.timeit(stmt=pickle_model.predict(X))))
