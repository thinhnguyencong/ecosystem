import Web3 from "web3"
import fs from "fs"
import dayjs from "dayjs"
import lightwallet from "eth-lightwallet"
import User from "../../models/user.model.js";

import { collectionDeployedNetworkAddress } from "../collection/collection.controller.js"

const auctionDeployedNetworkAddress = "0x68B78b9EC65467929aB7513B13b1711B0CE8e8b3";
const tokenContractAddress = "0x66bb422559A3b24AbD6E87b7d1ba6b1B2C3462D9"

const NFTAuction = JSON.parse(fs.readFileSync("src/abis/NFTAuction.json"));
const NFTCollection = JSON.parse(fs.readFileSync("src/abis/NFTCollection.json"));
const MAoE = JSON.parse(fs.readFileSync("src/abis/MAoE.json"));

export const getNftAuctionList = async (req, res, next) => {
	try {
		const web3 = new Web3(
			new Web3.providers.HttpProvider(process.env.WEB3_PROVIDER)
		);
		const auctionContract = new web3.eth.Contract(NFTAuction.abi, auctionDeployedNetworkAddress);
		const auctionList = await auctionContract.methods._getAuctionList().call();
		let listAuction = [];
		for(let i = 0; i < auctionList.length; i++){
			// lấy dữ liệu qua method au sẽ chính xác hơn
			console.log("auctionList", auctionList)
			const auc = await auctionContract.methods.au(auctionList[i].ad, auctionList[i].id).call();
			const status = getStatus(auc.seller, auc.aucEnd)
			// lấy ra các thuộc tính của auction
			let data = {
				id: parseInt(auctionList[i].id),
				bidPeriod: parseInt(auc.bidPeriod),
				bidIncreasePercentage: parseInt(auc.bidPercentage),
				minPrice: web3.utils.fromWei(auc.minPrice, 'ether'),
				buyPrice: web3.utils.fromWei(auc.buyPrice, 'ether'),
				seller: auc.seller,
				collectionAddress: auctionList[i].ad,
				auctionEnd: auc.aucEnd,
				status: status
			}
			listAuction.push(data)
		}
		let x = await modifyListAuction(listAuction)
		res.status(200).json(x)
	} catch (error) {
		console.log(error)
		res.status(500).json({msg: "Internal server error!!"})
	}
	
}

const getStatus = (seller, auctionEnd ) => {
    console.log("auctionEnd", auctionEnd)
    let timeEnd = dayjs.unix(auctionEnd)
    let now = dayjs();
    let diff = timeEnd.diff(now)
    console.log("dfff", diff)
    if(seller !== "0x0000000000000000000000000000000000000000" && diff <= 0 ){
        return "auction-ended"
    }
    if(seller !== "0x0000000000000000000000000000000000000000" && diff > 0 ){
        return "auction-on-going"
    }else return "not-on-auction"
}

/**
 * fetch ảnh và tên NFT, thêm vào listAuction
 * @param {*} listAuction 
 * @returns 
 */
const modifyListAuction = async (listAuction) => {
	const web3 = new Web3(
		new Web3.providers.HttpProvider(process.env.WEB3_PROVIDER)
	);
    let newList = [];
    for(let auc of listAuction){
        const collectionContract = new web3.eth.Contract(NFTCollection.abi, auc.collectionAddress);
        const hash = await collectionContract.methods.tokenURI(auc.id).call();
        const response = await fetch(hash);
        if(!response.ok) {
            throw new Error('Something went wrong');
        }
        const metadata = await response.json();
        const owner = await collectionContract.methods.ownerOf(auc.id).call();
        
        let data = {
            ...auc,
            title: metadata.name,
            img: metadata.image,
            owner: owner,
        }
        newList.push(data)
    }
    return newList
    
}

