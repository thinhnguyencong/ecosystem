import Vue from 'vue'
import App from './App.vue'

import router from './router'

import store from './store'
import "bootstrap/scss/bootstrap.scss";
import * as bootstrap from 'bootstrap'
import '@mdi/font/css/materialdesignicons.css';
import Vuetify from 'vuetify'
import 'vuetify/dist/vuetify.min.css'
import Toast from "vue-toastification";
import "vue-toastification/dist/index.css";
import VueQuillEditor from 'vue-quill-editor'
// require styles
import 'quill/dist/quill.core.css'
import 'quill/dist/quill.snow.css'
import 'quill/dist/quill.bubble.css'
import VueSweetalert2 from 'vue-sweetalert2';

// If you don't need the styles, do not connect
import 'sweetalert2/dist/sweetalert2.min.css';

Vue.use(VueSweetalert2);
Vue.use(Vuetify)
Vue.use(VueQuillEditor)
// Vue.use(Toast, options);
new Vue({
    router,
    store,
    render: (h) => h(App)
  }).$mount('#app')
