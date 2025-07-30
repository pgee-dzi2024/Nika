from django.shortcuts import render
from rest_framework import generics
from .models import *
from .serializers import *


def index(request):
    context = {
        'tab_title': 'Списък',
    }
    return render(request, 'main/main_list.html', context)


class SysParamListView(generics.ListCreateAPIView):
    queryset = SysParam.objects.all()
    serializer_class = SysParamSerializer


class AthleteListView(generics.ListAPIView):
    queryset = Athlete.objects.all()
    serializer_class = AthleteSerializer