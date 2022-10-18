import express from 'express';
import walletMiddleware from '../middleware/walletMiddleware.js';
import * as controller from './wallet.controller.js';

const walletRouter = express.Router();

/** POST /api/auth */
walletRouter.get('/user/:userId', controller.wallet);
walletRouter.post('/sign-message', walletMiddleware.isAuth, controller.signMessage);
walletRouter.post('/mint', walletMiddleware.isAuth, controller.mint);
walletRouter.get('/user-collection-list', walletMiddleware.isAuth, controller.getUserCollectionList);
walletRouter.get('/current-id', walletMiddleware.isAuth, controller.getCurrentId);
walletRouter.get('/user-sign-list', walletMiddleware.isAuth, controller.getUserSignList);
walletRouter.get('/user-signed-list', walletMiddleware.isAuth, controller.getUserSignedList);
walletRouter.get('/doc-info/:id', walletMiddleware.isAuth, controller.getDocInfo);
walletRouter.post('/check-user-signed-status-time', walletMiddleware.isAuth, controller.checkUserSignedStatusTime);
walletRouter.post('/sign-doc', walletMiddleware.isAuth, controller.signDoc);

export default walletRouter