import { NFTStorage, File } from 'nft.storage'
export const IpfsClient = async () => {
    try {
        //const ipfs = window.IpfsHttpClient({ host: '127.0.0.1', port: 5001, protocol: 'http', timeout: 10000 })
        const ipfs = await window.IpfsHttpClient({ host: '10.10.1.15', port: 7001, protocol: 'http', timeout: 10000 })
        //const ipfs = window.IpfsHttpClient({ host: '18.136.124.115', port: 5001, protocol: 'http', timeout: 10000 })
        await ipfs.version()
        console.log(ipfs);
        return ipfs
    } catch (error) {
        console.log("error", error);
        alert("Cannot connect to IPFS Client")
        return null
    }
    
}

export const nftStorage = () => {
    return new NFTStorage({ token: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJkaWQ6ZXRocjoweDFCN2I1Q2VFYjUwNUQ0NjZkNTA1QkViOTY4RTI4ZGQ5RDUzYzU1OTgiLCJpc3MiOiJuZnQtc3RvcmFnZSIsImlhdCI6MTY3NTA2MzkzNzUxMCwibmFtZSI6ImtleSJ9.47VIy2hx7MgMaCiHFz5KXcOVarFM8fa6fZ80QR5fIZ4' }) 
}