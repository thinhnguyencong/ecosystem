import User from "../../models/user.model.js";
import Service from "../../models/service.model.js";

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
		//check if user has logged to this service before
		if(user?.servicesUsed.some(s => service._id.toString() === s.serviceId.toString())){
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
	} catch (error) {
		console.log(error)
		res.status(500).json({msg: "Error when verify wallet"})
	}
};

export default {
	walletVerifier: walletVerifier,
};