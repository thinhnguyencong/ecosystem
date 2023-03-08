import { isValidObjectId } from "mongoose"
import fs from "fs"
import lightwallet from "eth-lightwallet"
import Folder from "../../models/folder.model.js"
import User from "../../models/user.model.js"
import { getWeb3 } from "../../config/web3Connection.js";
import File from "../../models/file.model.js"
import { createNotification, saveTransaction } from "../user/user.controller.js"
import mongoose from "mongoose";

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
/**
 * 
 * @param {*} req 
 * @param {*} res 
 * @param {*} next 
 * @returns folder detail by id. Details includes: sub-folder in this folder, folder status, folder files
 * 
 */
export const getFolderById = async (req, res, next) => {
	let id = req.query.id
	let ancestors = [];
	let status;
	const userEmail = req.jwtDecoded.email
	let user = await User.findOne({ email: userEmail })
	let userId = user._id.valueOf()
	if (!isValidObjectId(id)) {
		return res.status(404).send({
			msg: "Folder not exist"
		})
	}
	let myFolder = await Folder.findOne({ parent: null, owner: userId }).lean()
	let folder = await Folder.findById(id).lean()
	folder = { ...folder, _id: folder._id.valueOf() }
	let children = await Folder.find({ parent: id }).lean()
	if (!folder) {
		return res.status(404).send({
			msg: "Folder not exist"
		})
	}
	let files = await getFile(userId, folder.files)
	let ownerInfo = ""
	if (folder.owner) {
		ownerInfo = await getUserInfoById(folder.owner)
	}
	children = await Promise.all(children.map(async c => ({ ...c, owner: await getUserInfoById(c.owner) })))
	await addToRecent({ documentId: id, user: user, type: 'folder' })

	// check if folder is public folder
	if (folder.type == "public" || folder.shared.includes(userId) || folder.owner == userId) {
		if (folder.type == "public") {
			status = "public"
			return res.send({
				msg: "Success",
				data: {
					children: children,
					folder: {
						...folder,
						status,
						owner: ownerInfo,
						files: files,
					},
				},

			})
		}
		if (folder.owner == userId && folder.ancestors.includes(myFolder._id.valueOf())) {
			status = "my-folder"
			if (folder.ancestors.length) {
				for (let i = 0; i < folder.ancestors.length; i++) {
					let ancestorFolder = await Folder.findById(folder.ancestors[i])
					if (ancestorFolder && ancestorFolder.parent && ancestorFolder.owner == userId) {
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
						...folder,
						status,
						owner: ownerInfo,
						files: files,
					},
				},

			})
		}
		if (folder.shared.includes(userId)) {
			status = "shared-with-me"
			if (folder.ancestors.length) {
				for (let i = 0; i < folder.ancestors.length; i++) {
					let ancestorFolder = await Folder.findById(folder.ancestors[i])
					// only get permissioned folder
					if (ancestorFolder && ancestorFolder.shared.includes(userId)) {
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
					children: children.filter(child => child.shared.includes(userId) || child.owner == userId),
					folder: {
						...folder,
						status,
						owner: ownerInfo,
						files: files,
					},
				},

			})
		}
	} else {
		return res.status(404).send({
			msg: "You don't have permission to view this folder"
		})
	}
}

/**
 * 
 * @param {*} req 
 * @param {*} res 
 * @param {*} next 
 * @returns 
 */
export const getFoldersInMyFolder = async (req, res, next) => {
	const userEmail = req.jwtDecoded.email
	let user = await User.findOne({ email: userEmail })
	let userId = user._id.valueOf()
	// console.log(userId);
	if (isValidObjectId(userId)) {
		// get root "My Folder"
		let myFolder = await Folder.findOne({ parent: null, owner: userId }).lean()
		if (!myFolder) {
			return res.status(500).send({
				msg: "Folder not exist"
			})
		}
		let myFolderItems = await Folder.find({parent: myFolder._id.valueOf()}).lean()
		// get owner info
		let result = await Promise.all(myFolderItems.map(async f => ({ ...f,_id: f._id.valueOf(), owner: await getUserInfoById(f.owner) })))

		//get permissioned files
		let files = await getFile(userId, myFolder.files)
		return res.send({
			msg: "Success",
			data: {
				myFolders: result,
				folder: { ...myFolder, files: files, owner: await getUserInfoById(userId) },
			},
		})
	} else {
		return res.status(404).send({
			msg: "Folder not found"
		})
	}

}

