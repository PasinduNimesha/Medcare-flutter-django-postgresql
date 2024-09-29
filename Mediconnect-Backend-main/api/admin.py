from django.contrib import admin
from .models import Patient, User, Doctor, Appointment, Prescription, Note

# Register your models here.
admin.site.register(Patient)
admin.site.register(User)
admin.site.register(Doctor)
admin.site.register(Appointment)
admin.site.register(Prescription)
admin.site.register(Note)

