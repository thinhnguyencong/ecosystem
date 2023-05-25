import app from '@/main.js'

const mutations = {
    SET_LANG(state,payload) {
        app.$i18n.locale = payload;
    }
};

const action = {
    setLang({commit}, payload) {
        commit('SET_LANG',payload)
    }
};

const lang = {
    namespace:true,
    action,
    mutations
};

export default lang;