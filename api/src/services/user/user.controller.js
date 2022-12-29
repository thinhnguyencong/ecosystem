import User from "../../models/user.model.js";
import lightwallet from "eth-lightwallet"
import fs from "fs"
import crypto from "crypto"
// import ffi from "ffi-napi"
import { getWeb3 } from "../../config/web3Connection.js";
import Department from "../../models/department.model.js";
import Role from "../../models/role.model.js";
import Service from "../../models/service.model.js";

const Token = JSON.parse(fs.readFileSync("src/abis/MAoE.json"));

export const findUser = async (req, res, next) => {
	try {
		const userEmail = req.jwtDecoded.email
		// let result = web3.utils.checkAddressChecksum("0x09876c96f80247184921f24547c861c99083f602")
		// let result2 = web3.utils.checkAddressChecksum("0xFfca474d18285c35DB310F1eD48A4495e894D7dC")
		// console.log(result, result2)  // => true
		let user = await User.findOne({email: userEmail})
		const {publicAddress, keystore} = user
		const ks = lightwallet.keystore.deserialize(keystore)
		ks.keyFromPassword(process.env.SECRET, async function (err, pwDerivedKey) {
			ks.generateNewAddress(pwDerivedKey, 1)
			if (err) throw err;
			let privateKey = ks.exportPrivateKey(publicAddress, pwDerivedKey)
			res.json({msg: "Get user sucessfully", data: {email: user.email, publicAddress: user.publicAddress, privateKey: privateKey}})
		})
		
	} catch (error) {
		console.log(error)
		return res.status(500).json({msg: "Internal server error, please try again!"});
	}
	
};
export const getUserInfo = async (req, res, next) => {
	try {
		const web3Connection = await getWeb3()
		if(!web3Connection.status) {
			return res.status(500).json({msg: "Cannot connect to Web3 Provider"});
		}
		const web3 = web3Connection.web3

		if(req.query.tokens) {
			let assets = [];
			let tokens = JSON.parse(req.query.tokens)
			const userEmail = req.jwtDecoded.email
			let user = await User.findOne({email: userEmail})
			let balance = await web3.eth.getBalance(user.publicAddress)
			console.log("tokens", tokens);
			for (const address in tokens) {
				// load Contract
				if(address !== "0x0000000000000000000000000000000000000000") {
					const tokenContractAddress = address; // Contract Address Here
					const tokenContract = new web3.eth.Contract(
						Token.abi,
						tokenContractAddress
					);
					const tokenBalance = await tokenContract.methods.balanceOf(user.publicAddress).call();
					assets.push({
						name: tokens[address].name,
						amount: web3.utils.fromWei(tokenBalance.toString()),
						type: tokens[address].type,
						address: address
					})
				}
			}
			
			res.json({
				publicAddress: user.publicAddress,
				balance: web3.utils.fromWei(balance),
				assets: assets
			})
		}
		else {
			res.json({msg: "No ERC Token provided"})
		}
		
		
	} catch (error) {
		console.log(error)
		return res.status(500).json({msg: "Internal server error, please try again!"});
	}
}

