from rest_framework.response import Response
from rest_framework import status
from rest_framework.decorators import api_view
from .models import Hospital
from .serializers import HospitalSerializer


# Create a new hospital
@api_view(['POST'])
def create_hospital(request):
    data = request.data
    serializer = HospitalSerializer(data=data)

    if serializer.is_valid():
        serializer.save()
        return Response({"status": "success", "data": serializer.data}, status=status.HTTP_201_CREATED)

    return Response({"status": "error", "message": "Error Creating Hospital"}, status=status.HTTP_400_BAD_REQUEST)


# Get all hospitals
@api_view(['GET'])
def get_all_hospitals(request):
    hospitals = Hospital.objects.all()
    serializer = HospitalSerializer(hospitals, many=True)
    return Response({"status": "success", "data": serializer.data}, status=status.HTTP_200_OK)


# Get a hospital by ID
@api_view(['GET'])
def get_hospital_by_id(request, pk):
    try:
        hospital = Hospital.objects.get(Hospital_ID=pk)
        serializer = HospitalSerializer(hospital, many=False)
        return Response({"status": "success", "data": serializer.data}, status=status.HTTP_200_OK)
    except Hospital.DoesNotExist:
        return Response({"status": "error", "message": "Hospital not found"}, status=status.HTTP_404_NOT_FOUND)


# Edit a hospital (update)
@api_view(['PUT'])
def update_hospital(request, pk):
    try:
        hospital = Hospital.objects.get(Hospital_ID=pk)
    except Hospital.DoesNotExist:
        return Response({"status": "error", "message": "Hospital not found"}, status=status.HTTP_404_NOT_FOUND)

    data = request.data
    serializer = HospitalSerializer(instance=hospital, data=data, partial=True)

    if serializer.is_valid():
        serializer.save()
        return Response({"status": "success", "data": serializer.data}, status=status.HTTP_200_OK)

    return Response({"status": "error", "message": serializer.errors}, status=status.HTTP_400_BAD_REQUEST)


# Delete a hospital
@api_view(['DELETE'])
def delete_hospital(request, pk):
    try:
        hospital = Hospital.objects.get(Hospital_ID=pk)
        hospital.delete()
        return Response({"status": "success", "message": "Hospital deleted successfully"},
                        status=status.HTTP_204_NO_CONTENT)
    except Hospital.DoesNotExist:
        return Response({"status": "error", "message": "Hospital not found"}, status=status.HTTP_404_NOT_FOUND)
