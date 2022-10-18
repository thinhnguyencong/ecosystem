import express from 'express';
import * as controller from './user.controller.js';

const userRouter = express.Router();

/** GET /api/user */
userRouter.get('/', controller.findUser);
userRouter.get('/info', controller.getUserInfo);
userRouter.get('/export-private-key', controller.exportPrivateKey);
userRouter.post('/transfer-token', controller.transferToken);

export default userRouter