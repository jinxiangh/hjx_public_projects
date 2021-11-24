from django.db import models
from _datetime import datetime

TAG_TYPE = [
    (0,"待定"),
    (1,"真"),
    (2,"假")
]

class User(models.Model):
    userid = models.AutoField(primary_key=True,verbose_name="用户Id")
    username = models.CharField(max_length=20,unique=True,verbose_name="用户名")
    password = models.CharField(max_length=255,verbose_name="密码")
    nickname = models.CharField(max_length=20,blank=True,null=True,verbose_name="昵称")
    avatarurl = models.CharField(max_length=255,blank=True,null=True,default="/static/picture/testimg.jpg",verbose_name="头像Url")
    tel = models.CharField(max_length=11,blank=True,null=True)
    token = models.CharField(max_length=255,blank=True,null=True)
    class Meta:
        db_table = "User"

class HotNews(models.Model):
    newsid = models.AutoField(primary_key=True,verbose_name="新闻Id")
    title = models.CharField(max_length=250,verbose_name="标题")
    content = models.TextField(verbose_name="内容")
    time = models.DateTimeField(default=datetime.now(),verbose_name="发布时间")
    imageUrl = models.CharField(max_length=250,verbose_name="插图")
    tag = models.SmallIntegerField(choices=TAG_TYPE,default=0,verbose_name="真假")

    class Meta:
        db_table = "HotNews"

class Question(models.Model):
    questionid = models.AutoField(primary_key=True,verbose_name="问题Id")
    userid = models.ForeignKey(to="User",on_delete=models.CASCADE,verbose_name="提问者Id")
    title = models.CharField(max_length=250,verbose_name="问题标题")
    content = models.TextField(verbose_name="内容")
    time = models.DateTimeField(default=datetime.now(),verbose_name="提问时间")

    class Meta:
        db_table = "Question"

class Answer(models.Model):
    answerid = models.AutoField(primary_key=True,verbose_name="评论Id")
    questionid = models.IntegerField(verbose_name="问题id")
    userid = models.IntegerField(verbose_name="评论者id")
    content = models.TextField(verbose_name="评论内容")
    time = models.DateTimeField(default=datetime.now(),verbose_name="评论时间")
    favor = models.IntegerField(default=0,verbose_name="点赞数")
    replyid = models.IntegerField(default=0,verbose_name="回复id")
    class Meta:
        db_table = "Answer"

class AnswerLike(models.Model):
    answerid = models.IntegerField(verbose_name="被点赞的回答id")
    userid = models.IntegerField(verbose_name="点赞用户id")
    time = models.DateTimeField(default=datetime.now(), verbose_name="操作时间")
    class Meta:
        db_table = "AnswerLike"

class MyLike(models.Model):
    likeid = models.AutoField(primary_key=True,verbose_name="收藏条目id")
    userid = models.IntegerField(verbose_name="收藏者id")
    newsid = models.IntegerField(verbose_name="被收藏新闻id")

    class Meta:
        db_table = "MyLike"
