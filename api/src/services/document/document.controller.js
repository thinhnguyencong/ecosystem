import { isValidObjectId } from "mongoose"
import fs from "fs"
import lightwallet from "eth-lightwallet"
import Folder from "../../models/folder.model.js"
import User from "../../models/user.model.js"
import { getWeb3 } from "../../config/web3Connection.js";
import File from "../../models/file.model.js"
import { saveTransaction } from "../user/user.controller.js"

const DMS = JSON.parse(fs.readFileSync("src/abis/DMS.json"));
const NFT_ADDRESS = "0x5281c02A833a491B764a704D3907373B20E7F482"

export const getRootFolders = async (req, res, next) => {
	let rootFolders = await Folder.find({ parent: null, owner: null, type: "public" })
	res.send({
		msg: "Success",
		data: {
			rootFolders: rootFolders
		},
		
	})
}

export const getFolderById = async (req, res, next) => {
	const web3Connection = await getWeb3()
	if(!web3Connection.status) {
		return res.status(500).json({msg: "Cannot connect to Web3 Provider"});
	}
	const web3 = web3Connection.web3
	const dmsContract =  new web3.eth.Contract(DMS.abi, NFT_ADDRESS);
	let id = req.query.id
	let ancestors= [];
	let status;
	const userEmail = req.jwtDecoded.email
	let user = await User.findOne({email: userEmail}) 
	let userId = user._id.valueOf() 
	if(!isValidObjectId(id)){
		return res.status(404).send({
			msg: "Folder not exist"
		})
	}
	let folderById = await Folder.findById(id)
	let children = await Folder.find({ parent: id })
	let folder = JSON.parse(JSON.stringify(folderById))
	if(!folder){
		return res.status(404).send({
			msg: "Folder not exist"
		})
	}
	let files = await getFile(userId, folder)
	let newFiles = files.length ? await getFileStatus(files, user.publicAddress, dmsContract) : []
	// check if folder is public folder
	if(folder.type == "public" || folder.shared.includes(userId) || folder.owner == userId) {
		if(folder.type == "public") {
			status="public"
			return res.send({
				msg: "Success",
				data: {
					children: children,
					folder: {
						_id: folder._id, 
						name: folder.name, 
						parent: folder.parent,
						status,
						owner: folder.owner,
						type: folder.type,
						files: newFiles,
						shared: folder.shared,
						createdAt: folder.createdAt,
						updatedAt: folder.updatedAt,
					}
				},
				
			})
		}
		if(folder.owner == userId){
			status="my-folder"
			if(folder.ancestors.length) {
				for (let i=0; i< folder.ancestors.length; i++ ){
					let ancestorFolder = await Folder.findById(folder.ancestors[i])
					if(ancestorFolder && ancestorFolder.parent && ancestorFolder.owner == userId) {
						ancestors.push({
							_id: JSON.parse(JSON.stringify(ancestorFolder))._id,
							name: JSON.parse(JSON.stringify(ancestorFolder)).name
						})
					}
				}
			}
			return res.send({
				msg: "Success",
				data: {
					ancestors: ancestors,
					children: children,
					folder: {
						_id: folder._id, 
						name: folder.name, 
						parent: folder.parent,
						status,
						owner: folder.owner,
						type: folder.type,
						files: newFiles,
						shared: folder.shared,
						createdAt: folder.createdAt,
						updatedAt: folder.updatedAt,
					}
				},
				
			})
		}
		if(folder.shared.includes(userId)) {
			status="shared-with-me"
			if(folder.ancestors.length) {
				for (let i=0; i< folder.ancestors.length; i++ ){
					let ancestorFolder = await Folder.findById(folder.ancestors[i])
					// only get permissioned folder
					if(ancestorFolder && ancestorFolder.shared.includes(userId)) {
						ancestors.push({
							_id: JSON.parse(JSON.stringify(ancestorFolder))._id,
							name: JSON.parse(JSON.stringify(ancestorFolder)).name
						})
					}
				}
			}
			return res.send({
				msg: "Success",
				data: {
					ancestors: ancestors,
					children: children.filter(child => child.shared.includes(userId) || child.owner == userId ),
					folder: {
						_id: folder._id, 
						name: folder.name, 
						parent: folder.parent,
						status,
						owner: folder.owner,
						type: folder.type,
						files: newFiles,
						shared: folder.shared,
						createdAt: folder.createdAt,
						updatedAt: folder.updatedAt,
					}
				},
				
			})
		}
	}else {
		return res.status(404).send({
			msg: "You don't have permission to view this folder"
		})
	}
}
export const getFoldersInMyFolder = async (req, res, next) => {
	const web3Connection = await getWeb3()
	if(!web3Connection.status) {
		return res.status(500).json({msg: "Cannot connect to Web3 Provider"});
	}
	const web3 = web3Connection.web3
	const dmsContract =  new web3.eth.Contract(DMS.abi, NFT_ADDRESS);
	const userEmail = req.jwtDecoded.email
	let user = await User.findOne({email: userEmail}) 
	let userId = user._id.valueOf()
	// console.log(userId);
	if(isValidObjectId(userId)) {
		let myFolder = await Folder.findOne({ parent: null, owner: userId }).lean()
		if(!myFolder){
			return res.status(500).send({
				msg: "Folder not exist"
			})
		}
		let myFolderItems = await Folder.find({ owner: userId, parent: { $ne: null } })

		let myFolderIds = myFolderItems.map(x=> x._id.valueOf())
		
		// filter child folder
		let result = myFolderItems.filter(item => !item.ancestors.some(a=> myFolderIds.includes(a)))
		console.time("get file")
		let files = await getFile(userId, myFolder)
		console.timeEnd("get file")
		let newFiles = files.length ? await getFileStatus(files, user.publicAddress, dmsContract) : []
		return res.send({
			msg: "Success",
			data: {
				myFolders: result,
				folder: {...myFolder, files: newFiles}
			},
		})
	}else {
		return res.status(404).send({
			msg: "Folder not found"
		})
	}
	
}

