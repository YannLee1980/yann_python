from django.shortcuts import render

# Create your views here.
from .models import Books
from django.db.models import Avg

def book_short(request):
    ###  从models取数据传给template  ###
    shorts = Books.objects.all()

    # 评论数量
    counter = Books.objects.all().count()

    # 平均星级
    star_avg = f'{Books.objects.aggregate(Avg('n_star'))['n_star__avg']:0.1f}'
    # 情感倾向
    sent_avg = f'{Books.objects.aggreate(Avg('sentiment'))['sentiment__avg']:0.2f}'
    # 正向数量
    queryset = Books.objects.values('sentiment')
    condtions = {'sentiment__gte': 0.5}
    plus = queryset.filter(**condtions).count()
    # 负向数量
    queryset = Books.objects.values('sentiment')
    condtions = {'sentiment__lt': 0.5}
    minus = queryset.filter(**condtions).count()

    return render(request, 'result.html', locals())

