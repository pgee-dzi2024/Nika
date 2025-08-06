from django.shortcuts import render
from rest_framework import generics, status
from .models import *
from .serializers import *

from rest_framework.views import APIView
from rest_framework.response import Response
from django.utils.timezone import now

from django.utils import timezone

from django.shortcuts import get_object_or_404


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


class AthleteListSortView(generics.ListCreateAPIView):
    serializer_class = AthleteSerializer

    def get_queryset(self):
        sk = self.kwargs.get('sk')
        order_field = 'bib_number'
        if sk == 2:
            order_field = 'num'
        elif sk == 3:
            order_field = 'result_time'
        return Athlete.objects.all().order_by(order_field)


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
        return Response({"status": comp.status}, status=200)


class CompetitionNextNumIncrement(APIView):
    def post(self, request):
        try:
            comp = Competition.objects.get(id=1)
        except Competition.DoesNotExist:
            return Response({"detail": "Not found."}, status=404)
        comp.next_num = (comp.next_num or 0) + 1
        comp.save()
        return Response({"next_num": comp.next_num}, status=200)


class AthleteNumBulkUpdateView(APIView):
    def post(self, request, *args, **kwargs):
        id1 = request.data.get('id1')
        num1 = request.data.get('num1')
        id2 = request.data.get('id2')
        num2 = request.data.get('num2')

        if not all([id1, num1, id2, num2]):
            return Response({'error': "Не са подадени всички параметри."}, status=status.HTTP_400_BAD_REQUEST)
        try:
            a1 = Athlete.objects.get(pk=id1)
            a2 = Athlete.objects.get(pk=id2)
        except Athlete.DoesNotExist:
            return Response({'error': "Невалиден ID на състезател."}, status=status.HTTP_404_NOT_FOUND)

        a1.num = num1
        a1.save()

        a2.num = num2
        a2.save()

        return Response({'success': True, "athletes": [
            {"id": a1.id, "num": a1.num},
            {"id": a2.id, "num": a2.num}
        ]})


class AthletePhotoUploadView(APIView):
    def post(self, request, athlete_id):
        athlete = get_object_or_404(Athlete, id=athlete_id)
        serializer = AthletePhotoSerializer(data=request.data)
        if serializer.is_valid():
            serializer.save(athlete=athlete)
            return Response(serializer.data, status=status.HTTP_201_CREATED)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)


class AthletePhotoListView(generics.ListAPIView):
    queryset = AthletePhoto.objects.all()
    serializer_class = AthletePhotoSerializer
