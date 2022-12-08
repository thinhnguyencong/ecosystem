import mongoose from "mongoose";
const Schema = mongoose.Schema

const serviceSchema = new Schema({
    client_id: {
        type: Schema.Types.String,
        required: true,
    },
    name: {
        type: Schema.Types.String,
        required: true,
    },
    link: {
        type: Schema.Types.String,
        required: false,
    }
},
{
    timestamps: true
})
const Service = mongoose.model('Service', serviceSchema);
export default Service