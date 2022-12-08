import { create } from 'ipfs-http-client'

export const IpfsClient = () => {
    try {
        //const ipfs = window.IpfsHttpClient({ host: '127.0.0.1', port: 5001, protocol: 'http' })
        const ipfs = window.IpfsHttpClient({ host: '10.10.1.15', port: 7001, protocol: 'http' })
        return ipfs
    } catch (error) {
        console.log("error", error);
        alert("Cannot connect to IPFS Client")
        return null
    }
    
}