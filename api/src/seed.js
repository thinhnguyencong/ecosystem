import mongoose from 'mongoose';
import dotenv from "dotenv";
import dotenvExpand from "dotenv-expand"
import lightwallet from "eth-lightwallet"
import axios from 'axios';
import Department from './models/department.model.js';
import Folder from './models/folder.model.js'
import Project from './models/project.model.js';
import Role from './models/role.model.js';
import User from './models/user.model.js';
import File from './models/file.model.js';
import Service from './models/service.model.js';
import connectDB from './config/dbConnection.js';

process.env.NODE_TLS_REJECT_UNAUTHORIZED = "0"
const myEnv = dotenv.config()
dotenvExpand.expand(myEnv)
await connectDB()
const initDB = async () => {
    const listDepts = [
        { name: "AI" }, 
        { name: "Blockchain" },
        { name: "BA"}, 
        { name: "BrSE"},
        { name: "Comtor" }, 
        { name: "Designer"}, 
        { name: "DEV"},
        { name: "HR"},
        { name: "Accounting" }, 
        { name: "KPI"}, 
        { name: "Marketing"},
        { name: "QA/Tester"},
        { name: "UX/UI"},
    ]

    const listProject = [
        {name: "Project Breeze"},
        {name: "Momentum Program"},
        {name: "Strategic Program"},
        {name: "Project Chroma"},
        {name: "Module Program"},
        {name: "Project More"},
        {name: "Project Signal"},
        {name: "Quest Program"},
        {name: "Project Force"},
        {name: "Native Program"},
        {name: "Project Systems"},
        {name: "Magnetic Program"},
        {name: "Project Illuminate"},
        {name: "Project Zen"},
        {name: "Dynamic Program"},
        {name: "Project Synergy"},
        {name: "Program Pad"},
        {name: "Project Point"},
        {name: "Command Program"},
    ]
    const roles = [
        { name: "Admin", type: "admin"},
        { name: "Chairperson", type: "chairperson"},
        { name: "Board of Director", type: "bod"},
        { name: "Manager", type: "manager"},
        { name: "Employee", type: "employee"}, 
    ]

    const listService = [
        { name: "Wallet Management", client_id: "wallet"},
        { name: "Auction", client_id: "auction"},
        { name: "Document Management System", client_id: "dms"},
    ]
    function isAdmin(role) {
        return role.type === "admin";
    }
    function isBod(role) {
        return role.type === "bod";
    }
    function isChairperson(role) {
        return role.type === "chairperson";
    }
    function isManager(role) {
        return role.type === "manager";
    }
    function isEmployee(role) {
        return role.type === "employee";
    }

    await Folder.deleteMany({})
    console.log('Folder collection removed') 
    await Project.deleteMany({})
    console.log('Project collection removed') 
    await Department.deleteMany({})
    console.log('Department collection removed') 
    await User.deleteMany({})
    console.log('User collection removed') 
    await Role.deleteMany({})
    console.log('Role collection removed') 
    await File.deleteMany({})
    console.log('File collection removed') 
    await Service.deleteMany({})
    console.log('Service collection removed') 
    
    const publicFolders = [
        { name: "Public", type: "public" }, 
        { name: "Paper", type: "public" }, 
    ]
    const internalFolders = listDepts.map(x=> ({name: x.name, type: "internal"}))
    const rootFolders = publicFolders.concat(internalFolders)
    const rootFoldersAdded = await Folder.insertMany(rootFolders)
    if(rootFoldersAdded) {
        console.log("Insert successfully public folders");
        console.log("Insert successfully internal folders");
    } else {
        console.error("Failed to insert rootFolders");
    }
  
    const projectAdded = await Project.insertMany(listProject)
    if(projectAdded) {
        console.log("Insert successfully projects");
    } else {
        console.error("Failed to insert projects");
    }
     
    const deptsAdded = await Department.insertMany(listDepts)
    if(deptsAdded) {
        console.log("Insert successfully departments");
    } else {
        console.error("Failed to insert departments");
    }

    const rolesAdded = await Role.insertMany(roles)
    const listRoles = rolesAdded.map(x=> ({_id: x._id.valueOf(), name: x.name, type: x.type}))

    const listServiceAdded = await Service.insertMany(listService)
    if(listServiceAdded) {
        console.log("Insert successfully services");
    } else {
        console.error("Failed to insert services");
    }

    const userList = [
        {
            username: "admin",
            email: "admin@dms-grooo.com.vn",
            keystore: null,
            publicAddress: null,
            firstName: "Admin",
            lastName: "",
            role: listRoles.find(isAdmin)._id,
            groups: ["admin-dms"],
            emailVerified: true
        },
        {
            username: "admin1",
            email: "admin1@dms-grooo.com.vn",
            keystore: null,
            publicAddress: null,
            firstName: "Admin 1",
            lastName: "",
            role: listRoles.find(isAdmin)._id,
            groups: ["admin-dms"],
            emailVerified: true
        },
        // {
        //     username: "cperson",
        //     email: "cperson@dms-grooo.com.vn",
        //     keystore: `{"encSeed":{"encStr":"5bcDmoRSxGi5KfipYqZT6LnwitQiBDmfBYXeK6Pe/OSudyjIfhNZGKL7a9OjQdF2JLmCsVZNfL0Lju5DE3GmhlNRcr2brH69GuqZWf/W5cHXMw6Rb5coNbGLPV+W6aUc3eZbeHDamEEUE7Vh1WqYJ3XwIs9gsysw3vojkKONFnAQ0VVoJ5v3Fw==","nonce":"ziWIeqplalezrClFuwUUOau2tYkw5/Pq"},"encHdRootPriv":{"encStr":"p07h35Gb7Vu/LBdtn5N1syk6tXYJAWFHR3cqdfHPDEocUEQEcD2TZR8RnmC/U1lwSDxhepSzQf9ZZQgx85inipMWSM4NBMGJMPR9gVzATDdpQuU5MFEXX99ZK3iRwMs8X/CMpWgzIrTFlitgSLfEvTD3KPGF7Y+EsCQ1afHfRA==","nonce":"VNM9ZBii3TAKw7lSfJv1xmkzGqhpQB3F"},"addresses":[],"encPrivKeys":{},"hdPathString":"m/0'/0'/0'","salt":"dwweJ/lWb0eYFxoLL08CCbvrJgvgXiaYJYCQF6MDcdQ=","hdIndex":0,"version":3}`,
        //     publicAddress: "0x09876c96F80247184921f24547c861c99083f602",
        //     firstName: "Si Chun",
        //     lastName: "Kim",
        //     role: listRoles.find(isChairperson)._id,
        //     groups: ["user-dms"],
        //     emailVerified: true
        // },
        // {
        //     username: "bod",
        //     email: "bod@dms-grooo.com.vn",
        //     keystore: `{"encSeed":{"encStr":"vK8KVzjwxv2fQWFcp8dtTp3xgCdTpOJDVun2OdvYCrpIwjIhL13vvbQR1wHuOKpY1GppAZUO6RHfdzhXTpnYfCDDumwVQSpWqKAX5yNRPZ8Ve+x1BhC0GdWIifkeexUpyf7dWJUXxKzkvLyHEak/WNIVT+wwHw/cgQnKY9VzyOeZnYZ6C+65Yw==","nonce":"sdiUYpsGW7N0vqJZayQAEfhx4PUUImNb"},"encHdRootPriv":{"encStr":"wLartzZK7/CrtOWwgWUNM8cITfpQSZMCmLyYNJFfZeFWsvi/tkg5X9GXOmVTM55d1bm+acLPF4AfEDLiqlglt8jC6Jk+X89gHtHttO0XwSvu2rONZC+ITXMptsxwmA248ZyAT5XLwnPiTvi99aOty9Hwmd59u7NIXluKqvROWg==","nonce":"E7G/0FkJOZA11x2hO6qpm+3FUlX37p79"},"addresses":["9f048a73735b6afee502ec605e08d83472857463","cc40cc0ba83048801e05ab6bcf3cdb827e31c488","9b17b0612069258b3cc9187c5a96107b8cc7968d","fe47e32e697532bba14ee50458055d1b80de4657","ff8ce8c35a2222c573352d182c50505010973244"],"encPrivKeys":{"9f048a73735b6afee502ec605e08d83472857463":{"key":"Oilu1IuI/zVTk0EOcKO4lalsgbEcmCnn1tuRGj94RelYK/4ZfUo3m/sbwG+QAFT0","nonce":"ofhgC5K+Ys10J7LFokpMUu1WmzElcOAc"},"cc40cc0ba83048801e05ab6bcf3cdb827e31c488":{"key":"43Ag+gMn45vRw92cCMpqyh4yMcViYLXPaYSmlnu2TXE00ONQFtMrP146zxDkaJHZ","nonce":"r3O6GMamtZOJ9Wu8SPCe2Hpzb4fTYghU"},"9b17b0612069258b3cc9187c5a96107b8cc7968d":{"key":"So9W5QfmIrIZiJn4dAkE4pbl98alrs2pYaTYtqDSf5/w+Ibx8B9DOpqDE+neREZ6","nonce":"Tgip+KSB3pbNQQjpCaVFUf7WRK3QpLJd"},"fe47e32e697532bba14ee50458055d1b80de4657":{"key":"dIuqZq1T9P99WXU2Ld5g/N/fMW522JukDYTvaVN8pX5rgEWOxwO0Jsx3UzAjGBeI","nonce":"dOBTux2+l7CRQatUTNshpLt+fXG1oDTS"},"ff8ce8c35a2222c573352d182c50505010973244":{"key":"g4rJrEWFPLPorpCSM9RN+Z/g+9aKoDXik/eN8N/P/JLCDUpFjBr1NnHk31f4npXJ","nonce":"tkvvfhJ+YpxlJDv7D1ah1pp9dfPUjEhy"}},"hdPathString":"m/0'/0'/0'","salt":"/k1/PWF2VJVmlb9PIJuITQR1igdA1U9AdAhiXFIZgD4=","hdIndex":5,"version":3}`,
        //     publicAddress: "0xfe47e32e697532bba14ee50458055d1b80de4657",
        //     firstName: "Minh Hien",
        //     lastName: "Nguyen",
        //     role: listRoles.find(isBod)._id,
        //     groups: ["user-dms"],
        //     emailVerified: true
        // },
        // {
        //     username: "bod1",
        //     email: "bod1@dms-grooo.com.vn",
        //     keystore: `{"encSeed":{"encStr":"vK8KVzjwxv2fQWFcp8dtTp3xgCdTpOJDVun2OdvYCrpIwjIhL13vvbQR1wHuOKpY1GppAZUO6RHfdzhXTpnYfCDDumwVQSpWqKAX5yNRPZ8Ve+x1BhC0GdWIifkeexUpyf7dWJUXxKzkvLyHEak/WNIVT+wwHw/cgQnKY9VzyOeZnYZ6C+65Yw==","nonce":"sdiUYpsGW7N0vqJZayQAEfhx4PUUImNb"},"encHdRootPriv":{"encStr":"wLartzZK7/CrtOWwgWUNM8cITfpQSZMCmLyYNJFfZeFWsvi/tkg5X9GXOmVTM55d1bm+acLPF4AfEDLiqlglt8jC6Jk+X89gHtHttO0XwSvu2rONZC+ITXMptsxwmA248ZyAT5XLwnPiTvi99aOty9Hwmd59u7NIXluKqvROWg==","nonce":"E7G/0FkJOZA11x2hO6qpm+3FUlX37p79"},"addresses":["9f048a73735b6afee502ec605e08d83472857463","cc40cc0ba83048801e05ab6bcf3cdb827e31c488","9b17b0612069258b3cc9187c5a96107b8cc7968d","fe47e32e697532bba14ee50458055d1b80de4657","ff8ce8c35a2222c573352d182c50505010973244"],"encPrivKeys":{"9f048a73735b6afee502ec605e08d83472857463":{"key":"Oilu1IuI/zVTk0EOcKO4lalsgbEcmCnn1tuRGj94RelYK/4ZfUo3m/sbwG+QAFT0","nonce":"ofhgC5K+Ys10J7LFokpMUu1WmzElcOAc"},"cc40cc0ba83048801e05ab6bcf3cdb827e31c488":{"key":"43Ag+gMn45vRw92cCMpqyh4yMcViYLXPaYSmlnu2TXE00ONQFtMrP146zxDkaJHZ","nonce":"r3O6GMamtZOJ9Wu8SPCe2Hpzb4fTYghU"},"9b17b0612069258b3cc9187c5a96107b8cc7968d":{"key":"So9W5QfmIrIZiJn4dAkE4pbl98alrs2pYaTYtqDSf5/w+Ibx8B9DOpqDE+neREZ6","nonce":"Tgip+KSB3pbNQQjpCaVFUf7WRK3QpLJd"},"fe47e32e697532bba14ee50458055d1b80de4657":{"key":"dIuqZq1T9P99WXU2Ld5g/N/fMW522JukDYTvaVN8pX5rgEWOxwO0Jsx3UzAjGBeI","nonce":"dOBTux2+l7CRQatUTNshpLt+fXG1oDTS"},"ff8ce8c35a2222c573352d182c50505010973244":{"key":"g4rJrEWFPLPorpCSM9RN+Z/g+9aKoDXik/eN8N/P/JLCDUpFjBr1NnHk31f4npXJ","nonce":"tkvvfhJ+YpxlJDv7D1ah1pp9dfPUjEhy"}},"hdPathString":"m/0'/0'/0'","salt":"/k1/PWF2VJVmlb9PIJuITQR1igdA1U9AdAhiXFIZgD4=","hdIndex":5,"version":3}`,
        //     publicAddress: "0xff8ce8c35a2222c573352d182c50505010973244",
        //     firstName: "Van Dam",
        //     lastName: "Pham",
        //     role: listRoles.find(isBod)._id,
        //     groups: ["user-dms"],
        //     emailVerified: true
        // },
    ]
    async function addUser(user) {
        let randomSeed = lightwallet.keystore.generateRandomSeed();
        lightwallet.keystore.createVault({
            password: process.env.SECRET,
            seedPhrase: randomSeed,
            hdPathString: 'm/0\'/0\'/0\''
        }, function (err, ks) {
            if (err) console.log(err);
            ks.keyFromPassword(process.env.SECRET, async function (err, pwDerivedKey) {
                if (err) console.log(err);
                ks.generateNewAddress(pwDerivedKey, 1)
                // console.log("ks", ks)
                let addr = ks.getAddresses();
                const newUser = new User({
                    username: user.username,
                    email: user.email,
                    keystore: user.keystore ? user.keystore : ks.serialize(),
                    publicAddress: user.publicAddress ? user.publicAddress.toLowerCase() : addr[0].toLowerCase(),
                    name: user.lastName+ " " +user.firstName ,
                    role: user.role,
                });
                let addedUser = await newUser.save()
                let userAdded = { 
                    _id: addedUser._id.valueOf(), 
                    username: addedUser.username,
                    email: addedUser.email,
                    publicAddress: addedUser.publicAddress,
                    name: addedUser.name,
                    role: addedUser.role,
                    dept: addedUser.dept
                }
                console.log("userAdded", userAdded);
                // create "My Folder" for user
                const myFolder = new Folder({
                    name: "My Folder", 
                    owner: userAdded._id,
                }) 
                await myFolder.save()
                const filter = { type: "internal" };
                await Folder.updateMany(filter, {$push: {shared: userAdded._id }})
            })
        })
    }
    if(rolesAdded) {
        var data = {
            client_id: process.env.KEYCLOAK_DEMO_SSO_CLIENT_ID_3,
            client_secret: process.env.KEYCLOAK_DEMO_SSO_CLIENT_SECRET_3,
            grant_type: 'client_credentials' 
        };
        let tokenRequest = await axios({
            method: 'post',
            url: process.env.KEYCLOAK_DEMO_SSO_TOKEN_URL,
            headers: { 
                'Content-Type': 'application/x-www-form-urlencoded'
            },
            data : data
        })
        const token = tokenRequest.data.access_token
        console.log("token", token);
        if(token) {
            for (let index = 0; index < userList.length; index++) {
                let user = userList[index];
                let data = JSON.stringify({
                    enabled: true,
                    emailVerified: user.emailVerified,
                    username: user.username,
                    email: user.email,
                    firstName: user.firstName,
                    lastName: user.lastName,
                    groups: user.groups,
                    credentials: [
                        {
                            type: "password",
                            value: "1",
                            temporary: true
                        }
                    ]
                });
            
                let config = {
                    method: 'post',
                    url: process.env.KEYCLOAK_USERS_URL,
                    headers: { 
                        'Authorization': "Bearer "+ token,
                        'Content-Type': 'application/json'
                    },
                    data : data
                }
                let res = await axios(config)
                if(res.status === 201) {
                    await addUser(user)
                    console.log("Res", res.status);
                }
                
            }
        }
    }
}
console.time()
initDB().then(res=> console.timeEnd()).catch(err => {
    console.log(err);
    process.exit(1)
});

