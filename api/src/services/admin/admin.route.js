import express from 'express';
import * as controller from './admin.controller.js';

const adminRouter = express.Router();

adminRouter.get('/users', controller.getAllUsers);
adminRouter.post('/create-user', controller.createUser);


export default adminRouter