from django.shortcuts import render,redirect, get_object_or_404
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
from . import models
from .models import Author, Post, Teacher
from .forms import CommentForm
from django.http import HttpResponseRedirect
from django.urls import reverse
from django.views import View
from django.utils.text import slugify




# Create your views here.


def index(request):
    return render(request, "users/index.html")


def signup(request):
    if request.method == 'POST':
        username_fetched = request.POST["username"]
        email_fetched = request.POST["email"]
        pass1_fetched = request.POST["pass1"]
        
        firstName_fetched = request.POST["firstName"]
        lastName_fetched = request.POST["lastName"]
        
        

        new_user = User.objects.create_user(username=username_fetched, email=email_fetched, password=pass1_fetched)
        new_user.first_name = firstName_fetched
        new_user.last_name = lastName_fetched
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
            login(request, logging_user) 
            
            try:
                author = request.user.author
            except Author.DoesNotExist:
                
                email_2 = request.user.email
                
                username, domain = email_2.split("@")

                username_parts = username.split("-")
                
                registration_number = "-".join(username_parts[1:3]) 
                
                # registration_number = username_parts[1]
                
                Author.objects.create(
                    user=request.user,
                    first_name=request.user.first_name,
                    last_name=request.user.last_name,
                    registration_number=registration_number 
                )
            
            
            return redirect("home")  
        else:
            return render(request, "users/signin.html", {"error": "Invalid credentials"})
        
    return render(request, "users/signin.html")

@login_required
def home(request):
    teachers = Teacher.objects.all()
    
    if request.method == "POST":
        title = request.POST["title"]
        description = request.POST["description"]
        subject = request.POST["subject"]
        teacher_id = request.POST["teacher"]
        
        teacher = Teacher.objects.get(id=teacher_id)
        
        slug = slugify(title)
        
        # try:
        #     author = request.user.author
            
        # except Author.DoesNotExist:
            
        #     author = Author.objects.create(user=request.user, first_name=request.user.first_name, last_name=request.user.last_name)
        
        author = request.user.author  

        Post.objects.create(
            title=title,
            description=description,
            subject=subject,
            teacher=teacher,
            author=author,
            slug=slug, 
        )
    
    if(User.is_authenticated):
        posts = models.Post.objects.all()
        

        return render(request,"users/home.html", {
            "all_posts" : posts,
            "teachers" : teachers,
        })
    
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
    
    
def post_detail(request,slug):
    identified_post = get_object_or_404(Post, slug=slug)
    # identified_post = Post.objects.get(slug=slug)
    # identified_post = next(post for post in all_posts if post['slug'] == slug)

    return render(request,"users/post-detail.html", {
        "post" : identified_post,
    })
    
    
class SinglePostView(View):
    # template_name = "blog/post-detail.html"
    # model = Post

    def get(self,request,slug):
        post = Post.objects.get(slug=slug)
        context = {
            "post": post,
            "comment_form": CommentForm(),
            "comments" : post.comments.all().order_by("-id"),
        }
        return render(request, "users/post-detail.html",context)


    def post(self,request,slug):
        comment_form = CommentForm(request.POST)
        post = Post.objects.get(slug=slug)

        if comment_form.is_valid():
            comment = comment_form.save(commit=False) #linking the form to the post
            comment.post = post
            comment.author = request.user.author
            comment.save()

            return HttpResponseRedirect(reverse('post-detail-page', args=[slug]))
        
        context = {
            "post": post,
            "comment_form": comment_form,
            "comments" : post.comments.all().order_by("-id"),
        }   
        return render(request, "users/post-detail.html",context)