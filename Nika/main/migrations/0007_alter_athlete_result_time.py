# Generated by Django 4.2.23 on 2025-07-31 18:29

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('main', '0006_alter_athlete_name'),
    ]

    operations = [
        migrations.AlterField(
            model_name='athlete',
            name='result_time',
            field=models.CharField(blank=True, default='', max_length=10, null=True, verbose_name='Време'),
        ),
    ]
