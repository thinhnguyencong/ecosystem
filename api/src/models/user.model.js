import mongoose from "mongoose";
const Schema = mongoose.Schema

const Notifications = new Schema ( {
    content : String,
    from : String,
    type: {
        type: Schema.Types.String,
        enum: ['file', 'folder'],
        required : true 
    },
    documentId: String,
    read : { type: Boolean, default : false },
    new : { type: Boolean, default : true }
}, {
    timestamps: true
});
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
        required: true,
    },
    username: {
        type: Schema.Types.String,
        required: true,
    },
    dept: {
        type: Schema.Types.String,
        required: false,
        default: null,
    },
    role:{
        type: Schema.Types.String,
        default: null,
    },
    position: {
        type: Schema.Types.String,
        required: false,
    },
    project:  [{
        type: Schema.Types.String,
        default: null,
    }],
    servicesUsed: [
        {
            serviceId: {
                type: Schema.Types.ObjectId,
                ref: "Service"
            },
            transactions: [Schema.Types.String],
        }
    ],
    notifications: [Notifications],
    recent: [
        {
            documentId: Schema.Types.String,
            type: {
                type: Schema.Types.String,
                enum: ['file', 'folder'],
                required : true 
            },
            lastAccess: {
                type: Number,
                default: new Date(),
                required : true 
            },
        }
    ]
}, 
{
    timestamps: true
}
)
const User = mongoose.model('User', userSchema);
export default User