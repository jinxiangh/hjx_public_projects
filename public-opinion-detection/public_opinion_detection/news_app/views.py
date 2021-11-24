import base64
import time
import random
import os
from django.db.models import Q, Model
from django.contrib.auth.hashers import make_password, check_password
from django.core import serializers
from django.core.paginator import Paginator, PageNotAnInteger, EmptyPage
from django.forms import model_to_dict
from django.http import HttpResponse
import json
from django.views.decorators.csrf import csrf_exempt
from news_app.models import User, HotNews, MyLike, Question, Answer, AnswerLike
from news_app.utils.captcha import captcha
from news_app.utils.datetimeEncoder import DateEncoder
from public_opinion_detection import settings
from public_opinion_detection.settings import SERVER_ADDRESS
from django_redis import get_redis_connection
import uuid


def hello(request):
    return HttpResponse(uuid.uuid4())

@csrf_exempt
def get_captcha(request):
    #获取二维码

    dic = {'status': 200, 'msg': 'success', 'data': ''}
    data,captcha_str = captcha.Captcha().getCaptcha()

    uu_id = uuid.uuid4()
    redis_conn = get_redis_connection('verify_code')
    redis_conn.setex('img_%s' % uu_id, 300, captcha_str)

    file_path = captcha.Captcha().base64_img_name(btyes_data=data,save_name=captcha_str,save_path="news_app/static/captcha",save_type="png")
    dic["msg"] = str(uu_id)
    dic["data"] = SERVER_ADDRESS + file_path[8:]
    print("set_captcha_str:",captcha_str)
    return HttpResponse(json.dumps(dic, ensure_ascii=False))

@csrf_exempt
def regist(request):
    #注册
    dic = {'status':200,'msg':'success','data':''}
    print("regist请求时的cookie：", request.COOKIES)
    print("regist请求时的session.items()：", request.session.items())
    if request.method == 'GET':
        return HttpResponse("err")
    if request.method == 'POST':
        name = request.POST.get('username')
        password = request.POST.get('password')
        captcha = request.POST.get("captcha")
        uu_id = request.POST.get("uuid")
        redis_conn = get_redis_connection('verify_code')
        get_redis_captcha = redis_conn.get('img_%s' % uu_id).decode()

        print("uu_id:", uu_id)
        print("captcha:",captcha)
        print("get_redis_captcha:" , get_redis_captcha)###################

        if captcha.lower() == get_redis_captcha.lower():
            if (User.objects.filter(username=name).exists()==False): #不存在false
                password = make_password(password) #加密
                datadic = {"username":name,"password":password,"nickname":name}
                User.objects.create(**datadic)
            else:
                dic['msg'] = "用户名已存在"
        else:
            dic["msg"] = "验证码错误"

        return HttpResponse(json.dumps(dic, ensure_ascii=False))

@csrf_exempt
def login(request):
    #登入
    print("login请求时的cookie：", request.COOKIES)
    print("login请求时的session.items()：", request.session.items())

    if request.method == 'POST':
        dic = {'status': '200', 'msg': 'success', 'data': ''}
        name = request.POST.get('username')
        password = request.POST.get('password')
        response = HttpResponse()
        if User.objects.filter(username=name).exists():  # 查询用户是否在数据库中
            user = User.objects.get(username=name)
            if (check_password(password,user.password)):
                token = ''
                for i in range(15):
                    s = 'abcdefghijklmnopqrstuvwxyz'
                    # 获取随机的字符串
                    token += random.choice(s)
                now_time = int(time.time())
                token = 'TK' + token + str(now_time)
                # 绑定令牌到cookie里面
                response["Access-Control-Allow-Origin"] = "*" ##
                response.set_cookie('token', token, max_age=100000)# max_age 存活时间(秒)
                user.token = token # 存在服务端
                user.save()  # 保存
                dic['data'] = {'userId':user.userid,
                               'userName':user.username,
                               'nickName':user.nickname,
                               'avatarUrl':SERVER_ADDRESS + user.avatarurl,
                               'tel':user.tel,
                               'token':token}
            else:
                dic['msg'] = '密码错误'
        else:
            dic['msg'] = '用户不存在'
        response.content = json.dumps(dic, ensure_ascii=False)
        return response
    else:
        return HttpResponse('err')


