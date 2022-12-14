import axios from "axios"
import User from "../../models/user.model.js";
import lightwallet from "eth-lightwallet"
import Folder from "../../models/folder.model.js";
import Department from "../../models/department.model.js";

export const getAllUsers = async (req, res, next) => { 
	let usersFind = await User.find({})
	let users = usersFind.map(user=> (
		{ 
			_id: user._id.valueOf(),
			name: user.name,
			username: user.username,
			email: user.email,
			publicAddress: user.publicAddress,
			role: user.role,

		}))
	// console.log(users);
   
	
	res.status(200).send({
		data: users
	});
	
}

export const getUsersByListRoles = async (req, res, next) => { 
	
}
export const createUser = async (req, res, next) => { 
	let token = req.headers.authorization
	let {username, password, email, firstName, lastName, dept, role} = req.body.data
	if(!username || !password || !email || !firstName || !lastName || !dept || !role) {
		return res.status(400).send({
			msg: "Missing parameters"
	  });
	}
	let data = JSON.stringify({
		enabled: true,
		username: username,
		email: email,
		firstName: firstName,
		lastName: lastName,
		groups: ["user-dms"],
		credentials: [
			{
				type: "password",
				value: password,
				temporary: true
			}
		]
	  });

	  let config = {
			method: 'post',
			url: process.env.KEYCLOAK_USERS_URL,
			headers: { 
				'Authorization': token,
				'Content-Type': 'application/json'
			},
			data : data
	  }
	  axios(config)
		.then(function (response) {
			let randomSeed = lightwallet.keystore.generateRandomSeed();
			try {
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
							username: username,
							email: email,
							keystore: ks.serialize(),
							publicAddress: addr[0],
							name: firstName + " " + lastName,
							role: role,
							dept: dept
						});
						newUser.save(async (err, addedUser) => {
							if (err) throw err;
							let userAdded = { 
								_id: addedUser._id.valueOf(), 
								username: addedUser.username,
								email: addedUser.email,
								publicAddress: addedUser.publicAddress,
								name: addedUser.name,
								role: addedUser.role,
								dept: addedUser.dept
							}
							console.log("userAdded", userAdded);

							// create "My Folder" for user
							const myFolder = new Folder({
								name: "My Folder", 
								owner: userAdded._id,
							}) 
							await myFolder.save()

							//add user to Department Internal Folder
							let department = await Department.findById(dept)
							const filter = { name: department.name, type: "internal" };
							let folderUpdated = await Folder.findOneAndUpdate(filter, {$push: {shared: userAdded._id }})
							console.log("folderUpdated", folderUpdated);
							return res.status(200).send({
								data: userAdded,
								msg: "Create new user successfully"
							});
						})
					})
				})
			} catch (error) {
				return res.status(500).send({
					msg: "Error when create new user"
				});
			}
		})
		.catch(function (error) {
			console.error("Error in create user", error.response.data.errorMessage);
			return res.status(error.response.status).send({
				msg: error.response.data.errorMessage
			});
		});
}
// export const createUser = async (req, res, next) => { 
	
// }
// export const createUser = async (req, res, next) => { 
	
// }