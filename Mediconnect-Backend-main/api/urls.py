from django.urls import path
from . import views

urlpatterns = [
    path('',views.getRoutes),
    path('users/',views.getUsers),
    path('users/create/',views.createUser),
    path('users/<str:pk>/',views.getUserById),
    path('users/<str:pk>/update/',views.updateUser),
    path('users/<str:pk>/delete/',views.deleteUser),

    path('patients/',views.getPatients),
    path('patients/create/',views.createPatient),
    path('patients/<str:pk>/',views.getPatientById),
    path('patients/<str:pk>/update/',views.updatePatient),
    path('patients/<str:pk>/delete/',views.deletePatient),
]