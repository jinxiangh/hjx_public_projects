import base64
from PIL import Image,ImageDraw,ImageFont,ImageFilter
import random,string
from io import BytesIO

class Captcha():
    def __init__(self,captcha_size=(160,60),font_size=40,text_number=4, line_number=6):
        self.captcha_size=captcha_size
        self.text_number = text_number
        self.line_number = line_number
        self.font_size = font_size

    def getRandomChar(self):
        '''
        :return: 随机4个字符组合
        '''
        chr_all = string.ascii_letters+string.digits
        chr_4 = ''.join(random.sample(chr_all,4))
        return chr_4

    def getRandomColor(self,low,high):
        '''
        :param low: 最低阈值
        :param high: 最高阈值
        :return: 随机颜色RGB值
        '''
        return (random.randint(low,high),random.randint(low,high),random.randint(low,high))

    def draw_line(self, draw, captcha_width, captcha_height):
        '''
        绘制线条
        :param draw: 画笔对象
        :param captcha_width: 验证码的宽度
        :param captcha_height: 验证码的高度
        '''
        # 随机获取开始位置的坐标
        begin = (random.randint(0, captcha_width / 2), random.randint(0, captcha_height))
        # 随机获取结束位置的坐标
        end = (random.randint(captcha_width / 2, captcha_width), random.randint(0, captcha_height))
        draw.line([begin, end], fill=self.getRandomColor(0,250))

    def draw_point(self, draw, point_chance, captcha_width, captcha_height):
        '''
        绘制小圆点
        :param draw: 画笔对象
        :param point_chance: 绘制小圆点的几率 概率为 point_chance/100
        :param captcha_width: 验证码宽度
        :param captcha_height: 验证码高度
        '''
        # 按照概率随机绘制小圆点
        for w in range(captcha_width):
            for h in range(captcha_height):
                tmp = random.randint(0, 100)
                if tmp < point_chance:
                    draw.point((w, h), fill=self.getRandomColor(50,150))

    #制作验证码图片
    def getCaptcha(self,isFilter=False):
        '''
        :param isFilter: 是否模糊化处理
        :return:
        '''
        width,height = self.captcha_size
        #创建空白画布
        image = Image.new('RGB',(width,height),self.getRandomColor(200,255))
        #验证码的字体
        font = ImageFont.truetype('font/arial.ttf',self.font_size)
        #font = ImageFont.truetype('DejaVuSans.ttf',self.font_size) #linux
        #创建画笔
        draw = ImageDraw.Draw(image)
        #获取验证码
        char_4 = self.getRandomChar()
        #向画布上填写验证码
        for i in range(4):
            draw.text((40*i+10,5),char_4[i],font = font,fill=self.getRandomColor(0,200))

        # 绘制小圆点 10是概率 10/100， 10%的概率
        self.draw_point(draw, 10, width, height)

        # 绘制线条
        for i in range(self.line_number):
            self.draw_line(draw, width, height)

        #模糊处理
        if (isFilter):
           image = image.filter(ImageFilter.BLUR)

        #写入内存
        f = BytesIO()
        image.save(f,"png")
        data = f.getvalue()
        f.close()

        # image.save('../../static/captcha/{}.jpg'.format(char_4))
        # image.show()
        return data,char_4

    def base64_img_name(self,btyes_data,save_path,save_name,save_type):
        b64_fileName = base64.b64encode(bytes(save_name,'utf-8')).decode()
        file_path = save_path + "/" + str(b64_fileName) + "." +save_type
        with open(file_path,"wb") as f:
            f.write(btyes_data)
        return file_path


if __name__ == '__main__':
    data_,str_ = Captcha().getCaptcha()
    print(type(data_),str_)
    Captcha().base64_img_name(btyes_data=data_,save_name=str_,save_path=r"../../static/captcha",save_type="png")
