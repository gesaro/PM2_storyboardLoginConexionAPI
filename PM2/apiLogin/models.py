from django.db import models

# Create your models here.

class Post(models.Model):
    usuario = models.CharField(max_length=100, primary_key=True)
    password = models.CharField(max_length=100)
    created_at = models.DateTimeField(auto_now_add=True)

    def __str__(self): 
         return '$s $s %s' % (self.usuario, self.password, self.created_at)  