export const getRecentDocuments = async (req, res, next) => {
	const userEmail = req.jwtDecoded.email
	let user = await User.findOne({ email: userEmail }).lean()
	let userId = user._id.valueOf()
	// console.log(userId);
	if (isValidObjectId(userId)) {
		let recentFiles = []
		let recentDocs = JSON.parse(JSON.stringify(user.recent))
		console.log(recentDocs);
		for (const item of recentDocs) {
			if (item.type == 'file') {
				let file = await File.findById(item.documentId)
				recentFiles.push({ ...item, ...JSON.parse(JSON.stringify(file)), owner: await getUserInfoById(file.owner) })
			}
		}
		return res.send({
			msg: "Success",
			data: {
				recentFiles: recentFiles,
			},
		})
	} else {
		return res.status(404).send({
			msg: "User not found"
		})
	}

}

export const createFolder = async (req, res, next) => {
	let { parentId, name } = req.body.data
	console.log(req.body);
	const userEmail = req.jwtDecoded.email
	let user = await User.findOne({ email: userEmail })
	let userId = user._id.valueOf()
	//check if id is valid
	if (isValidObjectId(parentId)) {
		// check if parent folder exist
		let parentFolder = await Folder.findById(parentId)
		if (!parentFolder) {
			return res.status(500).send({
				msg: "Folder not exist"
			})
		}
		console.log(parentFolder.owner == userId);
		console.log(parentFolder.shared.includes(userId));
		// check if user has permission to create new folder in this folder
		if (parentFolder.owner == userId || parentFolder.shared.includes(userId)) {
			let newFolder = new Folder({
				name: name,
				parent: parentId,
				ancestors: [...parentFolder.ancestors, parentId],
				owner: userId,
				shared: parentFolder.shared
			})
			Folder.create(newFolder, async function (err, newFolderCreated) {
				let owner = await getUserInfoById(userId)
				let folderNew = JSON.parse(JSON.stringify(newFolderCreated))
				// console.log({...newFolderCreated, owner: owner});
				if (err) {
					console.log(err);
					return res.status(500).send({
						msg: "Error when connect to database"
					})
				}
				return res.status(200).send({
					msg: "Create folder successfully!",
					data: { ...folderNew, _id: newFolderCreated._id.valueOf(), owner: owner }
				})
			});

		} else {
			return res.status(400).send({
				msg: "Bad Request"
			})
		}
	} else {
		return res.status(404).send({
			msg: "Folder not found"
		})
	}
}
export const editFolder = async (req, res, next) => {
	let { data, type } = req.body.data
	const userEmail = req.jwtDecoded.email
	let user = await User.findOne({ email: userEmail })
	let userId = user._id.valueOf()
	let folder = await Folder.findById(data.folderId)
	// check if owner own this folder
	if (folder.owner !== userId) {
		return res.status(400).send({
			msg: "Bad request"
		})
	}
	// check if folder is "My Folder"
	if (folder.parent == userId) {
		return res.status(400).send({
			msg: "This folder cannot be shared"
		})
	}
	if (type == 'rename') {
		if (data.name) {
			console.log(data);
			const update = { name: data.name };
			let updatedFolder = await Folder.findByIdAndUpdate(data.folderId, update, { new: true });
			console.log(updatedFolder);
			return res.status(200).send({
				msg: "Rename folder successfully!",
			})
		} else {
			return res.status(400).send({
				msg: "Bad Request"
			})
		}
	} else if (type == 'share') {
		let { folderId, sharedList } = data
		// check if participants is already in this list, if true remove duplicate
		sharedList = sharedList.filter(function (item) {
			return item !== userId
		})
		// update shareList of this folder
		let updatedFolder = await Folder.findByIdAndUpdate(folderId, { $addToSet: { shared: sharedList } });
		for (const fileId of updatedFolder.files) {
			let updatedFile = await File.findByIdAndUpdate(fileId, { $addToSet: { shared: sharedList } })
		}

		// update shareList of descendants of this folder
		let descendants = await Folder.find({ ancestors: folderId }).lean();
		for (const des of descendants) {
			console.log(des);
			let updatedFolder = await Folder.findByIdAndUpdate(des._id.valueOf(), { $addToSet: { shared: sharedList } });
			for (const fileId of des.files) {
				console.log(fileId);
				let newFile = await File.findByIdAndUpdate(fileId, { $addToSet: { shared: sharedList } })
			}
		}
		createNotification(
			{
				from: user.name,
				content: "share a folder with you.",
				type: "folder",
				documentId: data.folderId
			},
			[...new Set([...sharedList.filter(id => id !== userId)])]
		)
		return res.status(200).send({
			msg: "Success",
			data: {
				updatedFolder: updatedFolder
			},

		})
	} else {
		return res.status(400).send({
			msg: "Bad Request"
		})
	}
}

