import { sendRequest } from "../../helpers/sendRequest";

const url = import.meta.env.VITE_SERVER_URL + '/api/admin/';

function getAllUsers() {
    return sendRequest({
        url: url+"users",
        method: "GET",
    })
}

function createUser(data) {
    return sendRequest({
        url: url+"create-user",
        method: "POST",
        data: data
    })
}

export const adminService = {
    getAllUsers,
    createUser
};
