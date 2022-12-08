import { sendRequest } from "../../helpers/sendRequest";

const url = import.meta.env.VITE_SERVER_URL + '/api/document/';


function getRootFolders() {
    return sendRequest({
        url: url+"get-root-folders",
        method: "GET",
    })
}

function getFolderById(data) {
    return sendRequest({
        url: url+"get-folder-by-id",
        method: "GET",
        params: data
    })
}



export const documentService = {
    getRootFolders,
    getFolderById
};