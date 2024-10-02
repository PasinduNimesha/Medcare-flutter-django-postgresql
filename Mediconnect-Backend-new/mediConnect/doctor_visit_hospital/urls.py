from django.urls import path
from . import views

urlpatterns = [
    path('visit/create/', views.create_doctor_visit_hospital),
    path('visit/', views.get_all_doctor_visit_hospitals),
    path('visit/<int:pk>/', views.get_doctor_visit_hospital_by_id),
    path('visit/doctor/<int:doctor_id>/', views.get_doctor_visit_hospital_by_doctor_id),
    path('visit/update/<int:pk>/', views.update_doctor_visit_hospital),
    path('visit/delete/<int:pk>/', views.delete_doctor_visit_hospital),
]
