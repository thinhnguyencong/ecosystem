import mongoose from "mongoose";
const Schema = mongoose.Schema

const fileSchema = new Schema({
    tokenId: {
        type: Schema.Types.String,
        required: false,
    },
    hash: {
        type: Schema.Types.String,
        required: true,
    },
    tokenURI: {
        type: Schema.Types.String,
        required: true,
    },
    owner: {
        type: Schema.Types.String,
        required: true,
    },
    description: {
        type: Schema.Types.String,
        default: "No Description"
    },
    parentFolder: {
        type: Schema.Types.String,
        required: true,
    },
    shared: {
        type: [Schema.Types.String],
        default: null,
    },
    key: {
        type: Schema.Types.String,
        default: null,
    },
    comments: [{
        userId: {
            type: Schema.Types.String,
            default: null,
        },
        name: {
            type: Schema.Types.String,
            default: null,
        },
        content: {
            type: Schema.Types.String,
            default: null,
        },
        attachments: {
            type: [{
                id: Schema.Types.String,
                name: Schema.Types.String
            }],
            default: null,
        },
        createdAt: {
            type: Number,
            default: new Date(),
        }
    }],
    isSharedPublic: {
        type: Boolean,
        default: false
    }
},
{
    timestamps: true
})
const File = mongoose.model('File', fileSchema);
export default File