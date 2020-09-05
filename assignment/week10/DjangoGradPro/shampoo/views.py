from django.shortcuts import render

# Create your views here.
from .models import Shampoo
from django.http import HttpResponse
from .form import ShortSearchForm, DateSearchForm

def get_names(shampoos):
    shampoo_names = []
    for s in shampoos:
        shampoo_names.append(s.name)
    return list(set(shampoo_names))


def shampoo(request):
    short_form = ShortSearchForm()
    date_form = DateSearchForm()

    shampoos = Shampoo.objects.all()
    #各项目的名称：
    shampoo_names = get_names(shampoos)
    #计算各项目的评价数：
    counts = []
    shampoo_groups = []
    anchors = []
    indexs = []
    plus = []
    minus = []
    i = 0
    for name in shampoo_names:
        count = Shampoo.objects.filter(name=name).count()
        counts.append(count)
        shampoo_groups.append(Shampoo.objects.filter(name=name))
        indexs.append(i)
        anchors.append('#'+str(i))
        i += 1
        #收集各正向和负向评价的数量：
        queryset1 = Shampoo.objects.filter(name=name)
        condtion1 = {'sentiment__gte': 0.5}
        plus.append(queryset1.filter(**condtion1).count())
        queryset2 = Shampoo.objects.filter(name=name)
        condtion2 = {'sentiment__lt': 0.5}
        minus.append(queryset2.filter(**condtion2).count())

    data = list(zip(shampoo_names, counts, anchors, indexs, shampoo_groups, plus, minus))

    return render(request, 'index.html', locals())

def short_search(request):
    date_form = DateSearchForm()
    if request.method == "POST":
        short_form = ShortSearchForm(request.POST)
        if short_form.is_valid():
            cd = short_form.cleaned_data
            short = cd['short']
            shampoo_results = Shampoo.objects.filter(short__icontains=short)
    return render(request, 'result.html', locals())

def date_search(request):
    short_form = ShortSearchForm()
    if request.method == "POST":
        date_form = DateSearchForm(request.POST)
    if date_form.is_valid():
        cd = date_form.cleaned_data
        date = cd['date']
        shampoo_results = Shampoo.objects.filter(time=date)
    return render(request, 'result.html', locals())