export const createFolder = async (req, res, next) => { 
	let {parentId, name} = req.body.data
	console.log(req.body);
	const userEmail = req.jwtDecoded.email
	let user = await User.findOne({email: userEmail}) 
	let userId = user._id.valueOf()
	//check if id is valid
	if(isValidObjectId(parentId)) {
		// check if parent folder exist
		let parentFolder = await Folder.findById(parentId)
		if(!parentFolder){
			return res.status(500).send({
				msg: "Folder not exist"
			})
		}
		console.log(parentFolder.owner == userId);
		console.log(parentFolder.shared.includes(userId));
		// check if user has permission to create new folder in this folder
		if(parentFolder.owner == userId || parentFolder.shared.includes(userId)) {
			let newFolder = new Folder({
				name: name,
				parent: parentId,
				ancestors: [...parentFolder.ancestors, parentId],
				owner: userId,
				shared: parentFolder.shared
			})
			Folder.create(newFolder, function (err, newFolderCreated) {
				if (err) {
					console.log(err);
					return res.status(500).send({
						msg: "Error when connect to database"
					})
				}
				return res.status(200).send({
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
	let owner = "6375eef4dc06c9e8cf391eb3"

	let {folderId, sharedList} = req.body
	let folder = await Folder.findById(folderId)

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
	let updatedFolder = await Folder.findByIdAndUpdate(folderId, update, {new: true});
	return res.status(200).send({
		msg: "Success",
		data: {
			updatedFolder: updatedFolder
		},
		
	})
}

export const getSharedWithMeFolder = async (req, res, next) => {
	const userEmail = req.jwtDecoded.email
	let user = await User.findOne({email: userEmail}) 
	let userId = user._id.valueOf()
	if(isValidObjectId(userId)) {
		let sharedWithMeFolders = await Folder.find({ shared: userId })
		//console.log("sharedWithMeFolders", sharedWithMeFolders);
		let result1 = []
		let a = sharedWithMeFolders.filter(f => f.parent == null).map(x=> ({_id: x._id.valueOf(), name: x.name}))
		console.log(a)
		let result = result1.concat(a)
		let b = sharedWithMeFolders.filter(f => f.parent !== null)

		for (let index = 0; index < b.length; index++) {
			let folder = b[index]
			// console.log(folder.name);
			if(folder.ancestors.length) {
				for (let i=0; i< folder.ancestors.length; i++ ){
					let ancestorFolder = await Folder.findById(folder.ancestors[i])
					// console.log("ancestorFolder", ancestorFolder);
					// only get permissioned folder
					if(ancestorFolder && ancestorFolder.shared.includes(userId) && ancestorFolder.parent !== null && ancestorFolder.owner !== userId) {
						result.push({
							_id: JSON.parse(JSON.stringify(ancestorFolder))._id,
							name: JSON.parse(JSON.stringify(ancestorFolder)).name
						})
					}
				}
			}
		}
		console.log("result", result);
		return res.status(200).send({
			msg: "Success",
			data: {
				sharedWithMeFolders: result
			},
			
		})
	}else {
		return res.status(400).send({
			msg: "Bad request"
		})
	}
}

export const uploadFile = async (req, res, next) => {
	// let {message, ethKey} = req.body.data
	console.log(req.body)
	let {tokenURI, signerList, key, reviewerList, shared, description} = req.body.data
	let sharedList = shared ? req.body.data.sharedList : []
	const web3Connection = await getWeb3()
	if(!web3Connection.status) {
		return res.status(500).json({msg: "Cannot connect to Web3 Provider"});
	}
	const web3 = web3Connection.web3
	const dmsContract =  new web3.eth.Contract(DMS.abi, NFT_ADDRESS);
	const userEmail = req.jwtDecoded.email
	let user = await User.findOne({email: userEmail}) 
	const {publicAddress, keystore} = user
	const ks = lightwallet.keystore.deserialize(keystore)
	console.log("1");
	ks.keyFromPassword(process.env.SECRET, async function (err, pwDerivedKey) {
		ks.generateNewAddress(pwDerivedKey, 1)
		if (err) {
			console.log(err)
			return res.status(500).send({
				msg: "Error when verify wallet account"
			})
		} 
		let privateKey = ks.exportPrivateKey(publicAddress, pwDerivedKey)
		const nonce = await web3.eth.getTransactionCount(publicAddress)
		let estimateGasUsed = await dmsContract.methods.mintNFT(publicAddress, tokenURI, reviewerList, signerList).estimateGas({ from: publicAddress })
		let balance = await web3.eth.getBalance(publicAddress)
		const gasPrice = await web3.eth.getGasPrice()
		let transactionFee = web3.utils.fromWei(gasPrice.toString()) * estimateGasUsed
		if(web3.utils.fromWei(balance.toString()) < transactionFee) {
			return res.status(400).json({
				msg: "Balance amount not enough!"
			})
		}
		const numberOfTokenId = await dmsContract.methods.getCurrentId().call({ from: publicAddress });
		const transaction = {
			from: publicAddress,
			to: NFT_ADDRESS,
			value: "0x0",
			gas: estimateGasUsed,
			nonce: nonce,
			data: dmsContract.methods.mintNFT(publicAddress, tokenURI, reviewerList, signerList).encodeABI(),
		};
		const signedTx = await web3.eth.accounts.signTransaction(transaction, privateKey);
		console.log("2");
		web3.eth.sendSignedTransaction(signedTx.rawTransaction, async function(error, hash) {
			console.log("The hash of your transaction is: ", hash);
			await saveTransaction(hash, userEmail, req.jwtDecoded.client_id )
			if(!error) {
				let signerAndReviewerListByAddress = await User.find({'publicAddress': {$in: [...new Set([...signerList, ...reviewerList])]}})
				let listIdShared = signerAndReviewerListByAddress.map(x=> x._id.valueOf())
				let parentFolder = await Folder.findById(JSON.parse(tokenURI).folder)
				let newSharedList = [...new Set([...listIdShared ,...parentFolder.shared, ...sharedList])]
				let newFile = new File({
					tokenId: parseInt(numberOfTokenId) + 1,
					hash: JSON.parse(tokenURI).hash,
					shared: newSharedList,
					parentFolder: JSON.parse(tokenURI).folder,
					key: key,
					owner: user._id.valueOf(),
					description: description,
					tokenURI: tokenURI
				})
				File.create(newFile, async function (err, newFileCreated) {
					if (err) {
						console.log(err);
						return res.status(500).send({
							msg: "Error when connect to database"
						})
					}
					const filter1 = { name: "My Folder", type: "normal", parent: null, owner: user._id.valueOf()};
					let folderUpdated = await Folder.findByIdAndUpdate(JSON.parse(tokenURI).folder, {$push: {files: newFileCreated._id.valueOf() }})
					// let myFolderUpdated = await Folder.findOneAndUpdate(filter1, {$push: {files: newFileCreated._id.valueOf() }})
					let fileData= {
						tokenURI: JSON.parse(tokenURI),
						tokenId: newFileCreated.tokenId
					}

					return res.status(200).send({
						data: JSON.parse(JSON.stringify(newFileCreated)),
						msg: "Upload file successfully!"
					})
				})
				
			} else {
				console.log("Error when send transaction to the network", error);
				throw new Error(error)
			}
		})
	})
}

const getFile = async (userId, folder) => {
	let allFiles = folder.files
	const files = await File.find({'_id': {$in: allFiles}}).lean()
	// console.log('files', files);
	let permissionedFiles = files.filter(file => file.shared.includes(userId)|| file.owner == userId)
	return permissionedFiles
}
export const getAllFiles = async (req, res, next) => {
	const web3Connection = await getWeb3()
	if(!web3Connection.status) {
		return res.status(500).json({msg: "Cannot connect to Web3 Provider"});
	}
	const web3 = web3Connection.web3
	try {
		const dmsContract =  new web3.eth.Contract(DMS.abi, NFT_ADDRESS);
		const userEmail = req.jwtDecoded.email
		let user = await User.findOne({email: userEmail}) 
		const {publicAddress} = user
		let userId = user._id.valueOf()
		if(isValidObjectId(userId)) {
			let files = await File.find({$or: [{ owner: userId }, { shared: userId }]}).lean()
			const startTime = Date.now();
			let newFiles = await getFileStatus(files, publicAddress, dmsContract)
			const endTime = Date.now();
			const timeTaken = endTime - startTime;
  			console.log(`Time taken to perform addition = ${timeTaken} milliseconds`);
			//console.log("newFiles", newFiles);
			return res.status(200).send({
				msg: "Success",
				data: {
					files: newFiles
				},
				
			})
		}else {
			return res.status(400).send({
				msg: "Bad request"
			})
		}
	} catch (error) {
		console.log(error);
		return res.status(500).send({
			msg: "Internal Server Error"
		})
	}
	
}
function getKeyByValue(object, value) {
	return Object.keys(object).find(key => object[key] === value);
}

export const addComment = async (req, res, next) => {
	let {fileId, content, attachments} = req.body.data
	const web3Connection = await getWeb3()
	if(!web3Connection.status) {
		return res.status(500).json({msg: "Cannot connect to Web3 Provider"});
	}
	const web3 = web3Connection.web3
	const dmsContract =  new web3.eth.Contract(DMS.abi, NFT_ADDRESS);
	const userEmail = req.jwtDecoded.email
	try {
		let user = await User.findOne({email: userEmail}) 
		let userId = user._id.valueOf()
		let newAttachment=[]
		let file = await File.findById(fileId).lean()
		let info = await dmsContract.methods.getDocInfo(file.tokenId).call({ from: user.publicAddress });

		//share attachment for reviewer and signer
		if(!info) {
			return res.status(500).json({msg: "Token ID is invalid"});
		}
		let signerAndReviewerListByAddress = await User.find({'publicAddress': {$in: [...new Set([...info[1], ...info[2]])]}})
		let listIdShared = signerAndReviewerListByAddress.map(x=> x._id.valueOf())
		for (let index = 0; index < attachments.length; index++) {
			const attachment = attachments[index];
			let file1 = await File.findById(attachment).lean()
			newAttachment.push({id: attachment, name: JSON.parse(file1.tokenURI).name})
			let newUpdate = {shared: [...new Set([...listIdShared, ...file1.shared])]}
			await File.findByIdAndUpdate(attachment, newUpdate, {new: true}).lean()
		}

		// update new comment
		let newComment = {content: content, userId: userId, name: user.name, createdAt: new Date(), attachments: newAttachment}
		let update = { $push: {comments: newComment} };
		let newFile = await File.findByIdAndUpdate(fileId, update, {new: true}).lean()
		
		return res.status(200).send({
			data: {
				comments: newFile.comments,
				fileId: fileId
			},
			msg: "Add comment successfully!"
		})
	} catch (error) {
		console.log(error);
	}
	
}

export const signDoc = async (req, res, next) => {
	let {type, tokenId} = req.body.data
	try {
		const web3Connection = await getWeb3()
		if(!web3Connection.status) {
			return res.status(500).json({msg: "Cannot connect to Web3 Provider"});
		}
		const web3 = web3Connection.web3
		const dmsContract =  new web3.eth.Contract(DMS.abi, NFT_ADDRESS);
		const userEmail = req.jwtDecoded.email
		let user = await User.findOne({email: userEmail}) 
		const {publicAddress, keystore} = user
		let userId = user._id.valueOf()
		const ks = lightwallet.keystore.deserialize(keystore)
		console.log("1");
		ks.keyFromPassword(process.env.SECRET, async function (err, pwDerivedKey) {
			ks.generateNewAddress(pwDerivedKey, 1)
			if (err) {
				console.log(err)
				return res.status(500).send({
					msg: "Error when verify wallet account"
				})
			}
			if(type=="review") {
				let privateKey = ks.exportPrivateKey(publicAddress, pwDerivedKey)
				const nonce = await web3.eth.getTransactionCount(publicAddress)
				console.log(nonce);
				let estimateGasUsed;
				try {
					estimateGasUsed = await dmsContract.methods.review(tokenId, "268").estimateGas({ from: publicAddress })
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
					to: NFT_ADDRESS,
					value: "0x0",
					gas: estimateGasUsed,
					nonce: nonce,
					data: await dmsContract.methods.review(tokenId, "268").encodeABI(),
				};
				const signedTx = await web3.eth.accounts.signTransaction(transaction, privateKey);
				console.log("2");
				web3.eth.sendSignedTransaction(signedTx.rawTransaction, async function(error, hash) {
					console.log("The hash of your transaction is: ", hash);
					await saveTransaction(hash, userEmail, req.jwtDecoded.client_id )
					if(!error) {
						return res.status(200).send({
							msg: "Review document successfully!"
						})
					} else {
						console.log("Error when send transaction to the network", error);
						throw new Error(error)
					}
				})
			}else if(type =="sign") {
				let privateKey = ks.exportPrivateKey(publicAddress, pwDerivedKey)
				const nonce = await web3.eth.getTransactionCount(publicAddress)
				let estimateGasUsed;
				try {
					estimateGasUsed = await dmsContract.methods.sign(tokenId, "268").estimateGas({ from: publicAddress })
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
					to: NFT_ADDRESS,
					value: "0x0",
					gas: estimateGasUsed,
					nonce: nonce,
					data: await dmsContract.methods.sign(tokenId, "268").encodeABI(),
				};
				const signedTx = await web3.eth.accounts.signTransaction(transaction, privateKey);
				console.log("2");
				web3.eth.sendSignedTransaction(signedTx.rawTransaction, async function(error, hash) {
					console.log("The hash of your transaction is: ", hash);
					await saveTransaction(hash, userEmail, req.jwtDecoded.client_id )
					if(!error) {
						return res.status(200).send({
							msg: "Sign document successfully!"
						})
					} else {
						console.log("Error when send transaction to the network", error);
						throw new Error(error)
					}
				})
			}else {
				return res.status(400).send({
					msg: "Bad Request"
				})
			}
			
		})
	} catch (error) {
		console.log(error);
		return res.status(500).send({
			msg: "Internal Server Error"
		})
	}
}

export const rejectDoc = async (req, res, next) => {
	let {type, tokenId} = req.body.data
	try {
		const web3Connection = await getWeb3()
		if(!web3Connection.status) {
			return res.status(500).json({msg: "Cannot connect to Web3 Provider"});
		}
		const web3 = web3Connection.web3
		const dmsContract =  new web3.eth.Contract(DMS.abi, NFT_ADDRESS);
		const userEmail = req.jwtDecoded.email
		let user = await User.findOne({email: userEmail}) 
		const {publicAddress, keystore} = user
		let userId = user._id.valueOf()
		const ks = lightwallet.keystore.deserialize(keystore)
		console.log("1");
		ks.keyFromPassword(process.env.SECRET, async function (err, pwDerivedKey) {
			ks.generateNewAddress(pwDerivedKey, 1)
			if (err) {
				console.log(err)
				return res.status(500).send({
					msg: "Error when verify wallet account"
				})
			}
			if(type=="review") {
				let privateKey = ks.exportPrivateKey(publicAddress, pwDerivedKey)
				const nonce = await web3.eth.getTransactionCount(publicAddress)
				let estimateGasUsed;
				try {
					estimateGasUsed = await dmsContract.methods.review(tokenId, 0).estimateGas({ from: publicAddress })
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
					to: NFT_ADDRESS,
					value: "0x0",
					gas: estimateGasUsed,
					nonce: nonce,
					data: await dmsContract.methods.review(tokenId, 0).encodeABI(),
				};
				const signedTx = await web3.eth.accounts.signTransaction(transaction, privateKey);
				console.log("2");
				web3.eth.sendSignedTransaction(signedTx.rawTransaction, async function(error, hash) {
					console.log("The hash of your transaction is: ", hash);
					await saveTransaction(hash, userEmail, req.jwtDecoded.client_id )
					if(!error) {
						return res.status(200).send({
							msg: "Reject document successfully!"
						})
					} else {
						console.log("Error when send transaction to the network", error);
						throw new Error(error)
					}
				})
			}else if(type =="sign") {
				let privateKey = ks.exportPrivateKey(publicAddress, pwDerivedKey)
				const nonce = await web3.eth.getTransactionCount(publicAddress)
				let estimateGasUsed;
				try {
					estimateGasUsed = await dmsContract.methods.sign(tokenId, 0).estimateGas({ from: publicAddress })
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
					to: NFT_ADDRESS,
					value: "0x0",
					gas: estimateGasUsed,
					nonce: nonce,
					data: await dmsContract.methods.sign(tokenId, 0).encodeABI(),
				};
				const signedTx = await web3.eth.accounts.signTransaction(transaction, privateKey);
				console.log("2");
				web3.eth.sendSignedTransaction(signedTx.rawTransaction, async function(error, hash) {
					console.log("The hash of your transaction is: ", hash);
					await saveTransaction(hash, userEmail, req.jwtDecoded.client_id )
					if(!error) {
						return res.status(200).send({
							msg: "Reject document successfully!"
						})
					} else {
						console.log("Error when send transaction to the network", error);
						throw new Error(error)
					}
				})
			}else {
				return res.status(400).send({
					msg: "Bad Request"
				})
			}
			
		})
	} catch (error) {
		console.log(error);
		return res.status(500).send({
			msg: "Internal Server Error"
		})
	}
}
export const getTreeFolder = async (req, res, next) => {
	const userEmail = req.jwtDecoded.email
	let user = await User.findOne({email: userEmail}) 
	let userId = user._id.valueOf()
	let myFolder = await Folder.findOne({ parent: null, owner: userId }).lean()
	if(!myFolder){
		return res.status(500).send({
			msg: "Folder not exist"
		})
	}
	let myFolderId = myFolder._id.valueOf()
	let descendants = await Folder.find({ancestors: myFolderId}).lean()
	const getName = async (files) => {
		// console.log("files", files);
		return await Promise.all(files.map(async (x) => {
			// console.log(x);
			let file = await File.findById(x).lean()
			let name = JSON.parse(file.tokenURI).name
			let fileType = JSON.parse(file.tokenURI).fileType
			// console.log('name', name);
			return {name: name, _id: x, fileType: fileType} 
		}))
	}
	descendants = await Promise.all(descendants.map(async x=> ({_id: x._id.valueOf(), name: x.name, parent: x.parent, files: await getName(x.files)})))

	const nest = (items, id = myFolderId, link = 'parent') => items.filter(item => item[link] === id).map(item => {
		console.log("item", item);
		let isDisabled = nest(items, item._id).length || item.files.length >0 ? false : true
		return {
			...item, children: [...nest(items, item._id), ...item.files], isDisabled: isDisabled
		}
	})
	let result = await nest(descendants)
	let myFolderFiles = await getName(myFolder.files)
	return res.status(200).send({
		msg: "OK",
		data: [
			{
				_id: myFolderId,
				name: myFolder.name,
				children: [...result, ...myFolderFiles],
				isDisabled: [...result, ...myFolderFiles].length ? false : true
			}
		]
	})
}

const getFileStatus = async (files, publicAddress, dmsContract) => {
	return await Promise.all(files.map(async (file, index)=> {
		let statusDetail = {
			reviewerList: [],
			signerList: []
		}
		let info = await dmsContract.methods.getDocInfo(file.tokenId).call({ from: publicAddress });
		let reviewerList = info[1].map(x=> x.toLowerCase())
		let signerList = info[2].map(x=> x.toLowerCase())
		let reviewArr = []
		let signArr = []
		for(let reviewer of reviewerList) {
			let reviewerStatus = await dmsContract.methods.checkUserSignedStatus(file.tokenId, reviewer).call({ from: publicAddress });
			let reviewTime = await dmsContract.methods.checkUserSignedTime(file.tokenId, reviewer).call({ from: publicAddress })
			let user = await User.findOne({'publicAddress': reviewer.toLowerCase()})
			if(user) {
				reviewArr.push(reviewerStatus)
				statusDetail.reviewerList.push({
					name: user.name,
					address: reviewer, 
					status: reviewerStatus=='0' ? 'not-yet-reviewed' : reviewerStatus=='1' ? 'reviewed' : reviewerStatus=='3' ? 'rejected' : 'error',
					time: reviewTime
				})
			}
		}
		for(let signer of signerList) {
			let signerStatus = await dmsContract.methods.checkUserSignedStatus(file.tokenId, signer).call({ from: publicAddress });
			let signTime = await dmsContract.methods.checkUserSignedTime(file.tokenId, signer).call({ from: publicAddress })
			let user = await User.findOne({'publicAddress': signer.toLowerCase()})
			if(user) {
				signArr.push(signerStatus)
				statusDetail.signerList.push({
					name: user.name,
					address: signer, 
					status: signerStatus=='0' ? 'not-yet-signed' : signerStatus=='2' ? 'signed' : signerStatus=='3' ? 'rejected' : 'error',
					time: signTime
				})
			}
		}
		file.statusDetail = statusDetail
		// console.log("file.tokenId", file.tokenId, publicAddress);
		// console.log("reviewerList", reviewerList);
		// console.log("signerList", signerList);
		// console.log("reviewArr", reviewArr);
		// console.log("signArr", signArr);
		//check if document has been rejected review
		if(reviewArr.includes("3")) {
			return {
				...file,
				status: "rejected",
				canComment: true,
				canReview: false,
				canSign: false
			}
		}else {
			// case check if anyone has ever review this file (all zeros means file has not been reviewed)
			if(reviewArr.every(item => item === "0")){
				// if user in reviewerList
				if(reviewerList.includes(publicAddress.toLowerCase())){
					return {
						...file,
						status: "waiting-to-review",
						canComment: true,
						canReview: true,
						canSign: false
					}
				}
				return {
					...file,
					status: "waiting-to-review",
					canComment: true,
					canReview: false,
					canSign: false
				}
			// case check if all user has reviewed this file (all 1s means file has been reviewed by all reviewers)
			}else if (reviewArr.every(item => item === "1")){
				// check if document has been rejected sign
				if(signArr.includes("3")) {
					return {
						...file,
						status: "rejected",
						canComment: true,
						canReview: false,
						canSign: false
					}
				}else {
					// case check if one or more user has signed this file (all 2s means file has been signed by all signers)
					if(signArr.every(item => item === "2")){
						return {
							...file,
							status: "signed",
							canComment: false,
							canReview: false,
							canSign: false
						}
					}else {
						// if user in signerList
						if(signerList.includes(publicAddress.toLowerCase())){
							let reviewerStatus = await dmsContract.methods.checkUserSignedStatus(file.tokenId, publicAddress).call({ from: publicAddress });
							if(reviewerStatus == "2") {
								return {
									...file,
									status: "waiting-to-sign",
									canComment: true,
									canReview: false,
									canSign: false
								}
							}
							return {
								...file,
								status: "waiting-to-sign",
								canComment: true,
								canReview: false,
								canSign: true
							}
						}else {
							return {
								...file,
								status: "waiting-to-sign",
								canComment: true,
								canReview: false,
								canSign: false
							}
						}
					}
				}
			}
			// 1 0 lẫn lộn ở trong reviewArr
			else {
				if(reviewerList.includes(publicAddress.toLowerCase())){
					let reviewerStatus = await dmsContract.methods.checkUserSignedStatus(file.tokenId, publicAddress).call({ from: publicAddress });
					if(reviewerStatus == "1") {
						return {
							...file,
							status: "waiting-to-review",
							canComment: true,
							canReview: false,
							canSign: false
						}
					}
					return {
						...file,
						status: "waiting-to-review",
						canComment: true,
						canReview: true,
						canSign: false
					}
				}
				return {
					...file,
					status: "waiting-to-review",
					canComment: true,
					canReview: false,
					canSign: false
				}
			}
		}
	}))
}