import {userService} from './user.service';
import { toast } from '../../plugins/toast';
const NATIVE_TOKEN = {
	name: "tBNB",
	address: "0x0000000000000000000000000000000000000000",
	type: "native"
}

const initialState = {
	publicAddress: null,
  username: null,
	balance: null,
	assets: [],
	tokenList: {},
	isLoading: false,
	privateKey: null,
	nonce: null,
  signature: null,
  encryptedKey: null,
  deptList: [],
  roleList: [],
  signerList: []
};

export const user = {
  namespaced: true,
  state: initialState,
  actions: {
    getUserInfo({ commit }, data) {
      commit('getUserInfo');
      return userService.getUserInfo(data)
      .then(
        res => {
          commit('getUserInfoSuccess', res);
        },
        error => {
          commit('getUserInfoFailure', error);
        }
      );
    },
    transferToken({ commit }, data) {
      commit('transferToken');
      return userService.transferToken(data)
      .then(
        res => {
          commit('transferTokenSuccess', res);
        },
        error => {
          commit('transferTokenFailure', error);
        }
      );
    },
    getAsset({commit}){
      commit('getAsset');
    },
    addAsset({commit}, data){
      commit('addAsset', data);
    },
    removeAsset({commit}, data){
      commit('removeAsset', data);
    },
    initRequestKey({ commit }) {
      commit('initRequestKey');
      return userService.initRequestKey()
      .then(
        res => {
          commit('initRequestKeySuccess', res);
        },
        error => {
          commit('initRequestKeyFailure', error);
        }
      );
    },
    requestKey({ commit }, data) {
      commit('requestKey');
      return userService.requestKey(data)
      .then(
        res => {
          commit('requestKeySuccess', res);
        },
        error => {
          commit('requestKeyFailure', error);
        }
      );
    },
    signMessage({ commit }, data) {
      commit('signMessage');
      return userService.signMessage(data)
      .then(
        res => {
          commit('signMessageSuccess', res);
        },
        error => {
          commit('signMessageFailure', error);
        }
      );
    },
    getDeptList({ commit }) {
      commit('getDeptList');
      return userService.getDeptList()
      .then(
        res => {
          commit('getDeptListSuccess', res);
        },
        error => {
          commit('getDeptListFailure', error);
        }
      );
    },
    getRoleList({ commit }) {
      commit('getRoleList');
      return userService.getRoleList()
      .then(
        res => {
          commit('getRoleListSuccess', res);
        },
        error => {
          commit('getRoleListFailure', error);
        }
      );
    },
    getSignerList({ commit }) {
      commit('getSignerList');
      return userService.getSignerList()
      .then(
        res => {
          commit('getSignerListSuccess', res);
        },
        error => {
          commit('getSignerListFailure', error);
        }
      );
    },
  },
  mutations: {
    // ------------------getUserInfo-----------------------------
    getUserInfo(state){
      state.isLoading = true
    },
    getUserInfoSuccess(state, result){
      state.isLoading = false;
			state.publicAddress = result.data.publicAddress;
			state.balance = result.data.balance
			state.assets = result.data.assets
    },
    getUserInfoFailure(state, error){
      state.isLoading = false
      console.log(error);
      toast.error(error.response.data.msg ? error.response.data.msg : error.message);
      toast.error(error.response.data.msg ? error.response.data.msg : error.message);
    },
    getAsset(){
      let tokenList = JSON.parse(localStorage.getItem('tokenList'))
			if(!tokenList) {
				localStorage.setItem('tokenList', JSON.stringify({
					[NATIVE_TOKEN.address]:  {
						name: NATIVE_TOKEN.name,
						type: NATIVE_TOKEN.type
					}
				}));
				
			}
    },
    addAsset(state, data){
      console.log(data);
			let tokenList = JSON.parse(localStorage.getItem('tokenList'))
			let newList = {
				...tokenList,
				[data.address]: {
					name: data.name,
					type: "utility"
				}
			}
			localStorage.setItem('tokenList', JSON.stringify(newList));
    },
    removeAsset(state, data){
      console.log(data)
			let tokenList = JSON.parse(localStorage.getItem('tokenList'))
			delete tokenList[data]
			localStorage.setItem('tokenList', JSON.stringify(tokenList));
    },

    // ------------------transferToken-----------------------------
    transferToken(state){
      state.isLoading = true
    },
    transferTokenSuccess(state, result){
      state.isLoading = false;
			alert("Success!! Your transaction hash is: " + result.data.transactionHash)
			window.location.reload()
    },
    transferTokenFailure(state, error){
      state.isLoading = false
      console.log(error);
      toast.error(error.response.data.msg ? error.response.data.msg : error.message);
    },

    // ------------------initRequestKey-----------------------------
    initRequestKey(state){
      state.isLoading = true
    },
    initRequestKeySuccess(state, result){
      state.isLoading = false;
			state.nonce = result.data.data.nonce;
      state.publicAddress= result.data.data.publicAddress
      state.username= result.data.data.username
    },
    initRequestKeyFailure(state, error){
      state.isLoading = false
      console.log(error);
      toast.error(error.response.data.msg ? error.response.data.msg : error.message);
    },

    // ------------------requestKey-----------------------------
    requestKey(state){
      state.isLoading = true
    },
    requestKeySuccess(state, result){
      state.isLoading = false;
      state.encryptedKey= result.data.data.encryptedKey
    },
    requestKeyFailure(state, error){
      state.isLoading = false
      console.log(error);
      toast.error(error.response.data.msg ? error.response.data.msg : error.message);
    },

    // ------------------signMessage-----------------------------
    signMessage(state){
      state.isLoading = true
    },
    signMessageSuccess(state, result){
      state.isLoading = false;
      state.signature = result.data.data.signature;
    },
    signMessageFailure(state, error){
      state.isLoading = false
      console.log(error);
      toast.error(error.response.data.msg ? error.response.data.msg : error.message);
    },

    // ------------------getDeptList-----------------------------
    getDeptList(state){
      state.isLoading = true
    },
    getDeptListSuccess(state, result){
      state.isLoading = false;
      state.deptList = result.data.data;
    },
    getDeptListFailure(state, error){
      state.isLoading = false
      console.log(error);
      toast.error(error.response.data.msg ? error.response.data.msg : error.message);
    },

    // ------------------getRoleList-----------------------------
    getRoleList(state){
      state.isLoading = true
    },
    getRoleListSuccess(state, result){
      state.isLoading = false;
      state.roleList = result.data.data;
    },
    getRoleListFailure(state, error){
      state.isLoading = false
      console.log(error);
      toast.error(error.response.data.msg ? error.response.data.msg : error.message);
    },

    // ------------------getSignerList-----------------------------
    getSignerList(state){
      state.isLoading = true
    },
    getSignerListSuccess(state, result){
      state.isLoading = false;
      state.signerList = result.data.data;
    },
    getSignerListFailure(state, error){
      state.isLoading = false
      console.log(error);
      toast.error(error.response.data.msg ? error.response.data.msg : error.message);
    },
  }
};