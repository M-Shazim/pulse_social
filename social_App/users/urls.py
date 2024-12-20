from django.contrib import admin
from django.urls import path, include
from . import views


urlpatterns = [
    path("",views.index,name="index"),
    path("signup",views.signup,name="signup"),
    path("signin",views.signin,name="signin"),
    path("home",views.home,name="home"),
    path("profile",views.profile,name="profile"),
    path("logout",views.logout_user,name="logout"),
    path("home/<slug:slug>", views.SinglePostView.as_view(), name="post-detail-page"), #posts/my-first-post
    path("activate/<uidb64>/<token>", views.activate, name="activate"),
]
