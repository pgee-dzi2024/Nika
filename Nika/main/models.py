from django.db import models
"""
***************************************
          Системни параметри
***************************************
"""


class Competition(models.Model):
    name = models.CharField('Име на състезанието', max_length=100)
    status = models.PositiveSmallIntegerField('Текущ статус на състезанието', null=True, default=0)
    start_time = models.DateTimeField('Начало на състезанието', null=True, blank=True)  # UTC!
    next_num = models.PositiveSmallIntegerField('Текущ пореден номер на пристигащ състезател', null=True, default=0)


    def __str__(self):
        return f'{self.name}'

    class Meta:
        verbose_name = 'Състезание'
        verbose_name_plural = 'Състезания'


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
    name = models.CharField('Име на състезателя', max_length=80)
    bib_number = models.IntegerField('Стартов номер', default=0)
    result_time = models.CharField('Време', max_length=10, default='0:00:00.0')
    num = models.PositiveSmallIntegerField('Текущ пореден номер на пристигащ състезател', null=True, default=999)
    status = models.PositiveSmallIntegerField('Статус на състезателя',
                                              choices=[(0, 'дисквалифициран'), (1, 'регистриран'), (2, 'финиширащ'),
                                                       (3, 'финиширал')], default=1)
    group = models.ForeignKey(
        Group,
        on_delete=models.PROTECT,   # За да не се позволи изтриване на ползвана група
        related_name='athletes',
        verbose_name='Група/категория'
    )
    user = models.CharField('Създадено от', max_length=1, default='М')

    def __str__(self):
        return f'{self.name} ({self.bib_number})'

    class Meta:
        verbose_name = 'състезател'
        verbose_name_plural = 'Състезатели'
