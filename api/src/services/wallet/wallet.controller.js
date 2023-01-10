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
const NFT_ADDRESS = "0x5281c02A833a491B764a704D3907373B20E7F482"

const web3 = new Web3(
	new Web3.providers.HttpProvider(process.env.WEB3_PROVIDER)
);
const DMS = JSON.parse(fs.readFileSync("src/abis/DMS.json"));
const dmsContract =  new web3.eth.Contract(DMS.abi, NFT_ADDRESS);
export const wallet = async (req, res, next) => {
	try {
		
		let userEmail = "thinhnc"
		console.log("email", userEmail)
		if(userEmail !== "null" && userEmail) {
			let user = await User.findOne({email: userEmail})
			// console.log(user)
			if(user) {
				const userData = {
					email: user.email,
					publicAddress: user.publicAddress
				}
				const token = jwt.sign(userData, process.env.TOKEN_SECRET);
				return res.status(200).json({account: user.publicAddress, jwt: token })
			}else {
				let randomSeed = lightwallet.keystore.generateRandomSeed();
				console.log("seed", randomSeed)
				lightwallet.keystore.createVault({
					password: process.env.SECRET,
					seedPhrase: randomSeed,
					//random salt
					hdPathString: 'm/0\'/0\'/0\''
				}, function (err, ks) {
					if (err) throw err;
					ks.keyFromPassword(process.env.SECRET, async function (err, pwDerivedKey) {
						if (err) throw err;
						ks.generateNewAddress(pwDerivedKey, 1)
						// console.log("ks", ks)
						let addr = ks.getAddresses();
						let privateKey = ks.exportPrivateKey(addr[0], pwDerivedKey)
						console.log("privatekey", privateKey)
						const newUser = new User({
							email: userEmail,
							keystore: ks.serialize(),
							publicAddress: addr[0].toLowerCase() 
						});
						newUser.save(async (err, addedUser) => {
							if (err) throw err;
							const userData = {
								email: addedUser.email,
								publicAddress: addedUser.publicAddress
							}
							const token = jwt.sign(userData, process.env.TOKEN_SECRET);
							return res.status(200).json({account: addedUser.publicAddress, jwt: token })
						})
						
					})
				})
			}
		} else {
			throw new Error("User id is not provided")
		}
		
	} catch (error) {
		return res.status(500)
	}
}

export const signMessage = async (req, res, next) => { 
	// let {message, ethKey} = req.body.data
	console.log(req.body)
	let {message} = req.body
	let userEmail = "thinhnc"
	let user = await User.findOne({email: userEmail})
	const {publicAddress, keystore} = user
	const ks = lightwallet.keystore.deserialize(keystore)
	ks.keyFromPassword(process.env.SECRET, async function (err, pwDerivedKey) {
		ks.generateNewAddress(pwDerivedKey, 1)
		if (err) throw err;
		let privateKey = ks.exportPrivateKey(ks.getAddresses()[0], pwDerivedKey)
		let sig = web3.eth.accounts.sign(message, privateKey)
		console.log(sig)
		return res.status(200).json({signature: sig.signature})
	})

	
}