export const getNftAuctionById = async (req, res, next) => {
	const web3 = new Web3(
		new Web3.providers.HttpProvider(process.env.WEB3_PROVIDER)
	);
	const auctionContract = new web3.eth.Contract(NFTAuction.abi, auctionDeployedNetworkAddress);
	let tokenId = req.query.id
	console.log("req.query.id", req.query.id)
	const bidPeriod = await auctionContract.methods._getAuctionBidPeriod(collectionDeployedNetworkAddress, tokenId).call();
	const bidIncreasePercentage = await auctionContract.methods._getBidIncreasePercentage(collectionDeployedNetworkAddress, tokenId).call();
	const buyPrice = await auctionContract.methods._getBuyPrice(collectionDeployedNetworkAddress, tokenId).call();
	const minPrice = await auctionContract.methods._getMinPrice(collectionDeployedNetworkAddress, tokenId).call();
	const seller = await auctionContract.methods._getNftSeller(collectionDeployedNetworkAddress, tokenId).call();
	const auctionStart = await auctionContract.methods._getStartTime(collectionDeployedNetworkAddress, tokenId).call();
	const auc = await auctionContract.methods.au(collectionDeployedNetworkAddress, tokenId).call();
	const highestBid = auc.highestBid
	const highestBidder = auc.highestBidder
	const auctionEnd = auc.aucEnd
	const status = getStatus(auc.seller, auc.aucEnd)
	res.status(200).json({
		bidPeriod: parseInt(bidPeriod),
		bidIncreasePercentage: parseInt(bidIncreasePercentage),
		minPrice: web3.utils.fromWei(minPrice, 'ether'),
		buyPrice: web3.utils.fromWei(buyPrice, 'ether'),
		seller: seller,
		highestBid: web3.utils.fromWei(highestBid, 'ether'),
		highestBidder: highestBidder,
		auctionStart: auctionStart,
		auctionEnd: auctionEnd,
		isLoading: false,
		status: status
	})
}

export const getBidHistory = async (req, res, next) => {
	const web3 = new Web3(
		new Web3.providers.HttpProvider(process.env.WEB3_PROVIDER)
	);
	const auctionContract = new web3.eth.Contract(NFTAuction.abi, auctionDeployedNetworkAddress);
	let tokenId = req.query.id
	const bidHistory = await auctionContract.methods._getBidHistory(collectionDeployedNetworkAddress, tokenId).call();
	let result = bidHistory.map(bid => ({
		user: bid.user,
		time: parseInt(bid.time),
		amount: web3.utils.fromWei(bid.amount, 'ether'),
	}))

	res.status(200).json(result)
}

