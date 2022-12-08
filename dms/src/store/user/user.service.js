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
function initRequestKey() {
    return sendRequest({
        url: url+"init-request-key",
        method: "GET",
    })
}
function requestKey(data) {
    return sendRequest({
        url: url+"request-key",
        method: "POST",
        data: data
    })
}
function signMessage(data) {
    return sendRequest({
        url: url+"sign-message",
        method: "POST",
        data: data
    })
}
function getDeptList(data) {
    return sendRequest({
        url: url+"department-list",
        method: "GET",
    })
}
function getRoleList(data) {
    return sendRequest({
        url: url+"role-list",
        method: "GET",
    })
}
function getSignerList(data) {
    return sendRequest({
        url: url+"signer-list",
        method: "GET",
    })
}

export const userService = {
    getUserInfo,
    transferToken,
    initRequestKey,
    requestKey,
    signMessage,
    getDeptList,
    getRoleList,
    getSignerList

};
