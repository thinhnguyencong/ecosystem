function randomString(len) {
    const charSet = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
    var randomString = '';
    for (var i = 0; i < len; i++) {
        var randomPoz = Math.floor(Math.random() * charSet.length);
        randomString += charSet.substring(randomPoz,randomPoz+1);
    }
    return randomString;
}
export const encrypt = (data) => {
    let randomKey = randomString(16)
    let utf8Encode = new TextEncoder();
    let key = utf8Encode.encode(randomKey);
    // console.log("key", key);
    var aesCtr = new window.aesjs.ModeOfOperation.ctr(key);
    var encryptedBytes = aesCtr.encrypt(data);
    // console.log("encryptedBytes", typeof encryptedBytes ,encryptedBytes);
    var encryptedHex = window.aesjs.utils.hex.fromBytes(encryptedBytes);
    // console.log(encryptedHex);
    let buffer = new Buffer(encryptedHex, 'hex')
    
    return {
        encryptedData : buffer, 
        key: window.aesjs.utils.hex.fromBytes(key)
    }
}

export const decrypt = (encryptedBytes, key) => {
    // When ready to decrypt the hex string, convert it back to bytes
    //let encryptedBytes = window.aesjs.utils.hex.toBytes(encryptedHex);
    
    // The counter mode of operation maintains internal state, so to
    // decrypt a new instance must be instantiated.
    // console.log("key", window.aesjs.utils.hex.toBytes(key));
    var aesCtr = new window.aesjs.ModeOfOperation.ctr(window.aesjs.utils.hex.toBytes(key));
    var decryptedBytes = aesCtr.decrypt(encryptedBytes);
    // console.log(window.aesjs.utils.hex.fromBytes(decryptedBytes));
    return decryptedBytes
}

