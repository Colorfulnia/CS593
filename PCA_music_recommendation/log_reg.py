import numpy as np
import pandas as pd
from sklearn.model_selection import train_test_split
from sklearn.linear_model import LogisticRegression

class Logistic_Regression:
    
    def __init__(self, data, variables, test):
        self.data = data
        self.variables = variables # input can be a list with first element being dependent variable and others being independent variables or 'all
        self.test_set = test

    def target_dataset(self):
        if self.variables == 'all' : return self.data
        return self.data[self.data.columns.intersection(self.variables)]

    def run_model(self):
        df = self.target_dataset()
        X_train,X_test,y_train,y_test = train_test_split(df[self.variables[:-1]],df[self.variables[-1]],test_size=0.1,random_state=0)
        model = LogisticRegression()
        model.fit(X_train,y_train)
        p = model.predict(X_test)
        coef = [model.intercept_] + model.coef_.tolist()
        residual = y_test - p # residual is calculated by actual value minus predicted value
        incorrect = np.count_nonzero(residual)
        return coef, p, 1 - incorrect / len(residual) # return coefficient and predicted value and accuracy

