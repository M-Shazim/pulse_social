from django.contrib import admin
from .models import Post, Author, Teacher, Comment


# Register your models here.



class TeacherAdmin(admin.ModelAdmin):
    list_display = ('first_name', 'last_name', 'position', 'likes')  
    search_fields = ('first_name', 'last_name')  
    list_filter = ('position',)  

class AuthorAdmin(admin.ModelAdmin):
    list_display = ('first_name', 'last_name', 'date_joined')
    search_fields = ('first_name', 'last_name')

class PostAdmin(admin.ModelAdmin):
    list_display = ('title', 'posted_on', 'teacher', 'author', 'views', 'likes')
    search_fields = ('title', 'description')
    list_filter = ('posted_on', 'teacher')
    prepopulated_fields = {"slug": ("title",)}

class CommentAdmin(admin.ModelAdmin):
    # list_display = ("post",)
    
    list_display = ['text', 'post']  
    search_fields = ['text']  


admin.site.register(Post, PostAdmin)
admin.site.register(Author, AuthorAdmin)
admin.site.register(Teacher,TeacherAdmin)
admin.site.register(Comment, CommentAdmin)