@csrf_exempt
def update_password(request):
    #修改密码
    if request.method == 'POST':
        dic = {'status': '', 'msg': 'success', 'data': ''}
        accessToken, islogin = isLogin(request)
        if islogin:
            old_password = request.POST.get('old_password')
            new_password = request.POST.get('new_password')
            user = User.objects.get(token=accessToken)
            if check_password(old_password,user.password):
                user.password = make_password(new_password)
                user.save()
            else:
                dic['msg'] = '原密码错误'
        else:
            dic['msg'] = '请登入操作'
        return HttpResponse(json.dumps(dic, ensure_ascii=False))
    else:
        return HttpResponse("err")

@csrf_exempt
def get_user_info(request):
    #根据token返回用户信息 #查询个人信息
    print("get_user_info请求时的cookie：", request.COOKIES)
    print("get_user_info请求时的session.items()：", request.session.items())
    if request.method == 'POST':
        dic = {'status': '', 'msg': 'success', 'data': ''}
        accessToken,islogin = isLogin(request)
        if islogin:
            response = HttpResponse()
            response.set_cookie('token', accessToken, max_age=100000)  # 延长存活时间(秒)
            user = User.objects.get(token=accessToken)
            dic['data'] = {'userId': user.userid,
                           'userName': user.username,
                           'nickName': user.nickname,
                           'avatarUrl': SERVER_ADDRESS + user.avatarurl,
                           'tel': user.tel,
                           'token': accessToken}
        else:
            dic['msg'] = '请登录操作'
        return HttpResponse(json.dumps(dic, ensure_ascii=False))
    else:
        return HttpResponse("err")

@csrf_exempt
def get_newslist(request):
    #获取文章列表
    dic = {'status': 200, 'msg': 'success', 'data': {'list':'','count':'','pageCount':''}}
    keyword = request.GET.get("keyword",None)
    pageIndex = request.GET.get("pageIndex",default=1)
    pageSize = request.GET.get("pageSize",default=10)
    if keyword==None:
        news_list = HotNews.objects.all()
    else:
        news_list = HotNews.objects.filter(Q(title__icontains=keyword)).all()
        # news_list = HotNews.objects.filter(Q(title__icontains=keyword)|Q(content__icontains=keyword)).all()
    dic['data']['list'] = pager(news_list,pageIndex,pageSize)
    dic['data']['count'] = news_list.count()
    dic['data']['pageCount'] = news_list.count() // int(pageSize) if news_list.count() % int(pageSize)==0 else news_list.count() // int(pageSize) +1
    return HttpResponse(json.dumps(dic, ensure_ascii=False,cls=DateEncoder))

@csrf_exempt
def get_news_details(request):
    #获取文章详情
    dic = {'status': 200, 'msg': '', 'data': ''}
    newsid = request.GET.get('newsid')
    accessToken, islogin = isLogin(request)
    if islogin:
        user = User.objects.filter(token=accessToken).first()
        islike = MyLike.objects.filter(userid=user.userid,newsid=newsid).count()
    news = HotNews.objects.get(newsid=newsid)
    result = model_to_dict(news)
    result['islike'] = islike if islogin else 0
    result['imageUrl'] = SERVER_ADDRESS + news.imageUrl
    dic['data'] = result
    return HttpResponse(json.dumps(dic, ensure_ascii=False,cls=DateEncoder))

@csrf_exempt
def get_article_like(request):
    #收藏
    if request.method == 'POST':
        dic = {'status': 200, 'msg': 'success', 'data': ''}
        newsid = request.POST.get('newsid')
        accessToken, islogin = isLogin(request)
        if islogin:
            userid = User.objects.filter(token=accessToken).first().userid
            if MyLike.objects.filter(newsid = newsid,userid = userid).exists(): #查询是否已收藏  未收藏False
                MyLike.objects.filter(newsid=newsid, userid=userid).delete()  # 取消收藏
            else:
                MyLike.objects.create(newsid=newsid, userid=userid)  # 点赞
        else:
            dic['msg'] = '请登录操作'
        return HttpResponse(json.dumps(dic, ensure_ascii=False,cls=DateEncoder))
    else:
        return HttpResponse("err")


