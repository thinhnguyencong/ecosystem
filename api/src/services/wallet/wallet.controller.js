import Web3 from "web3"
import jwt from 'jsonwebtoken';
import User from "../../models/user.model.js";
import lightwallet from "eth-lightwallet"
import fs from "fs"
import crypto from "crypto"
// import ffi from "ffi-napi"
import Folder from "../../models/folder.model.js";
import File from "../../models/file.model.js";
import { isValidObjectId } from "mongoose";
import requestPromise from "request-promise";
import _ from "underscore";
import { getWeb3 } from "../../config/web3Connection.js";
import Service from "../../models/service.model.js";


export const test = async (req, res, next) => { 
	// const web3 = new Web3(
	// 	new Web3.providers.HttpProvider(process.env.WEB3_PROVIDER)
	// );
	// // let userEmail = "hr_manager@dms-grooo.com.vn"
	// // let user = await User.findOne({email: userEmail})
	// // const {publicAddress, keystore} = user

	// //người ký
	// const publicAddress = "0x55fC5fD1d569Da536b15e3d9258aC61731b8699D"
	// const address = "0xD4Fe7aaCA926ec860f52db695782e8fD1E43415A"

	// //người tạo
	// 	const creator = "0x09876c96F80247184921f24547c861c99083f602"
	// const dmsContract =  new web3.eth.Contract(DMS.abi, NFT_ADDRESS);
	// let arr= [];
	// // for(let i=1; i<=3; i++) {
	// // 	let info = await dmsContract.methods.getDocInfo(i).call({ from: publicAddress });
	// // 	arr.push({item: info})
	// // }

	// // những tài liệu mà user có public address chưa kí
	// let x = await dmsContract.methods.getUserNotSignedList().call({ from: publicAddress });

	// // // văn bản đã được ký của người tạo
	// // let y = await dmsContract.methods.getUserSignedDoc().call({ from: publicAddress });

	// // // những tài liệu đã kí của publicaddress
	// // let z = await dmsContract.methods.getUserSignedList().call({ from: publicAddress });

	// // list: do người này đã làm gì (kí, reject)
	// // doc: của người này (đã được kí, đã bị reject)


	// // chưa hiểu 0,1,2 là gì
	// let a = await dmsContract.methods.checkUserSignedStatus(1, "0x3b323d3199bdd5b030a21009647a62d869b950ee").call({ from: "0x3b323d3199bdd5b030a21009647a62d869b950ee" });

	// // tất cả doc của người này 
	// let b = await dmsContract.methods.getUserCollectionList(creator).call({ from: creator });
	// let root = []

	// var getDescendants = async function(id,root) {
	// 	let children = await Folder.find({parent: id}).lean();
	// 	children = children.map(x=> ({...x, _id: x._id.valueOf()}))
	// 	// console.log('children', children);
	// 	children.forEach(function(child) {
	// 		// console.log('child', child);
	// 		root.push({
	// 			id: child._id,
	// 			name: child.name
	// 		})
	// 		// root[child._id] = {"name":child.name};
	// 		console.log("root", root);
	// 		if(child.parent == null) {
	// 			console.log(root);
	// 			return
	// 		}
	// 		getDescendants(child._id,root[child._id]);
	// 	});
	// };
	
	// let x = await getDescendants ("63a004e8413df1816c2274e4",root);
	// console.log(root);
	let {type, clientId} = req.query
	try {
		const web3Connection = await getWeb3()
		if(!web3Connection.status) {
			return res.status(500).json({msg: "Cannot connect to Web3 Provider"});
		}
		const web3 = web3Connection.web3
		let user = await User.findOne({email: 'sieunhannguyen26@gmail.com'})
		let result = [];
		if(type == 'all') {
			for (const service of user.servicesUsed) {
				for (const transaction of service.transactions) {
					let tx = await web3.eth.getTransaction(transaction)
					let block = await web3.eth.getBlock(tx.blockNumber)
					result.push({...tx, timestamp: block.timestamp})
				}
			}
			
		} else if(type == 'service') {
			const service = await Service.findOne({client_id: clientId})
			for (const s of user.servicesUsed) {
				if(service._id.valueOf() == s._id.valueOf()) {
					for (const transaction of s.transactions) {
						let tx = await web3.eth.getTransaction(transaction)
						let block = await web3.eth.getBlock(tx.blockNumber)
						result.push({...tx, timestamp: block.timestamp})
					}
				}
			}
		}else {
			res.status(400).json({
				msg: "Bad Request"
			})
		}
		res.status(200).json({
			result
		})
	} catch (error) {
		console.log(error);
	}
	
	
	
}

