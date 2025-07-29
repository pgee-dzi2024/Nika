const App = {
    delimiters: ['[[', ']]'], // Променяме синтаксиса на [[ ]]
    data() {
        return {
            status: 0, // 0 - преди състезанието; 1 - състезание; 2 - след състезанието
            showMode:0, // 0 - Регистрация; 1 - Старт; 2 - Състезание; 3 - Класиране
        }
    },
    methods: {
    closeRegistration(){
        this.status = 1
        this.showMode = 1
        this.toggleRightPanel()
        },

    toggleRightPanel(){
        $(".popup-dashboardright-btn").toggleClass("collapsed");
        $(".popup-dashboardright-section").toggleClass("collapsed");
        $(".rbt-main-content").toggleClass("area-right-expanded");
        $(".rbt-static-bar").toggleClass("area-right-expanded");
        },
    },
    created: function(){
        this.status = 0
        this.showMode = 0
    }
}

Vue.createApp(App).mount('#main')
