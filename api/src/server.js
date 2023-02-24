import express, { response } from "express";
import morgan from "morgan"
import chalk from 'chalk';
import dotenv from "dotenv";
import dotenvExpand from "dotenv-expand"
import cors from "cors";
import cookieParser from 'cookie-parser'
import mongoose from 'mongoose';
import { Server } from 'socket.io';
import { createServer } from "http";
import services from './services/index.js';
import connectDB from './config/dbConnection.js';

const myEnv = dotenv.config()
dotenvExpand.expand(myEnv)
process.env.NODE_TLS_REJECT_UNAUTHORIZED = "0" //config for HTTPS connection

const app = express();
const httpServer = createServer(app);
connectDB()
const PORT = process.env.PORT || 5555;

const allowedOrigins = process.env.WHITELIST.split(',').map(origin=>origin.trim());

const corsOptions ={
  origin: process.env.ALLOWED_ALL_ORIGINS=='true' ? true : (origin, callback) => {
    allowedOrigins.includes(origin) ? callback(null, true) : callback(new Error('Not allowed by CORS'))
  },
  credentials:true,            //access-control-allow-credentials:true
  optionSuccessStatus:200,
}


const morganMiddleware = morgan(function (tokens, req, res) {
    return [
        '\n',
        // chalk.hex('#ff4757').bold('🍄  Morgan --> '),
        chalk.hex('#34ace0')(tokens.method(req, res)),
        chalk.hex('#ffb142')(tokens.status(req, res)),
        chalk.hex('#ff5252')(tokens.url(req, res)),
        chalk.hex('#2ed573').bold(tokens['response-time'](req, res) + ' ms'),
        // chalk.hex('#f78fb3').bold('@ ' + tokens.date(req, res)),
        // chalk.yellow(tokens['remote-addr'](req, res)),
        chalk.hex('#fffa65')('from ' + tokens.referrer(req, res)),
        // chalk.hex('#1e90ff')(tokens['user-agent'](req, res)),
        ,
    ].join(' ');
});

app.use(morganMiddleware);

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

// set Socket io global variable
global.SOCKET_IO = new Server(httpServer, { cors: { origin: process.env.ALL_ALLOWED_ORIGINS=='true' ? '*' : allowedOrigins } });
global.CONNECTED_USERS = [];

// register a middleware which checks the userId and allows the connection:
SOCKET_IO.use((socket, next) => {
  const userId = socket.handshake.auth.userId;
  if (!userId) {
    return next(new Error("invalid user Id"));
  }
  socket.userId = userId;
  next();
});

SOCKET_IO.on('connection', (socket) => {
    CONNECTED_USERS.push({
      userId: socket.userId,
      socketId: socket.id
    });
  socket.emit("users", CONNECTED_USERS);
  
  socket.on("disconnect", function () {
    CONNECTED_USERS = CONNECTED_USERS.filter(
      (user) => user.socketId !== socket.id
    );
  });
});


mongoose.connection.once('open', () => {
  console.log('Connected to MongoDB');
  httpServer.listen(PORT, () =>
      console.log(`Express app listening on localhost:${PORT}`)
  );
});
