from rest_framework import serializers
from .models import *


class SysParamSerializer(serializers.ModelSerializer):
    class Meta:
        model = Competition
        fields = ['id', 'name', 'status', 'next_num']


class GroupSerializer(serializers.ModelSerializer):
    class Meta:
        model = Group
        fields = ['id', 'name', 'comment']


class AthleteSerializer(serializers.ModelSerializer):
    group = GroupSerializer(read_only=True)
    group_id = serializers.PrimaryKeyRelatedField(
        queryset=Group.objects.all(),
        source='group',
        write_only=True
    )

    class Meta:
        model = Athlete
        fields = ['id', 'name', 'bib_number', 'result_time', 'num', 'status', 'group', 'group_id','user']
