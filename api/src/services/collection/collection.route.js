import express from 'express';
import * as controller from './collection.controller.js';

const collectionRoute = express.Router();

collectionRoute.get('/get-nft-by-id', controller.getNftById);
collectionRoute.get('/get-collection', controller.getCollection);

export default collectionRoute