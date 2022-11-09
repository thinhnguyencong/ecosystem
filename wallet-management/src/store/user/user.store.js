import {userService} from './user.service';

const NATIVE_TOKEN = {
	name: "tBNB",
	address: "0x0000000000000000000000000000000000000000",
	type: "native"
}

const initialState = {
	publicAddress: null,
	balance: null,
	assets: [],
	tokenList: {},
	isLoading: false,
	privateKey: null
	
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
          console.log("res", res);
          commit('getUserInfoSuccess', res);
        },
        error => {
          commit('getUserInfoFailure', error);
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
  }
};