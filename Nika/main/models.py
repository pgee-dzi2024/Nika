from django.db import models
"""
***************************************
          Системни параметри
***************************************
"""
class SysParam(models.Model):

    name = models.CharField('Име на параметъра', max_length=30, default='')
    value = models.CharField('Стойност на параметъра', max_length=30, default='')
    comment = models.CharField('коментар/пояснение', max_length=80, default='', blank=True)

    def __str__(self):
        return f'{self.name}: {self.value}'

    class Meta:
        verbose_name = 'Системен параметър'
        verbose_name_plural = 'Системни параметри'


"""
***************************************
          Групи
***************************************
"""
class Group(models.Model):

    name = models.CharField('Име нагрупата', max_length=30, default='')
    comment = models.CharField('коментар/пояснение', max_length=80, default='', blank=True)

    def __str__(self):
        return f'{self.name}({self.comment})'

    class Meta:
        verbose_name = 'Група/категория'
        verbose_name_plural = 'Групи/категории'


"""
***************************************
          Списък участници
***************************************
"""
class Athlete(models.Model):
    name = models.CharField('Име на състезателя', max_length=60)
    bib_number = models.CharField('Стартов номер', max_length=10)
    result_time = models.DurationField('Време', null=True, blank=True)
    group = models.ForeignKey(
        Group,
        on_delete=models.PROTECT,   # За да не се позволи изтриване на ползвана група
        related_name='athletes',
        verbose_name='Група/категория'
    )

    def __str__(self):
        return f'{self.name} ({self.bib_number})'

    class Meta:
        verbose_name = 'Състезател'
        verbose_name_plural = 'Състезатели'
