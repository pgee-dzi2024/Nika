from django.contrib import admin
from .models import *


@admin.register(Competition)
class SysParamAdmin(admin.ModelAdmin):
    list_display = ('name', 'status', 'start_time', 'next_num')
    search_fields = ('name', 'status', 'start_time', 'next_num')


@admin.register(Group)
class GroupAdmin(admin.ModelAdmin):
    list_display = ('name', 'comment')
    search_fields = ('name', 'comment')


@admin.register(Athlete)
class AthleteAdmin(admin.ModelAdmin):
    list_display = ('name', 'bib_number', 'result_time', 'group','user')
    search_fields = ('name', 'bib_number')
    list_filter = ('group',)

