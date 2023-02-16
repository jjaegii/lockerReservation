from cryptography.fernet import Fernet
from random import randint


class session_funcs:
    def __init__(self):
        self.key = b'pAl5clMNb27FcwUxvs91XP-oK-3ICJJYBplcJVHAlgY='
        self.fernet = Fernet(self.key)

    def get(self, request):
        if 'studentID' not in request.session:
            return None
        else:
            # 복호화
            crypted = bytes(request.session['studentID'], 'utf-8')
            decrypt = self.fernet.decrypt(crypted)
            string = decrypt.decode('utf-8')
            return string[:8]

    def set(self, request, studentID):
        # 암호화
        byte = bytes(studentID + str(randint(10000000, 99999999)), 'utf-8')
        crypt = self.fernet.encrypt(byte)
        request.session['studentID'] = crypt.decode('utf-8')
        return request

    def delete(self, request):
        if 'studentID' in request.session:
            del request.session['studentID']
        return request
