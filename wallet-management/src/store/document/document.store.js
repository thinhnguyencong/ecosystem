import {documentService} from './document.service';


const initialState = {
	rootFolders: [],
    children: [],
    ancestors: [],
    isLoading: false
	
};

export const document = {
  namespaced: true,
  state: initialState,
  actions: {
    getRootFolders({ commit }, data) {
      commit('getRootFolders');
      return documentService.getRootFolders(data)
      .then(
        res => {
          commit('getRootFoldersSuccess', res);
        },
        error => {
          commit('getRootFoldersFailure', error);
        }
      );
    },
    getFolderById({ commit }, data) {
        commit('getFolderById');
        return documentService.getFolderById(data)
        .then(
          res => {
            commit('getFolderByIdSuccess', res);
          },
          error => {
            commit('getFolderByIdFailure', error);
          }
        );
      },
  },
  mutations: {
    // ------------------getRootFolders-----------------------------
    getRootFolders(state){
        state.isLoading = true
    },
    getRootFoldersSuccess(state, result){
        state.isLoading = false;
	    state.rootFolders = result.data.rootFolders;
    },
    getRootFoldersFailure(state, error){
        state.isLoading = false
        console.log(error);
        toast.error(error.response.data.msg ? error.response.data.msg : error.message);
    },

    // ------------------getFolderById-----------------------------
    getFolderById(state){
        state.isLoading = true
    },
    getFolderByIdSuccess(state, result){
        state.isLoading = false;
        state.children = result.data.children
        state.ancestors = result.data.ancestors
        state.folder = result.data.folder
    },
    getFolderByIdFailure(state, error){
        state.isLoading = false
        toast.error(error.response.data.msg ? error.response.data.msg : error.message);
    },

  }
};