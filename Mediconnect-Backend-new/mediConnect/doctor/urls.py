from django.urls import path
from . import views

urlpatterns = [
    # Doctor URLs
    path('doctors/', views.get_all_doctors),  # GET all doctors
    path('doctors/create/', views.create_doctor),  # POST create a new doctor
    path('doctors/<int:pk>/', views.get_doctor_by_id),  # GET a doctor by ID
    path('doctors/<int:pk>/get-all-data', views.get_doctor_with_visit),  # GET a doctor by ID
    path('doctors/update/<int:pk>/', views.update_doctor),  # PUT update a doctor by ID
    path('doctors/delete/<int:pk>/', views.delete_doctor),  # DELETE a doctor by ID
]
