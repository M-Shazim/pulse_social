from django.shortcuts import render,redirect
from django.contrib.auth.models import User
from django.contrib.auth import authenticate, login, logout

# Create your views here.


def index(request):
    return render(request, "users/index.html")



def signup(request):
    if request.method == 'POST':
        username_fetched = request.POST["username"]
        email_fetched = request.POST["email"]
        pass1_fetched = request.POST["pass1"]

        new_user = User.objects.create_user(username=username_fetched, email=email_fetched, password=pass1_fetched)
        new_user.save()

        return redirect("signin")

    return render(request, "users/signup.html")



def signin(request):

    if request.method == "POST":
        username_fetched = request.POST["username"]
        pass1_fetched = request.POST["pass1"]

        logging_user = authenticate(username=username_fetched, password=pass1_fetched)

        login(request,logging_user)

        return redirect("home")


    return render(request, "users/signin.html")


def home(request):
    return render(request,"users/home.html")