export const editFile = async (req, res, next) => {
	let { data, type } = req.body.data
	const userEmail = req.jwtDecoded.email
	let user = await User.findOne({ email: userEmail })
	let userId = user._id.valueOf()
	let file = await File.findById(data.fileId)
	if (!file) {
		return res.status(404).send({
			msg: "Not Found",
		})
	}
	if (type == 'rename') {

	} else if (type == 'share') {
		let updatedFile = await File.findByIdAndUpdate(data.fileId, { $addToSet: { shared: data.sharedList } })
		createNotification(
			{
				from: user.name,
				content: "share a file with you.",
				type: "file",
				documentId: data.fileId
			},
			[...new Set([...data.sharedList.filter(id => id !== userId)])],
		)

		return res.status(200).send({
			msg: "Success",
			data: {
				updatedFile: updatedFile
			},

		})
	} else {
		return res.status(400).send({
			msg: "Bad Request"
		})
	}
}

export const getSharedWithMeFolder = async (req, res, next) => {
	const userEmail = req.jwtDecoded.email
	let user = await User.findOne({ email: userEmail })
	let userId = user._id.valueOf()
	if (isValidObjectId(userId)) {
		let sharedWithMeFolders = await Folder.find({ shared: userId }).lean()
		let result = []
		sharedWithMeFolders = sharedWithMeFolders.map(x => ({ ...x, _id: x._id.valueOf() }))

		let idArr = sharedWithMeFolders.map(x => x._id)

		// filter other shared folder to get the "most" parent folder (folder shared above another folder)
		// For example, "Folder 1" and "Folder 2" both shared with user A, but "Folder 2" is the child of "Folder 1", so the result will only return "Folder 1".
		for (let index = 0; index < sharedWithMeFolders.length; index++) {
			let folder = sharedWithMeFolders[index]
			if (folder.ancestors) {
				const contains = folder.ancestors.some(e => {
					return idArr.includes(e);
				});
				if (!contains) {
					result = [...result, ...sharedWithMeFolders.filter(f => f._id == idArr[index])]
				}
			}
		}
		return res.status(200).send({
			msg: "Success",
			data: {
				sharedWithMeFolders: result
			},

		})
	} else {
		return res.status(400).send({
			msg: "Bad request"
		})
	}
}

export const uploadFile = async (req, res, next) => {
	// let {message, ethKey} = req.body.data
	console.log(req.body)
	let { tokenURI, signerList, key, reviewerList, shared, description } = req.body.data
	let sharedList = shared ? req.body.data.sharedList : []
	const web3Connection = await getWeb3()
	if (!web3Connection.status) {
		return res.status(500).json({ msg: "Cannot connect to Web3 Provider" });
	}
	const web3 = web3Connection.web3
	const dmsContract = new web3.eth.Contract(DMS.abi, NFT_ADDRESS);
	const userEmail = req.jwtDecoded.email
	let user = await User.findOne({ email: userEmail })
	const { publicAddress, keystore } = user
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
		try {
			let privateKey = ks.exportPrivateKey(publicAddress, pwDerivedKey)
			const nonce = await web3.eth.getTransactionCount(publicAddress)
			let estimateGasUsed = await dmsContract.methods.mintNFT(publicAddress, tokenURI, reviewerList, signerList).estimateGas({ from: publicAddress })
			let balance = await web3.eth.getBalance(publicAddress)
			const gasPrice = await web3.eth.getGasPrice()
			let transactionFee = web3.utils.fromWei(gasPrice.toString()) * estimateGasUsed
			if (web3.utils.fromWei(balance.toString()) < transactionFee) {
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
			web3.eth.sendSignedTransaction(signedTx.rawTransaction, async function (error, hash) {
				console.log("The hash of your transaction is: ", hash);
				await saveTransaction(hash, userEmail, req.jwtDecoded.client_id)
				if (!error) {
					let signerAndReviewerListByAddress = await User.find({ 'publicAddress': { $in: [...new Set([...signerList, ...reviewerList])] } })
					let listIdShared = signerAndReviewerListByAddress.map(x => x._id.valueOf())
					let parentFolder = await Folder.findById(JSON.parse(tokenURI).folder)
					let newSharedList = [...new Set([...listIdShared, ...parentFolder.shared, ...sharedList])]
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
						const filter1 = { name: "My Folder", type: "normal", parent: null, owner: user._id.valueOf() };
						let folderUpdated = await Folder.findByIdAndUpdate(JSON.parse(tokenURI).folder, { $push: { files: newFileCreated._id.valueOf() } })

						await createNotification(
							{
								from: user.name,
								content: "upload a file for you to review/sign.",
								type: "file",
								documentId: newFileCreated._id.valueOf()
							},
							[...new Set([...listIdShared.filter(id => id !== user._id.valueOf())])],
						)

						return res.status(200).send({
							data: JSON.parse(JSON.stringify(newFileCreated)),
							msg: "Upload file successfully!"
						})
					})

				} else {
					console.log("Error when send transaction to the network", error);
				}
			})
		} catch (error) {
			console.log(error)
			return res.status(500).send({
				msg: "Internal Server Error"
			})
		}
	})
}

