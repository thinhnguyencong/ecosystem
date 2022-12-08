import mongoose from 'mongoose';
import Folder from '../models/folder.model.js';
import User from '../models/user.model.js';
import lightwallet from "eth-lightwallet"
import Department from '../models/department.model.js';
import Project from '../models/project.model.js';

mongoose.connect('mongodb://localhost:27017/ecosystem', {
    useUnifiedTopology: true,
    useNewUrlParser: true,
});

const numUsers = 100
let usersFind = await User.find({})
let listDepts = await Department.find({})
let listProject = await Project.find({})
let listDeptsId = listDepts.map(x=> x._id.valueOf())
let listProjectId = listProject.map(x=> x._id.valueOf())
console.log(listProjectId);
for(let i = 0; i<usersFind.length; i++){
    console.log(i);
    let filter = {
        username: usersFind[i].username
    }
    console.log(listProjectId[Math.floor(Math.random()*listProjectId.length)]);
    let update = {
        dept: listDepts[Math.floor(Math.random()*listDepts.length)]._id.valueOf(),
        project: [listProjectId[Math.floor(Math.random()*listProjectId.length)]]
    }
    let newUser = await User.findOneAndUpdate(filter, update, {
        new: true
    });
}
console.log("Update user department successfully");

// create mock users
for(let i = 0; i<numUsers; i++){
    let randomSeed = lightwallet.keystore.generateRandomSeed();
			
    lightwallet.keystore.createVault({
        password: "123456",
        seedPhrase: randomSeed,
        hdPathString: 'm/0\'/0\'/0\''
    }, function (err, ks) {
        if (err) throw err;
        ks.keyFromPassword("123456", async function (err, pwDerivedKey) {
            if (err) throw err;
            ks.generateNewAddress(pwDerivedKey, 1)
            // console.log("ks", ks)
            let addr = ks.getAddresses();
            const newUser = new User({
                username: "testuser"+i,
                email: "testemail"+i,
                keystore: ks.serialize(),
                publicAddress: addr[0],
                name: "name"+ i,
                dept: listDeptsId[Math.floor(Math.random()*listDeptsId.length)],
                project: [listProjectId[Math.floor(Math.random()*listProjectId.length)]]
            });
            newUser.save(async (err, addedUser) => {
                if (err) throw err;
                let userAdded = {...addedUser, _id: addedUser._id.valueOf()}
                const myFolder = new Folder({
                    name: "My Folder", 
                    owner: userAdded._id,
                }) 
                await myFolder.save()
            })
        })
    })
}
console.log("Create mock user successfully");



// process.exit()