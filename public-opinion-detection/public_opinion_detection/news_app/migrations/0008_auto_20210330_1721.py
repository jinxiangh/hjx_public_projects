# Generated by Django 3.1.7 on 2021-03-30 09:21

import datetime
from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('news_app', '0007_auto_20210329_2357'),
    ]

    operations = [
        migrations.AddField(
            model_name='user',
            name='ticket',
            field=models.CharField(blank=True, max_length=250, null=True),
        ),
        migrations.AlterField(
            model_name='answer',
            name='time',
            field=models.DateTimeField(default=datetime.datetime(2021, 3, 30, 17, 21, 19, 342722), verbose_name='评论时间'),
        ),
        migrations.AlterField(
            model_name='hotnews',
            name='time',
            field=models.DateTimeField(default=datetime.datetime(2021, 3, 30, 17, 21, 19, 342722), verbose_name='发布时间'),
        ),
        migrations.AlterField(
            model_name='question',
            name='time',
            field=models.DateTimeField(default=datetime.datetime(2021, 3, 30, 17, 21, 19, 342722), verbose_name='提问时间'),
        ),
        migrations.AlterField(
            model_name='user',
            name='iconUrl',
            field=models.CharField(blank=True, default='/static/picture/testimg.jpg', max_length=100, null=True, verbose_name='头像Url'),
        ),
        migrations.AlterField(
            model_name='user',
            name='nickname',
            field=models.CharField(blank=True, max_length=20, null=True, verbose_name='昵称'),
        ),
        migrations.AlterField(
            model_name='user',
            name='tel',
            field=models.CharField(blank=True, max_length=11, null=True),
        ),
    ]
