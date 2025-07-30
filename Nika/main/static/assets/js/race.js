const App = {
    delimiters: ['[[', ']]'], // Променяме синтаксиса на [[ ]]
    data() {
        return {
            sysParams: {
                status: 0, // 0 - преди състезанието; 1 - състезание; 2 - след състезанието
                showMode: 0, // 0 - Регистрация; 1 - Старт; 2 - Състезание; 3 - Класиране
                },
            athletes: [],
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

    loadAthletes(){
        axios.get('/api/athletes/')
            .then(response => {
                // Обхождаме всеки запис от отговора
                this.athletes = response.data
                console.log(this.athletes.length)
            })
            .catch(error => {
                console.error('Error fetching system athletes:', error);
            });
        },
    },
    created: function(){
        this.loadSysParams()
        this.loadAthletes()
    }
}

Vue.createApp(App).mount('#main')
