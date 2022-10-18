import User from "../../models/user.model.js";
import Service from "../../models/service.model.js";
import lightwallet from "eth-lightwallet"
/**
 * Function to check if user had wallet account, else create new wallet for user
 * @param {*} req 
 * @param {*} res 
 * @param {*} next 
 */

const walletVerifier = async (req, res, next) => {
	try {
		let userEmail = req.jwtDecoded.email;
		let client_id = req.jwtDecoded.client_id
		const user = await User.findOne({email: userEmail})
		const service = await Service.findOne({client_id: client_id})
		// if user wallet exist
		if(user) {
			//check if user has logged to this service before
			if(user.servicesUsed.some(s => service._id.toString() === s.serviceId.toString())){
				next()
			}else {
				// if user login new service, update
				let newServicesUsed = JSON.parse(JSON.stringify(user.servicesUsed))
				newServicesUsed.push({serviceId: service._id,})
				const updatedUser = await User.findOneAndUpdate(
					{ email: userEmail },
					{ servicesUsed: newServicesUsed },
					{ new: true }
				);
				next()
			}
		// if user wallet not exist
		}else {
			let randomSeed = lightwallet.keystore.generateRandomSeed();
			
			lightwallet.keystore.createVault({
				password: process.env.SECRET,
				seedPhrase: randomSeed,
				hdPathString: 'm/0\'/0\'/0\''
			}, function (err, ks) {
				if (err) throw err;
				ks.keyFromPassword(process.env.SECRET, async function (err, pwDerivedKey) {
					if (err) throw err;
					ks.generateNewAddress(pwDerivedKey, 1)
					// console.log("ks", ks)
					let addr = ks.getAddresses();
					const newUser = new User({
						email: userEmail,
						keystore: ks.serialize(),
						publicAddress: addr[0],
						servicesUsed: [{serviceId: service._id}],
						name: req.jwtDecoded.name
					});
					newUser.save(async (err, addedUser) => {
						if (err) throw err;
						next()
						// console.log();
						// return res.status(200).json({msg: "Login successfully!", data: addedUser})
					})
				})
			})
		}
	} catch (error) {
		console.log(error)
		res.status(500).json({msg: "Error when verify wallet"})
	}
};

export default {
	walletVerifier: walletVerifier,
};