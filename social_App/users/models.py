from django.db import models

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
    first_name = models.CharField(max_length=30)
    last_name = models.CharField(max_length=30)
    registration_number = models.CharField(max_length=40, unique=True)
    total_posts = models.PositiveIntegerField(default=0)
    date_joined = models.DateField(auto_now_add=True)

    def __str__(self):
        return f"{self.first_name} {self.last_name}"
    

class Post(models.Model):
    title = models.CharField(max_length=200)
    description = models.TextField()
    posted_on = models.DateTimeField(auto_now_add=True)
    views = models.PositiveIntegerField(default=0)
    likes = models.PositiveIntegerField(default=0)
    subject = models.CharField(max_length=50)
    
    teacher = models.ForeignKey(Teacher, on_delete=models.CASCADE, related_name='posts')
    author = models.ForeignKey(Author, on_delete=models.CASCADE, related_name='posts')

    def __str__(self):
        return self.title

    
    
    
    
    
