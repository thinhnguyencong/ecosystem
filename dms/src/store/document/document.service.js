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

function getMyFolders() {
    return sendRequest({
        url: url+"my-folder",
        method: "GET",
    })
}

function getSharedWithMeFolders() {
    return sendRequest({
        url: url+"shared-with-me-folder",
        method: "GET",
    })
}

function createFolder(data) {
    return sendRequest({
        url: url+"create-folder",
        method: "POST",
        data: data
    })
}

function editFolder(data) {
    return sendRequest({
        url: url+"edit-folder",
        method: "POST",
        data: data
    })
}

function uploadFile(data) {
    return sendRequest({
        url: url+"upload-file",
        method: "POST",
        data: data
    })
}

function getAllFiles() {
    return sendRequest({
        url: url+"get-all-files",
        method: "GET",
    })
}

function addComment(data) {
    return sendRequest({
        url: url+"add-comment",
        method: "POST",
        data: data
    })
}

function signDoc(data) {
    return sendRequest({
        url: url+"sign-doc",
        method: "POST",
        data: data
    })
}
function rejectDoc(data) {
    return sendRequest({
        url: url+"reject-doc",
        method: "POST",
        data: data
    })
}
function getTreeFolder() {
    return sendRequest({
        url: url+"tree-folder",
        method: "GET",
    })
}
function getFileById(data) {
    return sendRequest({
        url: url+"get-file-by-id",
        method: "GET",
        params: data
    })
}
function getFileStatusById(data) {
    return sendRequest({
        url: url+"get-file-status-by-id",
        method: "GET",
        params: data
    })
}


export const documentService = {
    getRootFolders,
    getFolderById,
    getMyFolders,
    getSharedWithMeFolders,
    createFolder,
    editFolder,
    uploadFile,
    getAllFiles,
    addComment,
    signDoc,
    rejectDoc,
    getTreeFolder,
    getFileById,
    getFileStatusById
};