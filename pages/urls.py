from django.urls import path
from pages.views import home, get_status, run_task

urlpatterns = [
    path('', home, name='home'),
    path("tasks/<task_id>/", get_status, name="get_status"),
    path("tasks/", run_task, name="run_task"),
]