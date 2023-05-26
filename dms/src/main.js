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

import HighchartsVue from 'highcharts-vue'
import Highcharts from 'highcharts'

import drilldown from 'highcharts/modules/drilldown'
import exporting from 'highcharts/modules/exporting'
import exportData from 'highcharts/modules/export-data'
import accessibility from 'highcharts/modules/accessibility'


import i18n from './lang/i18n'





drilldown(Highcharts)
exporting(Highcharts)
exportData(Highcharts)
accessibility(Highcharts)





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
import {en} from "vuetify/es5/locale";



dayjs.extend(window.dayjs_plugin_relativeTime);
Vue.use(VueSweetalert2);
Vue.use(Vuetify)
Vue.use(VueQuillEditor)
Vue.use(vClickOutside)
Vue.use(HighchartsVue)
Vue.config.productionTip = false;
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


const app = new Vue({
    router,
    store,
    i18n,
    render: (h) => h(App)
  }).$mount('#app');

store.$app = app;
export default app;
