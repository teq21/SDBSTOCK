# -- coding: Utf-8 --
from flask import Flask,request
from flask_cors import CORS
import os
import sys
import json
import requests
sys.path.append(os.path.dirname(os.path.abspath(os.path.dirname(__file__))))
import service.btc_predict_service as bc

app = Flask(__name__)
CORS(app)
@app.route('/')
# @app.route('/', methods=['POST'] )
def stock_chart():
    
    # pchannel=request.args.get("pchannel")
    # ptocken=request.args.get("ptocken")
    # ptext=request.args.get("ptext")
    # jsonData = request.get_json()
    # pstock = jsonData['pstock']
    res=bc.predict()
    print(res)
    return res 


if __name__ == '__main__':
    app.run(host="127.0.0.1",port=9001)