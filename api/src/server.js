import express, { response } from "express";
import dotenv from "dotenv";
import dotenvExpand from "dotenv-expand"
import cors from "cors";
import cookieParser from 'cookie-parser'
import mongoose from 'mongoose';
import services from './services/index.js';
import connectDB from './config/dbConnection.js';

const myEnv = dotenv.config()
dotenvExpand.expand(myEnv)

const app = express();
connectDB()
const PORT = process.env.PORT || 5555;

const allowedOrigins = process.env.ALLOWED_ORIGINS.split(',').map(origin=>origin.trim());

const corsOptions ={
  // origin: (origin, callback) => {
  //   allowedOrigins.includes(origin) ? callback(null, true) : callback(new Error('Not allowed by CORS'))
  // },
  origin: true,
  credentials:true,            //access-control-allow-credentials:true
  optionSuccessStatus:200,
}

app.use(express.json());

app.use(cookieParser())

app.use(cors(corsOptions));

app.use('/api', function (req, res, next) {
  res.header("Access-Control-Allow-Methods", "GET,HEAD,OPTIONS,POST,PUT");
  res.header('Access-Control-Allow-Credentials', true); 
  res.header("Access-Control-Allow-Headers", "Origin, X-Requested-With, contentType,Content-Type, Accept, Authorization");
  next();
}, services);

app.get("/health", (req, res) => {
  console.log("cookies health", req.cookies);
  res.status(200).send({ message: "Health is good" });
});

mongoose.connection.once('open', () => {
  console.log('Connected to MongoDB');
  app.listen(PORT, () =>
      console.log(`Express app listening on localhost:${PORT}`)
  );
});
