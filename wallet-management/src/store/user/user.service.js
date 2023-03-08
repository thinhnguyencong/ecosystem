import { sendRequest } from "../../helpers/sendRequest";

const url = import.meta.env.VITE_SERVER_URL + '/api/user/';


function getUserInfo(data) {
    return sendRequest({
        url: url+"info",
        method: "GET",
        params: {tokens: data.tokens }
    })
}
function transferToken(data) {
    return sendRequest({
        url: url+"transfer-token",
        method: "POST",
        data: data
    })
}

function getTransactions(data) {
    return sendRequest({
        url: url+"transactions",
        method: "GET",
        params: data
    })
}
export const userService = {
    getUserInfo,
    transferToken,
    getTransactions
};
