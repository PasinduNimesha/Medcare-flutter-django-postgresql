from rest_framework.decorators import api_view
from rest_framework.response import Response
from django.http import JsonResponse
from django.shortcuts import get_object_or_404
from .dtos import *
from .models import *
from .serializers import *

@api_view(['GET'])
def getRoutes(request):
    routes = [ ###
    ]
    return Response(routes)


@api_view(['GET'])
def getUsers(request):
    users = User.objects.all()
    serializer = UserSerializer(users, many=True)
    return Response(serializer.data)


@api_view(['POST'])
def createUser(request):
    data = request.data
    user = User.objects.create(
        User_ID = data['User_ID'],
        Username = data['Username'],
        Role = data['Role'],
        Email = data['Email'],
        Password = data['Password'],
        NIC = data['NIC'],
        Device_ID = data['Device_ID'],
        Birthday = data['Birthday'],
        First_name = data['First_name'],
        Last_name = data['Last_name'],
    )
    serializer = UserSerializer(user)
    return Response(serializer.data)

@api_view(['GET'])
def getUserById(request, pk):
    user = User.objects.get(User_ID=pk)
    serializer = UserSerializer(user, many=False)
    return Response(serializer.data)

@api_view(['PUT'])
def updateUser(request, pk):
    data = request.data
    user = User.objects.get(User_ID=pk)
    serializer = UserSerializer(user, data=request.data)
    if serializer.is_valid():
        serializer.save()
    return Response(serializer.data)

@api_view(['DELETE'])
def deleteUser(request, pk):
    user = User.objects.get(User_ID=pk)
    user.delete()
    return Response('User deleted')



@api_view(['GET'])
def getPatients(request):
    patients = Patient.objects.all()
    serializer = PatientDTOSerializer(patients, many=True)
    return Response(serializer.data)

@api_view(['POST'])
def createPatient(request):
    data = request.data
    user = get_object_or_404(User, User_ID=data['User_ID'])
    patient = Patient.objects.create(
        User_ID = user,
        Patient_ID = data['Patient_ID'],
        Breakfast_time = data['Breakfast_time'],
        Lunch_time = data['Lunch_time'],
        Dinner_time = data['Dinner_time'],
    )
    return Response('Patient created')

@api_view(['GET'])
def getPatientById(request, pk):
    patient = Patient.objects.get(Patient_ID=pk)
    patientDto = PatientDTO(
        User_ID = patient.User_ID.User_ID,
        Patient_ID = patient.Patient_ID,
        Breakfast_time = patient.Breakfast_time,
        Lunch_time = patient.Lunch_time,
        Dinner_time = patient.Dinner_time,
    )
    serializer = PatientDTOSerializer(patientDto, many=False)
    return Response(serializer.data)

@api_view(['PUT'])
def updatePatient(request, pk):
    data = request.data
    user = get_object_or_404(User, User_ID=data['User_ID'])
    Patient.objects.filter(Patient_ID=pk).update(
        User_ID = user,
        Breakfast_time = data['Breakfast_time'],
        Lunch_time = data['Lunch_time'],
        Dinner_time = data['Dinner_time'],
    )
    return Response('Patient updated')


@api_view(['DELETE'])
def deletePatient(request, pk):
    patient = Patient.objects.get(Patient_ID=pk)
    patient.delete()
    return Response('Patient deleted')
