from rest_framework import serializers
from .models import Appointment
from doctor.models import Doctor
from hospital.models import Hospital


class DoctorSerializer(serializers.ModelSerializer):
    class Meta:
        model = Doctor
        fields = '__all__'  # Add or customize fields as necessary


class HospitalSerializer(serializers.ModelSerializer):
    class Meta:
        model = Hospital
        fields = '__all__'  # Add or customize fields as necessary


class AppointmentSerializer(serializers.ModelSerializer):
    Doctor_ID = DoctorSerializer()
    Hospital_ID = HospitalSerializer()

    class Meta:
        model = Appointment
        fields = '__all__'


class AppointmentAddSerializer(serializers.ModelSerializer):
    class Meta:
        model = Appointment
        fields = '__all__'
