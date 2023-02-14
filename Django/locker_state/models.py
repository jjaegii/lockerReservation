from django.db import models

# Create your models here.
class Locker(models.Model):

    studentID = models.CharField(max_length=8, null=False,primary_key=True) 
    location = models.CharField(max_length=1, null=False) # locker loation (ex : forward lec[104]) -> 'a'
    row = models.IntegerField(null=False) # locker row number
    column = models.IntegerField(null=False) # locker column number

    def __str__(self):
        return self.studentID
    
    def xy(self):
        # locker's coordinate (row , col)
        return str(self.row)+','+str(self.column)
    
