import express from 'express';
import * as controller from './document.controller.js';

const documentRouter = express.Router();

documentRouter.get('/get-root-folders', controller.getRootFolders);
documentRouter.get('/get-folder-by-id', controller.getFolderById);
documentRouter.get('/my-folder', controller.getFoldersInMyFolder);
documentRouter.post('/create-folder', controller.createFolder);
documentRouter.post('/share-folder', controller.shareFolder);
documentRouter.get('/shared-with-me-folder', controller.getSharedWithMeFolder);
documentRouter.get('/tree-folder', controller.getTreeFolder);

documentRouter.post('/upload-file', controller.uploadFile);
documentRouter.get('/get-all-files', controller.getAllFiles);
documentRouter.get('/get-file-by-id', controller.getFileById);

documentRouter.post('/add-comment', controller.addComment);
documentRouter.post('/sign-doc', controller.signDoc);
documentRouter.post('/reject-doc', controller.rejectDoc);
export default documentRouter