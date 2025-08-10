import configparser

import requests
import os

from Nika.robot.APIclient import RaceClient
from Nika.print.ranking_maker import Ranking
from Nika.print.ranking_docs import RankingDocBuilder


print('******************************')
print('*  Генериране на класиране   *')
print('* във формат MS Word (.docx) *')
print('******************************')
print()
print()

# Създаване на парсер и четене на .ini файл - настройки на приложнието
config = configparser.ConfigParser()
config.read('config.ini')

server_url = f'http://{config["server"]["ip"]}:{config["server"]["port"]}'
server_token = config["server"]["token"]

# Свързвам се със сървъра и чета необходимите данни
race_api = RaceClient(server_url, server_token)
race_api.load_sys_params()
race_api.load_groups()
race_ranking = Ranking()
race_ranking.make_statistics(race_api.groups_list, race_api.start_list)
race_ranking.make_start_list_g(3, race_api.start_list)
race_ranking.make_start_list_gs(3, race_api.start_list)

race_docs = RankingDocBuilder()

race_ranking.make_start_list_(3, race_api.start_list)
print(f"Генериран е файл за общо класиране без групиране челна тройка {race_docs.render_list_(race_ranking.start_list_, race_ranking.groups_list, 'general_top3.docx', ' ', race_ranking.count)}")
race_ranking.make_start_list_(1000, race_api.start_list)
print(f"Генериран е файл за общо класиране без групиране всички {race_docs.render_list_(race_ranking.start_list_,race_ranking.groups_list,'general_all.docx',' ',race_ranking.count)}")

race_ranking.make_start_list_s(3, race_api.start_list)
print(f"Генериран е файл за общо класиране мъже/жени челна тройка {race_docs.render_list_(race_ranking.start_list_s, race_ranking.groups_list,'general_top3_mf.docx','s', race_ranking.count)}")
race_ranking.make_start_list_s(1000, race_api.start_list)
print(f"Генериран е файл за общо класиране мъже/жени всички {race_docs.render_list_(race_ranking.start_list_s, race_ranking.groups_list,'general_all_mf.docx','s', race_ranking.count)}")

race_ranking.make_start_list_gs(3, race_api.start_list)
print(f"Генериран е файл за класиране по групи мъже/жени челна тройка {race_docs.render_list_(race_ranking.start_list_gs, race_ranking.groups_list,'by_cat_top3_mf.docx','gs', race_ranking.count)}")
race_ranking.make_start_list_gs(1000, race_api.start_list)
print(f"Генериран е файл за класиране по групи мъже/жени челна тройка {race_docs.render_list_(race_ranking.start_list_gs, race_ranking.groups_list,'by_cat_all_mf.docx','gs', race_ranking.count)}")

race_ranking.make_start_list_g(3, race_api.start_list)
print(f"Генериран е файл за класиране по групи челна тройка {race_docs.render_list_(race_ranking.start_list_gs, race_ranking.groups_list,'by_cat_top3.docx','g', race_ranking.count)}")
race_ranking.make_start_list_g(1000, race_api.start_list)
print(f"Генериран е файл за класиране по групи челна тройка {race_docs.render_list_(race_ranking.start_list_gs, race_ranking.groups_list,'by_cat_all.docx','g', race_ranking.count)}")