@csrf_exempt
def upload_avatar(request):
    #上传头像
    if request.method == "POST":
        dic = {'status': 200, 'msg': 'success', 'data': ''}
        accessToken, islogin = isLogin(request)
        if islogin:
            avatar = request.FILES.get("file")
            allow_upload = settings.ALLOW_UPLOAD
            save_base_path = "news_app/static/picture"
            new_img_name =  base64.b64encode(bytes(str(time.time()), 'utf-8')).decode()
            img_type = avatar.name.split('.')[-1]
            save_path = save_base_path+"/"+new_img_name+"."+img_type
            if img_type in allow_upload:
                with open(save_path,"wb") as f:
                    for c in avatar.chunks():
                        f.write(c)
                dic['data'] = SERVER_ADDRESS + save_path[8:]
            else:
                dic['msg'] = '图片类型不支持'
        else:
            dic['msg'] = '请登录操作'
        return HttpResponse(json.dumps(dic, ensure_ascii=False,cls=DateEncoder))

@csrf_exempt
def update_user_info(request):
    #更新用户数据
    if request.method == "POST":
        dic = {'status': 200, 'msg': 'success', 'data': ''}
        accessToken, islogin = isLogin(request)
        if islogin:
            user = User.objects.get(token=accessToken)
            user.tel = request.POST.get('tel')
            user.nickname = request.POST.get('nickName')
            user.avatarurl = request.POST.get('avatarUrl').replace(SERVER_ADDRESS,'')
            user.save()
        else:
            dic['msg'] = "请登录操作"
        return HttpResponse(json.dumps(dic, ensure_ascii=False))
    else:
        return HttpResponse('err')

@csrf_exempt
def query_collected_articles(request):
    #查询收藏的文章
    if request.method == "POST":
        dic = {'status': 200, 'msg': 'success', 'data': {'list':'','count':'','pageCount':''}}
        accessToken, islogin = isLogin(request)
        if islogin:
            userid = User.objects.filter(token=accessToken).first().userid
            pageIndex = request.GET.get("pageIndex", default=1)
            pageSize = request.GET.get("pageSize", default=10)
            newsid_dict_list = MyLike.objects.filter(userid=userid).all().values("newsid")
            newsid_list = [item['newsid'] for item in newsid_dict_list]
            news_list = HotNews.objects.filter(newsid__in=newsid_list).all().order_by('-time')
            dic['data']['list'] = pager(news_list, pageIndex, pageSize)
            dic['data']['count'] = news_list.count()
            dic['data']['pageCount'] = news_list.count() // int(pageSize) if news_list.count() % int(
                pageSize) == 0 else news_list.count() // int(pageSize) + 1
        else:
            dic['msg'] = "请登录操作"
        return HttpResponse(json.dumps(dic, ensure_ascii=False, cls=DateEncoder))
    else:
        return HttpResponse('err')

@csrf_exempt
def get_questions(request):
    #获取提问列表
    dic = {'status': 200, 'msg': 'success', 'data': {'list':'','count':'','pageCount':''}}
    pageIndex = request.GET.get("pageIndex",default=1)
    pageSize = request.GET.get("pageSize",default=10)
    question_list = Question.objects.all().order_by('-time')

    paginator = Paginator(question_list, pageSize)
    try:
        list = paginator.page(pageIndex)
    except PageNotAnInteger:
        list = paginator.page(1)
    except EmptyPage:
        # list = paginator.page(paginator.num_pages)
        return HttpResponse(json.dumps(dic, ensure_ascii=False,cls=DateEncoder))

    resultList = []
    for li in list:
        info = model_to_dict(li)
        info['userid'] = li.userid.userid
        info['avatarurl'] = SERVER_ADDRESS + Question.objects.filter(questionid=li.questionid).values("userid__avatarurl").first()['userid__avatarurl']
        info['answerCount'] = Answer.objects.filter(questionid=li.questionid,replyid=0).count()
        if len(li.content)>50:
            info['content'] = li.content[:50] + '...'
        resultList.append(info)
    dic['data']['list'] = resultList
    dic['data']['count'] = question_list.count()
    dic['data']['pageCount'] = question_list.count() // int(pageSize) if question_list.count() % int(pageSize) == 0 else question_list.count() // int(pageSize) + 1
    return HttpResponse(json.dumps(dic, ensure_ascii=False,cls=DateEncoder))