const getFile = async (userId, allFiles) => {
	const files = await File.find({ '_id': { $in: allFiles } }).lean()
	// console.log('files', files);
	let permissionedFiles = await Promise.all(files.filter(file => file.shared.includes(userId) || file.owner == userId).map(async c => ({ ...c, owner: await getUserInfoById(c.owner) })))
	return permissionedFiles
}
export const getAllFiles = async (req, res, next) => {
	try {
		const web3Connection = await getWeb3()
		if (!web3Connection.status) {
			return res.status(500).json({ msg: "Cannot connect to Web3 Provider" });
		}
		const web3 = web3Connection.web3
		const dmsContract = new web3.eth.Contract(DMS.abi, NFT_ADDRESS);
		const userEmail = req.jwtDecoded.email
		let user = await User.findOne({ email: userEmail })
		let userId = user._id.valueOf()
		// những tài liệu mà user có public address chưa kí
		let pendingDocs = await dmsContract.methods.getUserNotSignedList().call({ from: user.publicAddress });

		// // những tài liệu đã kí của user.publicaddress
		let signedDocs = await dmsContract.methods.getUserSignedList().call({ from: user.publicAddress });
		console.log("X", pendingDocs);
		console.log("z", signedDocs);
		if (isValidObjectId(userId)) {
			let files = await File.find({ $or: [{ owner: userId }, { shared: userId }] }).lean()
			files = await Promise.all(files.map(async f => ({ ...f, owner: await getUserInfoById(f.owner) })))
			return res.status(200).send({
				msg: "Success",
				data: {
					files: files,
					pendingDocs: pendingDocs,
					signedDocs: signedDocs
				},

			})
		} else {
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

export const addComment = async (req, res, next) => {
	let { fileId, content, attachments, tagList } = req.body.data
	const userEmail = req.jwtDecoded.email
	try {
		let user = await User.findOne({ email: userEmail })
		let userId = user._id.valueOf()
		let newAttachment = []
		let file = await File.findById(fileId).lean()
		let tokenURI = JSON.parse(file.tokenURI)

		let signerAndReviewerListByAddress = await User.find({ 'publicAddress': { $in: [...new Set([...tokenURI.reviewers, ...tokenURI.signers])] } })
		let listIdShared = signerAndReviewerListByAddress.map(x => x._id.valueOf())
		for (let index = 0; index < attachments.length; index++) {
			const attachment = attachments[index];
			let file1 = await File.findById(attachment).lean()
			newAttachment.push({ id: attachment, name: JSON.parse(file1.tokenURI).name })
			let newUpdate = { shared: [...new Set([...listIdShared, ...file1.shared])] }
			await File.findByIdAndUpdate(attachment, newUpdate, { new: true }).lean()
		}

		// update new comment
		let newComment = {
			_id: mongoose.Types.ObjectId(),
			content: content,
			userId: userId,
			name: user.name,
			createdAt: new Date(),
			attachments: newAttachment
		}
		let update = { $push: { comments: newComment } };
		let newFile = await File.findByIdAndUpdate(fileId, update, { new: true }).lean()

		// notification tag event
		createNotification(
			{
				from: user.name,
				content: "mentions you in a file.",
				type: "file",
				documentId: fileId
			},
			[...new Set([...tagList.filter(id => id !== userId)])],
		)

		// notification comment event
		createNotification(
			{
				from: user.name,
				content: "comments on a file.",
				type: "file",
				documentId: fileId
			},
			[...new Set([...listIdShared.filter(id => id !== userId)])],
		)
		if (userId !== file.owner) {
			createNotification(
				{
					from: user.name,
					content: "comments on your file.",
					type: "file",
					documentId: fileId
				},
				[file.owner],
			)
		}

		// real-time comment, when 2 user open same file
		const emitArray = CONNECTED_USERS.filter(
			(client) => [...newFile.shared, ...[newFile.owner]].includes(client.userId)
		).filter(x => x.userId !== userId);

		if (emitArray.length) {
			for (const emitUser of emitArray) {
				SOCKET_IO.to(emitUser.socketId).emit("add comment", { fileId: fileId, comment: newComment });
			}
		}
		
		return res.status(200).send({
			data: {
				comment: newComment,
				fileId: fileId
			},
			msg: "Add comment successfully!"
		})
	} catch (error) {
		console.log(error);
	}

}

export const signDoc = async (req, res, next) => {
	let { type, tokenId, fileId } = req.body.data
	try {
		const web3Connection = await getWeb3()
		if (!web3Connection.status) {
			return res.status(500).json({ msg: "Cannot connect to Web3 Provider" });
		}
		const web3 = web3Connection.web3
		const dmsContract = new web3.eth.Contract(DMS.abi, NFT_ADDRESS);
		const userEmail = req.jwtDecoded.email
		let user = await User.findOne({ email: userEmail })
		let file = await File.findById(fileId).lean()
		const { publicAddress, keystore } = user
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
			if (type == "review") {
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
				if (web3.utils.fromWei(balance.toString()) < transactionFee) {
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
				web3.eth.sendSignedTransaction(signedTx.rawTransaction, async function (error, hash) {
					console.log("The hash of your transaction is: ", hash);
					if (!error) {
						await saveTransaction(hash, userEmail, req.jwtDecoded.client_id)
						console.log(file.shared, file.owner);
						await createNotification(
							{
								from: user.name,
								content: "has finished reviewing a file.",
								type: "file",
								documentId: fileId
							},
							[...new Set([...file.shared.filter(id => id !== userId)])],
						)
						if (userId !== file.owner) {
							await createNotification(
								{
									from: user.name,
									content: "has finished reviewing your file.",
									type: "file",
									documentId: fileId
								},
								[file.owner],
							)
						}
						const emitArray = CONNECTED_USERS.filter(
							(client) => [...file.shared, ...[file.owner]].includes(client.userId)
						).filter(x => x.userId !== userId);

						if (emitArray.length) {
							for (const emitUser of emitArray) {
								SOCKET_IO.to(emitUser.socketId).emit("review doc", { fileId: fileId, publicAddress: publicAddress });
							}
						}
						return res.status(200).send({
							msg: "Review document successfully!",
						})
					} else {
						console.log("Error when send transaction to the network", error.message);
						return res.status(500).send({
							msg: error.message
						})
					}
				})
			} else if (type == "sign") {
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
				if (web3.utils.fromWei(balance.toString()) < transactionFee) {
					return res.status(400).json({
						msg: "Balance amount not enough!",
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
				web3.eth.sendSignedTransaction(signedTx.rawTransaction, async function (error, hash) {
					console.log("The hash of your transaction is: ", hash);
					if (!error) {
						await saveTransaction(hash, userEmail, req.jwtDecoded.client_id)
						await createNotification(
							{
								from: user.name,
								content: "has finished signing a file.",
								type: "file",
								documentId: fileId
							},
							[...new Set([...file.shared.filter(id => id !== userId)])],
						)
						if (userId !== file.owner) {
							await createNotification(
								{
									from: user.name,
									content: "has finished signing your file.",
									type: "file",
									documentId: fileId
								},
								[file.owner],
							)
						}
						const emitArray = CONNECTED_USERS.filter(
							(client) => [...file.shared, ...[file.owner]].includes(client.userId)
						).filter(x => x.userId !== userId);

						if (emitArray.length) {
							for (const emitUser of emitArray) {
								SOCKET_IO.to(emitUser.socketId).emit("sign doc", { fileId: fileId, publicAddress: publicAddress });
							}
						}
						return res.status(200).send({
							msg: "Sign document successfully!",
						})
					} else {
						console.log("Error when send transaction to the network", error.message);
						return res.status(500).send({
							msg: error.message
						})
					}
				})
			} else {
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
	let { type, tokenId, fileId } = req.body.data
	try {
		const web3Connection = await getWeb3()
		if (!web3Connection.status) {
			return res.status(500).json({ msg: "Cannot connect to Web3 Provider" });
		}
		const web3 = web3Connection.web3
		const dmsContract = new web3.eth.Contract(DMS.abi, NFT_ADDRESS);
		const userEmail = req.jwtDecoded.email
		let user = await User.findOne({ email: userEmail })
		let file = await File.findById(fileId).lean()
		const { publicAddress, keystore } = user
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
			// reject reviewing document
			if (type == "review") {
				let privateKey = ks.exportPrivateKey(publicAddress, pwDerivedKey)
				const nonce = await web3.eth.getTransactionCount(publicAddress)
				let estimateGasUsed;
				try {
					estimateGasUsed = await dmsContract.methods.review(tokenId, 0).estimateGas({ from: publicAddress })
				} catch (error) {
					console.log(error.message);
					return res.status(500).send({
						msg: error.message,
					})
				}
				let balance = await web3.eth.getBalance(publicAddress)
				const gasPrice = await web3.eth.getGasPrice()
				let transactionFee = web3.utils.fromWei(gasPrice.toString()) * estimateGasUsed
				if (web3.utils.fromWei(balance.toString()) < transactionFee) {
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
				web3.eth.sendSignedTransaction(signedTx.rawTransaction, async function (error, hash) {
					console.log("The hash of your transaction is: ", hash);
					if (!error) {
						await saveTransaction(hash, userEmail, req.jwtDecoded.client_id)
						await createNotification(
							{
								from: user.name,
								content: "has rejected reviewing a file.",
								type: "file",
								documentId: fileId
							},
							[...new Set([...file.shared.filter(id => id !== userId)])],
						)
						if (userId !== file.owner) {
							await createNotification(
								{
									from: user.name,
									content: "has rejected reviewing your file.",
									type: "file",
									documentId: fileId
								},
								[file.owner],
							)
						}
						const emitArray = CONNECTED_USERS.filter(
							(client) => [...file.shared, ...[file.owner]].includes(client.userId)
						).filter(x => x.userId !== userId);

						if (emitArray.length) {
							for (const emitUser of emitArray) {
								SOCKET_IO.to(emitUser.socketId).emit("reject review doc", { fileId: fileId, publicAddress: publicAddress });
							}
						}
						return res.status(200).send({
							msg: "Reject document successfully!",
						})
					} else {
						console.log("Error when send transaction to the network", error.message);
						return res.status(500).send({
							msg: error.message
						})
					}
				})
			} else if (type == "sign") { // reject signing document
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
				if (web3.utils.fromWei(balance.toString()) < transactionFee) {
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
				web3.eth.sendSignedTransaction(signedTx.rawTransaction, async function (error, hash) {
					console.log("The hash of your transaction is: ", hash);
					if (!error) {
						await saveTransaction(hash, userEmail, req.jwtDecoded.client_id)
						await createNotification(
							{
								from: user.name,
								content: "has rejected signing a file.",
								type: "file",
								documentId: fileId
							},
							[...new Set([...file.shared.filter(id => id !== userId)])],
						)
						if (userId !== file.owner) {
							await createNotification(
								{
									from: user.name,
									content: "has rejected signing your file.",
									type: "file",
									documentId: fileId
								},
								[file.owner],
							)
						}
						const emitArray = CONNECTED_USERS.filter(
							(client) => [...file.shared, ...[file.owner]].includes(client.userId)
						).filter(x => x.userId !== userId);

						if (emitArray.length) {
							for (const emitUser of emitArray) {
								SOCKET_IO.to(emitUser.socketId).emit("reject sign doc", { fileId: fileId, publicAddress: publicAddress });
							}
						}
						return res.status(200).send({
							msg: "Reject document successfully!",
						})
					} else {
						console.log("Error when send transaction to the network", error.message);
						return res.status(500).send({
							msg: error.message
						})
					}
				})
			} else {
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
	let type = req.query.type
	const userEmail = req.jwtDecoded.email
	let user = await User.findOne({ email: userEmail })
	let userId = user._id.valueOf()
	if (type == "my-folder") {
		let myFolder = await Folder.findOne({ parent: null, owner: userId }).lean()
		if (!myFolder) {
			return res.status(500).send({
				msg: "Folder not exist"
			})
		}
		let myFolderId = myFolder._id.valueOf()
		let descendants = await Folder.find({ ancestors: myFolderId }).lean()
		async function getName(files) {
			// console.log("files", files);
			return await Promise.all(files.map(async (x) => {
				// console.log(x);
				let file = await File.findById(x).lean()
				let name = JSON.parse(file.tokenURI).name
				let fileType = JSON.parse(file.tokenURI).fileType
				// console.log('name', name);
				return { name: name, _id: x, fileType: fileType }
			}))
		}
		descendants = await Promise.all(descendants.map(async x => ({ _id: x._id.valueOf(), name: x.name, parent: x.parent, files: await getName(x.files) })))

		const nest = (items, id = myFolderId, link = 'parent') =>
			items.filter(item => item[link] === id).map(item => {
				let isDisabled = nest(items, item._id).length || item.files.length > 0 ? false : true
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
	} else if (type == "folder") {
		let folderId = req.query.folderId
		let folder = await Folder.findById(folderId).lean()
		if (folder.shared.includes(userId) || folder.owner == userId) {
			let descendants = await Folder.find({ ancestors: folderId }).lean()
			async function getFileDetail(files) {
				// console.log("files", files);
				return await Promise.all(files.map(async (x) => {
					// console.log(x);
					let file = await File.findById(x).lean()
					let name = JSON.parse(file.tokenURI).name
					// console.log('name', name);
					return { name: name, _id: x, data: file }
				}))
			}
			descendants = await Promise.all(descendants.map(async x => ({ _id: x._id.valueOf(), name: x.name, parent: x.parent, files: await getFileDetail(x.files) })))

			const nest = (items, id = folderId, link = 'parent') =>
				items.filter(item => item[link] === id).map(item => {
					return {
						...item, children: [...nest(items, item._id), ...item.files]
					}
				})
			let result = await nest(descendants)
			let folderFiles = await getFileDetail(folder.files)
			return res.status(200).send({
				msg: "OK",
				data: [
					{
						_id: folderId,
						name: folder.name,
						children: [...result, ...folderFiles],
					}
				]
			})
		} else {
			return res.status(404).send({
				msg: "You don't have permission to view this folder"
			})
		}
	}
}

export const getFileById = async (req, res, next) => {
	let id = req.query.id
	try {
		const userEmail = req.jwtDecoded.email
		let user = await User.findOne({ email: userEmail })
		let userId = user._id.valueOf()
		if (!isValidObjectId(id)) {
			return res.status(404).send({
				msg: "File not exist"
			})
		}
		let fileById = await File.findById(id).lean()
		if (!fileById) {
			return res.status(404).send({
				msg: "File not exist"
			})
		}
		if (fileById.shared.includes(userId) || fileById.owner == userId) {
			fileById.owner = await getUserInfoById(fileById.owner)
			await addToRecent({ documentId: id, user: user, type: 'file' })

			return res.status(200).send({
				data: {
					file: fileById,
				},
				msg: "Get file by Id successfully!"
			})
		}
		return res.status(401).send({
			msg: "Unauthorized"
		})
	} catch (error) {
		return res.status(500).send({
			msg: error.message ? "Internal Server Error: " + error.message : "Internal Server Error"
		})
	}
}
export const getFileStatusById = async (req, res, next) => {
	const web3Connection = await getWeb3()
	if (!web3Connection.status) {
		return res.status(500).json({ msg: "Cannot connect to Web3 Provider" });
	}
	const web3 = web3Connection.web3
	const dmsContract = new web3.eth.Contract(DMS.abi, NFT_ADDRESS);
	let id = req.query.id
	try {
		const userEmail = req.jwtDecoded.email
		let user = await User.findOne({ email: userEmail })
		if (!isValidObjectId(id)) {
			return res.status(404).send({
				msg: "File not exist"
			})
		}
		let fileById = await File.findById(id).lean()
		if (!fileById) {
			return res.status(404).send({
				msg: "File not exist"
			})
		}
		const startTime = Date.now();
		let fileStatus = await getFileStatus(fileById.tokenId, user.publicAddress, dmsContract)
		const endTime = Date.now();
		const timeTaken = endTime - startTime;
		console.log(`Time taken to perform get file status = ${timeTaken} milliseconds`);

		return res.status(200).send({
			data: {
				fileStatus: fileStatus,
			},
			msg: "Get file status successfully!"
		})
	} catch (error) {
		return res.status(500).send({
			msg: error.message ? "Internal Server Error: " + error.message : "Internal Server Error"
		})
	}
}

const getUserInfoById = async (id) => {
	let user = await User.findById(id).lean()
	if (user) {
		return {
			_id: id,
			name: user.name
		}
	}
}
const getFileStatus = async (tokenId, publicAddress, dmsContract) => {
	let result = {};
	let statusDetail = {
		reviewerList: [],
		signerList: []
	}
	let info = await dmsContract.methods.getDocInfo(tokenId).call({ from: publicAddress });
	let reviewerList = info[1].map(x => x.toLowerCase())
	let signerList = info[2].map(x => x.toLowerCase())
	let reviewArr = []
	let signArr = []
	for (let reviewer of reviewerList) {
		let reviewerStatus = await dmsContract.methods.checkUserSignedStatus(tokenId, reviewer).call({ from: publicAddress });
		let reviewTime = await dmsContract.methods.checkUserSignedTime(tokenId, reviewer).call({ from: publicAddress })
		let user = await User.findOne({ 'publicAddress': reviewer.toLowerCase() })
		if (user) {
			reviewArr.push(reviewerStatus)
			statusDetail.reviewerList.push({
				name: user.name,
				address: reviewer,
				status: reviewerStatus == '0' ? 'not-yet-reviewed' : reviewerStatus == '1' ? 'reviewed' : reviewerStatus == '3' ? 'rejected' : 'error',
				time: reviewTime
			})
		}
	}
	for (let signer of signerList) {
		let signerStatus = await dmsContract.methods.checkUserSignedStatus(tokenId, signer).call({ from: publicAddress });
		let signTime = await dmsContract.methods.checkUserSignedTime(tokenId, signer).call({ from: publicAddress })
		let user = await User.findOne({ 'publicAddress': signer.toLowerCase() })
		if (user) {
			signArr.push(signerStatus)
			statusDetail.signerList.push({
				name: user.name,
				address: signer,
				status: signerStatus == '0' ? 'not-yet-signed' : signerStatus == '2' ? 'signed' : signerStatus == '3' ? 'rejected' : 'error',
				time: signTime
			})
		}
	}
	result.statusDetail = statusDetail
	//check if document has been rejected review
	if (reviewArr.includes("3")) {
		return {
			...result,
			status: "rejected",
			canReview: false,
			canSign: false
		}
	} else {
		// case check if anyone has ever review this file (all zeros means file has not been reviewed)
		if (reviewArr.every(item => item === "0")) {
			// if user in reviewerList
			if (reviewerList.includes(publicAddress.toLowerCase())) {
				return {
					...result,
					status: "waiting-to-review",
					canReview: true,
					canSign: false
				}
			}
			return {
				...result,
				status: "waiting-to-review",
				canReview: false,
				canSign: false
			}
			// case check if all user has reviewed this file (all 1s means file has been reviewed by all reviewers)
		} else if (reviewArr.every(item => item === "1")) {
			// check if document has been rejected sign
			if (signArr.includes("3")) {
				return {
					...result,
					status: "rejected",
					canReview: false,
					canSign: false
				}
			} else {
				// case check if one or more user has signed this file (all 2s means file has been signed by all signers)
				if (signArr.every(item => item === "2")) {
					return {
						...result,
						status: "signed",
						canReview: false,
						canSign: false
					}
				} else {
					// if user in signerList
					if (signerList.includes(publicAddress.toLowerCase())) {
						let reviewerStatus = await dmsContract.methods.checkUserSignedStatus(tokenId, publicAddress).call({ from: publicAddress });
						if (reviewerStatus == "2") {
							return {
								...result,
								status: "waiting-to-sign",
								canReview: false,
								canSign: false
							}
						}
						return {
							...result,
							status: "waiting-to-sign",
							canReview: false,
							canSign: true
						}
					} else {
						return {
							...result,
							status: "waiting-to-sign",
							canReview: false,
							canSign: false
						}
					}
				}
			}
		}
		// 1 0 lẫn lộn ở trong reviewArr
		else {
			if (reviewerList.includes(publicAddress.toLowerCase())) {
				let reviewerStatus = await dmsContract.methods.checkUserSignedStatus(tokenId, publicAddress).call({ from: publicAddress });
				if (reviewerStatus == "1") {
					return {
						...result,
						status: "waiting-to-review",
						canReview: false,
						canSign: false
					}
				}
				return {
					...result,
					status: "waiting-to-review",
					canReview: true,
					canSign: false
				}
			}
			return {
				...result,
				status: "waiting-to-review",
				canReview: false,
				canSign: false
			}
		}
	}
}
async function addToRecent({ documentId, user, type }) {
	if (user.recent.some(f => f.documentId === documentId)) {
		const updatedUser = await User.findOneAndUpdate(
			{ email: user.email, 'recent.documentId': documentId },
			{ 'recent.$.lastAccess': new Date() },
			{ upsert: true }
		);
	} else {
		const addToRecent = {
			documentId: documentId,
			type: type,
		}
		const updatedUser = await User.findOneAndUpdate(
			{ email: user.email },
			{ $push: { recent: addToRecent } },
			{ new: true }
		);
	}
}