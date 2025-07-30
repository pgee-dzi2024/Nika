from rest_framework import serializers
from .models import *


class SysParamSerializer(serializers.ModelSerializer):
    class Meta:
        model = SysParam
        fields = ['id', 'name', 'value', 'comment']


class GroupSerializer(serializers.ModelSerializer):
    class Meta:
        model = Group
        fields = ['id', 'name', 'comment']


class AthleteSerializer(serializers.ModelSerializer):
    group = GroupSerializer(read_only=True)

    class Meta:
        model = Athlete
        fields = ['id', 'name', 'bib_number', 'result_time', 'group']