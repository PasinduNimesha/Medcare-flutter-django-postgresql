from django.db import models

from doctor.models import Doctor
from hospital.models import Hospital


class DoctorVisitHospital(models.Model):
    Visit_ID = models.BigAutoField(primary_key=True)
    Hospital_ID = models.ForeignKey(Hospital, on_delete=models.CASCADE)
    Doctor_ID = models.ForeignKey(Doctor, on_delete=models.CASCADE)
    Mon = models.BooleanField(default=False)
    Tue = models.BooleanField(default=False)
    Wed = models.BooleanField(default=False)
    Thu = models.BooleanField(default=False)
    Fri = models.BooleanField(default=False)
    Sat = models.BooleanField(default=False)
    Sun = models.BooleanField(default=False)
    AP_Start_Time = models.CharField(max_length=255)
    AP_End_Time = models.CharField(max_length=255)
    AP_Count = models.IntegerField()
    APL_Start_Time = models.CharField(max_length=255)
    APL_End_Time = models.CharField(max_length=255)
    APL_Count = models.IntegerField()

    class Meta:
        unique_together = ('Hospital_ID', 'Doctor_ID')


