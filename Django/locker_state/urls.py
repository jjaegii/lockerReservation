from django.urls import path, include
from django.contrib import admin
from . import views

urlpatterns = [

    #path('state',views.LockerListAPIView.as_view()),
    path('state',views.LockerList),
    path('state/admin',admin.site.urls),
    #path('state/<int:loc>',views.Lockerset),
]
