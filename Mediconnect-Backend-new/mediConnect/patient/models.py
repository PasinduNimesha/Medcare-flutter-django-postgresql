from django.db import models
from user.models import User


class Patient(models.Model):
    User_ID = models.OneToOneField(User, on_delete=models.CASCADE, unique=True)
    Patient_ID = models.BigAutoField(primary_key=True)

    First_name = models.CharField(max_length=255)
    Last_name = models.CharField(max_length=255)
    Other_name = models.CharField(max_length=255)
    Birthday = models.CharField(max_length=255)

    Street_No = models.CharField(max_length=255)
    Street_Name = models.CharField(max_length=255)
    City = models.CharField(max_length=255)
    Postal_Code = models.CharField(max_length=255)

    NIC = models.CharField(max_length=20)
    Breakfast_time = models.CharField(max_length=255)
    Lunch_time = models.CharField(max_length=255)
    Dinner_time = models.CharField(max_length=255)
