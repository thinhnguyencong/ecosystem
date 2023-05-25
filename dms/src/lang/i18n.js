import Vue from 'vue'
import VueI18n from 'vue-i18n'
import vnMess from './vn.json';
import enMess from './en.json'
Vue.use(VueI18n)

const messages = {
    vn: vnMess,
    en: enMess
}

const i18n = new VueI18n({
    locale: 'en',
    messages,
    fallbackLocale:'en'
})

export default i18n;