import Web3 from "web3"

export const getWeb3 = async () => {
    try {
        const web3 = new Web3(
            new Web3.providers.HttpProvider(process.env.WEB3_PROVIDER)
        );
        let isConnected = await web3.eth.net.isListening()
        if(isConnected) {
            //console.log('Web3 Provider is connected')
            return {status: true, web3}
        }else {
            return {status: false}
        }
    } catch (error) {
        console.log("error", error);
        return {status: false}
    }
    
}