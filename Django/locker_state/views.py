from rest_framework.response import Response
from rest_framework.decorators import api_view
from rest_framework import exceptions
from rest_framework import status

from .models import Locker
from .serializers import LockerSerializer,LockerCreateSerializer
from lockerReservation.session import session_funcs

# Create your views here.


@api_view(['GET','POST'])
def LockerList(request,format = None):
    try:
        if request.method == 'GET':  # 사물함 조회 (파라미터는 location)
            loc = request.GET['location'] 
            if len(loc) > 1 : 
                raise exceptions.ParseError("not enable data") 
            #print(loc) 
            queryset = Locker.objects.filter(location = loc) 
            serializer = LockerSerializer(queryset,many = True) 
            return Response(serializer.data) 

        elif request.method == 'POST':  # 사물함 예약
            #print(request)
            serializer = LockerCreateSerializer(data = request.data)
            if request.data['studentID']!=session_funcs().get(request):  # 세션 확인 (이거 studentID 보내기 힘들면 없애고 그냥 세션에서 받아올예정)
                raise serializers.ValidationError('studentID error')
            
            if Locker.objects.filter(**request.data).exists(): # 예약 취소 (중복일때)
                lk = Locker.objects.get(studentID = request.data['studentID'])
                lk.delete()
                return Response(status=status.HTTP_204_NO_CONTENT)
            
            if Locker.objects.filter(location = request.data['location'], row = request.data['row'], column =  request.data['column'] ).exists():
                raise serializers.ValidationError('location is already use')

            if Locker.objects.filter(studentID = request.data['studentID']).exists():
                raise serializers.ValidationError('This data already exists')
            

            if (len(request.data['studentID']) > 8 or len(request.data['location']) > 1):
                #print('here')
                raise exceptions.ParseError("not enable data")

            if(request.data['studentID']== None or request.data['location']==  None or request.data['row']== None or request.data['column']== None ):
                raise exceptions.ParseError("not enable data")

            #print('post on')
            if serializer.is_valid():
                serializer.save()
                return Response(serializer.data, status = status.HTTP_201_CREATED)
    except:
        return Response(status=status.HTTP_404_NOT_FOUND)
    #return Response(status=status.HTTP_404_NOT_FOUND)
        