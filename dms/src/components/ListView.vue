<template>
    <div class="table-responsive">
        <table id="transactionsTable" class="table table-hover" data-pagination="true">
            <thead>
            <tr>
                <th scope="col">Name &nbsp; <i class="mdi mdi-arrow-down text-dark"></i></th>
                <th scope="col">Token Id</th>
                <th scope="col">Date Modified</th>
                <th scope="col">Status</th>
                <th scope="col">Owner</th>
                <th scope="col">Size</th>
                <th scope="col">Action</th>
            </tr>
            </thead>
            <tbody>
                <tr role='button' v-if="(folders.length>0)" @click="handleAccessFolder(folder._id)" v-for="(folder, index) in folders" :key="index">
                    <th scope="row">
                        <i class="mdi mdi-folder text-custom-color-blue"></i> {{folder.name}}
                    </th>
                    <td>-</td>
                    <td>{{(new Date(folder.createdAt)).toDateString()}}</td>
                    <td>-</td>
                    <td>{{folder.owner}}</td>
                    <td>-</td>
                    <td></td>
                </tr>
                <tr v-if="(files.length>0)" v-for="(file, index) in files" :key="file._id">
                    <th scope="row">
                        <i :class="getClass(JSON.parse(file.tokenURI).fileType)"></i>{{JSON.parse(file.tokenURI).name}}
                    </th>
                    <td>{{file.tokenId}}</td>
                    <td>{{(new Date(file.createdAt)).toDateString()}}</td>
                    <td>{{file.status}}</td>
                    <td>{{file.owner}}</td>
                    <td>{{niceBytes((JSON.parse(file.tokenURI).size))}}</td>
                    <td>
                        <span class="material-icons" @click="openModal(file._id)">visibility</span>&nbsp;&nbsp;
                        <span class="material-icons" @click="download(file)">download</span>&nbsp;&nbsp;
                        <!-- <span class="material-icons text-secondary">info</span>&nbsp;&nbsp;
                        <span class="material-icons text-success">edit_calendar</span> -->
                    </td>
                </tr>
                <tr v-if="(files.length + folders.length == 0)">
                    <td class="text-center" colspan="6" scope="row"><h5>Empty</h5></td>
                </tr>
            <!-- <tr>
                <td class="text-center" colspan="6" scope="row"><a href="">See more ...</a></td>
            </tr> -->
            </tbody>
            
        </table>
    </div>
</template>
<script>
import ModalFileDetails from '../views/ModalFileDetails.vue';
import $ from 'jquery' 
import { IpfsClient } from "../helpers/ipfs";
import {encrypt, decrypt} from "../helpers/encrypt-decrypt"

export default {
    props: {
        folders: Array,
        files: Array
    },
    data() {
        return {
        }
    },
    mounted() {
        console.log("folders", this.folders);
        console.log("files", this.files);
    },
    methods: {
        handleAccessFolder(id) {
            this.$router.push("/folder/" + id);
        },
        openModal(id) {
            $("#"+id).modal('toggle');
        },
        niceBytes(bytes) {
            const units = ['bytes', 'KB', 'MB', 'GB', 'TB', 'PB', 'EB', 'ZB', 'YB'];
            let l = 0, n = parseInt(bytes, 10) || 0;

            while(n >= 1024 && ++l){
                n = n/1024;
            }
            
            return(n.toFixed(n < 10 && l > 0 ? 1 : 0) + ' ' + units[l]);
        },
        getClass(type) {
            switch(type) {
                case 'application/pdf': return "mdi mdi-file-pdf-box text-danger"
                case 'application/vnd.ms-powerpoint': return "mdi mdi-microsoft-powerpoint text-danger"
                case 'application/vnd.openxmlformats-officedocument.presentationml.presentation': return "mdi mdi-microsoft-powerpoint text-danger"
                case 'application/msword': return "mdi mdi-microsoft-word text-primary"
                case 'application/vnd.openxmlformats-officedocument.wordprocessingml.document': return "mdi mdi-microsoft-word text-primary"
                case 'application/vnd.ms-excel': return "mdi mdi-microsoft-excel text-success"
                case 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet': return "mdi mdi-microsoft-excel text-success"
                case 'text/javascript': return "mdi mdi-language-javascript text-warning"
                case 'text/x-java-source': return "mdi mdi-language-java text-danger"
                case 'text/html': return "mdi mdi-language-html5 text-warning"
                case 'text/css': return "mdi mdi-language-css3 text-primary"
                default: return "mdi mdi-file text-secondary"
            }
        },
        download(file) {
            IpfsClient().get(file.hash).then(async (res) =>{
                if(res) {
                    console.log(res[0].content)
                    let resultDecrypt = decrypt(res[0].content, file.key)
                    console.log('resultDecrypt', resultDecrypt);
                    let tokenUri = JSON.parse(file.tokenURI)
                    console.log("tokenUri", tokenUri);
                    let blob = new Blob([resultDecrypt.buffer], {type: tokenUri.fileType});
                    let link = document.createElement('a');
                    link.href = window.URL.createObjectURL(blob);
                    let fileName = tokenUri.name;
                    link.download = fileName;
                    console.log("link", link);
                    link.click();
                }
                else {
                    alert("No file to download")
                }
            })
        },
    },
    components: { ModalFileDetails }
}
</script>
<style scoped>
.float-right {
    float: right;
}
.text-custom-color-blue {
    color: #00A8FF
}
.material-icons{
    cursor: pointer;
}
.material-icons:hover {
    background: transparent;
	color: #0f85f4;
}
</style>