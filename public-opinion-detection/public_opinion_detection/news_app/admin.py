from django.contrib import admin
from news_app.models import User,HotNews,Answer,Question,MyLike


@admin.register(User)
class UserAdmin(admin.ModelAdmin):
    list_display = ["userid","username","nickname","password","avatarurl","tel","token"]

@admin.register(HotNews)
class HotNewsAdmin(admin.ModelAdmin):
    list_display = ["newsid","title","time","imageUrl","tag"]

    list_per_page = 30
    # 满50条数据就自动分页
    ordering = ('-time',)
    # 后台数据列表排序方式
    list_editable = ['tag']
    # 设置哪些字段可以点击进入编辑界面

@admin.register(Question)
class QuestionAdmin(admin.ModelAdmin):
    list_display = ["questionid","userid","content","time"]

@admin.register(Answer)
class AnswerAdmin(admin.ModelAdmin):
    list_display = ["answerid","questionid","userid","content","time","favor","replyid"]

@admin.register (MyLike)
class MyLikeAdmin(admin.ModelAdmin):
    list_display = ["likeid","userid","newsid"]


