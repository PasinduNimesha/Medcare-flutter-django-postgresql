from django.shortcuts import render

from rest_framework.response import Response
from rest_framework import status
from rest_framework.decorators import api_view
from .models import DoctorVisitHospital
from .serializers import DoctorVisitHospitalSerializer


# Create a new DoctorVisitHospital entry
@api_view(['POST'])
def create_doctor_visit_hospital(request):
    data = request.data
    serializer = DoctorVisitHospitalSerializer(data=data, many=True)

    if serializer.is_valid():
        serializer.save()
        return Response({"status": "success", "data": serializer.data}, status=status.HTTP_201_CREATED)

    return Response({"status": "error", "message": serializer.errors}, status=status.HTTP_400_BAD_REQUEST)


# Get all DoctorVisitHospital entries
@api_view(['GET'])
def get_all_doctor_visit_hospitals(request):
    doctor_visits = DoctorVisitHospital.objects.all()
    serializer = DoctorVisitHospitalSerializer(doctor_visits, many=True)
    return Response({"status": "success", "data": serializer.data}, status=status.HTTP_200_OK)


# Get DoctorVisitHospital by Visit_ID (Primary Key)
@api_view(['GET'])
def get_doctor_visit_hospital_by_id(request, pk):
    try:
        visit = DoctorVisitHospital.objects.get(Visit_ID=pk)
        serializer = DoctorVisitHospitalSerializer(visit)
        return Response({"status": "success", "data": serializer.data}, status=status.HTTP_200_OK)
    except DoctorVisitHospital.DoesNotExist:
        return Response({"status": "error", "message": "Visit not found"}, status=status.HTTP_404_NOT_FOUND)


# Get DoctorVisitHospital by Doctor_ID
@api_view(['GET'])
def get_doctor_visit_hospital_by_doctor_id(request, doctor_id):
    try:
        visits = DoctorVisitHospital.objects.filter(Doctor_ID=doctor_id)
        if visits.exists():
            serializer = DoctorVisitHospitalSerializer(visits, many=True)
            return Response({"status": "success", "data": serializer.data}, status=status.HTTP_200_OK)
        return Response({"status": "error", "message": "No visits found for this doctor"},
                        status=status.HTTP_404_NOT_FOUND)
    except DoctorVisitHospital.DoesNotExist:
        return Response({"status": "error", "message": "Doctor not found"}, status=status.HTTP_404_NOT_FOUND)


# Update a DoctorVisitHospital entry
@api_view(['PUT'])
def update_doctor_visit_hospital(request, pk):
    try:
        visit = DoctorVisitHospital.objects.get(Visit_ID=pk)
    except DoctorVisitHospital.DoesNotExist:
        return Response({"status": "error", "message": "Visit not found"}, status=status.HTTP_404_NOT_FOUND)

    data = request.data
    serializer = DoctorVisitHospitalSerializer(instance=visit, data=data, partial=True)

    if serializer.is_valid():
        serializer.save()
        return Response({"status": "success", "data": serializer.data}, status=status.HTTP_200_OK)

    return Response({"status": "error", "message": serializer.errors}, status=status.HTTP_400_BAD_REQUEST)


# Delete a DoctorVisitHospital entry
@api_view(['DELETE'])
def delete_doctor_visit_hospital(request, pk):
    try:
        visit = DoctorVisitHospital.objects.get(Visit_ID=pk)
        visit.delete()
        return Response({"status": "success", "message": "Visit deleted successfully"},
                        status=status.HTTP_204_NO_CONTENT)
    except DoctorVisitHospital.DoesNotExist:
        return Response({"status": "error", "message": "Visit not found"}, status=status.HTTP_404_NOT_FOUND)
