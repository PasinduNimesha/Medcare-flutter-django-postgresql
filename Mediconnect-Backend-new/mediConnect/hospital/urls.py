from django.urls import path
from . import views

urlpatterns = [
    path('hospitals/', views.get_all_hospitals),
    path('hospitals/create/', views.create_hospital),
    path('hospitals/<int:pk>/', views.get_hospital_by_id),
    path('hospitals/update/<int:pk>/', views.update_hospital),
    path('hospitals/delete/<int:pk>/', views.delete_hospital),
]
