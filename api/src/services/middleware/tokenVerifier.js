import jwt from "jsonwebtoken";
import requestPromise from "request-promise";

const tokenVerifier = (req, res, next) => {
  let authHeader = req.headers.authorization;

  if (!authHeader) {
    return res.status(403).send({ auth: false, message: "No token provided" });
  }
  let token = authHeader.split(" ")[1];
  requestPromise({
    method: "POST",
    uri: process.env.KEYCLOAK_DEMO_SSO_TOKEN_INTROSPECT,
    form: {
      client_id: process.env.KEYCLOAK_DEMO_SSO_CLIENT_ID,
      client_secret: process.env.KEYCLOAK_DEMO_SSO_CLIENT_SECRET,
      token: token
    }
  })
    .then(response => {
       //if the response token is active, proceed to next action
      if(JSON.parse(response).active === true){
        req.jwtDecoded = JSON.parse(response);
        //console.log(JSON.parse(response));
        next();
      }
      else {
        if(req.cookies.refresh_token) {
          res.status(403).json({
            error: `Invalid credentials`,
          });
        }else {
          res.status(401).json({
            error: `Unauthorized`,
          });
        }
      }
      
    })
    .catch(error => {
      console.error("Error in Authenticate Token", error.error);
      res.sendStatus(error.statusCode);
    });
};

export default {
  tokenVerifier: tokenVerifier,
};