export const transferToken = async (req, res, next) => {
	try {
		const web3Connection = await getWeb3()
		if(!web3Connection.status) {
			return res.status(500).json({msg: "Cannot connect to Web3 Provider"});
		}
		const web3 = web3Connection.web3
		const {addressTo, amount, asset} = req.body.data
		console.log(req.body.data)
		const userEmail = req.jwtDecoded.email
		let user = await User.findOne({email: userEmail})
		const {keystore} = user
		let publicAddress = web3.utils.toChecksumAddress(user.publicAddress)
		const ks = lightwallet.keystore.deserialize(keystore)
		ks.keyFromPassword(process.env.SECRET, async function (err, pwDerivedKey) {
			ks.generateNewAddress(pwDerivedKey, 1)
			if (err) throw err;
			let privateKey = ks.exportPrivateKey(publicAddress, pwDerivedKey)
			if(asset.type === "native") {
				// let latestBlock = await web3.eth.getBlock("latest");
				const estimateGasUsed = 21000;
				const gasPrice = await web3.eth.getGasPrice()
				const transaction = {
					from: publicAddress,
					to: web3.utils.toChecksumAddress(addressTo), // faucet address to return eth
					value: web3.utils.toWei(amount, "ether"),
					gas: estimateGasUsed,
					// optional data field to send message or execute smart contract
				};
				let balance = await web3.eth.getBalance(publicAddress)
				let transactionFee = web3.utils.fromWei(gasPrice.toString()) * estimateGasUsed
				if(web3.utils.fromWei(balance.toString()) < transactionFee + parseFloat(amount)) {
					return res.status(400).json({
						msg: "Balance amount not enough!"
					})
				}
				const signedTx = await web3.eth.accounts.signTransaction(transaction, privateKey);
				console.log("signedTx", signedTx);
				web3.eth.sendSignedTransaction(signedTx.rawTransaction, async function(error, hash) {
					if (!error) {
						await saveTransaction(hash, userEmail, req.jwtDecoded.client_id )
						console.log("🎉 The hash of your transaction is: ", hash, balance);
						return res.json({
							data: amount,
							transactionHash: signedTx.transactionHash, 
							msg: "Send TBNB successfully!"
						})
					} else {
						console.log("❗Something went wrong while submitting your transaction:", error)
						throw new Error(error)
					}
				})
				
			}else if(asset.type === "utility") {
				//load Contract
				const tokenContractAddress = asset.address; // Contract Address Here
				const tokenContract = new web3.eth.Contract(
					Token.abi,
					tokenContractAddress
				);
				let estimateGasUsed
				try {
					estimateGasUsed = await tokenContract.methods.transfer(addressTo, web3.utils.toWei(amount, "ether")).estimateGas({ from: publicAddress })
				} catch (error) {
					console.log(error.message);
					return res.status(500).send({
						msg: error.message
					})
				}
				let balance = await web3.eth.getBalance(publicAddress)
				const gasPrice = await web3.eth.getGasPrice()
				let transactionFee = web3.utils.fromWei(gasPrice.toString()) * estimateGasUsed
				if(web3.utils.fromWei(balance.toString()) < transactionFee) {
					return res.status(400).json({
						msg: "Balance amount not enough!"
					})
				}
				const transaction = {
					from: publicAddress,
					to: tokenContractAddress, // faucet address to return eth
					value: "0x0" ,
					gas: estimateGasUsed,
					data: tokenContract.methods.transfer(addressTo, web3.utils.toWei(amount, "ether")).encodeABI(),
				};
				console.log(transaction);
				
				const signedTx = await web3.eth.accounts.signTransaction(transaction, privateKey);
				console.log("signedTx", signedTx);
				web3.eth.sendSignedTransaction(signedTx.rawTransaction, async function(error, hash) {
					if (!error) {
						console.log("🎉 The hash of your transaction is: ", hash);
						await saveTransaction(hash, userEmail, req.jwtDecoded.client_id )
						return res.status(200).json({
							data: signedTx.transactionHash, 
							msg: "Send token success!! Your transaction hash is: " + hash
						})
					} else {
						console.log("❗Something went wrong while submitting your transaction:", error)
						throw new Error(error)
					}
				})
				
			}else {
				throw new Error("Something's wrong when getting token address")
			}
			
		})
			
		
		
	} catch (error) {
		console.log(error)
		return res.status(500).json({msg: "Internal server error, please try again!"});
	}
}

export const exportPrivateKey = async (req, res, next) => {
	try {
		const userEmail = req.jwtDecoded.email
		let user = await User.findOne({email: userEmail})
		const {publicAddress, keystore} = user
		const ks = lightwallet.keystore.deserialize(keystore)
		ks.keyFromPassword(process.env.SECRET, async function (err, pwDerivedKey) {
			if (err) throw err;
			ks.generateNewAddress(pwDerivedKey, 1)
			let privateKey = ks.exportPrivateKey(publicAddress, pwDerivedKey)
			return res.json({
				privateKey: privateKey, msg: "Get private key successfully!!"
			})
		})
		
	} catch (error) {
		console.log(error)
		return res.status(500).json({msg: "Internal server error, please try again!"});
	}
}

export const initRequestKey = async (req, res, next) => { 
	// const userEmail = req.jwtDecoded.email
	// let user = await User.findOne({email: userEmail})
	// const {publicAddress, username} = user
	// let nonce = crypto.randomBytes(32); 
	// // Prints random bytes of generated data
	// //console.log("The random bytes of data generated is: " + nonce.toString('hex'));
	// res.json({
	// 	data: {
	// 		publicAddress: publicAddress,
	// 		nonce: nonce.toString('hex'),
	// 		username: username
	// 	},
	// 	msg: "Get nonce successfully"
	// })
}


