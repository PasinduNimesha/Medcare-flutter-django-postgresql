from django.urls import path
from . import views

urlpatterns = [
    path('users/', views.get_users),
    path('users/create/', views.create_user),
    path('users/<str:pk>/', views.get_use_by_id),
]