from django.urls import path
from .views import *

urlpatterns = [
    path('', index, name='home'),
    path('api/sysparams/', SysParamListView.as_view(), name='sysparam-list'),
    path('api/groups/', GroupListView.as_view(), name='group-list'),
    path('api/athletes/', AthleteListView.as_view(), name='athlete-list'),
    path('api/athletes/<int:pk>/', AthleteDetailView.as_view(), name='athlete-detail'),
    path('api/competition/time/', CurrentStartTime.as_view()),
    path('api/competition/start/', StartCompetition.as_view()),
    path('api/competition/status/', CompetitionStatusUpdate.as_view()),
    path('api/competition/nextnum/inc/', CompetitionNextNumIncrement.as_view()),
]
