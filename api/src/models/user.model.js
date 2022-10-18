import mongoose from "mongoose";
const Schema = mongoose.Schema

const userSchema = new Schema({
    publicAddress: {
        type: Schema.Types.String,
        required: true,
    },
    keystore: {
        type: Schema.Types.String,
        required: true,
    },
    email: {
        type: Schema.Types.String,
        required: true,
    },
    name: {
        type: Schema.Types.String,
        required: false,
    },
    servicesUsed: [
        {
            serviceId: {
                type: Schema.Types.ObjectId,
                ref: "Service"
            },
            transactions: [
                {
                    type: Schema.Types.ObjectId,
                    ref: "Transaction"
                }
            ]
        }
    ]
})
const User = mongoose.model('User', userSchema);
export default User