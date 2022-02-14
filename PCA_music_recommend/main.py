import pandas as pd
import numpy as np
from copy import deepcopy
from PCA import Principle_Component_Analysis
from log_reg import Logistic_Regression
from sklearn.metrics.pairwise import cosine_similarity

class music_recommend:

    def __init__(self, data):
        self.df = data

    def train_set(self):
        df = deepcopy(self.df)
        size = len(df) / 5
        return  df[:int(size)]# get a subset of original data, the size is set to be 1/5 of original data

    def important_col(self):
        df = self.train_set()
        input_set = df[['artists'] + df.select_dtypes(include=np.number).columns.tolist()[:-2]]
        comp, e = Principle_Component_Analysis(input_set).PCA()
        comp = comp[['Principal Component 1','Principal Component 2','Principal Component 3']]
        # apply pca to reduce the dimension of data set
        reverse = (comp.values).dot(np.array(e)[:3,:3])
        reverse += np.mean(comp, axis=0)
        # reconstruct the original data to get important columns
        mean = np.mean(reverse, axis=0)
        col_list = []
        for col in df.select_dtypes(include=np.number).columns.tolist():
            if df[col].mean() - mean[0] <= 0.2 and df[col].mean() - mean[0] > 0:
                col_list.append(col)
        return ['id'] + col_list

    def similarity(self, info):
        df = self.train_set()
        target_row = df.loc[df.isin(info).any(axis=1)].iloc[0].values # find the corresponding music info
        num_list = []
        for i in range(len(target_row)):
            if isinstance(target_row[i], str):
                num_list.append(i)
        target_row = np.delete(target_row,num_list)
        df1 = deepcopy(df)
        del df1['artists'],df1['id'],df1['name'],df1['release_date']
        sim = cosine_similarity(target_row.reshape((1, -1)), df1).reshape(-1) # calculate cosine similarity of target and other music
        df['if_recom'] = sim
        df.loc[(df['if_recom'] >= 0.9999999),'if_recom'] = 1
        df.loc[(df['if_recom'] < 0.9999999),'if_recom'] = 0
        return df
      
    def recommend(self, info):
        cols = self.important_col() + ['if_recom']
        df = self.similarity(info)
        df = df[df.columns.intersection(cols)]
        var = ['explicit', 'instrumentalness', 'speechiness', 'if_recom']
        pred_set = self.df[self.df.columns.intersection(['explicit', 'instrumentalness', 'speechiness'])]
        lr = Logistic_Regression(df, var, pred_set)
        model_coef,pred,accuracy = lr.run_model() # use the previous subset as trainning set and use logistic regression to predict the similarity to target music
        self.df['if_recom'] = 1/(1 + np.exp((model_coef[0][0] + model_coef[1][0] * self.df['explicit'] + model_coef[1][1] * self.df['instrumentalness'] + model_coef[1][2] * self.df['speechiness'])))
        self.df = self.df[self.df.columns.intersection(['artists', 'name', 'id', 'if_recom'])]
        self.df = self.df[self.df['if_recom'] > 0.98] # we can set a relatively high threshold for this system
        self.df = self.df.sort_values('if_recom')
        self.df = self.df[:-10] # return 10 similar songs to users
        del self.df['if_recom']
        self.df.reset_index(inplace=True, drop = True)
        #print(accuracy) has an accuracy of 0.9
        return self.df.tail(10)
        
'''
this algorithm starts from a small subset of original dataset
apply pca to find the significant components and reconstruct them in original set
compute the similarity of input music info and music info in subset
what music will be recommended is based on values of similarity
add an extra column indicates if the music will be recommended
use subset as a tranning set and use logistic regression to find the recommended music in whole dataset
since the threshold is usually 0.5 in logistic regression
in this system, i raised it to 0.98
finally, user will get 10 recommended songs similar to input song
'''       
        
if __name__ == "__main__":
    music_list = pd.read_csv(r'/Users/zhuofanli/Desktop/project/python/CS593/Final/Wynk.csv')
    mr = music_recommend(music_list)
    res = mr.recommend(['St. Louis Blues',['Bessie Smith', 'Louis Armstrong']])
    print(res)
    # test case input is St. Louis Blues by Bessie Smith and Louis Armstrong
