import {documentService} from './document.service';
import router from '../../router';
import { toast } from '../../plugins/toast';
import { auth } from '../auth/auth.store';
const initialState = {
  children: [],
  ancestors: [],
  folder: {},
  isLoading: false,
  files: [],
  file: {
    comments: [],
    isLoading: false,
    isLoadingComment: false,
  },
  fileStatusList: {
    isLoading: false,
    isLoadingSign: false,
    isLoadingReject: false,
  },
  treeFolder: {},
  pendingDocs: [],
  signedDocs: [],
  recentFolders: [],
  recentFiles: []
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
      editFolder({ commit }, data) {
        commit('editFolder');
        return documentService.editFolder(data)
        .then(
          res => {
            commit('editFolderSuccess', {res, data});
          },
          error => {
            commit('editFolderFailure', error);
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
      editFile({ commit }, data) {
        commit('editFile');
        return documentService.editFile(data)
        .then(
          res => {
            commit('editFileSuccess', {res, data});
          },
          error => {
            commit('editFileFailure', error);
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
            commit('signDocSuccess', {res, data});
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
            commit('rejectDocSuccess', {res, data});
          },
          error => {
            commit('rejectDocFailure', error);
          }
        );
      },
      getTreeFolder({ commit }, data) {
        commit('getTreeFolder');
        return documentService.getTreeFolder(data)
        .then(
          res => {
            commit('getTreeFolderSuccess', {res, data});
          },
          error => {
            commit('getTreeFolderFailure', error);
          }
        );
      },
      getFileById({ commit }, data) {
        commit('getFileById');
        return documentService.getFileById(data)
        .then(
          res => {
            commit('getFileByIdSuccess', res);
          },
          error => {
            commit('getFileByIdFailure', error);
          }
        );
      },
      getFileStatusById({ commit }, data) {
        commit('getFileStatusById', data);
        return documentService.getFileStatusById(data)
        .then(
          res => {
            console.log(data);
            commit('getFileStatusByIdSuccess', {res, data});
          },
          error => {
            commit('getFileStatusByIdFailure', {error, data});
          }
        );
      },
      addCommentRealtime({commit}, data){
        commit('addCommentRealtime', data);
      },
      signDocRealtime({commit}, data){
        commit('signDocRealtime', data);
      },
      reviewDocRealtime({commit}, data){
        commit('reviewDocRealtime', data);
      },
      rejectSignDocRealtime({commit}, data){
        commit('rejectSignDocRealtime', data);
      },
      rejectReviewDocRealtime({commit}, data){
        commit('rejectReviewDocRealtime', data);
      },
      getRecentDocuments({ commit }) {
        commit('getRecentDocuments');
        return documentService.getRecentDocuments()
        .then(
          res => {
            commit('getRecentDocumentsSuccess', res);
          },
          error => {
            commit('getRecentDocumentsFailure', error);
          }
        );
      },
      
      
  },
  mutations: {
    // ------------------getRootFolders-----------------------------
    getRootFolders(state){
        if(!state.isLoading) {
          state.isLoading = true
        }
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
        if(!state.isLoading) {
          state.isLoading = true
          state.children = []
          state.ancestors = []
          state.folder = {}
        }
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
      if(!state.isLoading) {
          state.isLoading = true
        }
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
      if(!state.isLoading) {
          state.isLoading = true
        }
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
      if(!state.isLoading) {
          state.isLoading = true
        }
    },
    createFolderSuccess(state, result){
        state.isLoading = false;
        console.log(result);
        state.children.unshift(result.data.data)
        toast.success(result.data.msg)
    },
    createFolderFailure(state, error){
        state.isLoading = false
        console.log(error);
        toast.error(error.response.data.msg ? error.response.data.msg : error.message);
    },

    // ------------------editFolder-----------------------------
    editFolder(state){
      if(!state.isLoading) {
        state.isLoading = true
      }
    },
    editFolderSuccess(state, result){
        state.isLoading = false;
        console.log(result);
        if(result.data.type == 'rename') {
          state.children[state.children.findIndex(el => el._id === result.data.data.folderId)].name = result.data.data.name
        }
        toast.success(result.res.data.msg)
    },
    editFolderFailure(state, error){
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
      if(!state.isLoading) {
        state.isLoading = true
      }
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

    // ------------------editFile-----------------------------
    editFile(state){
      if(!state.isLoading) {
        state.isLoading = true
      }
    },
    editFileSuccess(state, result){
        state.isLoading = false;
        console.log(result);
        if(result.data.type == 'rename') {
          state.children[state.children.findIndex(el => el._id === result.data.data.folderId)].name = result.data.data.name
        }
        toast.success(result.res.data.msg)
    },
    editFileFailure(state, error){
        state.isLoading = false
        console.log(error);
        toast.error(error.response.data.msg ? error.response.data.msg : error.message);
    },

    // ------------------getAllFiles-----------------------------
    getAllFiles(state){
      if(!state.isLoading) {
          state.isLoading = true
        }
    },
    getAllFilesSuccess(state, result){
        state.isLoading = false;
        state.files = result.data.data.files;
        state.pendingDocs = result.data.data.pendingDocs
        state.signedDocs = result.data.data.signedDocs
    },
    getAllFilesFailure(state, error){
        state.isLoading = false
        console.log(error);
        toast.error(error.response.data.msg ? error.response.data.msg : error.message);
    },

    // ------------------addComment-----------------------------
    addComment(state){
      state.file.isLoadingComment = true
    },
    addCommentSuccess(state, result){
        state.file.isLoadingComment = false
        state.file.comments= [...[result.data.data.comment], ...state.file.comments]
        toast.success(result.data.msg)
    },
    addCommentFailure(state, error){
        state.file.isLoadingComment = false
        console.log(error);
        toast.error(error.response.data.msg ? error.response.data.msg : error.message);
    },

    // ------------------signDoc-----------------------------
    signDoc(state){
      state.fileStatusList.isLoadingSign = true
    },
    signDocSuccess(state, result){
      state.fileStatusList[result.data.fileId] = {
        ...state.fileStatusList[result.data.fileId],
        canReject: false,
        canReview: false,
        canSign: false,
      }
      state.fileStatusList.isLoadingSign = false
      if (result.data.type == "review") {
          state.fileStatusList[result.data.fileId].statusDetail.reviewerList.find(reviewer => reviewer.address == auth.state.user.publicAddress).status = "reviewed"
          state.fileStatusList[result.data.fileId].statusDetail.reviewerList.find(reviewer => reviewer.address == auth.state.user.publicAddress).time = Math.floor(Date.now()/1000) 
          if(state.fileStatusList[result.data.fileId].statusDetail.reviewerList.map(reviewer => reviewer.status).every(status => status === "reviewed")) {
            state.fileStatusList[result.data.fileId].status = "waiting-to-sign"
          }
      }
      if (result.data.type == "sign") {
        state.fileStatusList[result.data.fileId].statusDetail.signerList.find(signer => signer.address == auth.state.user.publicAddress).status = "signed"
        state.fileStatusList[result.data.fileId].statusDetail.signerList.find(signer => signer.address == auth.state.user.publicAddress).time = Math.floor(Date.now()/1000)
        console.log("state.fileStatusList[result.data.fileId].statusDetail.signerList", state.fileStatusList[result.data.fileId].statusDetail.signerList, state.fileStatusList[result.data.fileId].statusDetail.signerList.map(signer => signer.status).every(status => status === "signed"));
        if(state.fileStatusList[result.data.fileId].statusDetail.signerList.map(signer => signer.status).every(status => status === "signed")) {
          state.fileStatusList[result.data.fileId].status = "signed"
        }
      }
      toast.success(result.res.data.msg)
    },
    signDocFailure(state, error){
        state.fileStatusList.isLoadingSign = false
        console.log(error);
        toast.error(error.response.data.msg ? error.response.data.msg : error.message);
    },

    // ------------------rejectDoc-----------------------------
    rejectDoc(state){
      state.fileStatusList.isLoadingReject = true
    },
    rejectDocSuccess(state, result){
      state.fileStatusList[result.data.fileId] = {
        ...state.fileStatusList[result.data.fileId],
        canReject: false,
        canReview: false,
        canSign: false,
      }
      state.fileStatusList.isLoadingReject = false
      if (result.data.type == "review") {
        state.fileStatusList[result.data.fileId].statusDetail.reviewerList.find(reviewer => reviewer.address == auth.state.user.publicAddress).status = "rejected"
        state.fileStatusList[result.data.fileId].statusDetail.reviewerList.find(reviewer => reviewer.address == auth.state.user.publicAddress).time = Math.floor(Date.now()/1000) 
        state.fileStatusList[result.data.fileId].status = "rejected"
      }
      if (result.data.type == "sign") {
        state.fileStatusList[result.data.fileId].statusDetail.signerList.find(signer => signer.address == auth.state.user.publicAddress).status = "rejected"
        state.fileStatusList[result.data.fileId].statusDetail.signerList.find(signer => signer.address == auth.state.user.publicAddress).time = Math.floor(Date.now()/1000)
        state.fileStatusList[result.data.fileId].status = "rejected"
      }
      toast.success(result.res.data.msg)
    },
    rejectDocFailure(state, error){
      state.fileStatusList.isLoadingReject = false
      console.log(error);
      toast.error(error.response.data.msg ? error.response.data.msg : error.message);
    },

    // ------------------getTreeFolder-----------------------------
    getTreeFolder(state){
      if(!state.isLoading) {
          state.isLoading = true
        }
    },
    getTreeFolderSuccess(state, result){
        state.isLoading = false;
        if(result.data.type == "my-folder") {
          state.treeFolder['my-folder'] = result.res.data.data
        }else if(result.data.type == "folder") {
          state.treeFolder[result.data.folderId] = result.res.data.data
        }
    },
    getTreeFolderFailure(state, error){
        state.isLoading = false
        console.log(error);
        toast.error(error.response.data.msg ? error.response.data.msg : error.message);
    },

    // ------------------getFileById-----------------------------
    getFileById(state){
      state.file = {
        isLoading: true,
        isLoadingComment: false,
      }
    },
    getFileByIdSuccess(state, result){
        state.file = {
          ...state.file,
          ...result.data.data.file,
          isLoading: false,
        }
    },
    getFileByIdFailure(state, error){
        state.file.isLoading = false
        console.log(error);
        if (error.response.status === 404) {
          toast.error(error.response.data.msg ? error.response.data.msg : error.message);
          router.push('/404')
        } else {
          toast.error(error.response.data.msg ? error.response.data.msg : error.message);
        }
    },
    // ------------------getFileStatusById-----------------------------
    getFileStatusById(state, data){
      state.fileStatusList[data.id] = {
        ... state.fileStatusList[data.id],
        canReject: false,
        canReview: false,
        canSign: false,
      }
      state.fileStatusList.isLoading = true
    },
    getFileStatusByIdSuccess(state, result){
      console.log(result);
      state.fileStatusList[result.data.id] = {
        ...result.res.data.data.fileStatus,
      }
      state.fileStatusList.isLoading = false
    },
    getFileStatusByIdFailure(state, result){
      console.log(result.error);
      state.fileStatusList.isLoading = false
      if (result.error.response.status === 404) {
        toast.error(result.error.response.data.msg ? result.error.response.data.msg : result.error.message);
        router.push('/404')
      } else {
        console.error(result.error.response.data.msg ? result.error.response.data.msg : result.error.message);
        //toast.error(result.error.response.data.msg ? result.error.response.data.msg : result.error.message);
      }
    },
    addCommentRealtime(state, data){
      state.file.comments= [...[data.comment], ...state.file.comments]
    },
    reviewDocRealtime(state, data){
      state.fileStatusList[data.fileId].statusDetail.reviewerList.find(reviewer => reviewer.address == data.publicAddress).status = "reviewed"
      state.fileStatusList[data.fileId].statusDetail.reviewerList.find(reviewer => reviewer.address == data.publicAddress).time = Math.floor(Date.now()/1000) 
      if(state.fileStatusList[data.fileId].statusDetail.reviewerList.map(reviewer => reviewer.status).every(status => status === "reviewed")) {
        state.fileStatusList[data.fileId].status = "waiting-to-sign"
      }
    },
    rejectReviewDocRealtime(state, data){
      state.fileStatusList[data.fileId].statusDetail.reviewerList.find(reviewer => reviewer.address == data.publicAddress).status = "rejected"
      state.fileStatusList[data.fileId].statusDetail.reviewerList.find(reviewer => reviewer.address == data.publicAddress).time = Math.floor(Date.now()/1000) 
      state.fileStatusList[data.fileId].status = "rejected"
    },
    signDocRealtime(state, data){
      state.fileStatusList[data.fileId].statusDetail.signerList.find(signer => signer.address == data.publicAddress).status = "signed"
      state.fileStatusList[data.fileId].statusDetail.signerList.find(signer => signer.address == data.publicAddress).time = Math.floor(Date.now()/1000)
      if(state.fileStatusList[data.fileId].statusDetail.signerList.map(signer => signer.status).every(status => status === "signed")) {
        state.fileStatusList[data.fileId].status = "signed"
      }
    },
    rejectSignDocRealtime(state, data){
      state.fileStatusList[data.fileId].statusDetail.signerList.find(signer => signer.address == data.publicAddress).status = "rejected"
      state.fileStatusList[data.fileId].statusDetail.signerList.find(signer => signer.address == data.publicAddress).time = Math.floor(Date.now()/1000)
      state.fileStatusList[data.fileId].status = "rejected"
    },
    // ------------------getRecentDocuments-----------------------------
    getRecentDocuments(state, data){
      if(!state.isLoading) {
        state.isLoading = true
      }
    },
    getRecentDocumentsSuccess(state, result){
      state.isLoading = false;
      state.recentFiles = result.data.data.recentFiles;

    },
    getRecentDocumentsFailure(state, result){
      console.log(result.error);
      
    },
  },
};