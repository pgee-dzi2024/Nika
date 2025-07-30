const App = {
    delimiters: ['[[', ']]'], // Променяме синтаксиса на [[ ]]
    data() {
        return {
            sysParams: {
                status: 0, // 0 - преди състезанието; 1 - състезание; 2 - след състезанието
                showMode: 0, // 0 - Регистрация; 1 - Старт; 2 - Състезание; 3 - Класиране
                },
            startList: [],
            groupsList: [],
            c_athlete: {
                id: 1,
                name: "Иван Петров",
                bib_number: "88",
                result_time: null,
                group: {
                    id: 3,
                    name: "Елит",
                    comment: "20-40 г"
                }
            },
        }
    },
    methods: {
    closeRegistration(){
        this.sysParams.status = 1
        this.sysParams.showMode = 1
        this.toggleRightPanel()
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
                // Обхождаме всеки запис от отговора
                response.data.forEach(param => {
                    // За всеки създаваме променлива под sysParams с ключ - името и стойност - value
                    this.sysParams[param.name] = param.value;
                });
            })
            .catch(error => {
                console.error('Error fetching system parameters:', error);
            });
        },

        loadStartList(){
        axios.get('/api/athletes/')
            .then(response => {
                this.startList = response.data
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
            this.c_athlete.group = this.startList[num].group
        },

        changeGroup(idx){
            this.c_athlete.group = this.groupsList[idx]
        },

        newAthlete(){
            this.c_athlete.id = 0
            this.c_athlete.name = ""
            this.c_athlete.bib_number = ""
            this.c_athlete.result_time = null
            this.c_athlete.group = this.groupsList[0]
        },

        saveAthlete() {
            let payload = {
                name: this.c_athlete.name,
                bib_number: this.c_athlete.bib_number,
                result_time: this.c_athlete.result_time,
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

    },

    created: function(){
        this.loadSysParams()
        this.loadStartList()
        this.loadGroupsList()
    }
}

Vue.createApp(App).mount('#main')
