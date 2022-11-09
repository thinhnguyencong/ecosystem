import {authService} from './auth.service';

const initialState = {
	isAuthenticated: false,
	user: {},
	//roles: [],
	isLoading: false
};

export const auth = {
  namespaced: true,
  state: initialState,
  actions: {
    doAuthRedirect({ commit }, data) {
      commit('doAuthRedirect');
      return authService.doAuthRedirect(data)
      .then(
        res => {
          console.log("res", res);
          commit('doAuthRedirectSuccess', res);
        },
        error => {
          commit('doAuthRedirectFailure', error);
        }
      );
    },
    reAuth({ commit }) {
      commit('reAuth');
      return authService.reAuth()
      .then(
        res => {
          console.log("res", res);
          commit('reAuthSuccess', res);
        },
        error => {
          commit('reAuthFailure', error);
        }
      );
    },
    getAuthToken({ commit }, data) {
      commit('getAuthToken');
      return authService.getAuthToken(data)
      .then(
        res => {
          console.log("res", res);
          commit('getAuthTokenSuccess', res);
        },
        error => {
          commit('getAuthTokenFailure', error);
        }
      );
    },
    logout({commit}, data) {
      commit('logout');
      return authService.logout(data)
      .then(
        res => {
          console.log("res", res);
          commit('logoutSuccess', res);
        },
        error => {
          commit('logoutFailure', error);
        }
      );
    },
    findUser({commit}) {
      commit('findUser');
      return authService.findUser()
      .then(
        res => {
          console.log("res", res);
          commit('findUserSuccess', res);
        },
        error => {
          commit('findUserFailure', error);
        }
      );
    },
    
  },
  mutations: {
    // ------------------doAuthRedirect-----------------------------
    doAuthRedirect(state){
      state.isLoading = true
    },
    doAuthRedirectSuccess(state, result){
      state.isLoading = false
      window.location = result.data.url
      state.isAuthenticated = "pending"
    },
    doAuthRedirectFailure(state, error){
      state.isLoading = false
      console.log(error);
    },

    // ------------------reAuth-----------------------------
    reAuth(state) {
      state.isLoading = true;
    },
    reAuthSuccess(state, result) {
      if (result.status === 200) {
				state.isAuthenticated= true
        //state.user= result.data.user
			} else {
				window.sessionStorage.clear();
				window.location = import.meta.env.VITE_CLIENT_URL
			}
			state.isLoading = false;
    },
    reAuthFailure(state, error) {
      console.log(error);
      state.isLoading = false;
			window.sessionStorage.clear();
			window.location = import.meta.env.VITE_CLIENT_URL
    },

    // ------------------getAuthToken-----------------------------
    getAuthToken(state) {
      state.isLoading = true;
    },
    getAuthTokenSuccess(state, result) {
      const { authToken, user } = result.data;
			state.isAuthenticated= true
			state.isLoading = false;
			//state.user = user;
      window.history.replaceState({}, null, window.location.href.split('?')[0]);
			window.sessionStorage.setItem("authToken", authToken);
    },
    getAuthTokenFailure(state, error) {
      state.isLoading = false
      console.log(error);
    },

    // ------------------logout-----------------------------
    logout(state) {
      state.isLoading = true;
    },
    logoutSuccess(state, result) {
      state.isLoading = false;
      window.sessionStorage.clear();
    	window.location = result.data.url
    },
    logoutFailure(state, error) {
      state.isLoading = false
      console.log(error);
    },

    // ------------------findUser-----------------------------
    findUser(state) {
      state.isLoading = true;
    },
    findUserSuccess(state, result) {
      state.isLoading = false;
    	state.user = result.data.data
    },
    findUserFailure(state, error) {
      state.isLoading = false
      console.log(error);
    },
  }
};