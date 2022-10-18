import express from 'express';

import authRouter from './auth/auth.route.js';
import userRouter from './user/user.route.js';
import auctionRoute from './auction/auction.route.js';
import collectionRoute from './collection/collection.route.js';
import walletRouter from './wallet/wallet.route.js';
import tokenMiddleware from './middleware/tokenVerifier.js'
import walletMiddleware from './middleware/walletVerifier.js'

const services = express.Router();

//dms wallet
services.use('/wallet', walletRouter);

services.use('/auth', authRouter);
services.use(tokenMiddleware.tokenVerifier, walletMiddleware.walletVerifier) // middleware to verify user credentials when user try to access resources
services.use('/user', userRouter);
services.use('/auction', auctionRoute)
services.use('/collection', collectionRoute)

export default services