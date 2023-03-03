from rest_framework import serializers
from user.models import User, Cert_table


class UserSerializer(serializers.ModelSerializer):
    class Meta:
        model = User
        fields = [
            'studentID',
            'name',
            'phone_num',
            'password',
        ]

class CertSerializer(serializers.ModelSerializer):
    class Meta:
        model = Cert_table
        fields = [
            'phone_num',
            'cert_number',
            'cert_status',
        ]