const accountTest = [
    {
        username: "hr_manager",
        keystore: `{"encSeed":{"encStr":"KvvbHYrd2MhQK2+KzJERltdOVwBqU+D25DRZUcQR+uRz5n9pEdnp+XiQfTMGeqp+N6uDxQj5YIZQkmR2fzFBlIUXdD9dUpXxTyEiqh5B5+mxHUdG0Sz3x4sxrkmRn8Iq4SWpxiJzHL5jfn+CC38Jb/Zzan2hzBroEcjEb2fkFyX4efETGt0O4A==","nonce":"LhNjLEaDx9RKQwnvy5yZ0eRD6/4spVgt"},"encHdRootPriv":{"encStr":"cKrf5KJ+A79/W17Xp0JZZRnEzdDko91QKtPSwDszXbcoeDTD9sfrUEkaeXU3lH6jhu2MjlZAPGBfAdIBt7WS/o8UFGp/qkykII1AdfvzJ4c5AO3HXsBC9/hDs2CQdt2zuqpHiy2vmJdF+kzXXGL8itcIQtx/vNVgqDVaCzHvgA==","nonce":"AbPA1EfEeQ0Wj4qneETPLQ2tGIIF7Sz8"},"addresses":["b9190a71c1cdf18b684245deb3fd4177daa18f27"],"encPrivKeys":{"b9190a71c1cdf18b684245deb3fd4177daa18f27":{"key":"FlWBmX2/PTdvrUhBy7UVS1oGSdZhI4St46USaY7UbCn2hCnIsqh7WMnUqXpBNsn+","nonce":"Y3z6M5C6svaZAr7nCaksiwNv1K8MdsgK"}},"hdPathString":"m/0'/0'/0'","salt":"xrE8+TjSWNPIydBKz1KOCn60ZfHYFcQnbYuhJN8h+GE=","hdIndex":1,"version":3}`,
        address: "0xb9190a71c1cdf18b684245deb3fd4177daa18f27"
    },
    {
        username: "bod",
        keystore: `{"encSeed":{"encStr":"vK8KVzjwxv2fQWFcp8dtTp3xgCdTpOJDVun2OdvYCrpIwjIhL13vvbQR1wHuOKpY1GppAZUO6RHfdzhXTpnYfCDDumwVQSpWqKAX5yNRPZ8Ve+x1BhC0GdWIifkeexUpyf7dWJUXxKzkvLyHEak/WNIVT+wwHw/cgQnKY9VzyOeZnYZ6C+65Yw==","nonce":"sdiUYpsGW7N0vqJZayQAEfhx4PUUImNb"},"encHdRootPriv":{"encStr":"wLartzZK7/CrtOWwgWUNM8cITfpQSZMCmLyYNJFfZeFWsvi/tkg5X9GXOmVTM55d1bm+acLPF4AfEDLiqlglt8jC6Jk+X89gHtHttO0XwSvu2rONZC+ITXMptsxwmA248ZyAT5XLwnPiTvi99aOty9Hwmd59u7NIXluKqvROWg==","nonce":"E7G/0FkJOZA11x2hO6qpm+3FUlX37p79"},"addresses":["9f048a73735b6afee502ec605e08d83472857463","cc40cc0ba83048801e05ab6bcf3cdb827e31c488","9b17b0612069258b3cc9187c5a96107b8cc7968d","fe47e32e697532bba14ee50458055d1b80de4657","ff8ce8c35a2222c573352d182c50505010973244"],"encPrivKeys":{"9f048a73735b6afee502ec605e08d83472857463":{"key":"Oilu1IuI/zVTk0EOcKO4lalsgbEcmCnn1tuRGj94RelYK/4ZfUo3m/sbwG+QAFT0","nonce":"ofhgC5K+Ys10J7LFokpMUu1WmzElcOAc"},"cc40cc0ba83048801e05ab6bcf3cdb827e31c488":{"key":"43Ag+gMn45vRw92cCMpqyh4yMcViYLXPaYSmlnu2TXE00ONQFtMrP146zxDkaJHZ","nonce":"r3O6GMamtZOJ9Wu8SPCe2Hpzb4fTYghU"},"9b17b0612069258b3cc9187c5a96107b8cc7968d":{"key":"So9W5QfmIrIZiJn4dAkE4pbl98alrs2pYaTYtqDSf5/w+Ibx8B9DOpqDE+neREZ6","nonce":"Tgip+KSB3pbNQQjpCaVFUf7WRK3QpLJd"},"fe47e32e697532bba14ee50458055d1b80de4657":{"key":"dIuqZq1T9P99WXU2Ld5g/N/fMW522JukDYTvaVN8pX5rgEWOxwO0Jsx3UzAjGBeI","nonce":"dOBTux2+l7CRQatUTNshpLt+fXG1oDTS"},"ff8ce8c35a2222c573352d182c50505010973244":{"key":"g4rJrEWFPLPorpCSM9RN+Z/g+9aKoDXik/eN8N/P/JLCDUpFjBr1NnHk31f4npXJ","nonce":"tkvvfhJ+YpxlJDv7D1ah1pp9dfPUjEhy"}},"hdPathString":"m/0'/0'/0'","salt":"/k1/PWF2VJVmlb9PIJuITQR1igdA1U9AdAhiXFIZgD4=","hdIndex":5,"version":3}`,
        address: "0xfe47e32e697532bba14ee50458055d1b80de4657"
    },
    {
        username: "bod1",
        keystore: `{"encSeed":{"encStr":"vK8KVzjwxv2fQWFcp8dtTp3xgCdTpOJDVun2OdvYCrpIwjIhL13vvbQR1wHuOKpY1GppAZUO6RHfdzhXTpnYfCDDumwVQSpWqKAX5yNRPZ8Ve+x1BhC0GdWIifkeexUpyf7dWJUXxKzkvLyHEak/WNIVT+wwHw/cgQnKY9VzyOeZnYZ6C+65Yw==","nonce":"sdiUYpsGW7N0vqJZayQAEfhx4PUUImNb"},"encHdRootPriv":{"encStr":"wLartzZK7/CrtOWwgWUNM8cITfpQSZMCmLyYNJFfZeFWsvi/tkg5X9GXOmVTM55d1bm+acLPF4AfEDLiqlglt8jC6Jk+X89gHtHttO0XwSvu2rONZC+ITXMptsxwmA248ZyAT5XLwnPiTvi99aOty9Hwmd59u7NIXluKqvROWg==","nonce":"E7G/0FkJOZA11x2hO6qpm+3FUlX37p79"},"addresses":["9f048a73735b6afee502ec605e08d83472857463","cc40cc0ba83048801e05ab6bcf3cdb827e31c488","9b17b0612069258b3cc9187c5a96107b8cc7968d","fe47e32e697532bba14ee50458055d1b80de4657","ff8ce8c35a2222c573352d182c50505010973244"],"encPrivKeys":{"9f048a73735b6afee502ec605e08d83472857463":{"key":"Oilu1IuI/zVTk0EOcKO4lalsgbEcmCnn1tuRGj94RelYK/4ZfUo3m/sbwG+QAFT0","nonce":"ofhgC5K+Ys10J7LFokpMUu1WmzElcOAc"},"cc40cc0ba83048801e05ab6bcf3cdb827e31c488":{"key":"43Ag+gMn45vRw92cCMpqyh4yMcViYLXPaYSmlnu2TXE00ONQFtMrP146zxDkaJHZ","nonce":"r3O6GMamtZOJ9Wu8SPCe2Hpzb4fTYghU"},"9b17b0612069258b3cc9187c5a96107b8cc7968d":{"key":"So9W5QfmIrIZiJn4dAkE4pbl98alrs2pYaTYtqDSf5/w+Ibx8B9DOpqDE+neREZ6","nonce":"Tgip+KSB3pbNQQjpCaVFUf7WRK3QpLJd"},"fe47e32e697532bba14ee50458055d1b80de4657":{"key":"dIuqZq1T9P99WXU2Ld5g/N/fMW522JukDYTvaVN8pX5rgEWOxwO0Jsx3UzAjGBeI","nonce":"dOBTux2+l7CRQatUTNshpLt+fXG1oDTS"},"ff8ce8c35a2222c573352d182c50505010973244":{"key":"g4rJrEWFPLPorpCSM9RN+Z/g+9aKoDXik/eN8N/P/JLCDUpFjBr1NnHk31f4npXJ","nonce":"tkvvfhJ+YpxlJDv7D1ah1pp9dfPUjEhy"}},"hdPathString":"m/0'/0'/0'","salt":"/k1/PWF2VJVmlb9PIJuITQR1igdA1U9AdAhiXFIZgD4=","hdIndex":5,"version":3}`,
        address: "0xff8ce8c35a2222c573352d182c50505010973244"
    },
]