import {documentService} from './document.service';
import router from '../../router';
import { toast } from '../../plugins/toast';
const initialState = {
  children: [],
  ancestors: [],
  folder: {},
  isLoading: false,
  // key: {
  //   isActivated: false,
  //   keyId: "",
  //   keyAttributes: [],
  // },
  files: [],
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
      getMyFolders({ commit }) {
        commit('getMyFolders');
        return documentService.getMyFolders()
        .then(
          res => {
            commit('getMyFoldersSuccess', res);
          },
          error => {
            commit('getMyFoldersFailure', error);
          }
        );
      },
      getSharedWithMeFolders({ commit }) {
        commit('getSharedWithMeFolders');
        return documentService.getSharedWithMeFolders()
        .then(
          res => {
            commit('getSharedWithMeFoldersSuccess', res);
          },
          error => {
            commit('getSharedWithMeFoldersFailure', error);
          }
        );
      },
      createFolder({ commit }, data) {
        commit('createFolder');
        return documentService.createFolder(data)
        .then(
          res => {
            commit('createFolderSuccess', res);
          },
          error => {
            commit('createFolderFailure', error);
          }
        );
      },
      activateKey({commit}, data){
        commit('activateKey', data);
      },
      uploadFile({ commit }, data) {
        commit('uploadFile');
        return documentService.uploadFile(data)
        .then(
          res => {
            commit('uploadFileSuccess', res);
          },
          error => {
            commit('uploadFileFailure', error);
          }
        );
      },
      getAllFiles({ commit }) {
        commit('getAllFiles');
        return documentService.getAllFiles()
        .then(
          res => {
            commit('getAllFilesSuccess', res);
          },
          error => {
            commit('getAllFilesFailure', error);
          }
        );
      },
      addComment({ commit }, data) {
        commit('addComment');
        return documentService.addComment(data)
        .then(
          res => {
            commit('addCommentSuccess', res);
          },
          error => {
            commit('addCommentFailure', error);
          }
        );
        
      },
      signDoc({ commit }, data) {
        commit('signDoc');
        return documentService.signDoc(data)
        .then(
          res => {
            commit('signDocSuccess', res);
          },
          error => {
            commit('signDocFailure', error);
          }
        );
      },
      rejectDoc({ commit }, data) {
        commit('rejectDoc');
        return documentService.rejectDoc(data)
        .then(
          res => {
            commit('rejectDocSuccess', res);
          },
          error => {
            commit('rejectDocFailure', error);
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
	      state.children = result.data.data.rootFolders;
        state.folder= {}
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
        state.children = result.data.data.children
        state.ancestors = result.data.data.ancestors
        state.folder = result.data.data.folder
    },
    getFolderByIdFailure(state, error){
        state.isLoading = false
        if (error.response.status === 404) {
          toast.error(error.response.data.msg ? error.response.data.msg : error.message);
          router.push('/404')
        }
        
    },

    // ------------------getMyFolders-----------------------------
    getMyFolders(state){
      state.isLoading = true
    },
    getMyFoldersSuccess(state, result){
        state.isLoading = false;
        state.children = result.data.data.myFolders;
        state.folder = result.data.data.folder;
    },
    getMyFoldersFailure(state, error){
        state.isLoading = false
        console.log(error);
        toast.error(error.response.data.msg ? error.response.data.msg : error.message);
    },

    // ------------------getSharedWithMeFolders-----------------------------
    getSharedWithMeFolders(state){
      state.isLoading = true
    },
    getSharedWithMeFoldersSuccess(state, result){
        state.isLoading = false;
        state.children = result.data.data.sharedWithMeFolders;
    },
    getSharedWithMeFoldersFailure(state, error){
        state.isLoading = false
        console.log(error);
        toast.error(error.response.data.msg ? error.response.data.msg : error.message);
    },

    // ------------------createFolder-----------------------------
    createFolder(state){
      state.isLoading = true
    },
    createFolderSuccess(state, result){
        state.isLoading = false;
        console.log(result);
        state.children.unshift(result.data.data)
    },
    createFolderFailure(state, error){
        state.isLoading = false
        console.log(error);
        toast.error(error.response.data.msg ? error.response.data.msg : error.message);
    },

     // ------------------activateKey-----------------------------
     activateKey(state, data){
      state.key.isActivated = true
      state.key.keyId = data.key_id
      state.key.keyAttributes = data.attributes
    },

    // ------------------uploadFile-----------------------------
    uploadFile(state){
      state.isLoading = true
    },
    uploadFileSuccess(state, result){
        state.isLoading = false;
        state.folder.files.push(result.data.data)
        toast.success(result.data.msg)
    },
    uploadFileFailure(state, error){
        state.isLoading = false
        console.log(error);
        toast.error(error.response.data.msg ? error.response.data.msg : error.message);
    },

    // ------------------getAllFiles-----------------------------
    getAllFiles(state){
      state.isLoading = true
    },
    getAllFilesSuccess(state, result){
        state.isLoading = false;
        state.files = result.data.data.files;
    },
    getAllFilesFailure(state, error){
        state.isLoading = false
        console.log(error);
        toast.error(error.response.data.msg ? error.response.data.msg : error.message);
    },

    // ------------------addComment-----------------------------
    addComment(state){
      state.isLoading = true
    },
    addCommentSuccess(state, result){
        state.isLoading = false;
        if(state.files.length) state.files.find(file=> file._id == result.data.data.fileId).comments = result.data.data.comments
        if(state.folder.files.length) state.folder.files.find(file=> file._id == result.data.data.fileId).comments = result.data.data.comments
        toast.success(result.data.msg)
    },
    addCommentFailure(state, error){
        state.isLoading = false
        console.log(error);
        toast.error(error.response.data.msg ? error.response.data.msg : error.message);
    },

    // ------------------signDoc-----------------------------
    signDoc(state){
      state.isLoading = true
    },
    signDocSuccess(state, result){
        state.isLoading = false;
        toast.success(result.data.msg)
        setTimeout(() => {
          window.location.reload()
        }, 3000);
    },
    signDocFailure(state, error){
        state.isLoading = false
        console.log(error);
        toast.error(error.response.data.msg ? error.response.data.msg : error.message);
    },

    // ------------------rejectDoc-----------------------------
    rejectDoc(state){
      state.isLoading = true
    },
    rejectDocSuccess(state, result){
        state.isLoading = false;
        toast.success(result.data.msg)
        setTimeout(() => {
          window.location.reload()
        }, 3000);
    },
    rejectDocFailure(state, error){
        state.isLoading = false
        console.log(error);
        toast.error(error.response.data.msg ? error.response.data.msg : error.message);
    },
  }
};