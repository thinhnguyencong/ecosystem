import { createStore } from "vuex";
import { auth } from "./auth/auth.store";
import { user } from "./user/user.store";

const store = createStore({
  modules: {
    auth,
    user
  },
});

export default store;