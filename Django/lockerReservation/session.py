from cryptography.fernet import Fernet
from random import randint
import os


class session_funcs:
    def __init__(self):
        self.key = os.environ.get("SESSION_KEY")
        self.fernet = Fernet(self.key)

    def get(self, request):
        if 'studentID' not in request.COOKIES:
            return None
        else:
            # 복호화
            crypted = bytes(request.COOKIES['studentID'], 'utf-8')
            decrypt = self.fernet.decrypt(crypted)
            string = decrypt.decode('utf-8')
            return string[:8]

    def set(self, request, studentID):
        # 암호화
        byte = bytes(studentID + str(randint(10000000, 99999999)), 'utf-8')
        crypt = self.fernet.encrypt(byte)
        request.set_cookie('studentID', crypt.decode('utf-8'), max_age=1800)
        return request
