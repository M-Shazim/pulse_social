from django.contrib import admin
from .models import Post, Author, Teacher

admin.site.register(Post)
admin.site.register(Author)
admin.site.register(Teacher)

class TeacherAdmin(admin.ModelAdmin):
    list_display = ('first_name', 'last_name', 'position', 'likes')  
    search_fields = ('first_name', 'last_name')  
    list_filter = ('position',)  

class AuthorAdmin(admin.ModelAdmin):
    list_display = ('first_name', 'last_name', 'registration_number', 'date_joined')
    search_fields = ('first_name', 'last_name', 'registration_number')

class PostAdmin(admin.ModelAdmin):
    list_display = ('title', 'posted_on', 'teacher', 'author', 'views', 'likes')
    search_fields = ('title', 'description')
    list_filter = ('posted_on', 'teacher')


# Register your models here.
