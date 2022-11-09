import { sendRequest } from "../../helpers/sendRequest";

const url = import.meta.env.VITE_SERVER_URL + '/api/auth/';

function doAuthRedirect(data) {
    console.log("ru", data);
    const params = { 
        clientId: import.meta.env.VITE_CLIENT_ID,
        redirect_uri: data.redirect_uri
    };
    return sendRequest({
        url: url+"authurl",
        method: "GET",
        params: params
    })
}

function reAuth() {
    const payload = { clientId: import.meta.env.VITE_CLIENT_ID };
    return sendRequest({
        url: url+"reauth",
        method: "POST",
        data: payload
    })
}

function getAuthToken(data) {
    const payload = {
        code: data.code,
        clientId: import.meta.env.VITE_CLIENT_ID,
        redirect_uri: data.redirect_uri
    };
    return sendRequest({
        url: url+"authtoken",
        method: "POST",
        data: payload
    })
}

function logout() {
    const params = { 
        clientId: import.meta.env.VITE_CLIENT_ID,
    };
    return sendRequest({
        url: url+"logout",
        method: "GET",
        params: params
    })
}

function findUser() {
    return sendRequest({
        url: "http://localhost:5555/api/user",
        method: "GET",
    })
}


export const authService = {
    reAuth,
    doAuthRedirect,
    getAuthToken,
    logout,
    findUser
};
