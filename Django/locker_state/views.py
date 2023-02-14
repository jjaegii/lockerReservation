#from django.shortcuts import render
from rest_framework.response import Response
from rest_framework.decorators import api_view
#from django.http.response import HttpResponse
from rest_framework import status
from .models import Locker
#from rest_framework.views import APIView
from .serializers import LockerSerializer

# Create your views here.


@api_view(['GET','POST'])
def LockerList(request):
    try:
        if request.method == 'GET':
            loc = request.GET['location']
            #print(loc)
            queryset = Locker.objects.filter(location = loc)
            serializer = LockerSerializer(queryset,many = True)
            return Response(serializer.data)

        #elif request.method == 'POST':

    except:
        return Response(status=status.HTTP_404_NOT_FOUND)

'''
@api_view(['POST'])
def LockerList(request):
    queryset = Locker.object.all()
    serializer = LockerSerializer(queryset,many = True)
    return Response(serializer.data)
'''
'''
class LockerListAPIView(APIView):
    def post(self,requset):
        queryset = Locker.objects.all()
        serializer = LockerSerializer(queryset,many=True)
'''
'''
class RegistrationAPIView(APIView):
    permission_classes = (AllowAny,)
    serializer_class = RegistrationSerializer

    def post(self, request):
        user = request.data

        serializer = self.serializer_class(data=user)
        serializer.is_valid(raise_exception=True)
        serializer.save()

        return Response(serializer.data, status=status.HTTP_201_CREATED)
'''