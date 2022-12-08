import mongoose from "mongoose";
const Schema = mongoose.Schema

const deptSchema = new Schema({
    name: {
        type: Schema.Types.String,
        required: true,
    },
    description: {
        type: Schema.Types.String,
        required: false,
    }
},
{
    timestamps: true
})
const Department = mongoose.model('Department', deptSchema);
export default Department