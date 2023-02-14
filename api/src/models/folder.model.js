import mongoose from "mongoose";
const Schema = mongoose.Schema

const folderSchema = new Schema({
    name: {
        type: Schema.Types.String,
        required: true,
    },
    type: {
        type: Schema.Types.String,
        default: "normal"
    },
    parent: {
        type: Schema.Types.String,
        default : null
    },
    ancestors: {
        type: [Schema.Types.String],
        default: null,
    },
    files: [Schema.Types.String],
    owner : {
        type: Schema.Types.String,
        default : null
    },
    shared: {
        type: [Schema.Types.String],
        default: null,
    },
    hidden: [Schema.Types.String],
    favorite: [Schema.Types.String]
},
{
    timestamps: true
})
// folderSchema.index({ ancestors: 1 }); 
const Folder = mongoose.model('Folder', folderSchema);
export default Folder