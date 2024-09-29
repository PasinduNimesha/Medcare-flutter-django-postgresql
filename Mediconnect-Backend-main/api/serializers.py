# users/serializers.py
from rest_framework import serializers
from .models import User
from .dtos import PatientDTO

class UserSerializer(serializers.ModelSerializer):
    class Meta:
        model = User
        fields = '__all__'

class PatientDTOSerializer(serializers.ModelSerializer):
    class Meta:
        model = PatientDTO
        fields = '__all__'

