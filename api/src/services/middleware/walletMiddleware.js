import jwtHelper from "../helpers/jwt.helper.js"
import jwt from "jsonwebtoken"
 // secretKey
 const accessTokenSecret = process.env.ACCESS_TOKEN_SECRET
 
 /**
  * Middleware: Authorization user by Token
  * @param {*} req 
  * @param {*} res 
  * @param {*} next 
  */
 let isAuth = async (req, res, next) => {
   const tokenFromClient = req.headers["authorization"];

   if (tokenFromClient) {
     try {
        jwt.verify(tokenFromClient, process.env.TOKEN_SECRET, function(err, decoded) {
            if (err) throw err;
            // console.log(decoded) // bar
            req.jwtDecoded = decoded;
            next();
        });
       
     } catch (error) {
        console.log("error", error)
       return res.status(401).json({
         msg: 'Unauthorized.',
       });
     }
   } else {
     // Không tìm thấy token trong request
     console.log("xxx")
     return res.status(403).json({
       msg: 'No token provided.',
     });
   }
 }
 
export default {
   isAuth: isAuth,
 };
 