from django.urls import path
from .views import *

urlpatterns = [
    path('', index, name='home'),
    path('api/sysparams/', SysParamListView.as_view(), name='sysparam-list'),
]
