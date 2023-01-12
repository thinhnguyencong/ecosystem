import Vue from 'vue'
import App from './App.vue'

import router from './router'

import store from './store'
import "bootstrap/scss/bootstrap.scss";
import * as bootstrap from 'bootstrap'
import '@mdi/font/css/materialdesignicons.css';
import Vuetify from 'vuetify'
import 'vuetify/dist/vuetify.min.css'
import "vue-toastification/dist/index.css";
// quill
import VueQuillEditor from 'vue-quill-editor'
import 'quill/dist/quill.core.css'
import 'quill/dist/quill.snow.css'
import 'quill/dist/quill.bubble.css'
// sweetalert
import VueSweetalert2 from 'vue-sweetalert2';
import 'sweetalert2/dist/sweetalert2.min.css';
// tree select
import '@riophae/vue-treeselect/dist/vue-treeselect.css'
import vClickOutside from 'v-click-outside'

dayjs.extend(window.dayjs_plugin_relativeTime);
Vue.use(VueSweetalert2);
Vue.use(Vuetify)
Vue.use(VueQuillEditor)
Vue.use(vClickOutside)
Vue.mixin({
  beforeCreate() {
    if (this.$options.watch) {
      Object.entries(this.$options.watch).forEach(([watcherKey, func]) => {
        this.$options.watch[watcherKey] = new Proxy(func, {
          apply(target, thisArg) {
            console.log(`Called watcher ${target.name} on component ${thisArg.$options.name}`);
          },
        });
      });
    }
  },
});
new Vue({
    router,
    store,
    render: (h) => h(App)
  }).$mount('#app')