@csrf_exempt
def get_questions_details(request):
    #获取提问详情
    dic = {'status': 200, 'msg': 'success', 'data': ''}
    questionid = request.GET.get('questionid')
    question = Question.objects.filter(questionid=questionid).first()
    result = model_to_dict(question)
    result['nickname'] = Question.objects.filter(questionid=questionid).values("userid__nickname").first()['userid__nickname']
    result['avatarurl'] = SERVER_ADDRESS + Question.objects.filter(questionid=questionid).values("userid__avatarurl").first()['userid__avatarurl']
    dic['data'] = result
    return HttpResponse(json.dumps(dic, ensure_ascii=False, cls=DateEncoder))

@csrf_exempt
def issue_question(request):
    #我要提问
    if request.method =='POST':
        dic = {'status': 200, 'msg': 'success', 'data': ''}
        title = request.POST.get('title')
        content = request.POST.get('content')
        accessToken, islogin = isLogin(request)
        if islogin:
            userid = User.objects.filter(token=accessToken).first()
            Question.objects.create(userid=userid,title=title,content=content)
        else:
            dic['msg'] = '请登入操作'
        return HttpResponse(json.dumps(dic, ensure_ascii=False, cls=DateEncoder))
    else:
        return HttpResponse('err')

@csrf_exempt
def get_answer(request):
    #获取回答
    dic = {'status': 200, 'msg': 'success', 'data': ''}
    questionid = request.GET.get('questionid')
    accessToken, islogin = isLogin(request)
    answer_list =  Answer.objects.filter(questionid=questionid,replyid=0).all()
    result = []
    if islogin:
        userid = User.objects.filter(token=accessToken).first().userid
    for answer in answer_list:
        answer_dict = model_to_dict(answer)
        user = User.objects.filter(userid=answer_dict['userid']).first()
        answer_dict['nickname'] = user.nickname
        answer_dict['avatarurl'] = SERVER_ADDRESS + user.avatarurl
        reply_list = Answer.objects.filter(questionid=questionid, replyid=answer_dict['answerid']).all()
        answer_dict['reply_count'] = reply_list.count() #回复数
        answer_dict['islike'] = AnswerLike.objects.filter(userid=userid,answerid=answer_dict['answerid']).count() if islogin else 0
        answer_dict['reply'] = []
        for reply in reply_list:
            reply_dict = model_to_dict(reply)
            user = User.objects.filter(userid=reply_dict['userid']).first()
            reply_dict['nickname'] = user.nickname
            reply_dict['avatarurl'] = SERVER_ADDRESS + user.avatarurl
            reply_dict['islike'] = AnswerLike.objects.filter(userid=userid,answerid=answer_dict['answerid']).count() if islogin else 0
            answer_dict['reply'].append(reply_dict)
        result.append(answer_dict)
    dic['data'] = result
    return HttpResponse(json.dumps(dic, ensure_ascii=False, cls=DateEncoder))

