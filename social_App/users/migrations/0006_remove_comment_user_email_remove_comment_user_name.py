# Generated by Django 5.1.3 on 2024-12-16 06:34

from django.db import migrations


class Migration(migrations.Migration):

    dependencies = [
        ('users', '0005_remove_author_registration_number'),
    ]

    operations = [
        migrations.RemoveField(
            model_name='comment',
            name='user_email',
        ),
        migrations.RemoveField(
            model_name='comment',
            name='user_name',
        ),
    ]
