from numpy.core.fromnumeric import shape
import pandas as pd
import numpy as np
from sklearn.preprocessing import StandardScaler

class Principle_Component_Analysis:

    def __init__(self, dataset):
        self.raw_data = dataset

    def standardize_dataset(self):
        features = self.raw_data.select_dtypes(include=np.number).columns.tolist() # select numeric columns
        tartget = list(set(self.raw_data.columns.to_list()) - set(features)) # select non-numeric columns
        x = self.raw_data.loc[:, features].values
        x = StandardScaler().fit_transform(x) # Standardizing the features
        df = pd.DataFrame(x,columns=features) # write data to dataframe
        if len(tartget) != 0: df['Target'] = self.raw_data[tartget[0]]
        return df, x

    def covar_matrix(self, X):
        return np.dot(X.T, X) / X.shape[0] # numpy.cov uses n-1, here we use the population

    def PCA(self):
        df, X = self.standardize_dataset()
        cov = self.covar_matrix(X)
        eigen_value, eigen_vector = np.linalg.eig(cov) # find the eigen value and eigen vector of covariance matrix
        col_name = ['Principal Component ' + str(i) for i in range(1, X.shape[1]+1)] # name for new components
        componet = np.dot(X,eigen_vector)
        componet = pd.DataFrame(componet,columns=col_name) # wrtite new components to dataframe
        try:
            componet['Target'] = df['Target']
        except KeyError:
            pass
        return componet,eigen_vector
        

    