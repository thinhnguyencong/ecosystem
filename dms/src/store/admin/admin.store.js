import {adminService} from './admin.service';
import { toast } from '../../plugins/toast';

const initialState = {
  users: [],
  isLoading: false
};

export const admin = {
  namespaced: true,
  state: initialState,
  actions: {
    getAllUsers({commit}) {
      commit('getAllUsers');
      return adminService.getAllUsers()
      .then(
        res => {
          console.log("res", res);
          commit('getAllUsersSuccess', res);
        },
        error => {
          commit('getAllUsersFailure', error);
        }
      );
    },
    createUser({commit}, data) {
      commit('createUser');
      return adminService.createUser(data)
      .then(
        res => {
          console.log("res", res);
          commit('createUserSuccess', res);
        },
        error => {
          commit('createUserFailure', error);
        }
      );
    },
  },
  mutations: {
    // ------------------getAllUsers-----------------------------
    getAllUsers(state) {
      state.isLoading = true;
    },
    getAllUsersSuccess(state, result) {
      state.isLoading = false;
    	state.users = result.data.data
    },
    getAllUsersFailure(state, error) {
      state.isLoading = false
      console.log(error);
      toast.error(error.response.data.msg ? error.response.data.msg : error.message);
    },

    // ------------------createUser-----------------------------
    createUser(state) {
      state.isLoading = true;
    },
    createUserSuccess(state, result) {
      state.isLoading = false;
      console.log(result.data.data);
      toast.success(result.data.msg)
    },
    createUserFailure(state, error) {
      state.isLoading = false
      console.log(error);
      toast.error(error.response.data.msg ? error.response.data.msg : error.message);
    },
  }
};