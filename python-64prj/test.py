import streamlit as st
from cryptocmd import CmcScraper
import plotly.express as px
from datetime import datetime

st.write('# 가상화폐 차트')

st.sidebar.header('chart')

name = st.sidebar.selectbox('종목', ['BTC', 'ETH', 'USDT'])

start_date = st.sidebar.date_input('시작일', datetime(2021, 1, 1))
end_date = st.sidebar.date_input('종료일', datetime(2021, 6, 17))

# https://coinmarketcap.com
scraper = CmcScraper(name, start_date.strftime('%d-%m-%Y'), end_date.strftime('%d-%m-%Y')) # '%d-%m-%Y'
df = scraper.get_dataframe()

fig_close = px.line(df, x='Date', y=['Open', 'High', 'Low', 'Close'], title='시세')
fig_volume = px.line(df, x='Date', y=['Volume'], title='거래량')

st.plotly_chart(fig_close)
st.plotly_chart(fig_volume)