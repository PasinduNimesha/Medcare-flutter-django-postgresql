from django.urls import path
from . import views

urlpatterns = [
    path('patient/create/', views.create_patient),
    path('patient/<str:pk>/', views.get_patient_by_id),
]