import time
import pyupbit
import datetime
import schedule
from fbprophet import Prophet 
import matplotlib.pyplot as plt
import pandas as pd

predicted_close_price = 0
def predict_price():
    """Prophet으로 당일 종가 가격 예측"""
    global predicted_close_price
    df = pyupbit.get_ohlcv("KRW-BTC", interval="minute60")
    df = df.reset_index()
    df['ds'] = df['index']
    df['y'] = df['close']
    data = df[['ds','y']]
    model = Prophet()
    model.fit(data)
    future = model.make_future_dataframe(periods=24, freq='H')
    forecast = model.predict(future)
    
    fig1=model.plot(forecast)
    
    
    df=forecast[['ds', 'yhat']]
   
    pd.options.display.float_format = '{:.5f}'.format
    js = df.to_json(orient = 'records')
    
    print(df)
predict_price()

