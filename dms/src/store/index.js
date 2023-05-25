import Vue from "vue";

import Vuex from "vuex";

Vue.use(Vuex);
import { admin } from "./admin/admin.store";
import { auth } from "./auth/auth.store";
import  lang  from "./lang/lang.js";
import { user } from "./user/user.store";
import { document } from "./document/document.store";

const store = new Vuex.Store({
  modules: {
    admin,
    auth,
    user,
    lang,
    document
  },
});

export default store;