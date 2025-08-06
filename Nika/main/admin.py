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


@admin.register(AthletePhoto)
class AthletePhotoAdmin(admin.ModelAdmin):
    list_display = [field.name for field in AthletePhoto._meta.fields] + ["athlete_bib_number", "athlete_name",]

    def athlete_name(self, obj):
        # ако искаш цялото име (first + last)
        return obj.athlete.name

    athlete_name.short_description = "Име на атлет"

    def athlete_bib_number(self, obj):
        return obj.bib_number

    athlete_bib_number.short_description = "Номер (bib)"
