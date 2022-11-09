import Web3 from "web3"
import jwt from 'jsonwebtoken';
import User from "../../models/user.model.js";
import lightwallet from "eth-lightwallet"
import fs from "fs"
import crypto from "crypto"
import ffi from "ffi-napi"
import {dirname} from "path";
import { fileURLToPath } from 'url';

const NFT_ADDRESS = "0xA53DE6658D258A96fA7a5f0ed66F84439fFDDD2A"

const web3 = new Web3(
	new Web3.providers.HttpProvider(process.env.WEB3_PROVIDER)
);
const DMS = JSON.parse(fs.readFileSync("src/abis/DMSSign.json"));
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
							publicAddress: addr[0] 
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
		let privateKey = ks.exportPrivateKey(publicAddress, pwDerivedKey)
		let sig = web3.eth.accounts.sign(message, privateKey)
		console.log(sig)
		return res.status(200).json({signature: sig.signature})
	})

	
}

export const mint = async (req, res, next) => { 
	// let {message, ethKey} = req.body.data
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
			gas: 6000000,
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
			gas: 6000000,
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
	let nonce = crypto.randomBytes(32); 
	// Prints random bytes of generated data
	console.log("The random bytes of data generated is: "
	+ nonce.toString('hex'));
	res.json({
		result: nonce.toString('hex')
	})
}


export const requestKey = async (req, res, next) => { 
	let {pubWallet, nonce, sigWallet, fgp} = req.body
	const web3 = new Web3(
		new Web3.providers.HttpProvider(process.env.WEB3_PROVIDER)
	);
	console.log(process.platform);
	let lib;
	if(process.platform === "win32") {
		lib = ffi.Library('rust/target/release/abe_native.dll', {
			'verify': ['bool', ['string', 'string']],
			'generate_key': ['string', ['string', 'string', 'string']],
			'encrypt': ['string', ['string', 'string']]
		})
	} else {
		lib = ffi.Library('rust-2/target/release/libabe_native.so', {
			'verify': ['bool', ['string', 'string']],
			'generate_key': ['string', ['string', 'string', 'string']],
			'encrypt': ['string', ['string', 'string']]
		})
	}
	
	console.log("lib", lib);
	console.log("req.body", req.body);
	const signature = web3.eth.accounts.sign(nonce, "28eb42b6c1fd2b665e8e119a8eeb3d1cecd7d39f40b50eee0f7e28f52621130c");
	console.log("signature w3", signature);
	let isSigVerified = pubWallet === web3.eth.accounts.recover(nonce, signature.signature) ? true : false;
	console.log("isSigVerified", isSigVerified);
	if(!isSigVerified) {
		res.json({
			msg: "Signature is not verified"
		})
	}

	let isReqVerified = lib.verify(nonce, fgp);
	console.log("isReqVerified", isReqVerified);
	if(!isReqVerified) {
		res.json({
			msg: "Request is not verified"
		})
	}

	let attributes = [
		'userId:nguyenln', 
		'wallet:0x57add32f1888dece0ebfa667de80df426119419a', 
		'address:null', 
		'position:Developer', 
		'dept:AI', 
		'manager:thinhnc', 
		'name:Nguyễn Lương Nguyên'
	]

	attributes.push("GroooDMS")
	let attributesStr = attributes.join("::")
	console.log(attributesStr);
	let key = lib.generate_key(attributesStr, pubWallet.toLowerCase(), "nguyenln")
	console.log("key", key);
	let encryptedKey = lib.encrypt(nonce.substring(64), key);
	console.log("encryptedKey", encryptedKey);
	if(!encryptedKey || encryptedKey.startsWith("!!!")){
		res.json({
			msg: "Unable to generate key"
		})
	}
	res.json({
		result: encryptedKey
	})



}
export const test = async (req, res, next) => { 
	const web3 = new Web3(
		new Web3.providers.HttpProvider(process.env.WEB3_PROVIDER)
	);
	let userEmail = "thinhnc"
	let user = await User.findOne({email: userEmail})
	const {publicAddress, keystore} = user

	const dmsContract =  new web3.eth.Contract(DMS.abi, NFT_ADDRESS);
	let arr= [];
	for(let i=1; i<=42; i++) {
		let info = await dmsContract.methods.getDocInfo(i).call({ from: publicAddress });
		arr.push({item: info})
	}
	res.json({
		array: arr
	})
}