<template>
    <div>
        <div class="table-responsive" v-if="!documentState.isLoading">
            <br>
            <table id="transactionsTable" class="table table-hover" data-pagination="true">
                <thead>
                <tr>
                    <th scope="col">Name &nbsp; <i class="mdi mdi-arrow-down text-dark"></i></th>
                    <th scope="col">Token Id</th>
                    <th scope="col">Date Modified</th>
                    <th v-if="status" scope="col">Status</th>
                    <th scope="col">Owner</th>
                    <th scope="col">Size</th>
                    <th scope="col">Action</th>
                </tr>
                </thead>
                <tbody>
                    <tr role='button' @click="handleAccessFolder(folder._id)" v-for="(folder) in folders" :key="folder._id">
                        <th class="truncate" scope="row">
                            <i class="mdi mdi-folder text-custom-color-blue"></i> {{folder.name}}
                        </th>
                        <td>-</td>
                        <td>{{(new Date(folder.createdAt)).toDateString()}}</td>
                        <td v-if="status">-</td>
                        <td>{{folder.owner && folder.owner.name}}</td>
                        <td>-</td>
                        <td></td>
                    </tr>
                    <router-link
                        tag="tr"
                        class="item cursor-pointer" 
                        v-for="(file) in files"
                        :key="file._id"
                        :to="$route.path == '/' ? `${$route.path}file/${file._id}`: `${$route.path}/file/${file._id}`"
                    >
                        <th class="truncate" scope="row">
                            <i :class="getClassFileType(JSON.parse(file.tokenURI).fileType)"></i>{{JSON.parse(file.tokenURI).name}}
                        </th>
                        <td>{{file.tokenId}}</td>
                        <td>{{(new Date(file.createdAt)).toDateString()}}</td>
                        <td v-if="status" :class="getClassStatus(file.status)">{{file.status}}</td>
                        <td>{{file.owner.name}}</td>
                        <td>{{niceBytes((JSON.parse(file.tokenURI).size))}}</td>
                        <td>
                            <v-btn flat icon color="indigo">
                                <v-icon data-toggle="tooltip" title="" color="black">
                                    visibility
                                </v-icon>
                            </v-btn>
                            <span v-if="isLoadingDownload.id == file._id && isLoadingDownload.value" class="spinner-border text-dark mr-2 mt-2" role="status">
                                <span class="sr-only">Loading...</span>
                            </span>
                            <span v-else @click.stop="" @click="download(file)">
                                <v-btn flat icon color="indigo">
                                    <v-icon data-toggle="tooltip" title="" color="black">
                                        download
                                    </v-icon>
                                </v-btn>
                            </span>
                        </td>
                    </router-link>
                    <tr v-if="(files.length + folders.length == 0)">
                        <td class="text-center" colspan="6" scope="row"><h5>Empty</h5></td>
                    </tr>
                <!-- <tr>
                    <td class="text-center" colspan="6" scope="row"><a href="">See more ...</a></td>
                </tr> -->
                </tbody>
            </table>
        </div>
        <div v-else class="pl-4 pr-4">
            <div class="spinner-border text-dark" role="status">
                <span class="sr-only">Loading...</span>
            </div>
        </div>
        <Transition name="modal">
            <router-view v-if="showModal"></router-view>
        </Transition>
    </div>
    
</template>
<script>
import { IpfsClient } from "../helpers/ipfs";
import {encrypt, decrypt} from "../helpers/encrypt-decrypt"
import {getClassFileType}  from "../helpers/index"
export default {
    props: {
        folders: {
            type: Array,
            default() {return []}
        },
        files: {
            type: Array,
            default() {return []}
        },
        hasStatus: {
            type: Boolean,
            default() {return true}
        }
    },
    data() {
        return {
            showModal: false,
            isLoadingDownload: {
                id: null,
                value: false
            },
            status: true
        }
    },
    mounted() {
        this.status = this.hasStatus
    },
    computed: {
        documentState() {return this.$store.state.document },
    },
    methods: {
        handleAccessFolder(id) {
            this.$router.push("/folder/" + id);
        },
        getClassFileType: getClassFileType,
        niceBytes(bytes) {
            const units = ['bytes', 'KB', 'MB', 'GB', 'TB', 'PB', 'EB', 'ZB', 'YB'];
            let l = 0, n = parseInt(bytes, 10) || 0;

            while(n >= 1024 && ++l){
                n = n/1024;
            }
            
            return(n.toFixed(n < 10 && l > 0 ? 1 : 0) + ' ' + units[l]);
        },
        
        getClassStatus(type) {
            switch(type) {
                case 'rejected': return "text-danger"
                case 'waiting-to-review': return "text-warning"
                case 'waiting-to-sign': return "text-info"
                case 'signed': return "text-success"
                
                default: return "text-secondary"
            }
        },
        download(file) {
            this.isLoadingDownload.value = true
            this.isLoadingDownload.id = file._id
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
                    this.isLoadingDownload.value = false
                }
            }).catch(error=> {
                this.isLoadingDownload.value = false
                console.log(error);
                alert("No file to download")
            })
        },
    },
    watch: {
      '$route': {
        immediate: true,
        handler: function(newVal, oldVal) {
            this.showModal = newVal.meta && newVal.meta.showModal;
        }
      },
    }
}
</script>
<style scoped>
.table th, .table td {
    font-size: 1.3rem;
    vertical-align: middle;
}
.v-btn {
    margin: 0
}
.float-right {
    float: right;
}
.text-custom-color-blue {
    color: #00A8FF
}
.cursor-pointer {
    cursor: pointer;
}
.modal-enter, .modal-leave-active {
    opacity: 0;
}

.modal-enter .modal-container,
.modal-leave-active .modal-container {
  -webkit-transform: scale(1.1);
  transform: scale(1.1);
}

.truncate {
    max-width: 200px;
    white-space: nowrap;
    overflow: hidden;
    text-overflow: ellipsis;
}
</style>