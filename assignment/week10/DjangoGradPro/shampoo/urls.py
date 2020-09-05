from django.urls import path
from . import views

urlpatterns = [
    path('', views.shampoo),
    path('index', views.shampoo),
    path('shampoo', views.shampoo),
    path('short_search', views.short_search),
    path('date_search', views.date_search),
]