import Vue from "vue";

import Vuex from "vuex";

Vue.use(Vuex);
import { auth } from "./auth/auth.store";
import { user } from "./user/user.store";
import { document } from "./document/document.store";

const store = new Vuex.Store({
  modules: {
    auth,
    user,
    document
  },
});

export default store;