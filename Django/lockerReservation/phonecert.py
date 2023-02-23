import requests
import sys
import os
import hashlib
import hmac
import base64
import requests
import time
import json


class cert_funcs:
    access_key = "uHJq1qUMBXqCwdaCkYkH"				# access key id (from portal or Sub Account)
    secret_keys = "55eozAM8Vweqim1lDcHFT6toIyJb6b9mTOphMf5n"				# secret key (from portal or Sub Account)
    # Create your views here.

    # 네이버 api 휴대폰 인증 기능

    URL = "https://sens.apigw.ntruss.com"
    URI = "/sms/v2/services/ncp:sms:kr:287329930734:locker_reservation/messages"

    def	make_signature():
        timestamp = int(time.time() * 1000)
        timestamp = str(timestamp)
        secret_key = bytes(secret_keys, 'UTF-8')
        method = "POST"
        message = method + " " + URI + "\n" + timestamp + "\n"+ access_key
        message = bytes(message, 'UTF-8')
        signingKey = base64.b64encode(hmac.new(secret_key, message, digestmod=hashlib.sha256).digest())
        return signingKey

    def certification(self,cert_num,phone_num):
        header = {
            "Content-Type" : "application/json; charset=utf-8",
	        "x-ncp-apigw-timestamp" : timestamp,
	        "x-ncp-iam-access-key" : access_key,
	        "x-ncp-apigw-signature-v2" : make_signature()
        }
        data = {
            "type":"LMS",
            "from":"01033149563",
            "subject":"[컴퓨터 공학과 사물함 예약 서비스]",
            "content":"인증번호 ["+cert_num+"]를 입력해 주세요.",
            "messages":[
                {
                    "to":phone_num,
                }
            ]
        }
        res= requests.post(URL+URI,headers=header,data=json.dumps(data))