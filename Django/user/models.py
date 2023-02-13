from django.db import models
from django.contrib.auth.models import AbstractBaseUser, BaseUserManager

# Create your models here.

# User Model


class UserManager(BaseUserManager):
    # user 생성
    def create_user(self, studentID, name, phone_num, password=None):
        if not studentID:
            raise ValueError('Users must have an studentID.')
        if not name:
            raise ValueError('Users must have an name')
        if not phone_num:
            raise ValueError('Users must have an phone_num')
        user = self.model(
            studentID=studentID,
            name=name,
            phone_num=phone_num
        )
        user.set_password(password)
        user.save(using=self._db)
        return user


class User(AbstractBaseUser):
    studentID = models.CharField(
        max_length=8, null=False, unique=True, blank=False)
    name = models.CharField(max_length=40, null=False, blank=False)
    phone_num = models.CharField(
        max_length=13, null=False, unique=True, blank=False)

    objects = UserManager()  # 헬퍼 클래스 사용

    USERNAME_FIELD = 'studentID'  # 로그인 ID로 사용할 필드
    REQUIRED_FIELDS = ['studentID', 'name', 'phone_num']  # 필수 작성 필드

    def __str__(self):
        return self.studentID

    def get_full_name(self):
        return self.studentID

    def get_short_name(self):
        return self.studentID


# 네이버 api 휴대폰 인증 기능, 미구현
'''
class TimeStampedModel(models.Model):
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    class Meta:
        abstract = True


class AuthSms(TimeStampedModel):
    phone_number = models.CharField(
        verbose_name='휴대폰 번호', primary_key=True, max_length=11)
    auth_number = models.IntegerField(verbose_name='인증 번호')

    class Meta:
        db_table = 'auth'

    def save(self, *args, **kwargs):
        self.auth_number = randint(1000, 10000)
        super().save(*args, **kwargs)
        self.send_sms()  # 인증번호가 담긴 SMS를 전송

    def send_sms(self):
        url = 'https://sens.apigw.ntruss.com/sms/v2/services/ncp:sms:kr:287329930734:locker_reservation/messages'
        data = {
            "type": "SMS",
            "from": "01033149563",
            "to": [self.phone_number],
            "content": "[테스트] 인증 번호 [{}]를 입력해주세요.".format(self.auth_number)
        }
        headers = {
            "Content-Type": "application/json",
            "x-ncp-iam-access-key": 'uHJq1qUMBXqCwdaCkYkH',
            "x-ncp-apigw-signature-v2": '55eozAM8Vweqim1lDcHFT6toIyJb6b9mTOphMf5n',
        }
        requests.post(url, json=data, headers=headers)
'''
