import requests
import hashlib
import hmac
import base64
import requests
import time
import json
import os


class cert_funcs:

    '''
    def __init__(self):
    def	make_signature():

        secret_key = bytes(self.secret_keys, 'UTF-8')
        method = "POST"
        message = method + " " + self.URI + "\n" + self.timestamp + "\n"+ self.access_key
        message = bytes(message, 'UTF-8')
        signingKey = base64.b64encode(hmac.new(secret_key, message, digestmod=hashlib.sha256).digest())
        return signingKey
    '''

    def certification(self, cert_num, phone_num):

        timestamp = int(time.time() * 1000)
        timestamp = str(timestamp)

        # access key id (from portal or Sub Account)
        access_key = os.environ.get("PHONE_CERT_ACCESS_KEY")
        # secret key (from portal or Sub Account)
        secret_keys = os.environ.get("PHONE_CERT_SECRET_KEY")
        # Create your views here.

        # 네이버 api 휴대폰 인증 기능

        URL = "https://sens.apigw.ntruss.com"
        URI = os.environ.get("PHONE_CERT_URI")

        secret_key = bytes(secret_keys, 'UTF-8')
        method = "POST"
        message = method + " " + URI + "\n" + timestamp + "\n" + access_key
        message = bytes(message, 'UTF-8')
        signingKey = base64.b64encode(
            hmac.new(secret_key, message, digestmod=hashlib.sha256).digest())
        # return signingKey

        header = {
            "Content-Type": "application/json; charset=utf-8",
            "x-ncp-apigw-timestamp": timestamp,
            "x-ncp-iam-access-key": access_key,
            "x-ncp-apigw-signature-v2": signingKey,
        }
        data = {
            "type": "LMS",
            "from": os.environ.get("PHONE_CERT_NUMBER"),
            "subject": "[컴퓨터 공학과 사물함 예약 서비스]",
            "content": "인증번호 ["+cert_num+"]를 입력해 주세요.",
            "messages": [
                {
                    "to": phone_num,
                }
            ]
        }
        res = requests.post(URL+URI, headers=header, data=json.dumps(data))
        # print(res)
        return res
