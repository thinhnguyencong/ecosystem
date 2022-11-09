import express from 'express';
import walletMiddleware from '../middleware/walletMiddleware.js';
import * as controller from './wallet.controller.js';

const walletRouter = express.Router();

walletRouter.get('/test', controller.test);
walletRouter.get('/init-request-key', controller.initRequestKey);
walletRouter.post('/request-key', controller.requestKey);

walletRouter.get('/user/:userId', controller.wallet);
walletRouter.post('/sign-message', controller.signMessage);
walletRouter.post('/mint', controller.mint);
walletRouter.get('/user-collection-list', controller.getUserCollectionList);
walletRouter.get('/current-id', controller.getCurrentId);
walletRouter.get('/user-sign-list', controller.getUserSignList);
walletRouter.get('/user-signed-list', controller.getUserSignedList);
walletRouter.get('/doc-info/:id', controller.getDocInfo);
walletRouter.post('/check-user-signed-status-time', controller.checkUserSignedStatusTime);
walletRouter.post('/sign-doc', controller.signDoc);

export default walletRouter