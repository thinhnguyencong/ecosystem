import mongoose from "mongoose";
const Schema = mongoose.Schema

const roleSchema = new Schema({
    name: {
        type: Schema.Types.String,
        required: true,
    },
    description: {
        type: Schema.Types.String,
        required: false,
    },
    type: {
        type: Schema.Types.String,
        required: true,
    },
},
{
    timestamps: true
})
const Role = mongoose.model('Role', roleSchema);
export default Role