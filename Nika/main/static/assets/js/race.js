const App = {
    delimiters: ['[[', ']]'], // Променяме синтаксиса на [[ ]]
    data() {
        return {
            sysParams: {
                id:0,
                status: 0, // 0 - преди състезанието; 1 - състезание; 2 - след състезанието
                next_num:0,
                },
            showMode: 0, // 0 - Регистрация; 1 - Старт; 2 - Състезание; 3 - Класиране
            startList: [],
            groupsList: [],
            c_athlete: {
                id: 1,
                name: "Иван Петров",
                bib_number: 88,
                result_time: '',
                num: 999,
                status: 1,
                group: {
                    id: 3,
                    name: "Елит",
                    comment: "20-40 г"
                },
            },
            lookupNumber: '80',
            filter: {
                waitingToFinish: true,
                disqualified: true,
                finished: true,
            },
            startTime: null, // UTC timestamp от сървъра
            serverNow: null,
            timeOffset: 0,   // разлика между клиент и сървър
            timerInterval: null,
            timerValue: 0,   // ще показва изминалите секунди
        }
    },

    methods: {
        closeRegistration(){
            this.sysParams.status = 1
            this.showMode = 1
            this.toggleRightPanel()
            },

        closeCompetition(){
            this.sysParams.status = 2
            this.showMode = 3
            },

        toggleRightPanel(){
            $(".popup-dashboardright-btn").toggleClass("collapsed");
            $(".popup-dashboardright-section").toggleClass("collapsed");
            $(".rbt-main-content").toggleClass("area-right-expanded");
            $(".rbt-static-bar").toggleClass("area-right-expanded");
            },

        loadSysParams(){
            axios.get('/api/sysparams/')
                .then(response => {
                    this.sysParams = response.data[0]
                })
                .catch(error => {
                    console.error('Error fetching system parameters:', error);
                });
            },

        loadStartList(){
        axios.get('/api/athletes/')
            .then(response => {
                this.startList = response.data
                console.log(" ****")
            })
            .catch(error => {
                console.error('Error fetching start list:', error);
            });
        },

        loadGroupsList(){
        axios.get('/api/groups/')
            .then(response => {
                this.groupsList = response.data
            })
            .catch(error => {
                console.error('Error fetching groups list:', error);
            });
        },

        editAthlete(num){
            this.c_athlete.id = this.startList[num].id
            this.c_athlete.name = this.startList[num].name
            this.c_athlete.bib_number = this.startList[num].bib_number
            this.c_athlete.result_time = this.startList[num].result_time
            this.c_athlete.num = this.startList[num].num
            this.c_athlete.status = this.startList[num].status
            this.c_athlete.group = this.startList[num].group
        },

        changeGroup(idx){
            this.c_athlete.group = this.groupsList[idx]
        },

        newAthlete(){
            this.c_athlete.id = 0
            this.c_athlete.name = ""
            this.c_athlete.bib_number = ""
            this.c_athlete.result_time = ""
            this.c_athlete.num =  999
            this.c_athlete.status =  1
                this.c_athlete.group = this.groupsList[0]
        },

        saveAthlete() {
            let payload = {
                name: this.c_athlete.name,
                bib_number: this.c_athlete.bib_number,
                result_time: this.c_athlete.result_time,
                num: this.c_athlete.num,
                status: this.c_athlete.status,
                group_id: this.c_athlete.group.id
            };

            const config = {
                headers: { 'X-CSRFToken': CSRF_TOKEN }
            };

            if (this.c_athlete.id === 0) {
                axios.post('/api/athletes/', payload, config)
                    .then(response => {
                        this.loadStartList();
                        this.newAthlete();

                    })
                    .catch(e => {
                        alert('Грешка при създаване!');
                        console.error(e);
                    });
            } else {
                axios.put('/api/athletes/' + this.c_athlete.id + '/', payload, config)
                    .then(response => {
                        this.loadStartList();
                    })
                    .catch(e => {
                        alert('Грешка при редакция!');
                        console.error(e);
                    });
            }
        },

        deleteAthlete() {
            axios.delete('/api/athletes/' + this.c_athlete.id + '/', {
                headers: { 'X-CSRFToken': CSRF_TOKEN }
            })
                .then(response => {
                    this.loadStartList();      // Обновява списъка
                })
                .catch(e => {
                    alert('Грешка при изтриване!');
                    console.error(e);
                });
        },

        countAthletesInGroup(groupId) {
            if (!this.startList) return 0;
            return this.startList.filter(a => a.group && a.group.id === groupId).length;
        },

        focusDivById(id) {
            console.log('Опитвам да фокусирам id=',id)
            const el = document.getElementById(id);
            if (el) {
                el.scrollIntoView({ behavior: 'smooth', block: 'center' });
                el.classList.add('active-focus');
                setTimeout(() => el.classList.remove('active-focus'), 1200);
            }
        },

        checkAllFilters(){
            if (this.filter.waitingToFinish && this.filter.disqualified && this.filter.finished) {
                this.filter.waitingToFinish = false
                this.filter.disqualified = false
                this.filter.finished = false
            }
            else {
                this.filter.waitingToFinish = true
                this.filter.disqualified = true
                this.filter.finished = true
            }

        },

        fetchStartTime() {
            axios.get('/api/competition/time/')
                .then(response => {
                    this.startTime = new Date(response.data.start_time).getTime();
                    this.serverNow = new Date(response.data.server_time).getTime();
                    // Измери разликата с твоя часовник:
                    this.timeOffset = Date.now() - this.serverNow;
                    this.startTimerLoop();
                });
        },

        startTimerLoop() {
            if (this.timerInterval) clearInterval(this.timerInterval);
            this.timerInterval = setInterval(() => {
                this.timerValue = ((Date.now() - this.timeOffset) - this.startTime) / 1000;
            }, 100); // точност до 0.1 сек
        },

        startCompetition() {
            axios({
                method:'POST',
                url:'/api/competition/start/',
                headers:{
                    'X-CSRFToken':CSRF_TOKEN,
                    },
                })
                .then(response => {
                    // Можеш да опресниш start_time от отговора:
                    this.startTime = new Date(response.data.start_time);
                })
                .catch(e => alert('Грешка при стартиране!'));
        },

        startRace(){
            this.startCompetition()
            this.toggleRightPanel()
            this.sysParams.status=1
            this.showMode=2
            this.fetchStartTime()
        },

        formatTimer(seconds) {
            const totalSeconds = Math.floor(seconds);
            const deci = Math.floor((seconds - totalSeconds) * 10); // десети

            const hours = Math.floor(totalSeconds / 3600);
            const minutes = Math.floor((totalSeconds % 3600) / 60);
            const secs = totalSeconds % 60;

            // ЧЧ: без водеща, но винаги показано
            // ММ: винаги с водеща 0
            // СС: винаги с водеща 0
            return `${hours}:${minutes.toString().padStart(2, '0')}:${secs.toString().padStart(2, '0')}.${deci}`;
        },

        setStatus(num, value) {
            if(value===2){this.incrementNextNum()}
            this.editAthlete(num)
            this.c_athlete.status = value
            if (this.c_athlete.status === 3) {
                this.c_athlete.result_time = this.formatTimer(this.timerValue);
            } else if (this.c_athlete.status === 0) {
                this.c_athlete.result_time = 'DQ';
                this.c_athlete.num = '999';
            } else {
                this.c_athlete.result_time = '0:00:00.0';
            }
            if(value===2){this.c_athlete.num=this.sysParams.next_num}
            this.saveAthlete()
            console.log('this.showMode = ', this.showMode);
            if(this.showMode===2){
                console.log('сортиране по num')
                this.sortStartListByNum()
            }
            if(this.showMode===3){
                console.log('сортиране по време')
                this.sortStartListByTime()
            }
        },

        upEnable(num){
            if(num>0){
                return this.startList[num].status === this.startList[num - 1].status;
            }
            else {
                return false
            }
        },

        downEnable(num){
            if(num<(this.startList.length-1)){
                return this.startList[num].status === this.startList[num + 1].status;
            }
            else {
                return false
            }
        },

        updateStatus(newStatus) {
            axios.patch(
                '/api/competition/status/',
                { status: newStatus }
            )
                .then(response => {
                    this.sysParams.status = response.data.status;
                })
                .catch(e => {
                    alert("Грешка при запис статуса: " + (e.response?.data?.status || "неизвестна грешка"));
                });
        },

        incrementNextNum() {
            axios({
                method:'POST',
                url:'/api/competition/nextnum/inc/',
                headers:{
                    'X-CSRFToken':CSRF_TOKEN,
                },
            })
                .then(response => {
                    this.sysParams.next_num = response.data.next_num;
                })
                .catch(e => alert("Грешка при увеличаване на пореден номер: " + (e.response?.data?.detail || "неизвестна грешка")));

        },

        sortStartListByNum() {
            this.startList.sort((a, b) => a.num - b.num);
        },

        sortStartListByTime() {
            const status3 = this.startList.filter(a => a.status === 3);
            const others = this.startList.filter(a => a.status !== 3);

            // Функция за конвертиране на време в секунди
            function timeStringToSeconds(timeStr) {
                if (!timeStr || typeof timeStr !== 'string') return Infinity;
                if (timeStr === 'DQ') return Infinity;
                let [hms, ms] = timeStr.split('.');
                let [h, m, s] = hms.split(':').map(Number);
                let milliseconds = ms ? Number('0.' + ms) : 0;
                if (isNaN(h) || isNaN(m) || isNaN(s)) return Infinity;
                return h * 3600 + m * 60 + s + milliseconds;
            }

            // Сортираме само status3
            status3.sort((a, b) => timeStringToSeconds(a.result_time) - timeStringToSeconds(b.result_time));

            // Записваме обратно: първо всички с status 3 (сортирани), после другите (по стар ред)
            this.startList = [...status3, ...others];
        },

    },

    created: function(){
        this.loadSysParams()
        this.loadStartList()
        this.loadGroupsList()
    }
}

Vue.createApp(App).mount('#main')
