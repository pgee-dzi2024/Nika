from django.contrib import admin
from .models import SysParam, Group, Athlete


@admin.register(SysParam)
class SysParamAdmin(admin.ModelAdmin):
    list_display = ('name', 'value', 'comment')
    search_fields = ('name', 'value', 'comment')


@admin.register(Group)
class GroupAdmin(admin.ModelAdmin):
    list_display = ('name', 'comment')
    search_fields = ('name', 'comment')


@admin.register(Athlete)
class AthleteAdmin(admin.ModelAdmin):
    list_display = ('name', 'bib_number', 'result_time', 'group')
    search_fields = ('name', 'bib_number')
    list_filter = ('group',)
