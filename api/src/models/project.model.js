import mongoose from "mongoose";
const Schema = mongoose.Schema

const projectSchema = new Schema({
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
const Project = mongoose.model('Project', projectSchema);
export default Project