@csrf_exempt
def get_answer_detail(request):
    #获取回答详情和它的回复
    dic = {'status': 200, 'msg': 'success', 'data': ''}
    answerid = request.GET.get('answerid')
    accessToken, islogin = isLogin(request)
    if islogin:
        userid = User.objects.filter(token=accessToken).first().userid
    answer = Answer.objects.filter(answerid=answerid).first()
    answer_dict = model_to_dict(answer)
    user = User.objects.filter(userid=answer_dict['userid']).first()
    answer_dict['nickname'] = user.nickname
    answer_dict['avatarurl'] = SERVER_ADDRESS + user.avatarurl
    reply_list = Answer.objects.filter(replyid=answer_dict['answerid']).all()
    answer_dict['reply_count'] = reply_list.count()  # 回复数
    answer_dict['islike'] = AnswerLike.objects.filter(userid=userid,answerid=answer_dict['answerid']).count() if islogin else 0
    answer_dict['reply'] = []
    for reply in reply_list:
        reply_dict = model_to_dict(reply)
        user = User.objects.filter(userid=reply_dict['userid']).first()
        reply_dict['nickname'] = user.nickname
        reply_dict['avatarurl'] = SERVER_ADDRESS + user.avatarurl
        reply_dict['islike'] = AnswerLike.objects.filter(userid=userid,answerid=reply_dict['answerid']).count() if islogin else 0
        answer_dict['reply'].append(reply_dict)
    dic['data'] = answer_dict
    return HttpResponse(json.dumps(dic, ensure_ascii=False, cls=DateEncoder))

@csrf_exempt
def add_answer(request):
    #发表回答
    if request.method == "POST":
        dic = {'status': 200, 'msg': 'success', 'data': ''}
        questionid = request.POST.get('questionid')
        content = request.POST.get('content')
        accessToken, islogin = isLogin(request)
        if islogin:
            userid = User.objects.filter(token=accessToken).first().userid
            Answer.objects.create(questionid=questionid,userid=userid,content=content)
            result = []
            answer_list = Answer.objects.filter(questionid=questionid, replyid=0).all()
            for answer in answer_list:
                answer_dict = model_to_dict(answer)
                user = User.objects.filter(userid=answer_dict['userid']).first()
                answer_dict['nickname'] = user.nickname
                answer_dict['avatarurl'] = SERVER_ADDRESS + user.avatarurl
                reply_list = Answer.objects.filter(questionid=questionid, replyid=answer_dict['answerid']).all()
                answer_dict['reply_count'] = reply_list.count()  # 回复数
                answer_dict['islike'] = AnswerLike.objects.filter(userid=userid, answerid=answer_dict[
                    'answerid']).count() if islogin else 0
                answer_dict['reply'] = []
                for reply in reply_list:
                    reply_dict = model_to_dict(reply)
                    user = User.objects.filter(userid=reply_dict['userid']).first()
                    reply_dict['nickname'] = user.nickname
                    reply_dict['avatarurl'] = SERVER_ADDRESS + user.avatarurl
                    reply_dict['islike'] = AnswerLike.objects.filter(userid=userid, answerid=reply_dict[
                        'answerid']).count() if islogin else 0
                    answer_dict['reply'].append(reply_dict)
                result.append(answer_dict)
            dic['data'] = result
        else:
            dic['msg'] = '请登录操作'
        return HttpResponse(json.dumps(dic, ensure_ascii=False, cls=DateEncoder))
    else:
        return HttpResponse('err')

@csrf_exempt
def add_reply(request):
    #回复
    if request.method == "POST":
        dic = {'status': 200, 'msg': 'success', 'data': ''}
        questionid = request.POST.get('questionid')
        replyid = request.POST.get('replyid')
        content = request.POST.get('content')
        accessToken, islogin = isLogin(request)
        if islogin:
            userid = User.objects.filter(token=accessToken).first().userid
            Answer.objects.create(questionid=questionid,userid=userid,content=content,replyid=replyid)
            result = []
            reply_list = Answer.objects.filter(replyid=replyid).all()
            for reply in reply_list:
                reply_dict = model_to_dict(reply)
                user = User.objects.filter(userid=reply_dict['userid']).first()
                reply_dict['nickname'] = user.nickname
                reply_dict['avatarurl'] = SERVER_ADDRESS + user.avatarurl
                reply_dict['islike'] = AnswerLike.objects.filter(userid=userid, answerid=reply_dict[
                    'answerid']).count() if islogin else 0
                result.append(reply_dict)
            dic['data'] = result
        else:
            dic['msg'] = '请登录操作'
        return HttpResponse(json.dumps(dic, ensure_ascii=False, cls=DateEncoder))
    else:
        return HttpResponse('err')

