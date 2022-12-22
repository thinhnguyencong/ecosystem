import { OAuthStrategies } from "./strategy/OAuthStrategies.js";
import requestPromise from "request-promise";
import jwt from "jsonwebtoken";

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
	const oAuthStrategies = new OAuthStrategies(clientId, redirect_uri);
	const authStrategy = oAuthStrategies.getStrategy();
	requestPromise(authStrategy.getAuthTokenOptions(code))
	.then(tokenRes => {
		const jwtAccessToken = jwt.decode(JSON.parse(tokenRes).access_token);
		const user = authStrategy.getUser(jwtAccessToken);

		console.log(`User ${user.username} successfully logged in.`);
		res.cookie("refresh_token", JSON.parse(tokenRes).refresh_token, {
			httpOnly: true,
			secure: true,
			sameSite: 'lax'
		});

		res.status(200).send({
			authToken: JSON.parse(tokenRes).access_token,
			user: user,
		});
	})
	.catch(error => {
		console.error("Error in Auth Token", error.error);
		const status = error.statusCode || 500
		res.sendStatus(status);
	});
}

export const reAuth = async (req, res, next) => {
	const {clientId} = req.body.data;
	const oAuthStrategies = new OAuthStrategies(clientId);
	const authStrategy = oAuthStrategies.getStrategy();
	let token = req.headers.authorization.split(" ")[1]
	requestPromise(authStrategy.getTokenUrlOptions(token))
	.then(response => {
		// if the request status isn't "OK", the token is invalid
		if (JSON.parse(response).active !== true) {
			res.status(401).json({
				error: `Unauthorized`,
			});
		}else {
			res.status(200).send({
				//authToken: token,
				user: {
					username: JSON.parse(response).preferred_username,
					name: JSON.parse(response).family_name + " " + JSON.parse(response).given_name
				},
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