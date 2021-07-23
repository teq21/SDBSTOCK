import pandas as pd
from pandas.core.arrays import string_
import FinanceDataReader as fdr
import requests
from fbprophet import Prophet
import numpy as np
import seaborn as sns
import warnings
import os
import requests
import json


def predict():    
    btc = fdr.DataReader('BTC/KRW', '2021')
    
    btc['y']=btc['Close']
    btc['ds']=btc.index
    m=Prophet()
    m.fit(btc)
    future = m.make_future_dataframe(periods=3)
   
    forecast = m.predict(future)
    new_btc=btc[['ds','Close']]
    f_data=forecast[['yhat']]
    final=pd.concat([new_btc.reset_index(),f_data],axis=1)

    js = final.to_json(orient = 'records')
    
    

    def post_message(token, channel, text):
            response = requests.post("https://slack.com/api/chat.postMessage",
                                    headers={"Authorization": "Bearer "+token},
                                    data={"channel": channel, "text": text}
                                    )
            print(response)

    myToken = "xoxb-2150311790080-2139137610961-rQjiq0HzzWIYbz15QMSiON2H"
    
    post_message(myToken, "#stockmessage", "BTC 1일뒤 예측가: "+str(final.iloc[-3].yhat))
    post_message(myToken, "#stockmessage", "BTC 2일뒤 예측가: "+str(final.iloc[-2].yhat))
    post_message(myToken, "#stockmessage", "BTC 3일뒤 예측가: "+str(final.iloc[-1].yhat))
    
    return js

def ethpredict():    
    btc = fdr.DataReader('ETH/KRW', '2021')
    
    btc['y']=btc['Close']
    btc['ds']=btc.index
    m=Prophet()
    m.fit(btc)
    future = m.make_future_dataframe(periods=3)
   
    forecast = m.predict(future)
    new_btc=btc[['ds','Close']]
    f_data=forecast[['yhat']]
    final=pd.concat([new_btc.reset_index(),f_data],axis=1)

    js = final.to_json(orient = 'records')

    def post_message(token, channel, text):
            response = requests.post("https://slack.com/api/chat.postMessage",
                                    headers={"Authorization": "Bearer "+token},
                                    data={"channel": channel, "text": text}
                                    )
            print(response)

    myToken = "xoxb-2150311790080-2139137610961-rQjiq0HzzWIYbz15QMSiON2H"
    
    post_message(myToken, "#stockmessage", "ETH 1일뒤 예측가: "+str(final.iloc[-3].yhat))
    post_message(myToken, "#stockmessage", "ETH 2일뒤 예측가: "+str(final.iloc[-2].yhat))
    post_message(myToken, "#stockmessage", "ETH 3일뒤 예측가: "+str(final.iloc[-1].yhat))
    
 
    return js

ethpredict()










    
