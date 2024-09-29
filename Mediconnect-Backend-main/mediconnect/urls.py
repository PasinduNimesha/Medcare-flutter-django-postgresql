from django.contrib import admin
from django.urls import path, include

urlpatterns = [
    path('admin/', admin.site.urls),
    path('', include('api.urls')),
    path('users/', include('api.urls')),
    path('users/create/', include('api.urls')),
    path('users/<str:pk>/', include('api.urls')),
    path('users/<str:pk>/update/', include('api.urls')),
    path('users/<str:pk>/delete/', include('api.urls')),

    path('patients/', include('api.urls')),
    path('patients/create/', include('api.urls')),
    path('patients/<str:pk>/', include('api.urls')),
    path('patients/<str:pk>/update/', include('api.urls')),
    path('patients/<str:pk>/delete/', include('api.urls')),
]
