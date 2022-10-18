import User from "../../models/user.model.js";
import Web3 from "web3"
import lightwallet from "eth-lightwallet"
import fs from "fs"

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
		const web3 = new Web3(
			new Web3.providers.HttpProvider(process.env.WEB3_PROVIDER)
		);
		if(req.query.tokens) {
			let assets = [];
			let tokens = JSON.parse(req.query.tokens)
			const userEmail = req.jwtDecoded.email
			let user = await User.findOne({email: userEmail})
			let balance = await web3.eth.getBalance(user.publicAddress)
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
		
		
	} catch (error) {
		console.log(error)
		return res.status(500).json({msg: "Internal server error, please try again!"});
	}
}

export const transferToken = async (req, res, next) => {
	try {
		const web3 = new Web3(
			new Web3.providers.HttpProvider(process.env.WEB3_PROVIDER)
		);
		const {addressTo, amount, asset} = req.body.data
		console.log(req.body.data)
		const userEmail = req.jwtDecoded.email
		let user = await User.findOne({email: userEmail})
		const {publicAddress, keystore} = user
		const ks = lightwallet.keystore.deserialize(keystore)
		ks.keyFromPassword(process.env.SECRET, async function (err, pwDerivedKey) {
			ks.generateNewAddress(pwDerivedKey, 1)
			if (err) throw err;
			let privateKey = ks.exportPrivateKey(publicAddress, pwDerivedKey)
			if(asset.type === "native") {
				// let latestBlock = await web3.eth.getBlock("latest");
				const transaction = {
					from: publicAddress,
					to: addressTo, // faucet address to return eth
					value: web3.utils.toWei(amount, "ether"),
					gas: 60000,
					// optional data field to send message or execute smart contract
				};
				const signedTx = await web3.eth.accounts.signTransaction(transaction, privateKey);
				console.log("signedTx", signedTx);
				web3.eth.sendSignedTransaction(signedTx.rawTransaction, function(error, hash) {
					if (!error) {
						console.log("🎉 The hash of your transaction is: ", hash);
						return res.json({
							transactionHash: signedTx.transactionHash, msg: "Transaction signed successfully!"
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
				// let latestBlock = await web3.eth.getBlock("latest");
				// console.log("latestBlock",latestBlock)
				const transaction = {
					from: publicAddress,
					to: tokenContractAddress, // faucet address to return eth
					value: "0x0" ,
					gas: await tokenContract.methods.transfer(addressTo, web3.utils.toWei(amount, "ether")).estimateGas({ from: publicAddress }),
					data: tokenContract.methods.transfer(addressTo, web3.utils.toWei(amount, "ether")).encodeABI(),
				};
				console.log(transaction);
				
				const signedTx = await web3.eth.accounts.signTransaction(transaction, privateKey);
				console.log("signedTx", signedTx);
				web3.eth.sendSignedTransaction(signedTx.rawTransaction, function(error, hash) {
					if (!error) {
						console.log("🎉 The hash of your transaction is: ", hash);
						return res.json({
							transactionHash: signedTx.transactionHash, msg: "Transaction signed successfully!"
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
		const web3 = new Web3(
			new Web3.providers.HttpProvider(process.env.WEB3_PROVIDER)
		);
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