export const createAuction  = async (req, res, next) => {
	try {
		const web3 = new Web3(
			new Web3.providers.HttpProvider(process.env.WEB3_PROVIDER)
		);
		const collectionContract = new web3.eth.Contract(NFTCollection.abi, collectionDeployedNetworkAddress);
		const auctionContract = new web3.eth.Contract(NFTAuction.abi, auctionDeployedNetworkAddress);
		let {data, type} = req.body.data
		console.log("data", data, typeof data.nftAddress)
		const userEmail = req.jwtDecoded.email
		let user = await User.findOne({email: userEmail})
		const {publicAddress, keystore} = user
		console.log("publicAddress", publicAddress, typeof publicAddress)
		const ks = lightwallet.keystore.deserialize(keystore)
		const minPrice = web3.utils.toWei(data.minPrice, 'ether');
		const buyPrice = web3.utils.toWei(data.buyPrice, 'ether');
		ks.keyFromPassword(process.env.SECRET, async function (err, pwDerivedKey) {
			ks.generateNewAddress(pwDerivedKey, 1)
			if (err) throw err;
			let privateKey = ks.exportPrivateKey(publicAddress, pwDerivedKey)
			
			if (type === "default") {
				const nonce = await web3.eth.getTransactionCount(publicAddress)
				const approveTransaction = {
					from: publicAddress,
					to: collectionDeployedNetworkAddress,
					value: "0x0" ,
					gas: 600000,
					nonce: nonce,
					data: collectionContract.methods.approve(auctionDeployedNetworkAddress, data.tokenId).encodeABI(),
				};
				const signedApproveTx = await web3.eth.accounts.signTransaction(approveTransaction, privateKey);
				web3.eth.sendSignedTransaction(signedApproveTx.rawTransaction, async function(error, hash) {
					if (!error) {
						console.log("🎉 The hash of your approve transaction is: ", hash);
						const transaction = {
							from: publicAddress,
							to: auctionDeployedNetworkAddress,
							value: "0x0",
							gas: 600000,
							nonce: nonce +1,
							data: auctionContract.methods.createDefaultNftAuction(collectionDeployedNetworkAddress, data.tokenId, minPrice, buyPrice, data.endDate).encodeABI(),
						};
						const signedTx = await web3.eth.accounts.signTransaction(transaction, privateKey);
						web3.eth.sendSignedTransaction(signedTx.rawTransaction, function(error, hash) {
							console.log("The hash of your transaction is: ", hash);
							if(!error) {
								return res.json({
									transactionHash: signedTx.transactionHash, msg: "Transaction signed successfully!"
								})
							} else {
								console.log("Create auction failed! Try again", error);
								throw new Error(error)
							}
						})
					} else {
						console.log("Error when calling approve method! Try again ");
						throw new Error(error)
					}
				})
				
			} 
			else if (type === "custom") {
				const nonce = await web3.eth.getTransactionCount(publicAddress)
				const approveTransaction = {
					from: publicAddress,
					to: collectionDeployedNetworkAddress,
					value: "0x0" ,
					gas: 600000,
					nonce: nonce,
					data: collectionContract.methods.approve(auctionDeployedNetworkAddress, data.tokenId).encodeABI(),
				};
				const signedApproveTx = await web3.eth.accounts.signTransaction(approveTransaction, privateKey);
				web3.eth.sendSignedTransaction(signedApproveTx.rawTransaction, async function(error, hash) {
					if (!error) {
						console.log("🎉 The hash of your approve transaction is: ", hash);
						const transaction = {
							from: publicAddress,
							to: auctionDeployedNetworkAddress,
							value: "0x0",
							gas: 600000,
							nonce: nonce +1,
							data: auctionContract.methods.createNewNftAuction(collectionDeployedNetworkAddress, data.tokenId, minPrice, buyPrice, data.endDate, data.bidPeriod, data.bidIncrease).encodeABI(),
						};
						const signedTx = await web3.eth.accounts.signTransaction(transaction, privateKey);
						web3.eth.sendSignedTransaction(signedTx.rawTransaction, function(error, hash) {
							console.log("The hash of your transaction is: ", hash);
							if(!error) {
								return res.json({
									transactionHash: signedTx.transactionHash, msg: "Transaction signed successfully!"
								})
							} else {
								console.log("Create auction failed! Try again", error);
								throw new Error(error)
							}
						})
					} else {
						console.log("Error when calling approve method! Try again ");
						throw new Error(error)
					}
				})
			}
		})
			
		
	} catch (error) {
		return res.status(500).json({
			msg: "Internal server error!"
		})
	}
	
	
}

export const placeBid  = async (req, res, next) => {
	try {
		const web3 = new Web3(
			new Web3.providers.HttpProvider(process.env.WEB3_PROVIDER)
		);
		const tokenContract = new web3.eth.Contract(MAoE.abi, tokenContractAddress);

		let {tokenId} = req.body.data
		console.log("req.body.data", req.body.data)
		const bidPrice = web3.utils.toWei(req.body.data.bidPrice, 'ether')
		const userEmail = req.jwtDecoded.email
		let user = await User.findOne({email: userEmail})
		const {publicAddress, keystore} = user
		const ks = lightwallet.keystore.deserialize(keystore)
		ks.keyFromPassword(process.env.SECRET, async function (err, pwDerivedKey) {
			ks.generateNewAddress(pwDerivedKey, 1)
			if (err) throw err;
			let privateKey = ks.exportPrivateKey(publicAddress, pwDerivedKey)
			const nonce = await web3.eth.getTransactionCount(publicAddress)
			const approveTransaction = {
				from: publicAddress,
				to: tokenContractAddress,
				value: "0x0" ,
				gas: 600000,
				nonce: nonce,
				data: tokenContract.methods.approve(auctionDeployedNetworkAddress, bidPrice).encodeABI(),
			};
			console.log("approveTransaction", approveTransaction)
			const signedApproveTx = await web3.eth.accounts.signTransaction(approveTransaction, privateKey);
			web3.eth.sendSignedTransaction(signedApproveTx.rawTransaction, async function(error, hash) {
				if (!error) {
					console.log("🎉 The hash of your approve transaction is: ", hash);
					const transaction = {
						from: publicAddress,
						to: auctionDeployedNetworkAddress,
						value: "0x0",
						gas: 600000,
						nonce: nonce +1,
						data: auctionContract.methods.makeBid(collectionDeployedNetworkAddress, tokenId, bidPrice).encodeABI(),
					};
					const signedTx = await web3.eth.accounts.signTransaction(transaction, privateKey);
					web3.eth.sendSignedTransaction(signedTx.rawTransaction, function(error, hash) {
						console.log("The hash of your transaction is: ", hash);
						if(!error) {
							return res.json({
								transactionHash: signedTx.transactionHash, msg: "Transaction signed successfully!"
							})
						} else {
							console.log("Create auction failed! Try again", error);
							throw new Error(error)
						}
					})
				} else {
					console.log("Error when calling approve method! Try again ");
					throw new Error(error)
				}
			})
		})
	} catch (error) {
		console.log(error);
		return res.status(500).json({
			msg: "Internal server error!"
		})
	}
}

