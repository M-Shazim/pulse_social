from django.db import models
from django.urls import reverse
from django.contrib.auth.models import User


# Create your models here.

class Teacher(models.Model):
    first_name = models.CharField(max_length=30)
    last_name = models.CharField(max_length=30)
    position = models.CharField(max_length=50)
    likes = models.PositiveIntegerField(default=0)
    email = models.EmailField(unique=True,null=True)

    def __str__(self):
        return f"{self.first_name} {self.last_name}"
    
    
class Author(models.Model):
    user = models.OneToOneField(User, on_delete=models.CASCADE)
    first_name = models.CharField(max_length=30)
    last_name = models.CharField(max_length=30)
    registration_number = models.CharField(max_length=40, unique=True, null=True)
    total_posts = models.PositiveIntegerField(default=0)
    date_joined = models.DateField(auto_now_add=True)

    def __str__(self):
        return f"{self.first_name} {self.last_name}"
    

class Post(models.Model):
    title = models.CharField(max_length=200)
    slug = models.SlugField(unique=True ,default="",blank=True, null=False, db_index=True)
    description = models.TextField()
    posted_on = models.DateTimeField(auto_now_add=True)
    views = models.PositiveIntegerField(default=0)
    likes = models.PositiveIntegerField(default=0)
    subject = models.CharField(max_length=50)
    
    teacher = models.ForeignKey(Teacher, on_delete=models.CASCADE, related_name='posts')
    author = models.ForeignKey(Author, on_delete=models.CASCADE, related_name='posts')

    def get_absolute_url(self):
        return reverse("post-detail-page", args=[self.slug])

    def __str__(self):
        return self.title

    
class Comment(models.Model):
    # user_name = models.CharField(max_length=120)
    # user_email = models.EmailField()
    text = models.TextField(max_length=400)
    post = models.ForeignKey(
        Post, on_delete=models.CASCADE, related_name="comments")
    author = models.ForeignKey(Author, on_delete=models.CASCADE, null=True)
    
    
    def __str__(self):
        return self.text[:50] 
    
    
    
