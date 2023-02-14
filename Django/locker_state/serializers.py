from django.core import serializers
from rest_framework import serializers
from .models import Locker

class LockerSerializer(serializers.ModelSerializer) :
    class Meta :
        model = Locker
        fields = ['studentID','location','row','column']