export const mint = async (req, res, next) => { 
	// let {message, ethKey} = req.body.data
	const web3Connection = await getWeb3()
	if(!web3Connection.status) {
		return res.status(500).json({msg: "Cannot connect to Web3 Provider"});
	}
	const web3 = web3Connection.web3
	console.log(req.body)
	let {tokenURI, signerList} = req.body
	let userEmail = "thinhnc"
	let user = await User.findOne({email: userEmail})
	const {publicAddress, keystore} = user
	const ks = lightwallet.keystore.deserialize(keystore)
	ks.keyFromPassword(process.env.SECRET, async function (err, pwDerivedKey) {
		ks.generateNewAddress(pwDerivedKey, 1)
		if (err) throw err;
		let privateKey = ks.exportPrivateKey(publicAddress, pwDerivedKey)
		const nonce = await web3.eth.getTransactionCount(publicAddress)
		const transaction = {
			from: publicAddress,
			to: NFT_ADDRESS,
			value: "0x0",
			gas: await dmsContract.methods.mintNFT(publicAddress, tokenURI, signerList).estimateGas({ from: publicAddress }),
			nonce: nonce,
			data: dmsContract.methods.mintNFT(publicAddress, tokenURI, signerList).encodeABI(),
		};
		const signedTx = await web3.eth.accounts.signTransaction(transaction, privateKey);
		web3.eth.sendSignedTransaction(signedTx.rawTransaction, function(error, hash) {
			console.log("The hash of your transaction is: ", hash);
			if(!error) {
				return res.json({
					transactionHash: signedTx.transactionHash, msg: "Mint successfully!"
				})
			} else {
				console.log("Error when send transaction to the network", error);
				throw new Error(error)
			}
		})
	})

	
}

export const getUserCollectionList = async (req, res, next) => { 
	const web3 = new Web3(
		new Web3.providers.HttpProvider(process.env.WEB3_PROVIDER)
	);
	const dmsContract =  new web3.eth.Contract(DMS.abi, NFT_ADDRESS);
	let userEmail = "nguyenln"
	let user = await User.findOne({email: userEmail})
	const {publicAddress} = user
	const userList = await dmsContract.methods.getUserCollectionList().call({ from: publicAddress });
	res.status(200).json({userList: userList})
	
}

export const getCurrentId = async (req, res, next) => { 
	const web3 = new Web3(
		new Web3.providers.HttpProvider(process.env.WEB3_PROVIDER)
	);
	const dmsContract =  new web3.eth.Contract(DMS.abi, NFT_ADDRESS);
	let userEmail = "nguyenln"
	let user = await User.findOne({email: userEmail})
	const {publicAddress} = user
	const userLists = await dmsContract.methods.getCurrentId().call({ from: publicAddress });
	res.status(200).json({userLists: userLists})
	
}

export const getUserSignList = async (req, res, next) => { 
	const web3 = new Web3(
		new Web3.providers.HttpProvider(process.env.WEB3_PROVIDER)
	);
	const dmsContract =  new web3.eth.Contract(DMS.abi, NFT_ADDRESS);
	let userEmail = "nguyenln"
	let user = await User.findOne({email: userEmail})
	const {publicAddress} = user
	const userSignList = await dmsContract.methods.getUserSignList().call({ from: publicAddress });
	res.status(200).json({userSignList: userSignList})
	
}

export const getUserSignedList = async (req, res, next) => { 
	const web3 = new Web3(
		new Web3.providers.HttpProvider(process.env.WEB3_PROVIDER)
	);
	const dmsContract =  new web3.eth.Contract(DMS.abi, NFT_ADDRESS);
	let userEmail = "nguyenln"
	let user = await User.findOne({email: userEmail})
	const {publicAddress} = user
	const userSignedList = await dmsContract.methods.getUserSignedList().call({ from: publicAddress });
	res.status(200).json({userSignedList: userSignedList})
	
}

export const getDocInfo = async (req, res, next) => { 
	const web3 = new Web3(
		new Web3.providers.HttpProvider(process.env.WEB3_PROVIDER)
	);
	const dmsContract =  new web3.eth.Contract(DMS.abi, NFT_ADDRESS);
	let userEmail = "nguyenln"
	let id = req.params.id
	let user = await User.findOne({email: userEmail})
	const {publicAddress} = user
	const info = await dmsContract.methods.getDocInfo(id).call({ from: publicAddress });
	res.status(200).json({info: info})
	
}

