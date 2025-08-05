"""
Пример за обработка на събитие:
"""
# Когато се отчете събитие (например бариерата сработи)
def set_athlete_finished(athlete, timer_value):  # athlete -> dict
    athlete["status"] = 3  # финиширал
    athlete["result_time"] = format_timer(timer_value)
    athlete["num"] = 0
    race_api.save_athlete(athlete)
    print(f"Състезател {athlete['bib_number']} финализиран с време {athlete['result_time']}.")

def format_timer(seconds):
    total_seconds = int(seconds)
    deci = int((seconds - total_seconds) * 10)
    hours = total_seconds // 3600
    minutes = (total_seconds % 3600) // 60
    secs = total_seconds % 60
    return f"{hours}:{minutes:02}:{secs:02}.{deci}"



"""
Използване в главния цикъл
"""
from time import time, sleep

# Примерна инициализация на състезание/бегачи:
sysparams = race_api.get_sysparams()
start_list = race_api.get_start_list(0)

# Главен цикъл (схематичен!)
while True:
    # ... четене от камери и/или бариера ...
    # ако бариерата сработи:
    # 1. намираш следващия атлет от start_list
    # 2. извикваш set_athlete_finished(athlete, time_on_timer)
    break  # излизаш за тест, махни го в реално приложениe

"""
примерен обект
"""
import requests
import threading

class RaceClient:
    def __init__(self, base_url, token):
        # Свързване към API
        self.base_url = base_url.rstrip('/')
        self.session = requests.Session()
        self.session.headers.update({
            'Authorization': f'Token {token}',
            'Content-Type': 'application/json'
        })

        # Главни свойства от оригиналния Vue обект
        self.sysparams = {
            "id": 0,
            "status": 0,
            "next_num": 0,
        }
        self.sysparams_prev = {}

        self.start_list = []
        self.groups_list = []
        self.c_athlete = {
            "id": 0,
            "name": "",
            "bib_number": 0,
            "result_time":"",
            "num": 0,
            "status": 0,
            "user": "",
            "group": {}
        }
        self.start_mode = 0
        self.result_mode = 0
        self.is_dialog = False
        self.timer_value = 0.0
        self.start_time = 0.0
        self.diff_time = 0.0
        self.user = 'А'
        self.window_focus = True

    # === Всички API-действия са самообновяващи свойства ===

    def update_sysparams(self):
        resp = self.session.get(f"{self.base_url}/api/sysparams/")
        resp.raise_for_status()
        sysparams = resp.json()[0]
        self.sysparams_prev = self.sysparams.copy()
        self.sysparams = sysparams

    def update_start_list(self, show_mode=None):
        mode = show_mode if show_mode is not None else self.result_mode
        resp = self.session.get(f"{self.base_url}/api/athletes/sort/{mode}/")
        resp.raise_for_status()
        self.start_list = resp.json()

    def update_groups_list(self):
        resp = self.session.get(f"{self.base_url}/api/groups/")
        resp.raise_for_status()
        self.groups_list = resp.json()

    def update_competition_status(self, new_status):
        resp = self.session.patch(
            f"{self.base_url}/api/competition/status/",
            json={"status": new_status}
        )
        resp.raise_for_status()
        self.sysparams['status'] = resp.json().get("status", new_status)

    def start_competition(self):
        resp = self.session.post(f"{self.base_url}/api/competition/start/")
        resp.raise_for_status()
        self.start_time = resp.json().get("start_time", 0.0)

    def save_athlete(self, athlete):
        # Използва или POST, или PUT според наличието на id
        if athlete.get("id", 0) == 0:
            resp = self.session.post(
                f"{self.base_url}/api/athletes/",
                json=athlete
            )
        else:
            resp = self.session.put(
                f"{self.base_url}/api/athletes/{athlete['id']}/",
                json=athlete
            )
        resp.raise_for_status()
        # Може по избор да добавиш промяна в self.start_list

    def fetch_athlete(self, athlete_id):
        resp = self.session.get(f"{self.base_url}/api/athletes/{athlete_id}/")
        resp.raise_for_status()
        self.c_athlete = resp.json()

    def delete_athlete(self, athlete_id):
        self.session.delete(f"{self.base_url}/api/athletes/{athlete_id}/")
        # При успех премахваш от self.start_list, ако желаеш

    # Можеш да добавиш още методи от race.js аналогично...

    # === Примерна periodic sync логика ===
    def periodic_sync(self, sync_interval=1.0):
        # стартираш това в отделна нишка
        def _sync_loop():
            import time
            last_sysparam = 0
            last_start = 0
            last_groups = 0
            while True:
                now = time.monotonic()
                if now - last_sysparam > sync_interval:
                    self.update_sysparams()
                    last_sysparam = now
                if now - last_start > sync_interval:
                    self.update_start_list()
                    last_start = now
                if now - last_groups > 15*sync_interval:
                    self.update_groups_list()
                    last_groups = now
                time.sleep(0.01)
        t = threading.Thread(target=_sync_loop, daemon=True)
        t.start()


# *************************************************************
# Използвай threading.Lock или threading.RLock:

class RaceClient:
    def __init__(self, ...):
        self._lock = threading.Lock()
        # ...
    def update_start_list(self):
        data = ... # get from API
        with self._lock:
            self.start_list = data
    def main_method(self):
        with self._lock:
            ... ползваш/променяш self.start_list безопасно ...