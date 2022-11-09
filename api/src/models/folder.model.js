import mongoose from "mongoose";
const Schema = mongoose.Schema

const folderSchema = new Schema({
    name: {
        type: Schema.Types.String,
        required: true,
    },
    parent: {
        type: Schema.Types.ObjectId,
        required: true,
    },
})
const Folder = mongoose.model('Folder', folderSchema);
export default Folder