export const settleAuction  = async (req, res, next) => {
	try {
		const web3 = new Web3(
			new Web3.providers.HttpProvider(process.env.WEB3_PROVIDER)
		);
		const auctionContract = new web3.eth.Contract(NFTAuction.abi, auctionDeployedNetworkAddress);
		let {nftAddress, tokenId} = req.body.data
		console.log("data", req.body.data)
		const userEmail = req.jwtDecoded.email
		let user = await User.findOne({email: userEmail})
		const {publicAddress, keystore} = user
		console.log("publicAddress", publicAddress, typeof publicAddress)
		const ks = lightwallet.keystore.deserialize(keystore)
		ks.keyFromPassword(process.env.SECRET, async function (err, pwDerivedKey) {
			ks.generateNewAddress(pwDerivedKey, 1)
			if (err) throw err;
			let privateKey = ks.exportPrivateKey(publicAddress, pwDerivedKey)
			const nonce = await web3.eth.getTransactionCount(publicAddress)
			const transaction = {
				from: publicAddress,
				to: auctionDeployedNetworkAddress,
				value: "0x0",
				gas: 600000,
				nonce: nonce,
				data: auctionContract.methods.settleAuction(nftAddress, tokenId).encodeABI(),
			};
			const signedTx = await web3.eth.accounts.signTransaction(transaction, privateKey);
			web3.eth.sendSignedTransaction(signedTx.rawTransaction, function(error, hash) {
				console.log("The hash of your transaction is: ", hash);
				if(!error) {
					return res.json({
						transactionHash: signedTx.transactionHash, msg: "Transaction signed successfully!"
					})
				} else {
					console.log("Settle auction failed! Try again", error);
					throw new Error(error)
				}
			})
		})
	} catch (error) {
		console.log(error);
		return res.status(500).json({
			msg: "Internal server error!"
		})
	}
	
	
}

export const withdrawAuction = async (req, res, next) => {
	const web3 = new Web3(
		new Web3.providers.HttpProvider(process.env.WEB3_PROVIDER)
	);
	const auctionContract = new web3.eth.Contract(NFTAuction.abi, auctionDeployedNetworkAddress);
	let {tokenId} = req.body.data
	const userEmail = req.jwtDecoded.email
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
			to: auctionDeployedNetworkAddress,
			value: "0x0",
			gas: 600000,
			nonce: nonce,
			data: auctionContract.methods.withdrawAuction(collectionDeployedNetworkAddress, tokenId).encodeABI(),
		};
		const signedTx = await web3.eth.accounts.signTransaction(transaction, privateKey);
		web3.eth.sendSignedTransaction(signedTx.rawTransaction, function(error, hash) {
			console.log("The hash of your transaction is: ", hash);
			if(!error) {
				return res.json({
					transactionHash: signedTx.transactionHash, msg: "Transaction signed successfully!"
				})
			} else {
				console.log("Withdraw auction failed! Try again", error);
				throw new Error(error)
			}
		})
	})
}