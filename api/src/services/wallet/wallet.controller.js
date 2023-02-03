import Web3 from "web3"
import jwt from 'jsonwebtoken';
import User from "../../models/user.model.js";
import lightwallet from "eth-lightwallet"
import fs from "fs"
import crypto from "crypto"
// import ffi from "ffi-napi"
import Folder from "../../models/folder.model.js";
import File from "../../models/file.model.js";
import Department from "../../models/department.model.js";
import { isValidObjectId } from "mongoose";
import requestPromise from "request-promise";
import _ from "underscore";
import { getWeb3 } from "../../config/web3Connection.js";
import Service from "../../models/service.model.js";


export const test = async (req, res, next) => { 

	// //   Get transactions
	// let {type, clientId} = req.query
	// try {
	// 	const web3Connection = await getWeb3()
	// 	if(!web3Connection.status) {
	// 		return res.status(500).json({msg: "Cannot connect to Web3 Provider"});
	// 	}
	// 	const web3 = web3Connection.web3
	// 	let user = await User.findOne({email: 'sieunhannguyen26@gmail.com'})
	// 	let result = [];
	// 	if(type == 'all') {
	// 		for (const service of user.servicesUsed) {
	// 			for (const transaction of service.transactions) {
	// 				let tx = await web3.eth.getTransaction(transaction)
	// 				let block = await web3.eth.getBlock(tx.blockNumber)
	// 				result.push({...tx, timestamp: block.timestamp})
	// 			}
	// 		}
			
	// 	} else if(type == 'service') {
	// 		const service = await Service.findOne({client_id: clientId})
	// 		for (const s of user.servicesUsed) {
	// 			if(service._id.valueOf() == s._id.valueOf()) {
	// 				for (const transaction of s.transactions) {
	// 					let tx = await web3.eth.getTransaction(transaction)
	// 					let block = await web3.eth.getBlock(tx.blockNumber)
	// 					result.push({...tx, timestamp: block.timestamp})
	// 				}
	// 			}
	// 		}
	// 	}else {
	// 		res.status(400).json({
	// 			msg: "Bad Request"
	// 		})
	// 	}
	// 	res.status(200).json({
	// 		result
	// 	})
	// } catch (error) {
	// 	console.log(error);
	// }
	let users = await User.find({}).lean()
	let result = []
	let children = []
	const listDept = await Department.find({}).lean()
	for (let index = 0; index < listDept.length; index++) {
		const dept = listDept[index];
		let userInDept = users.filter(u=> u.dept == dept._id.valueOf()).map(u=> ({_id: u._id.valueOf(), name: u.name}))
		children.push({
			_id: dept._id.valueOf(),
			name: dept.name,
			children: userInDept,
			isDisabled: userInDept.length ? false : true
		})
	}
	let noDeptUser = users.filter(user=> user.dept == null).map(u=> ({_id: u._id.valueOf(), name: u.name}))
	for (let index = 0; index < noDeptUser.length; index++) {
		children.push(noDeptUser[index])
	}
	result.push({
		_id: "null",
		name: "Company",
		children
	})
	return res.status(200).json({
		result
	})
	
	
}

