"""public_opinion_detection URL Configuration

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/3.1/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  path('', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  path('', Home.as_view(), name='home')
Including another URLconf
    1. Import the include() function: from django.urls import include, path
    2. Add a URL to urlpatterns:  path('blog/', include('blog.urls'))
"""

from django.contrib import admin
from django.urls import path
from django.conf.urls import include,url
from news_app import views

urlpatterns = [
    path('admin/', admin.site.urls),
    path('', views.hello),

    path("app/regist",views.regist),
    path('app/regist/get_captcha',views.get_captcha),
    path("app/login",views.login),
    path("app/logout",views.logout),
    path("app/updatePassword",views.update_password),
    path("app/getUserInfo",views.get_user_info),
    path("app/uploadAvatar", views.upload_avatar),
    path("app/updateUserInfo",views.update_user_info),
    path("app/queryMyQuestions", views.query_my_questions),
    path("app/queryCollectedActicles",views.query_collected_articles),

    path("app/getNewsList",views.get_newslist),
    path("app/getNewsDetails",views.get_news_details),
    path("app/getArticleLike",views.get_article_like),

    path("app/getQuestions",views.get_questions),
    path("app/getQuestionsDetails",views.get_questions_details),
    path("app/getAnswer",views.get_answer),
    path("app/getAnswerDetail",views.get_answer_detail),
    path("app/getAnswerLike",views.get_answer_like),
    path("app/addAnswer",views.add_answer),
    path("app/addReply",views.add_reply),
    path("app/issueQuestion",views.issue_question),



]
