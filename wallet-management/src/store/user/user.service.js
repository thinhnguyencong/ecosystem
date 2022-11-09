import { sendRequest } from "../../helpers/sendRequest";

const url = import.meta.env.VITE_SERVER_URL + '/api/user/';


function getUserInfo(data) {
    return sendRequest({
        url: url+"info",
        method: "GET",
        params: {tokens: data.tokens }
    })
}


export const userService = {
    getUserInfo,
};
