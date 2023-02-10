import express from 'express';
import * as controller from './user.controller.js';

const userRouter = express.Router();

/** GET /api/user */
userRouter.get('/', controller.findUser);
userRouter.get('/info', controller.getUserInfo);
userRouter.get('/export-private-key', controller.exportPrivateKey);
userRouter.post('/transfer-token', controller.transferToken);
userRouter.get('/init-request-key', controller.initRequestKey);
userRouter.post('/request-key', controller.requestKey);
userRouter.post('/sign-message', controller.signMessage);

userRouter.get('/department-list', controller.getListDepartment);
userRouter.get('/role-list', controller.getListRole);
userRouter.get('/signer-list', controller.getListSigner);
userRouter.get('/tree-user', controller.getTreeUser);

userRouter.get('/notifications', controller.getNotifications);
export default userRouter