export const requestKey = async (req, res, next) => { 
	// let {pubWallet, nonce, sigWallet, fgp} = req.body.data
	// //console.log(req.body);
	// const web3Connection = await getWeb3()
	// if(!web3Connection.status) {
	// 	return res.status(500).json({msg: "Cannot connect to Web3 Provider"});
	// }
	// const web3 = web3Connection.web3
	// let lib;
	// if(process.platform === "win32") {
	// 	lib = ffi.Library('rust/target/release/abe_native.dll', {
	// 		'verify': ['bool', ['string', 'string']],
	// 		'generate_key': ['string', ['string', 'string', 'string']],
	// 		'encrypt': ['string', ['string', 'string']]
	// 	})
	// } else {
	// 	lib = ffi.Library('rust-2/target/release/libabe_native.so', {
	// 		'verify': ['bool', ['string', 'string']],
	// 		'generate_key': ['string', ['string', 'string', 'string']],
	// 		'encrypt': ['string', ['string', 'string']]
	// 	})
	// }
	// const userEmail = req.jwtDecoded.email
	// let user = await User.findOne({email: userEmail})
	// const {publicAddress, keystore, username, position, dept, name} = user
	// //console.log("x", web3.eth.accounts.recover(nonce, sigWallet));
	// let isSigVerified = pubWallet.toLowerCase() === web3.eth.accounts.recover(nonce, sigWallet).toLowerCase() ? true : false;
	// // console.log("isSigVerified", isSigVerified);
	// if(!isSigVerified) {
	// 	return res.status(400).json({
	// 		msg: "Signature is not verified"
	// 	})
	// }

	// let isReqVerified = lib.verify(nonce, fgp);
	// //console.log("isReqVerified", isReqVerified);
	// if(!isReqVerified) {
	// 	return res.status(400).json({
	// 		msg: "Request is not verified"
	// 	})
	// }

	// let attributes = [
	// 	'username:'+username, 
	// 	'wallet:'+publicAddress, 
	// 	'position:'+position, 
	// 	'dept:'+dept, 
	// 	'name:'+name
	// ]
	
	// attributes.push("GroooDMS")
	// let attributesStr = attributes.join("::")
	// let key = lib.generate_key(attributesStr, pubWallet.toLowerCase().replace("0x", ""), username)
	// let encryptedKey = lib.encrypt(nonce.substring(64), key);
	// //console.log("encryptedKey", encryptedKey);
	// if(!encryptedKey || encryptedKey.startsWith("!!!")){
	// 	return res.status(400).json({
	// 		msg: "Unable to generate key"
	// 	})
	// }
	// return res.json({
	// 	data: {
	// 		encryptedKey: encryptedKey
	// 	},
	// 	msg: "OK"
	// })
	
}

export const signMessage = async (req, res, next) => {
	// const web3Connection = await getWeb3()
	// if(!web3Connection.status) {
	// 	return res.status(500).json({msg: "Cannot connect to Web3 Provider"});
	// }
	// const web3 = web3Connection.web3
	// let {message} = req.body.data
	// //console.log(req.body.data);
	// const userEmail = req.jwtDecoded.email
	// let user = await User.findOne({email: userEmail})
	// const {publicAddress, keystore} = user
	// const ks = lightwallet.keystore.deserialize(keystore)
	// ks.keyFromPassword(process.env.SECRET, async function (err, pwDerivedKey) {
	// 	ks.generateNewAddress(pwDerivedKey, 1)
	// 	if (err) throw err;
	// 	let privateKey = ks.exportPrivateKey(ks.getAddresses()[0], pwDerivedKey)
	// 	let sig = web3.eth.accounts.sign(message, privateKey)
	// 	//console.log(sig)
	// 	return res.status(200).json({
	// 		data: {
	// 			signature: sig.signature
	// 		},
	// 		msg: "Sign message successfully"
	// 	})
	// })

	
}
export const getListDepartment = async (req, res, next) => {
	let deptsFind = await Department.find({})
    let deptList = deptsFind.map(dept=> ({ _id: dept._id.valueOf(), name: dept.name,}))
	res.status(200).send({
		data: deptList,
		msg: "Get depts successfully"
	});
}
export const getListRole = async (req, res, next) => {
	let rolesFind = await Role.find({})
    let roleList = rolesFind.map(role=> ({ _id: role._id.valueOf(), name: role.name, type: role.type}))
	res.status(200).send({
		data: roleList.filter(role=> role.type!=="admin" && role.type!=="bod" && role.type!=="chairperson"),
		msg: "Get roles successfully"
	});
}

export const getListSigner = async (req, res, next) => {
	let rolesFind = await Role.find({})
    let roleList = rolesFind.filter(role=> role.type=="bod" || role.type=="chairperson").map(role=>  role._id.valueOf())
	let signerList = await User.find({role: {$in : roleList}})
	
	res.status(200).send({
		data: signerList,
		msg: "Get singers successfully"
	});
}
export const saveTransaction = async (transactionHash, email, clientId) => {
	const service = await Service.findOne({client_id: clientId})
	const updatedUser = await User.findOneAndUpdate(
		{ email: email, 'servicesUsed.serviceId': service._id },
		{ $push: {'servicesUsed.$.transactions': transactionHash }}
	);
	console.log("updatedUser", updatedUser)
}
