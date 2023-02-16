from rest_framework import status
from rest_framework.response import Response
from rest_framework.decorators import api_view
from rest_framework.parsers import JSONParser

from user.models import User
from lockerReservation.session import session_funcs

# Create your views here.

# 네이버 api 휴대폰 인증 기능, 미구현
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
            request = session_funcs().set(request, studentID)
            return Response({"studentID": obj.studentID, "name": obj.name}, status=status.HTTP_200_OK)
        else:
            return Response({"error": "password mismatch"}, status=status.HTTP_401_UNAUTHORIZED)


@api_view(['GET'])
def logout_api(request):
    if request.method == 'GET':
        request = session_funcs().delete(request)
        return Response(status=status.HTTP_200_OK)
