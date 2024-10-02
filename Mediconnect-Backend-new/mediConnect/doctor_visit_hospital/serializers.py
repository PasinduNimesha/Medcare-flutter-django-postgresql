from rest_framework import serializers
from .models import DoctorVisitHospital


class DoctorVisitHospitalSerializer(serializers.ModelSerializer):
    class Meta:
        model = DoctorVisitHospital
        fields = '__all__'
