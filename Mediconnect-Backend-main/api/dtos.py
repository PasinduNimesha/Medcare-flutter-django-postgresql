# users/dtos.py
from django.db import models


class PatientDTO(models.Model):
    User_ID = models.CharField(max_length=255)
    Patient_ID = models.CharField(max_length=255)
    Breakfast_time = models.TimeField()
    Lunch_time = models.TimeField()
    Dinner_time = models.TimeField()

class UserDTO:
    User_ID = models.CharField(max_length=255)
    Username = models.CharField(max_length=255)
    Role = models.CharField(max_length=255)
    Email = models.EmailField()
    Password = models.CharField(max_length=255)
    NIC = models.CharField(max_length=20)
    Device_ID = models.CharField(max_length=255)
    Birthday = models.DateField()
    First_name = models.CharField(max_length=255)
    Last_name = models.CharField(max_length=255)
