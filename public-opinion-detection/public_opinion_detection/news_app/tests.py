from django.test import TestCase

# Create your tests here.
# 测试环境的准备 去manage.py中拷贝前四行代码 然后自己写两行
import os

if __name__ == "__main__":
    os.environ.setdefault("DJANGO_SETTINGS_MODULE", "day64.settings")
    import django
    django.setup()

    from news_app import models
    # 在这个代码块的下面就可以测试django里面的单个py文件了