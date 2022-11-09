import express from 'express';
import * as controller from './auth.controller.js';

const authRouter = express.Router();

authRouter.get('/authurl', controller.authUrl);
authRouter.post('/authtoken', controller.authToken);
authRouter.post('/reauth', controller.reAuth);
authRouter.get('/refreshToken', controller.refreshToken);
authRouter.get('/logout', controller.logout);

export default authRouter