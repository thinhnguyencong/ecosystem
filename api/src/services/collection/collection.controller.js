import Web3 from "web3"
import fs from "fs"
import dayjs from "dayjs"
export const collectionDeployedNetworkAddress = "0xb8262489b64477E88619DE37C6bA6a116a2ADcb7";

const NFTCollection = JSON.parse(fs.readFileSync("src/abis/NFTCollection.json"));

export const getNftById = async (req, res, next) => {
	try {
		const web3 = new Web3(
			new Web3.providers.HttpProvider(process.env.WEB3_PROVIDER)
		);
		let id = req.query.id
	
	// Load Contracts
		const contract = new web3.eth.Contract(NFTCollection.abi, collectionDeployedNetworkAddress);
		const hash = await contract.methods.tokenURI(id).call();
		const response = await fetch(hash);
		if(!response.ok) {
			throw new Error('Something went wrong');
		}

		const metadata = await response.json();
		// alert(metadata)
		const owner = await contract.methods.ownerOf(id).call();
		//load total supply
		let item = {
			id: id,
			title: metadata.name,
			img: metadata.image,
			owner: owner
		}
		return res.status(200).json(item)
	} catch (error) {
		console.log(error)
		return res.status(500).json({msg: "Internal server error!!"})
	}
	
}

export const getCollection = async (req, res, next) => {
	try {
		const web3 = new Web3(
			new Web3.providers.HttpProvider(process.env.WEB3_PROVIDER)
		);
		let collection = [];
		const contract = new web3.eth.Contract(NFTCollection.abi, collectionDeployedNetworkAddress);
		const totalSupply = await contract.methods.totalSupply().call();
		console.log(totalSupply)
		console.time();
		for(let i = 0; i < totalSupply; i++) {
			const hash = await contract.methods.tokenURI(i+1).call();
			console.log("hash", hash)
			const response = await fetch(hash);
			if(!response.ok) {
				throw new Error('Something went wrong');
			}
			const metadata = await response.json();
			const owner = await contract.methods.ownerOf(i + 1).call();
			collection = [{
				id: i + 1,
				title: metadata.name,
				img: metadata.image,
				owner: owner
			}, ...collection];
			console.log("collection", collection)
		}
		console.timeEnd()
		return res.status(200).json(collection)
		
		
	} catch (error) {
		console.log(error)
		return res.status(500).json({msg: "Internal server error!!"})
	}
   
}