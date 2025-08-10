class Ranking:
    def __init__(self):
        self.count = {}
        self.groups_list = []
        self.start_list_ = [] # класиране без никакво групиране
        self.start_list_g = []
        self.start_list_s = []
        self.start_list_gs = []

    def make_statistics(self, gr_list, st_list):
        # прави статистиката общо и по групи
        self.groups_list = []
        for group in gr_list:
            group['reg_male'] = 0
            group['reg_male'] = 0
            group['reg_female'] = 0
            group['fin_male'] = 0
            group['fin_female'] = 0
            group['started_male'] = 0
            group['started_female'] = 0

            for athlete in st_list:
                if athlete['group']['id'] == group['id']:
                    if athlete['gender']:
                        group['reg_male'] +=1
                    else:
                        group['reg_female'] +=1
                    if athlete['status'] == 3:
                        if athlete['gender']:
                            group['fin_male'] +=1
                        else:
                            group['fin_female'] +=1
                    if athlete['status'] > -1:
                        if athlete['gender']:
                            group['started_male'] +=1
                        else:
                            group['started_female'] +=1
            self.groups_list.append(group)

        # пресмята тоталите за статистиката
        self.count['reg_male'] = 0
        self.count['reg_female'] = 0
        self.count['fin_male'] = 0
        self.count['fin_female'] = 0
        self.count['started_male'] = 0
        self.count['started_female'] = 0
        for group in self.groups_list:
            self.count['reg_male'] += group['reg_male']
            self.count['reg_female'] += group['reg_female']
            self.count['fin_male'] += group['fin_male']
            self.count['fin_female'] += group['fin_female']
            self.count['started_male'] += group['started_male']
            self.count['started_female'] += group['started_female']

    def make_start_list_(self, max_items, st_list):
        # номерира състазателите без групиране
        self.start_list_ = []
        currentNumber = 1
        for athlete in st_list:
            if (athlete['result_time'] != 'NS') and (athlete['result_time'] != 'DQ'):
                athlete['num'] = currentNumber
                currentNumber += 1
                self.start_list_.append(athlete)
                if currentNumber > max_items:
                    break

    def make_start_list_g(self, max_items, st_list):
        # номерира състазателите по групи без разделяне мъже/жени
        self.start_list_g = []
        for group in self.groups_list:
            currentNumber = 1
            for athlete in st_list:
                if (athlete['result_time'] != 'NS') and (athlete['result_time'] != 'DQ'):
                    if athlete['group']['id'] == group['id']:
                        athlete['num'] = currentNumber
                        currentNumber += 1
                        self.start_list_g.append(athlete)
                    if currentNumber > max_items:
                        break

    def make_start_list_s(self, max_items, st_list):
        # номерира състазателите групирани по мъж/жена
        self.start_list_s = []
        currentNumber_male = 1
        currentNumber_female = 1
        for athlete in st_list:
            if (athlete['result_time'] != 'NS') and (athlete['result_time'] != 'DQ'):
                if athlete['gender']:
                    if currentNumber_male <= max_items:
                        athlete['num'] = currentNumber_male
                        currentNumber_male += 1
                        self.start_list_s.append(athlete)
                else:
                    if currentNumber_female <= max_items:
                        athlete['num'] = currentNumber_female
                        currentNumber_female += 1
                        self.start_list_s.append(athlete)

    def make_start_list_gs(self, max_items, st_list):
        # номерира състазателите по групи с разделяне мъже/жени
        self.start_list_gs = []
        for group in self.groups_list:
            currentNumber_male = 1
            currentNumber_female = 1
            for athlete in st_list:
                if (athlete['result_time'] != 'NS') and (athlete['result_time'] != 'DQ'):
                    if athlete['group']['id'] == group['id']:
                        if athlete['gender']:
                            if currentNumber_male <= max_items:
                                athlete['num'] = currentNumber_male
                                currentNumber_male += 1
                                self.start_list_gs.append(athlete)
                        else:
                            if currentNumber_female <= max_items:
                                athlete['num'] = currentNumber_female
                                currentNumber_female += 1
                                self.start_list_gs.append(athlete)
