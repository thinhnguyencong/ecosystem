import Web3 from "web3"
import jwt from 'jsonwebtoken';
import User from "../../models/user.model.js";
import lightwallet from "eth-lightwallet"
import fs from "fs"

const NFT_ADDRESS = "0xA53DE6658D258A96fA7a5f0ed66F84439fFDDD2A"

const web3 = new Web3(
	new Web3.providers.HttpProvider(process.env.WEB3_PROVIDER)
);
const DMS = JSON.parse(fs.readFileSync("src/abis/DMSSign.json"));
const dmsContract =  new web3.eth.Contract(DMS.abi, NFT_ADDRESS);
export const wallet = async (req, res, next) => {
	try {
		
		let userEmail = req.params.userId
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
	let userEmail = req.jwtDecoded.email
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
	let userEmail = req.jwtDecoded.email
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
	let userEmail = req.jwtDecoded.email
	let user = await User.findOne({email: userEmail})
	const {publicAddress} = user
	const userList = await dmsContract.methods.getUserSignList().call({ from: publicAddress });
	res.status(200).json({userList: userList})
	
}

export const getCurrentId = async (req, res, next) => { 
	let userEmail = req.jwtDecoded.email
	let user = await User.findOne({email: userEmail})
	const {publicAddress} = user
	const userLists = await dmsContract.methods.getCurrentId().call({ from: publicAddress });
	res.status(200).json({userLists: userLists})
	
}

export const getUserSignList = async (req, res, next) => { 
	let userEmail = req.jwtDecoded.email
	let user = await User.findOne({email: userEmail})
	const {publicAddress} = user
	const userSignList = await dmsContract.methods.getUserSignList().call({ from: publicAddress });
	res.status(200).json({userSignList: userSignList})
	
}

export const getUserSignedList = async (req, res, next) => { 
	let userEmail = req.jwtDecoded.email
	let user = await User.findOne({email: userEmail})
	const {publicAddress} = user
	const userSignedList = await dmsContract.methods.getUserSignedList().call({ from: publicAddress });
	res.status(200).json({userSignedList: userSignedList})
	
}

export const getDocInfo = async (req, res, next) => { 
	let userEmail = req.jwtDecoded.email
	let id = req.params.id
	let user = await User.findOne({email: userEmail})
	const {publicAddress} = user
	const info = await dmsContract.methods.getDocInfo(id).call({ from: publicAddress });
	res.status(200).json({info: info})
	
}

export const checkUserSignedStatusTime = async (req, res, next) => { 
	let {tokenId, users} = req.body
	let userEmail = req.jwtDecoded.email
	let user = await User.findOne({email: userEmail})
	const {publicAddress} = user
	const checkUser = await dmsContract.methods.checkUserSignedStatus(tokenId, users).call({ from: publicAddress });
	const userTime = await dmsContract.methods.checkUserSignedStatus(tokenId, users).call({ from: publicAddress });
	res.status(200).json({checkUser: checkUser, userTime: userTime})
	
}

export const signDoc = async (req, res, next) => { 
	let {id} = req.body
	let userEmail = req.jwtDecoded.email
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
