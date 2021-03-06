# Generated by Django 3.1.7 on 2021-03-30 12:29

import datetime
from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('news_app', '0008_auto_20210330_1721'),
    ]

    operations = [
        migrations.AddField(
            model_name='hotnews',
            name='title',
            field=models.CharField(default=1, max_length=250, verbose_name='标题'),
            preserve_default=False,
        ),
        migrations.AlterField(
            model_name='answer',
            name='time',
            field=models.DateTimeField(default=datetime.datetime(2021, 3, 30, 20, 29, 48, 805154), verbose_name='评论时间'),
        ),
        migrations.AlterField(
            model_name='hotnews',
            name='time',
            field=models.DateTimeField(default=datetime.datetime(2021, 3, 30, 20, 29, 48, 805154), verbose_name='发布时间'),
        ),
        migrations.AlterField(
            model_name='question',
            name='time',
            field=models.DateTimeField(default=datetime.datetime(2021, 3, 30, 20, 29, 48, 805154), verbose_name='提问时间'),
        ),
    ]
