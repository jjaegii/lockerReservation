from rest_framework.response import Response
from rest_framework.decorators import api_view
from rest_framework import exceptions
from rest_framework import status

from .models import Locker
from .serializers import LockerSerializer,LockerCreateSerializer

# Create your views here.


@api_view(['GET','POST'])
def LockerList(request,format = None):
    try:
        if request.method == 'GET':
            loc = request.GET['location']
            #print(loc) 
            queryset = Locker.objects.filter(location = loc)
            serializer = LockerSerializer(queryset,many = True)
            return Response(serializer.data)

        elif request.method == 'POST':
            #print(request)
            serializer = LockerCreateSerializer(data = request.data)
            if Locker.objects.filter(**request.data).exists():
                raise serializers.ValidationError('This data already exists')

            if Locker.objects.filter(location = request.data['location'], row = request.data['row'], column =  request.data['column'] ).exists():
                raise serializers.ValidationError('location is already use')

            if Locker.objects.filter(studentID = request.data['studentID']).exists():
                raise serializers.ValidationError('This data already exists')
            

            if (len(request.data['studentID']) > 8 or len(request.data['location']) > 1):
                #print('here')
                raise exceptions.ParseError("not enable data")

            if(request.data['studentID']== null or request.data['location']== null or request.data['row']== null or request.data['column']== null ):
                raise exceptions.ParseError("not enable data")

            print('post on')
            if serializer.is_valid():
                serializer.save()
                return Response(serializer.data, status = status.HTTP_201_CREATED)
    except:
        return Response(status=status.HTTP_404_NOT_FOUND)
    #return Response(status=status.HTTP_404_NOT_FOUND)
        