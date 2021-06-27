
# -*- coding: utf-8 -*-
"""
Created on Tue Aug 21 21:53:22 2018

@author: Nalabolu
"""


import pandas as pd

train_df=pd.read_csv("G:\\Data science\\Kaggle\\House_Price_Prediction\\Dataset\\train.csv")

train_df.isnull().sum().sum()

train_df.isnull().sum()


train_df=train_df.dropna(thresh=(len(train_df)*60)/100,axis=1)

train_df.shape

train_df.isnull().sum()

train_df.dtypes

colsToDrop=["Id","YearBuilt","YearRemodAdd","MoSold","YrSold"]

train_df=train_df.drop(colsToDrop,axis=1)

### Preprocessing

def impute_dataframe(df):
    for col in df.columns.values:
        if str(df[col].dtype) == 'float64' or str(df[col].dtype) == 'int64':
            df[col]=df[col].fillna(value=df[col].mean())
        elif str(df[col].dtype) == 'category' or str(df[col].dtype) == 'object':
            df[col]=df[col].fillna(value=df[col].mode()[0])
    return df

train_df=impute_dataframe(train_df)

import matplotlib.pyplot as plt
import numpy as np
plt.hist(train_df['SalePrice'])

plt.boxplot(train_df['SalePrice'])

y=train_df['SalePrice']
X=train_df.drop(['SalePrice'],axis=1)

def impute_outliers_df_StdDev_Boundaries(df_in):
    for col_name in df_in.columns.values:
        if str(df_in[col_name].dtype) == 'float64' or str(df_in[col_name].dtype) == 'int64':
            fence_low = df_in[col_name].mean()-3*df_in[col_name].std()
            fence_high = df_in[col_name].mean()+3*df_in[col_name].std()
            df_in[col_name] = df_in[col_name].mask(df_in[col_name] >fence_high, fence_high)
            df_in[col_name] = df_in[col_name].mask(df_in[col_name] <fence_low, fence_low)
    return df_in

X=impute_outliers_df_StdDev_Boundaries(X)

###Label Encoding

from sklearn import preprocessing
le = preprocessing.LabelEncoder()

for col in X.columns.values:
    if str(X[col].dtype) == 'object':
        le.fit(pd.Series(X[col]))
        X[col]=le.transform(pd.Series(X[col]))
        

###Dummies - One Hot Encoding

X=pd.get_dummies(X,drop_first=True )

from sklearn.model_selection import train_test_split
X_train, X_test, y_train, y_test = train_test_split(X, y, 
                                                    test_size=0.25,
                                                    random_state=123)   

corr=X.corr()

import seaborn as sns

sns.heatmap(corr, 
        xticklabels=corr.columns,
        yticklabels=corr.columns)

##Linear Regression

from sklearn import linear_model
from sklearn.metrics import r2_score , mean_absolute_error,mean_squared_error
from math import sqrt
linreg = linear_model.LinearRegression()


linreg.fit(X_train,y_train)
preds=linreg.predict(X_test)



print(sqrt(mean_squared_error(preds, y_test)))


r_squared = r2_score(preds,y_test)
print(r_squared)
# Adjusted R Squared
1 - (1-r_squared)*(len(y_train)-1)/(len(y_train)-X_train.shape[1]-1)