export const checkUserSignedStatusTime = async (req, res, next) => { 
	const web3 = new Web3(
		new Web3.providers.HttpProvider(process.env.WEB3_PROVIDER)
	);
	const dmsContract =  new web3.eth.Contract(DMS.abi, NFT_ADDRESS);
	let {tokenId, users} = req.body
	let userEmail = "nguyenln"
	let user = await User.findOne({email: userEmail})
	const {publicAddress} = user
	const checkUser = await dmsContract.methods.checkUserSignedStatus(tokenId, users).call({ from: publicAddress });
	const userTime = await dmsContract.methods.checkUserSignedTime(tokenId, users).call({ from: publicAddress });
	res.status(200).json({checkUser: checkUser, userTime: userTime})
	
}

export const signDoc = async (req, res, next) => { 
	let {id} = req.body
	let userEmail = "nguyenln"
	let user = await User.findOne({email: userEmail})
	const {publicAddress, keystore} = user
	const ks = lightwallet.keystore.deserialize(keystore)
	ks.keyFromPassword(process.env.SECRET, async function (err, pwDerivedKey) {
		ks.generateNewAddress(pwDerivedKey, 1)
		if (err) throw err;
		let privateKey = ks.exportPrivateKey(publicAddress, pwDerivedKey)
		const nonce = await web3.eth.getTransactionCount(publicAddress)
		const transaction = {
			from: publicAddress,
			to: NFT_ADDRESS,
			value: "0x0",
			gas: await dmsContract.methods.sign(NFT_ADDRESS, id).estimateGas({ from: publicAddress }),
			nonce: nonce,
			data: dmsContract.methods.sign(NFT_ADDRESS, id).encodeABI(),
		};
		const signedTx = await web3.eth.accounts.signTransaction(transaction, privateKey);
		web3.eth.sendSignedTransaction(signedTx.rawTransaction, function(error, hash) {
			console.log("The hash of your transaction is: ", hash);
			if(!error) {
				return res.json({
					transactionHash: signedTx.transactionHash, msg: "Sign successfully!"
				})
			} else {
				console.log("Error when send transaction to the network", error);
				throw new Error(error)
			}
		})
	})

	
}

export const initRequestKey = async (req, res, next) => { 
// 	let nonce = crypto.randomBytes(32); 
// 	// Prints random bytes of generated data
// 	console.log("The random bytes of data generated is: "
// 	+ nonce.toString('hex'));
// 	res.json({
// 		result: nonce.toString('hex')
// 	})
}


export const requestKey = async (req, res, next) => { 
// 	let {pubWallet, nonce, sigWallet, fgp} = req.body
// 	const web3 = new Web3(
// 		new Web3.providers.HttpProvider(process.env.WEB3_PROVIDER)
// 	);
// 	console.log(process.platform);
// 	let lib;
// 	if(process.platform === "win32") {
// 		lib = ffi.Library('rust/target/release/abe_native.dll', {
// 			'verify': ['bool', ['string', 'string']],
// 			'generate_key': ['string', ['string', 'string', 'string']],
// 			'encrypt': ['string', ['string', 'string']]
// 		})
// 	} else {
// 		lib = ffi.Library('rust-2/target/release/libabe_native.so', {
// 			'verify': ['bool', ['string', 'string']],
// 			'generate_key': ['string', ['string', 'string', 'string']],
// 			'encrypt': ['string', ['string', 'string']]
// 		})
// 	}
	
// 	console.log("lib", lib);
// 	console.log("req.body", req.body);
// 	const signature = web3.eth.accounts.sign(nonce, "28eb42b6c1fd2b665e8e119a8eeb3d1cecd7d39f40b50eee0f7e28f52621130c");
// 	console.log("signature w3", signature);
// 	let isSigVerified = pubWallet === web3.eth.accounts.recover(nonce, signature.signature) ? true : false;
// 	console.log("isSigVerified", isSigVerified);
// 	if(!isSigVerified) {
// 		res.json({
// 			msg: "Signature is not verified"
// 		})
// 	}

// 	let isReqVerified = lib.verify(nonce, fgp);
// 	console.log("isReqVerified", isReqVerified);
// 	if(!isReqVerified) {
// 		res.json({
// 			msg: "Request is not verified"
// 		})
// 	}

// 	let attributes = [
// 		'userId:nguyenln', 
// 		'wallet:0x57add32f1888dece0ebfa667de80df426119419a', 
// 		'address:null', 
// 		'position:Developer', 
// 		'dept:AI', 
// 		'manager:thinhnc', 
// 		'name:Nguyễn Lương Nguyên'
// 	]

// 	attributes.push("GroooDMS")
// 	let attributesStr = attributes.join("::")
// 	console.log(attributesStr);
// 	let key = lib.generate_key(attributesStr, pubWallet.toLowerCase(), "nguyenln")
// 	console.log("key", key);
// 	let encryptedKey = lib.encrypt(nonce.substring(64), key);
// 	console.log("encryptedKey", encryptedKey);
// 	if(!encryptedKey || encryptedKey.startsWith("!!!")){
// 		res.json({
// 			msg: "Unable to generate key"
// 		})
// 	}
// 	res.json({
// 		result: encryptedKey
// 	})



}
var arr = []

