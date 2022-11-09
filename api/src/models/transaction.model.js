import mongoose from "mongoose";
const Schema = mongoose.Schema

const transactionSchema = new Schema({
    transactionHash: {
        type: Schema.Types.String,
        required: true,
    },
    blockNumber: {
        type: Schema.Types.String,
        required: true,
    },
})
const Transaction = mongoose.model('Transaction', transactionSchema);
export default Transaction