from rest_framework import status
from rest_framework.response import Response
from rest_framework.decorators import api_view
from rest_framework.parsers import JSONParser

from user.models import User,Cert_table
from lockerReservation.session import session_funcs
from lockerReservation.phonecert import cert_funcs
from user.serializers import CertSerializer

from django.http import JsonResponse

import random

# 네이버 api 휴대폰 인증 기능


@api_view(['POST'])
def phone_api(request, format=None):
    try:
        if request.method == 'POST':
            cnum = str(random.randrange(100000, 999999))  # 인증번호 생성
            request.data['cert_number'] = cnum
            request.data['cert_status'] = False
            print(request.data)
            serializer = CertSerializer(data=request.data)
            if serializer.is_valid():
                serializer.save()
            cert_funcs().certification(request.data['cert_number'],request.data['phone_num'])
            #print(type(a))
            return Response({"status": "ok"}, status=status.HTTP_200_OK)
    except:
        return Response({"error": ""}, status=status.HTTP_404_NOT_FOUND)

@api_view(['POST'])
def certcheck_api(request, format=None):
    try:
        if request.method == 'POST':
            save = Cert_table.objects.get(phone_num = request.data['phone_num'])
            if(save.cert_number == request.data['cert_number']):
                save.cert_status = True
                save.save()
                return Response({"cert": "success"}, status=status.HTTP_200_OK)
            else:
                return Response({"cert": "fail"}, status=status.HTTP_200_OK)
    except:
        return Response({"error": ""}, status=status.HTTP_404_NOT_FOUND)

'''
class Auth(APIView):
    def post(self, request):
        try:
            p_num = request.data['phone_number']
        except KeyError:
            return Response({'message': 'Bad Request'}, status=status.HTTP_400_BAD_REQUEST)
        else:
            models.AuthSms.objects.update_or_create(phone_number=p_num)
            return Response({'message': 'OK'})
'''

# 회원가입 기능


@api_view(['POST'])
def registration_api(request):
    if request.method == 'POST':
        data = JSONParser().parse(request)
        studentID = data['studentID']
        name = data['name']
        phone_num = data['phone_num']
        password = data['password']
        # studentID 중복 있는지 체크
        obj = User.objects.filter(studentID=studentID)
        if obj:
            return Response({"error": "already exists"}, status=status.HTTP_409_CONFLICT)
        # password 암호화는 나중에
        User.objects.create(studentID=studentID, name=name,
                            phone_num=phone_num, password=password)
        return Response({"studentID": studentID, "name": name}, status=status.HTTP_201_CREATED)

# 로그인 기능


@api_view(['POST'])
def login_api(request):
    if request.method == 'POST':
        session = session_funcs().get(request)
        if session:
            return Response({"error": "already logined"}, status=status.HTTP_409_CONFLICT)

        data = JSONParser().parse(request)  # 얘 왜 에러뜸?

        studentID = data['studentID']
        obj = User.objects.filter(studentID=studentID)
        if not obj:
            return Response({"error": "user doesn't exist"}, status=status.HTTP_404_NOT_FOUND)

        obj = User.objects.get(studentID=studentID)
        if data['password'] == obj.password:
            response = JsonResponse(
                {"studentID": obj.studentID, "name": obj.name}, status=status.HTTP_200_OK)
            response = session_funcs().set(response, studentID)
            return response
        else:
            return Response({"error": "password mismatch"}, status=status.HTTP_401_UNAUTHORIZED)


@api_view(['GET'])
def logout_api(request):
    if request.method == 'GET':
        response = JsonResponse(
            data=None,
            status=status.HTTP_200_OK,
            safe=False
        )
        response.delete_cookie('studentID')
        return response
