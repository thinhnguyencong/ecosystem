import express from 'express';
import * as controller from './auction.controller.js';

const auctionRoute = express.Router();

auctionRoute.get('/auction-list', controller.getNftAuctionList);
auctionRoute.get('/auction-by-id', controller.getNftAuctionById);
auctionRoute.get('/bid-history', controller.getBidHistory);
auctionRoute.post('/create-auction', controller.createAuction);
auctionRoute.post('/place-bid', controller.placeBid);
auctionRoute.post('/settle-auction', controller.settleAuction);
auctionRoute.post('/withdraw-auction', controller.withdrawAuction);


export default auctionRoute