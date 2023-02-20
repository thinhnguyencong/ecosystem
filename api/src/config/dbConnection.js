import mongoose from 'mongoose';

const connectDB = async () => {
    return mongoose.connect(process.env.DATABASE_URI, { useNewUrlParser: true, useUnifiedTopology: true }, (err) => {
        if (err) {
          console.error('Failed to connect to mongo on startup - retrying in 5 sec', err)
          setTimeout(connectDB, 5000)
        }
      })
}

export default connectDB;