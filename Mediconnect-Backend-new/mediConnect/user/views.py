from .models import User
from .serializers import UserSerializer
from rest_framework.response import Response
from rest_framework import status
from rest_framework.decorators import api_view
from django.http import JsonResponse


@api_view(['GET'])
def get_users(request):
    users = User.objects.all()
    serializer = UserSerializer(users, many=True)
    return Response({"status": "success", "data": serializer.data}, status=status.HTTP_200_OK)


@api_view(['POST'])
def create_user(request):
    data = request.data
    user = User.objects.create(
        User_ID=data['User_ID'],
        Email=data['Email'],
        Password=data['Password'],
        Device_ID=data['Device_ID'],
    )
    serializer = UserSerializer(user)
    return Response(serializer.data)


@api_view(['GET'])
def get_use_by_id(request, pk):
    user = User.objects.get(User_ID=pk)
    serializer = UserSerializer(user, many=False)
    return Response(serializer.data)
