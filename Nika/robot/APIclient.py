import requests
import threading
import time
from datetime import datetime

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
        self.sysParams = {
            "id": 0,
            "status": 0,
            "next_num": 0,
        }
        self.start_list = []
        self.groups_list = []
        self.c_athlete = {
            "id": 0,
            "name": "",
            "bib_number": 0,
            "result_time":"0:00:00.0",
            "num": 999,
            "status": 0,
            "user": "A",
            "group": {}
        }
        self.start_time = 0
        self.server_now = 0
        self.time_offset = 0

        self._lock = threading.Lock()

        self._sync_thread = None
        self._sync_running = False

    def periodic_sync(self, sync_interval=1.0):
        def _sync_loop():
            last_update = 0
            while self._sync_running:
                now = time.monotonic()
                if now - last_update > sync_interval:
                    self.load_sys_params()
                    last_update = now
                time.sleep(sync_interval)

        self._sync_running = True
        self._sync_thread = threading.Thread(target=_sync_loop, daemon=True)
        self._sync_thread.start()

    def stop_sync(self):
        self._sync_running = False
        if self._sync_thread is not None:
            self._sync_thread.join(timeout=2)

    # Всички API-действия са самообновяващи свойства

    def load_sys_params(self):
        try:
            resp = self.session.get(f"{self.base_url}/api/sysparams/")
            resp.raise_for_status()
            self.sysParams = resp.json()[0]
            if self.sysParams['status'] == 2:  # ако е в режим "състезание"
                self.update_timer_params() # обновява данните за хронометъра
            self.load_start_list()
        except (requests.RequestException, KeyError, ValueError) as e:
            print("Грешка при получаване на системните параметри:", e)

    def update_timer_params(self):
        try:
            resp = self.session.get(f"{self.base_url}/api/competition/time/")
            resp.raise_for_status()
            data = resp.json()

            # Преобразуване на сървърния ISO-дата към милисекунди от епохата:
            self.start_time = int(datetime.fromisoformat(data['start_time']).timestamp() * 1000)
            self.server_now = int(datetime.fromisoformat(data['server_time']).timestamp() * 1000)

            # Разлика между локалното време и сървърното време (в милисекунди):
            self.time_offset = int(time.time() * 1000) - self.server_now

        except (requests.RequestException, KeyError, ValueError) as e:
            print("Грешка при вземане на start_time:", e)

    def format_timer(self):
        seconds = ((int(time.time() * 1000) - self.time_offset) - self.start_time) / 1000
        total_seconds = int(seconds)
        deci = int((seconds - total_seconds) * 10)  # десети

        hours = total_seconds // 3600
        minutes = (total_seconds % 3600) // 60
        secs = total_seconds % 60

        # ЧЧ:Без водеща нула, ММ:СС задължително по две цифри, десети след точка
        return f'{hours}:{minutes:02}:{secs:02}.{deci}'

    def load_start_list(self):
        try:
            mode = self.sysParams['status']
            resp = self.session.get(f"{self.base_url}/api/athletes/sort/{mode}/")
            resp.raise_for_status()
            self.start_list = resp.json()
        except (requests.RequestException, KeyError, ValueError) as e:
            print("Грешка при зареждане на стартовия лист:", e)
