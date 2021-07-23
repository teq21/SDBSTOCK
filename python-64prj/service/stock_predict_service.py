import pandas as pd
from pandas.core.arrays import string_
import json
import requests

from fbprophet import Prophet



def predict(stockname):    
    #해당 링크는 한국거래소에서 상장법인목록을 엑셀로 다운로드하는 링크입니다.
    #다운로드와 동시에 Pandas에 excel 파일이 load가 되는 구조입니다.
    stock_code = pd.read_html('http://kind.krx.co.kr/corpgeneral/corpList.do?method=download', header=0)[0] 
    #stock_code.head()

    # 데이터에서 정렬이 따로 필요하지는 않지만 테스트겸 Pandas sort_values를 이용하여 정렬을 시도해봅니다.
    stock_code.sort_values(['상장일'], ascending=True)

    # 필요한 것은 "회사명"과 "종목코드" 이므로 필요없는 column들은 제외
    stock_code = stock_code[['회사명', '종목코드']] 

    # 한글 컬럼명을 영어로 변경 
    stock_code = stock_code.rename(columns={'회사명': 'company', '종목코드': 'code'}) 
    #stock_code.head()

    # 종목코드가 6자리이기 때문에 6자리를 맞춰주기 위해 설정해줌 
    stock_code.code = stock_code.code.map('{:06d}'.format) 

    # LG화학의 일별 시세 url 가져오기 
    company=stockname
    code = stock_code[stock_code.company==company].code.values[0].strip() ## strip() : 공백제거
    df = pd.DataFrame()
    page=1
    for page in range(1,21):
        url = 'http://finance.naver.com/item/sise_day.nhn?code={code}'.format(code=code)     
        url = '{url}&page={page}'.format(url=url, page=page)
        print(url)
        header = {'User-Agent':'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.212 Safari/537.36'}  
        res = requests.get(url,headers=header)
        df = df.append(pd.read_html(res.text, header=0)[0])

    # df.dropna()를 이용해 결측값 있는 행 제거 
    df = df.dropna() 

    # 한글로 된 컬럼명을 영어로 바꿔줌 
    df = df.rename(columns= {'날짜': 'date', '종가': 'close', '전일비': 'diff', '시가': 'open', '고가': 'high', '저가': 'low', '거래량': 'volume'}) 
    # 데이터의 타입을 int형으로 바꿔줌 
    df[['close', 'diff', 'open', 'high', 'low', 'volume']] = df[['close', 'diff', 'open', 'high', 'low', 'volume']].astype(int) 

    # 컬럼명 'date'의 타입을 date로 바꿔줌 
    # df['date'] = df['date']
    # df['date'] = pd.to_datetime(df['date'],format='%Y-%m-%d', errors='coerce') 
    # # 일자(date)를 기준으로 오름차순 정렬 
    df = df.sort_values(by=['date'], ascending=True) 
    
    # # 상위 5개 데이터 확인 
    # df.head()
    #   js = df.iloc[0].to_json(orient = 'table')

    df['y'] = df['close']
    df['ds'] = df['date']

    m = Prophet()
    m.fit(df)
    future = m.make_future_dataframe(periods=30)
    forecast = m.predict(future)
    
    ne_df=df[['date','close']]
    f_data=forecast[['ds','yhat']]
    
  
    final=pd.concat([ne_df.reset_index(),f_data],axis=1)
    
    js = final.to_json(orient = 'records')
    
    print(final) 
    
    
    

    return js
   

