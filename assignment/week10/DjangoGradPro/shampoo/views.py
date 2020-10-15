from django.shortcuts import render

# Create your views here.
from .models import Shampoo
from django.http import HttpResponse
from .form import ShortSearchForm, DateSearchForm


def get_names(shampoos):
    '''
    找到数据库中所有洗发水品牌名称，并返回。
    '''
    shampoo_names = []
    for s in shampoos:
        shampoo_names.append(s.name)
    return list(set(shampoo_names))


def shampoo(request):
    '''
    展示各种数据
    '''

    # 搜索框初始化，以保证index.html首次运行时正常显示。
    short_form = ShortSearchForm()
    date_form = DateSearchForm()

    shampoos = Shampoo.objects.all()
    # 各洗发水的名称：
    shampoo_names = get_names(shampoos)
    # 各品牌洗发水的评论数：
    counts = []
    # 以各洗发水的品牌名称把数据分组，放到列表
    shampoo_groups = []
    # 以“#0”-“#9”形式的锚，用于'index.html'
    anchors = []
    # 0-9的数列，用于'index.html'
    indexs = []
    # 各洗发水的品牌的评价舆情分析为正的数量
    plus = []
    # 各洗发水的品牌的评价舆情分析为负的数量
    minus = []
    i = 0
    for name in shampoo_names:
        count = Shampoo.objects.filter(name=name).count()
        counts.append(count)
        shampoo_groups.append(Shampoo.objects.filter(name=name))
        indexs.append(i)
        anchors.append('#'+str(i))
        i += 1
        # 收集各正向和负向评价的数量：
        queryset1 = Shampoo.objects.filter(name=name)
        condtion1 = {'sentiment__gte': 0.5}
        plus.append(queryset1.filter(**condtion1).count())
        queryset2 = Shampoo.objects.filter(name=name)
        condtion2 = {'sentiment__lt': 0.5}
        minus.append(queryset2.filter(**condtion2).count())

    # 数据以data打包，用于'index.html'
    data = list(zip(shampoo_names, counts, anchors,
                    indexs, shampoo_groups, plus, minus))

    return render(request, 'index.html', locals())


def short_search(request):
    '''
    实现评论搜索框功能
    '''

    # 日期搜索框重建，以保证页面切换时正常显示。
    date_form = DateSearchForm()
    if request.method == "POST":
        short_form = ShortSearchForm(request.POST)
        if short_form.is_valid():
            cd = short_form.cleaned_data
            short = cd['short']
            shampoo_results = Shampoo.objects.filter(short__icontains=short)
    return render(request, 'result.html', locals())


def date_search(request):
    '''
    实现日期搜索框功能
    '''

    # 评论搜索框重建，以保证页面切换时正常显示。
    short_form = ShortSearchForm()
    if request.method == "POST":
        date_form = DateSearchForm(request.POST)
    if date_form.is_valid():
        cd = date_form.cleaned_data
        date = cd['date']
        shampoo_results = Shampoo.objects.filter(time=date)
    return render(request, 'result.html', locals())
