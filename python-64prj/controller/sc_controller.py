# -- coding: Utf-8 --
from flask import Flask,request
from flask_cors import CORS
import os
import sys
import json
import requests
sys.path.append(os.path.dirname(os.path.abspath(os.path.dirname(__file__))))
import service.stock_chart as sc

app = Flask(__name__)
CORS(app)
@app.route('/')

def stock_chart():
    pstock=request.args.get("pstock")
    
    res=sc.stock.sd(pstock)
    
    return res 


if __name__ == '__main__':
    app.run(host="127.0.0.1",port=8000)