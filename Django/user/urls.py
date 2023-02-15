from django.urls import path, include
from user import views

urlpatterns = [
    # 네이버 api 휴대폰 인증 기능, 미구현
    # path('register/', views.Auth.as_view())
    path('register', views.registration_api),
    path('login', views.login_api),
    path('logout', views.logout_api)
]