@csrf_exempt
def get_answer_like(request):
    # 点赞
    if request.method == "POST":
        dic = {'status': 200, 'msg': 'success', 'data': ''}
        answerid = request.POST.get('answerid')
        accessToken, islogin = isLogin(request)
        if islogin:
            userid = User.objects.filter(token=accessToken).first().userid
            answer = Answer.objects.filter(answerid=answerid).first()
            if AnswerLike.objects.filter(answerid=answerid,userid=userid).exists(): #已点过赞 True
                AnswerLike.objects.filter(answerid=answerid, userid=userid).delete() #取消点赞
                answer.favor -= 1
                answer.save()
            else:
                AnswerLike.objects.create(answerid=answerid, userid=userid) #点赞
                answer.favor += 1
                answer.save()
        else:
            dic['msg'] = '请登录操作'
        return HttpResponse(json.dumps(dic, ensure_ascii=False, cls=DateEncoder))
    else:
        return HttpResponse('err')

@csrf_exempt
def query_my_questions(request):
    #查询我的提问
    if request.method == 'POST':
        dic = {'status': 200, 'msg': 'success', 'data': {'list': '', 'count': '', 'pageCount': ''}}
        accessToken, islogin = isLogin(request)
        if islogin:
            userid = User.objects.filter(token=accessToken).first().userid
            pageIndex = request.POST.get("pageIndex", default=1)
            pageSize = request.POST.get("pageSize", default=10)

            question_list = Question.objects.filter(userid=userid).all().order_by('-time')
            paginator = Paginator(question_list, pageSize)
            try:
                list = paginator.page(pageIndex)
            except PageNotAnInteger:
                list = paginator.page(1)
            except EmptyPage:
                # list = paginator.page(paginator.num_pages)
                return HttpResponse(json.dumps(dic, ensure_ascii=False, cls=DateEncoder))

            resultList = []
            for li in list:
                info = model_to_dict(li)
                info['userid'] = li.userid.userid
                info['avatarurl'] = SERVER_ADDRESS + Question.objects.filter(questionid=li.questionid).values("userid__avatarurl").first()[
                    'userid__avatarurl']
                info['answerCount'] = Answer.objects.filter(questionid=li.questionid,replyid=li.questionid).count()
                if len(li.content) > 50:
                    info['content'] = li.content[:50] + '...'
                resultList.append(info)
            dic['data']['list'] = resultList
            dic['data']['count'] = question_list.count()
            dic['data']['pageCount'] = question_list.count() // int(pageSize) if question_list.count() % int(
                pageSize) == 0 else question_list.count() // int(pageSize) + 1
        else:
            dic['msg'] = '请登录操作'
        return HttpResponse(json.dumps(dic, ensure_ascii=False, cls=DateEncoder))
    else:
        return HttpResponse('err')


@csrf_exempt
def get_binding_phone(request):
    #绑定手机
    return

@csrf_exempt
def logout(request):
    #注销
    if request.method == 'POST':
        dic = {'status': 200, 'msg': 'success', 'data': ''}
        response = HttpResponse()
        accessToken, islogin = isLogin(request)
        if islogin:
            response.delete_cookie('token')
        else:
            dic['msg'] = '请登入操作'
        response.content = json.dumps(dic, ensure_ascii=False)
        return response
    else:
        return HttpResponse('err')

def pager(query_set,pageIndex,pageSize):
    #文章分页器
    resultList = []
    paginator = Paginator(query_set, pageSize)
    try:
        news = paginator.page(pageIndex)
    except PageNotAnInteger:
        news = paginator.page(1)
    except EmptyPage:
        # news = paginator.page(paginator.num_pages)
        return resultList
    for n in news:
        info = model_to_dict(n)
        info['content'] = ''
        info['imageUrl'] = SERVER_ADDRESS + n.imageUrl
        resultList.append(info)
    return resultList

def isLogin(request):
    try:
        accessToken = request.COOKIES["token"]
        print("accessToken", accessToken)
    except:
        return None,False
    return accessToken,User.objects.filter(token=accessToken).exists()
