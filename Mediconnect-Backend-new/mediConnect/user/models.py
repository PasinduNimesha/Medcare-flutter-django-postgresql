from django.db import models


# Create your models here.
class User(models.Model):
    User_ID = models.BigAutoField(primary_key=True)
    Email = models.EmailField()
    Password = models.CharField(max_length=255)
    Device_ID = models.CharField(max_length=255)
    IsRegistered = models.BooleanField(default=False)
