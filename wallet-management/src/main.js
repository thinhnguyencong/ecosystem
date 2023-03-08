import Vue from 'vue'
import App from './App.vue'

import router from './router'

import store from './store'
import "bootstrap/scss/bootstrap.scss";
import * as bootstrap from 'bootstrap'
import '@mdi/font/css/materialdesignicons.css';

import "vue-toastification/dist/index.css";
import Jazzicon from 'vue-jazzicon';

Vue.component('jazzicon', Jazzicon); // or Vue.component(Jazzicon.name, Jazzicon);
dayjs.extend(window.dayjs_plugin_relativeTime);
// Vue.use(Vuetify)
// Vue.use(Toast, options);
new Vue({
    router,
    store,
    render: (h) => h(App)
  }).$mount('#app')
