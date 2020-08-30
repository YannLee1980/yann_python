from django.shortcuts import render

# Create your views here.
from .models import Shorts
from django.http import HttpResponse

#展示高于 3 星级（不包括 3 星级）的短评内容和它对应的星级
def shorts(request):
    ### 从models取数据全部的评论传给template：
    # shorts = Shorts.objects.all()

    ### 找到高于 3 星级（不包括 3 星级）的短评内容：
    shorts = Shorts.objects.filter(star__gt = 3)

    return render(request, 'result.html', locals())
