import { OAuthStrategies } from "./strategy/OAuthStrategies.js";
import requestPromise from "request-promise";
import jwt from "jsonwebtoken";
import User from "../../models/user.model.js";

export const authUrl = async (req, res, next) => {
	console.log("api call");
	const { clientId, redirect_uri } = req.query;
	console.log("req.query", req.query);
	const oAuthStrategies = new OAuthStrategies(clientId, redirect_uri);
	const authStrategy = oAuthStrategies.getStrategy();

	res.send({
		url: authStrategy.getAuthUrl()
	});
}

export const authToken = async (req, res, next) => {
	const {code, clientId, redirect_uri} = req.body.data;
	console.log(" req.body.data", req.body.data);
	const oAuthStrategies = new OAuthStrategies(clientId, redirect_uri);
	const authStrategy = oAuthStrategies.getStrategy();
	requestPromise(authStrategy.getAuthTokenOptions(code))
	.then(async tokenRes => {
		const jwtAccessToken = jwt.decode(JSON.parse(tokenRes).access_token);
		console.log("jwtAccessToken", jwtAccessToken);
		const user = authStrategy.getUser(jwtAccessToken);
		const userFind = await User.findOne({username: user.username}, "publicAddress").exec()
		if(!userFind) {
			console.log("Not found user, contact admin for more information!");
			return res.status(404).send({msg: "Not found user, contact admin for more information!"});
		}
		console.log(`User ${user.username} successfully logged in.`);
		res.cookie("refresh_token", JSON.parse(tokenRes).refresh_token, {
			httpOnly: true,
			secure: true,
			sameSite: 'lax'
		});

		res.status(200).send({
			authToken: JSON.parse(tokenRes).access_token,
			user: {
				...user,
				publicAddress: userFind.publicAddress,
				_id: userFind._id.valueOf()
			},
		});
	})
	.catch(error => {
		console.error("Error in Auth Token", error.message);
		const status = error.statusCode || 500
		res.sendStatus(status).json({
			msg: "Error in Auth Token"
		});
	});
}

export const reAuth = async (req, res, next) => {
	const {clientId} = req.body.data;
	const oAuthStrategies = new OAuthStrategies(clientId);
	const authStrategy = oAuthStrategies.getStrategy();
	let token = req.headers.authorization.split(" ")[1]
	requestPromise(authStrategy.getTokenUrlOptions(token))
	.then(async response => {
		// if the request status isn't "OK", the token is invalid
		if (JSON.parse(response).active !== true) {
			res.status(401).json({
				error: `Unauthorized`,
			});
		}else {
			const user = authStrategy.getUser(JSON.parse(response));
			const userFind = await User.findOne({username: user.username}).exec()
			res.status(200).send({
				user: {
					...user,
					publicAddress: userFind.publicAddress,
					_id: userFind._id.valueOf()
				}
			});
		}
		
		})
	.catch(error => {
		console.error("Error in Re Auth Token", error);
		res.send(error.statusCode);
	});
}

export const refreshToken = async (req, res, next) => {
	console.log("REFRESH TOKEN....");
	const { clientId } = req.query;
	const oAuthStrategies = new OAuthStrategies(clientId);
	const authStrategy = oAuthStrategies.getStrategy();
	let refreshToken = req.cookies.refresh_token
	requestPromise(authStrategy.getATfromRTOptions(refreshToken))
	.then(response => {
		// console.log(JSON.parse(response));
		res.cookie("refresh_token", JSON.parse(response).refresh_token, {
			httpOnly: true,
			secure: true,
			sameSite: 'lax'
		});
		res.status(200).send({
			authToken: JSON.parse(response).access_token,
		});
	})
	.catch(error => {
		console.error(error.error);
		res.sendStatus(error.statusCode);
	});
	
}


export const logout = async (req, res, next) => {
	const { clientId } = req.query;
	const oAuthStrategies = new OAuthStrategies(clientId);
	const authStrategy = oAuthStrategies.getStrategy();

	res.send({
		url: authStrategy.getLogoutUrl()
	});
}