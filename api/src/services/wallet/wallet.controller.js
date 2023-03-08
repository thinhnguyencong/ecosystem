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
import axios from 'axios'


export const test = async (req, res, next) => { 
	let allFiles = await File.find({}).lean()
	let arr = []
	// for (const file of allFiles) {
	// 	let config = {
	// 		method: 'post',
	// 		url: `http://10.10.1.16:5001/api/v0/pin/add?arg=${file.hash}`,
	// 		headers: { }
	// 	};
		  
	// 	let result = await axios(config)
	// 	console.log("result", result.data);
	// 	arr.push(result.data)
	// }
	var config = {
		method: 'post',
		url: 'http://10.10.1.16:5001/api/v0/pin/ls',
		headers: { }
	  };
	  
	let b= await axios(config)
	return res.status(200).json({
		data: b.data
	})
	
}

