from django.shortcuts import render


def home(request):
    context = {
        'tab_title': 'Списък',
    }
    return render(request, 'main/main_list.html', context)
