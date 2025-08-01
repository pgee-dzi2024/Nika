from django.shortcuts import render
from rest_framework import generics, status
from .models import *
from .serializers import *

from rest_framework.views import APIView
from rest_framework.response import Response
from django.utils.timezone import now

from django.utils import timezone


def index(request):
    context = {
        'tab_title': 'Списък',
    }
    return render(request, 'main/main_list.html', context)


class SysParamListView(generics.ListCreateAPIView):
    queryset = Competition.objects.all()
    serializer_class = SysParamSerializer


class GroupListView(generics.ListCreateAPIView):
    queryset = Group.objects.all()
    serializer_class = GroupSerializer


class AthleteListView(generics.ListCreateAPIView):
    queryset = Athlete.objects.all().order_by('bib_number')
    serializer_class = AthleteSerializer


class AthleteDetailView(generics.RetrieveUpdateDestroyAPIView):
    queryset = Athlete.objects.all()
    serializer_class = AthleteSerializer


class CurrentStartTime(APIView):
    def get(self, request):
        comp = Competition.objects.get(id=1)
        return Response({
            'start_time': comp.start_time.isoformat() if comp.start_time else None,
            'server_time': now().isoformat()
        })


class StartCompetition(APIView):
    def post(self, request):
        try:
            comp = Competition.objects.get(id=1)
        except Competition.DoesNotExist:
            return Response({'error': 'Not found'}, status=404)
        comp.start_time = timezone.now()
        comp.save()
        return Response({'start_time': comp.start_time}, status=200)


class CompetitionStatusUpdate(APIView):
    def patch(self, request):
        try:
            comp = Competition.objects.get(id=1)
        except Competition.DoesNotExist:
            return Response({"detail": "Not found."}, status=404)
        status_ = request.data.get('status')
        if status_ is None or not str(status_).isdigit():
            return Response({"status": "Invalid value"}, status=400)
        comp.status = int(status_)
        comp.save()
        return Response({"status": comp.next_num}, status=200)


class CompetitionNextNumIncrement(APIView):
    def post(self, request):
        try:
            comp = Competition.objects.get(id=1)
        except Competition.DoesNotExist:
            return Response({"detail": "Not found."}, status=404)
        comp.next_num = (comp.next_num or 0) + 1
        comp.save()
        return Response({"next_num": comp.next_num}, status=200)