export const getFoldersInMyFolder = async (req, res, next) => { 
	let user_id = req.query.user_id
	if(isValidObjectId(user_id)) {
		let myFolder = await Folder.findOne({ parent: null, owner: user_id })
		if(!myFolder){
			return res.status(500).send({
				msg: "Folder not exist"
			})
		}
		let myFolderItems = await Folder.find({ parent: myFolder._id })

		res.send({
			myFolder: myFolderItems
		})
	}else {
		return res.status(404).send({
			msg: "Folder not found"
		})
	}
	
}

export const createFolder = async (req, res, next) => { 
	let {parent_id, name, user_id} = req.body
	console.log(req.body);
	//check if id is valid
	if(isValidObjectId(parent_id)) {
		// check if parent folder exist
		let parentFolder = await Folder.findById(parent_id)
		if(!parentFolder){
			return res.status(500).send({
				msg: "Folder not exist"
			})
		}
		console.log(parentFolder.owner == user_id);
		console.log(parentFolder.shared.includes(user_id));
		// check if user has permission to create new folder in this folder
		if(parentFolder.owner == user_id || parentFolder.shared.includes(user_id)) {
			let newFolder = new Folder({
				name: name,
				parent: parent_id,
				ancestors: [...parentFolder.ancestors, parent_id],
				owner: user_id,
			})
			Folder.create(newFolder, function (err, newFolderCreated) {
				if (err) {
					console.log(err);
					return res.status(500).send({
						msg: "Error when connect to database"
					})
				}
				res.status(200).send({
					msg: "Create folder successfully!",
					data: newFolderCreated
				})
			});

		}else {
			return res.status(400).send({
				msg: "Bad Request"
			})
		}
	}else {
		return res.status(404).send({
			msg: "Folder not found"
		})
	}
}
export const shareFolder = async (req, res, next) => {
	// get from token
	let {folder_id, sharedList, owner} = req.body
	let folder = await Folder.findById(folder_id)

	// check if owner own this folder
	if(folder.owner !== owner) {
		return res.status(400).send({
			msg: "Bad request"
		})
	}

	// check if folder is "My Folder"
	if(folder.parent == owner) {
		return res.status(400).send({
			msg: "This folder cannot be shared"
		})
	}

	// check if participants is already in this list, if true remove duplicate
	const newSharedList = [...new Set([...sharedList,...folder.shared])];
	const update = { shared: newSharedList };
	console.log(newSharedList);
	let updatedFolder = await Folder.findByIdAndUpdate(folder_id, update, {new: true});
	return res.status(200).send({
		updatedFolder: updatedFolder
	})
}

export const getSharedWithMeFolder = async (req, res, next) => {
	let userId = req.query.userId
	if(isValidObjectId(userId)) {
		let sharedWithMeFolders = await Folder.find({ shared: userId })

		return res.status(200).send({
			sharedWithMeFolders: sharedWithMeFolders
		})
	}else {
		return res.status(400).send({
			msg: "Bad request"
		})
	}
}

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

