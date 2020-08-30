# This is an auto-generated Django model module.
# You'll have to do the following manually to clean this up:
#   * Rearrange models' order
#   * Make sure each model has one field with primary_key=True
#   * Make sure each ForeignKey has `on_delete` set to the desired behavior.
#   * Remove `managed = False` lines if you wish to allow Django to create, modify, and delete the table
# Feel free to rename the models, but don't rename db_table values or field names.
from django.db import models


class Books(models.Model):
    index = models.BigIntegerField(blank=True, null=True)
    n_star = models.BigIntegerField(blank=True, null=True)
    short = models.TextField(blank=True, null=True)
    sentiment = models.FloatField(blank=True, null=True)

    class Meta:
        managed = False  #False表示：不能通过ORM修改或删除表到数据库，避免数据冲突。
        db_table = 'books' #原数据库的表名就是books。
