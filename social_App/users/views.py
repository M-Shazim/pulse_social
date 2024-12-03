from django.shortcuts import render,redirect
from django.contrib.auth.models import User
from django.contrib.auth import authenticate, login, logout
from django.contrib import messages
from social_App import settings
from django.core.mail import send_mail
from django.contrib.sites.shortcuts import get_current_site
from django.template.loader import render_to_string
from django.utils.http import urlsafe_base64_encode, urlsafe_base64_decode
from django.utils.encoding import force_bytes, force_str
from .tokens import generate_token
from django.core.mail import send_mail, EmailMessage
from django.contrib.auth.decorators import login_required

# Create your views here.


def index(request):
    return render(request, "users/index.html")


def signup(request):
    if request.method == 'POST':
        username_fetched = request.POST["username"]
        email_fetched = request.POST["email"]
        pass1_fetched = request.POST["pass1"]

        new_user = User.objects.create_user(username=username_fetched, email=email_fetched, password=pass1_fetched)
        new_user.is_active = False
        new_user.save()
        
        messages.success(request, "Successfully created user. We have sent you a joining email, go check it out!!!")
        
        subject = "Welcome to QRS."
        message = "Hello " + new_user.username + "! \n " + "From activating your account, Kindly "
        from_email = settings.EMAIL_HOST_USER
        to_list = [new_user.email]
        send_mail(subject,message, from_email, to_list, fail_silently=True)
        
        current_site = get_current_site(request)
        email_subject = "Confirm your email @ DjangoAuth"
        message2 = render_to_string("users/email_confirmation.html",{
            "name" : new_user.username,
            "domain" : current_site.domain,
            "uid" : urlsafe_base64_encode(force_bytes(new_user.pk)),
            "token" : generate_token.make_token(new_user)

        })
        
        email = EmailMessage(
            email_subject,
            message2,
            settings.EMAIL_HOST_USER,
            [new_user.email],
        )
        
        email.fail_silently = True
        email.send()
        

        return redirect("signin")

    return render(request, "users/signup.html")


def signin(request):

    if request.method == "POST":
        username_fetched = request.POST["username"]
        pass1_fetched = request.POST["pass1"]

        logging_user = authenticate(username=username_fetched, password=pass1_fetched)

        if logging_user is not None:
            login(request, logging_user)  # Log in the user
            return redirect("home")  # Redirect to the home page
        else:
            return render(request, "users/signin.html", {"error": "Invalid credentials"})
        
    return render(request, "users/signin.html")

@login_required
def home(request):
    if(User.is_authenticated):

        return render(request,"users/home.html")
    
    else:
        return render(request, "users/signin.html")
    
@login_required
def profile(request):
    return render(request, "users/profile.html")

def logout_user(request):
    logout(request)
    messages.success(request, "Logged out successfully! ")
    return redirect("index")


def activate(request, uidb64, token):
    try:
        uid = force_str(urlsafe_base64_decode(uidb64))
        myuser = User.objects.get(pk=uid)
    except (TypeError, ValueError, OverflowError, User.DoesNotExist):
        myuser = None

    if myuser is not None and generate_token.check_token(myuser, token):
        myuser.is_active = True
        myuser.save()
        login(request, myuser)
        return redirect("home")

    else:
        return render(request, "users/activation_failed.html")