import express from 'express';

import authRouter from './auth/auth.route.js';
import userRouter from './user/user.route.js';
import auctionRoute from './auction/auction.route.js';
import collectionRoute from './collection/collection.route.js';
import walletRouter from './wallet/wallet.route.js';
import tokenMiddleware from './middleware/tokenVerifier.js'
import serviceMiddleware from './middleware/serviceVerifier.js'
import documentRouter from './document/document.route.js';
import adminRouter from './admin/admin.route.js';

const services = express.Router();

//dms wallet
services.use('/wallet', walletRouter);

services.use('/auth', authRouter);
// middleware to verify user credentials when user try to access resources
services.use(tokenMiddleware.tokenVerifier, serviceMiddleware.serviceVerifier) 
services.use('/user', userRouter);
services.use('/admin', adminRouter);
services.use('/auction', auctionRoute)
services.use('/collection', collectionRoute)
services.use('/document', documentRouter)

export default services