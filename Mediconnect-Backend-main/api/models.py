from django.db import models
# from django.contrib.gis.db import models as gis_models

class Hospital(models.Model):
    Hospital_ID = models.BigAutoField(primary_key=True)
    Location = models.CharField(max_length=100) #gis_models.GeographyField()  # Enables geographical queries if using PostGIS
    Rating = models.FloatField()
    Name = models.CharField(max_length=255)

class User(models.Model):
    User_ID = models.BigAutoField(primary_key=True)
    Username = models.CharField(max_length=255)
    Role = models.CharField(max_length=255)
    Email = models.EmailField()
    Password = models.CharField(max_length=255)
    NIC = models.CharField(max_length=20)
    Device_ID = models.CharField(max_length=255)
    Birthday = models.DateField()
    First_name = models.CharField(max_length=255)
    Last_name = models.CharField(max_length=255)

class Doctor(models.Model):
    User_ID = models.OneToOneField(User, on_delete=models.CASCADE, unique=True)
    Doctor_ID = models.BigAutoField(primary_key=True)
    Reg_num = models.BigIntegerField()
    Specialization = models.CharField(max_length=255)
    Rating = models.FloatField()
    Current_HOS = models.CharField(max_length=255)
    Availability = models.BooleanField(default=True)
    ID_photo = models.BigIntegerField()

class Patient(models.Model):
    User_ID = models.OneToOneField(User, on_delete=models.CASCADE, unique=True)
    Patient_ID = models.BigAutoField(primary_key=True)
    Breakfast_time = models.TimeField()
    Lunch_time = models.TimeField()
    Dinner_time = models.TimeField()

class QUEUEDOCHOS(models.Model):
    Queue_ID = models.BigAutoField(primary_key=True)
    Doctor_ID = models.ForeignKey(Doctor, on_delete=models.CASCADE)
    Hospital_ID = models.ForeignKey(Hospital, on_delete=models.CASCADE)

class DocRecord(models.Model):
    Doctor_ID = models.ForeignKey(Doctor, on_delete=models.CASCADE)
    Hospital_ID = models.ForeignKey(Hospital, on_delete=models.CASCADE)
    Max_count = models.IntegerField()
    Appointments_start_time = models.TimeField()
    Appointments_end_time = models.TimeField()
    Patients_attended = models.IntegerField()
    Current_token_no = models.IntegerField()
    Average_time = models.TimeField()

    class Meta:
        unique_together = (('Doctor_ID', 'Hospital_ID'),)

class Session(models.Model):
    Session_ID = models.BigAutoField(primary_key=True)
    Patient_ID = models.ForeignKey(Patient, on_delete=models.CASCADE)
    Diagnosis = models.CharField(max_length=255)
    Doctor_ID = models.ForeignKey(Doctor, on_delete=models.CASCADE)

class Prescription(models.Model):
    Prescription_ID = models.BigAutoField(primary_key=True)
    Session_ID = models.ForeignKey(Session, on_delete=models.CASCADE)
    Notes = models.TextField()

class Medicine(models.Model):
    Medicine_ID = models.BigAutoField(primary_key=True)
    Prescription_ID = models.ForeignKey(Prescription, on_delete=models.CASCADE)
    Medicine = models.CharField(max_length=255)
    Quantity = models.FloatField()
    Strength = models.CharField(max_length=255)
    Notes = models.TextField()

class Pharmacy(models.Model):
    Medicine_ID = models.OneToOneField(Medicine, on_delete=models.CASCADE, primary_key=True)
    Interval = models.CharField(max_length=255)
    Times_per_day = models.IntegerField()
    Monday = models.BooleanField(default=False)
    Tuesday = models.BooleanField(default=False)
    Wednesday = models.BooleanField(default=False)
    Thursday = models.BooleanField(default=False)
    Friday = models.BooleanField(default=False)
    Saturday = models.BooleanField(default=False)
    Sunday = models.BooleanField(default=False)
    Before_meal = models.BooleanField(default=False)
    Quantity = models.CharField(max_length=255)
    Turn_off_after = models.CharField(max_length=255)
    Notes = models.TextField()

class Report(models.Model):
    Report_ID = models.BigAutoField(primary_key=True)
    Patient_ID = models.ForeignKey(Patient, on_delete=models.CASCADE)
    Prescription_ID = models.ForeignKey(Prescription, on_delete=models.CASCADE)
    Report = models.TextField()

class Schedule(models.Model):
    Schedule_ID = models.BigAutoField(primary_key=True)
    Hospital_ID = models.ForeignKey(Hospital, on_delete=models.CASCADE)
    Doctor_ID = models.ForeignKey(Doctor, on_delete=models.CASCADE)
    Start_time = models.TimeField()
    End_time = models.TimeField()
    Frequency = models.CharField(max_length=255)
    Monday = models.BooleanField(default=False)
    Tuesday = models.BooleanField(default=False)
    Wednesday = models.BooleanField(default=False)
    Thursday = models.BooleanField(default=False)
    Friday = models.BooleanField(default=False)
    Saturday = models.BooleanField(default=False)
    Sunday = models.BooleanField(default=False)

class Queue(models.Model):
    Queue_ID = models.OneToOneField(QUEUEDOCHOS, on_delete=models.CASCADE, primary_key=True)
    Patient_ID = models.ForeignKey(Patient, on_delete=models.CASCADE)
    Token_no = models.IntegerField(unique=True)  # Make Token_no unique


    class Meta:
        unique_together = (('Queue_ID', 'Patient_ID'),)

class Appointment(models.Model):
    Appointment_ID = models.BigAutoField(primary_key=True)
    Patient_ID = models.ForeignKey(Patient, on_delete=models.CASCADE)
    Session_ID = models.ForeignKey(Session, on_delete=models.CASCADE)
    Token_no = models.ForeignKey(Queue, on_delete=models.CASCADE, to_field='Token_no')
    Doctor_ID = models.ForeignKey(Doctor, on_delete=models.CASCADE)
    Start_time = models.TimeField()
    End_time = models.TimeField()
    Status = models.CharField(max_length=255)
    Date = models.DateField()
    Hospital_ID = models.ForeignKey(Hospital, on_delete=models.CASCADE)

class Feedback(models.Model):
    Hospital_ID = models.ForeignKey(Hospital, on_delete=models.CASCADE)
    Patient_ID = models.ForeignKey(Patient, on_delete=models.CASCADE)
    Note = models.TextField()

    class Meta:
        unique_together = (('Hospital_ID', 'Patient_ID'),)

class NoteUser(models.Model):
    Notification_ID = models.BigAutoField(primary_key=True)
    User_ID = models.ForeignKey(User, on_delete=models.CASCADE)

class Note(models.Model):
    Notification_ID = models.BigAutoField(primary_key=True)
    Note = models.TextField()

