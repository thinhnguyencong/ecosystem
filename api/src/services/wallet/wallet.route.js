import express from 'express';
import * as controller from './wallet.controller.js';

const walletRouter = express.Router();

walletRouter.get('/test', controller.test);

export default walletRouter