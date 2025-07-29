from rest_framework import serializers
from .models import SysParam


class SysParamSerializer(serializers.ModelSerializer):
    class Meta:
        model = SysParam
        fields = ['id', 'name', 'value', 'comment']