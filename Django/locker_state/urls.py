from django.urls import path, include
from . import views

urlpatterns = [

    #path('state',views.LockerListAPIView.as_view()),
    path('state',views.LockerList),
    #path('state/<int:loc>',views.Lockerset),
]
