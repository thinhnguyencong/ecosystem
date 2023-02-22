<template>
    <div v-if="!documentState.isLoading">
        <div v-if="layout == 'grid'">
            <br>
            <div v-if="folders.length">
                <h4 class="font-weight-bold">Folders</h4>
                <hr>
                <div class="item-grid-card">
                    <div v-for="(folder, index) in folders" class="tile">
                        <div class="float-right">
                            <div class="dropdown">
                                <div class="align-self-center" @click="openDropdown(folder._id)">
                                    <v-btn flat icon color="indigo">
                                        <v-icon data-toggle="tooltip" title="" color="#818181">
                                            more_vert
                                        </v-icon>
                                    </v-btn>
                                </div>
                                <div v-click-outside="(event) => closeDropdown(folder._id, event)"
                                    v-if="showMenu == folder._id" :id="'myDropdown-' + folder._id"
                                    class="dropdown-content">
                                    <div class="list-group">
                                        <a v-if="folder.owner && folder.owner._id == authState.user._id"
                                            @click="handleOpenModalRename(folder)"
                                            class="list-group-item list-group-item-action">
                                            <p class="h6 align-items-center d-flex">
                                                <i class="material-icons">drive_file_rename_outline</i>
                                                <span class="mt-2">Rename</span>
                                            </p>
                                        </a>
                                        <a v-if="folder.owner && folder.owner._id == authState.user._id"
                                            @click="handleOpenModalShare(folder)"
                                            class="list-group-item list-group-item-action">
                                            <p class="h6 align-items-center d-flex">
                                                <i class="material-icons">person_add</i>
                                                <span class="mt-2">Share</span>
                                            </p>
                                        </a>
                                        <a @click="handleDownloadFolder(folder)"
                                            class="list-group-item list-group-item-action">
                                            <p class="h6 align-items-center d-flex">
                                                <i class="material-icons">download</i>
                                                <span class="mt-2">Download</span>
                                            </p>
                                        </a>
                                        <a @click="handleHideFolder(folder)"
                                            class="list-group-item list-group-item-action">
                                            <p class="h6 align-items-center d-flex">
                                                <i class="material-icons">visibility_off</i>
                                                <span class="mt-2">Hide</span>
                                            </p>
                                        </a>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="folder" @click="handleAccessFolder(folder._id)">
                            <FolderVue :key="index" :folder="folder" />
                        </div>
                    </div>
                </div>
                <br>
                <br>
            </div>
            <div v-if="files.length">
                <h4 class="font-weight-bold">Files</h4>
                <hr>
                <div class="item-grid-card">
                    <router-link tag="tr" class="item" v-for="(file, index) in files" :key="file._id"
                        :to="$route.path == '/' ? `${$route.path}file/${file._id}` : `${$route.path}/file/${file._id}`">
                        <FileVue :name="JSON.parse(file.tokenURI).name" :fileType="JSON.parse(file.tokenURI).fileType"
                            :id="file._id" :file="file" />
                    </router-link>
                </div>
            </div>
            <div v-if="files?.length == 0 && folders?.length == 0">
                <h5>This folder is empty</h5>
            </div>
        </div>
        <div v-if="layout == 'list'">
            <div class="table-responsive">
                <br>
                <table id="listTable" class="table table-hover" data-pagination="true">
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
                        <tr role='button' @click="handleAccessFolder(folder._id)" v-for="(folder) in folders"
                            :key="folder._id">
                            <th class="truncate" scope="row">
                                <i
                                    :class="folder.owner?._id === authState.user._id ? 'mdi mdi-folder text-custom-color-blue' : 'mdi mdi-folder-account text-custom-color-blue'"></i>
                                {{ folder.name }}
                            </th>
                            <td>-</td>
                            <td>{{(new Date(folder.createdAt)).toDateString()}}</td>
                            <td>-</td>
                            <td>{{ folder.owner && folder.owner.name }}</td>
                            <td>-</td>
                            <td @click.stop="">
                                <div class="dropdown">
                                    <div class="align-self-center" @click="openDropdown(folder._id)">
                                        <v-btn flat icon color="indigo">
                                            <v-icon data-toggle="tooltip" title="" color="#818181">
                                                more_vert
                                            </v-icon>
                                        </v-btn>
                                    </div>
                                    <div v-click-outside="(event) => closeDropdown(folder._id, event)"
                                        v-if="showMenu == folder._id" :id="'myDropdown-' + folder._id"
                                        class="dropdown-content">
                                        <div class="list-group">
                                            <a v-if="folder.owner && folder.owner._id == authState.user._id"
                                                @click="handleOpenModalRename(folder)"
                                                class="list-group-item list-group-item-action">
                                                <p class="h6 align-items-center d-flex">
                                                    <i class="material-icons">drive_file_rename_outline</i>
                                                    <span class="mt-2">Rename</span>
                                                </p>
                                            </a>
                                            <a v-if="folder.owner && folder.owner._id == authState.user._id"
                                                @click="handleOpenModalShare(folder)"
                                                class="list-group-item list-group-item-action">
                                                <p class="h6 align-items-center d-flex">
                                                    <i class="material-icons">person_add</i>
                                                    <span class="mt-2">Share</span>
                                                </p>
                                            </a>
                                            <a @click="handleDownloadFolder(folder)"
                                                class="list-group-item list-group-item-action">
                                                <p class="h6 align-items-center d-flex">
                                                    <i class="material-icons">download</i>
                                                    <span class="mt-2">Download</span>
                                                </p>
                                            </a>
                                            <a @click="handleHideFolder(folder)"
                                                class="list-group-item list-group-item-action">
                                                <p class="h6 align-items-center d-flex">
                                                    <i class="material-icons">visibility_off</i>
                                                    <span class="mt-2">Hide</span>
                                                </p>
                                            </a>
                                        </div>
                                    </div>
                                </div>
                            </td>
                        </tr>
                        <router-link tag="tr" class="item cursor-pointer" v-for="(file) in files" :key="file._id"
                            :to="$route.path == '/' ? `${$route.path}file/${file._id}` : `${$route.path}/file/${file._id}`">
                            <th class="truncate" scope="row">
                                <i :class="getClassFileType(JSON.parse(file.tokenURI).fileType)"></i>{{
                                    JSON.parse(file.tokenURI).name
                                }}
                            </th>
                            <td>{{ file.tokenId }}</td>
                            <td>{{
                                file.lastAccess ? dayjs(file.lastAccess).format('HH:mm DD/MM/YYYY') : (new
                                    Date(file.createdAt)).toDateString()
                            }}</td>
                            <td :class="getClassStatus(file.status)">{{ file.status }}</td>
                            <td>{{ file.owner.name }}</td>
                            <td>{{ niceBytes((JSON.parse(file.tokenURI).size))}}</td>
                            <td>
                                <v-btn flat icon color="indigo">
                                    <v-icon data-toggle="tooltip" title="" color="black">
                                        visibility
                                    </v-icon>
                                </v-btn>
                                <span v-if="isLoadingDownload.id == file._id && isLoadingDownload.value"
                                    class="spinner-border text-dark mr-2 mt-2" role="status">
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
                            <td class="text-center" colspan="6" scope="row">
                                <h5>Empty</h5>
                            </td>
                        </tr>
                        <!-- <tr>
                        <td class="text-center" colspan="6" scope="row"><a href="">See more ...</a></td>
                    </tr> -->
                    </tbody>
                </table>
            </div>
        </div>
        <Transition name="modal">
            <router-view v-if="showModal"></router-view>
        </Transition>
        <Transition name="modal">
            <ModalRenameFolder v-if="folderRename?._id" :folderProps="folderRename"
                @handleCloseModal="handleCloseModalRename" />
        </Transition>
        <Transition name="modal">
            <ModalShareFolder v-if="folderShare?._id" :folderProps="folderShare"
                @handleCloseModal="handleCloseModalShare" />
        </Transition>
    </div>
    <div v-else class="pl-4 pr-4">
        <div class="spinner-border text-dark" role="status">
            <span class="sr-only">Loading...</span>
        </div>
    </div>
</template>

<script setup>
import FileVue from '../components/File.vue'
import FolderVue from '../components/Folder.vue';
import { toast } from '../plugins/toast';
import { encrypt, decrypt } from "../helpers/encrypt-decrypt"
import { getClassFileType, niceBytes, getClassStatus } from "../helpers/index"
import { IpfsClient } from "../helpers/ipfs";
import ModalRenameFolder from '../views/main/modal/ModalRenameFolder.vue';
import ModalShareFolder from '../views/main/modal/ModalShareFolder.vue';
import JSZip from "jszip"
</script>

<script>

export default {
    props: {
        folders: {
            type: Array,
            default() { return []; }
        },
        files: {
            type: Array,
            default() { return []; }
        },
        layoutProps: {
            type: String,
            default() { return "grid"; }
        }
    },
    data() {
        return {
            showModal: false,
            isLoadingDownload: {
                id: null,
                value: false
            },
            showMenu: "",
            layout: "",
            folderRename: {},
            folderShare: {},
            dayjs: dayjs,
            folderDownload: []
        };
    },
    mounted() {
        this.layout = this.layoutProps;
    },
    methods: {
        handleAccessFolder(id) {
            this.$router.push("/folder/" + id);
        },
        openDropdown(id) {
            this.showMenu = id;
        },
        closeDropdown(id) {
            this.showMenu = "";
        },
        handleOpenModalRename(folder) {
            this.folderRename = folder
            this.showMenu = ""
        },
        handleCloseModalRename() {
            this.folderRename = {}
        },
        handleOpenModalShare(folder) {
            console.log(folder);
            this.folderShare = folder
            this.showMenu = ""
        },
        handleCloseModalShare() {
            this.folderShare = {}
        },
        handleHideFolder() {

        },
        async handleDownloadFolder(folder) {
            this.showMenu = ""
            if(!this.documentState.treeFolder[folder._id]) {
                await this.$store.dispatch("document/getTreeFolder", { type: "folder", folderId: folder._id })
            }
            let zip = new JSZip()
            const toastZipping = toast.info("Zipping folder...", {
                position: "bottom-left",
                timeout: 0,
                closeOnClick: true,
                draggable: true,
                draggablePercent: 0.6,
                showCloseButtonOnHover: true,
                hideProgressBar: true,
                closeButton: "button",
                icon: true,
                rtl: false
            });
            const ipfs = await IpfsClient()
            if (!ipfs) {
                return
            }
            await this.zipFolder(ipfs, this.documentState.treeFolder[folder._id][0].children, zip)
            toast.success("Successfully zipping "+ '"' + folder.name+ '"', {
                position: "bottom-left",
                timeout: 1500,
                closeOnClick: true,
                draggable: true,
                draggablePercent: 0.6,
                showCloseButtonOnHover: true,
                hideProgressBar: false,
                closeButton: "button",
                icon: true,
                rtl: false
            });
            toast.dismiss(toastZipping)
            zip.generateAsync({ type: "blob" })
                .then(function (content) {
                    let link = document.createElement('a');
                    link.href = window.URL.createObjectURL(content);
                    let fileName = folder.name;
                    link.download = fileName;
                    link.click();
                }).catch(error => {
                    console.log(error);
                });
        },
		async zipFolder(ipfs, treeFolder, zip) {
			console.log(treeFolder);
			for (let child of treeFolder) {
				if(!child.children){
                    let res = await ipfs.get(child.data.hash)
                    let resultDecrypt = decrypt(res[0].content, child.data.key);
                    let tokenUri = JSON.parse(child.data.tokenURI);
                    zip.file(tokenUri.name, resultDecrypt);
				}else {
                    let folder = zip.folder(`${child.name}`);
					this.zipFolder(ipfs, child.children, folder)
				}
			}
		},
        getClassFileType: getClassFileType,
        niceBytes: niceBytes,
        getClassStatus: getClassStatus,

        async download(file) {
            this.isLoadingDownload.value = true;
            this.isLoadingDownload.id = file._id;
            const ipfs = await IpfsClient()
            if (!ipfs) {
                this.isLoadingDownload.value = false;
                console.log(error);
                alert("No file to download");
            }
            let res = await ipfs.get(file.hash)
            if (res) {
                console.log(res[0].content);
                let resultDecrypt = decrypt(res[0].content, file.key);
                console.log("resultDecrypt", resultDecrypt);
                let tokenUri = JSON.parse(file.tokenURI);
                console.log("tokenUri", tokenUri);
                let blob = new Blob([resultDecrypt.buffer], { type: tokenUri.fileType });
                let link = document.createElement("a");
                link.href = window.URL.createObjectURL(blob);
                let fileName = tokenUri.name;
                link.download = fileName;
                console.log("link", link);
                link.click();
                this.isLoadingDownload.value = false;
            }
        },
    },
    computed: {
        documentState() { return this.$store.state.document; },
        authState() { return this.$store.state.auth; },
    },
    watch: {
        "$route": {
            immediate: true,
            handler: function (newVal, oldVal) {
                this.showModal = newVal.meta && newVal.meta.showModal;
            }
        },
        layoutProps: {
            immediate: true,
            handler: function (newVal, oldVal) {
                this.layout = newVal;
            }
        },
        //   folders: {
        //     immediate: true,
        //     handler: function(newVal, oldVal) {
        //         this.folderList = newVal
        //     }
        //   }
    },
    components: { ModalRenameFolder, ModalShareFolder }
}
</script>
<style scoped>
.tile {
    border-radius: 3px;
    width: 200px;
    height: 100%;
    transition: 0.2s all cubic-bezier(0.4, 0.0, 0.2, 1);
    position: relative;
    cursor: pointer;
}

.folder {
    height: 100%;
    padding: 3.5rem 1rem 3rem;
    text-align: center;
    border: 1px solid #eeeeee;
    ;
}

.folder:hover {
    box-shadow: 0px 7px 5px -6px rgba(0, 0, 0, 0.12);
    background-color: #eeeeee;
    border: 1px solid #dddddd;
    ;
}

.item-grid-card {
    display: grid;
    grid-template-columns: repeat(auto-fill, minmax(200px, 1fr));
    gap: 1rem;
}

.modal-enter,
.modal-leave-active {
    opacity: 0;
}

.modal-enter .modal-container,
.modal-leave-active .modal-container {
    -webkit-transform: scale(1.1);
    transform: scale(1.1);
}

.dropdown {
    position: relative;
    display: inline-block;
    overflow: visible;
}

.dropdown-content {
    top: 3rem;
    left: 20px;
    display: block;
    position: absolute;
    background-color: #f1f1f1;
    width: 10rem;
    height: 5rem;
    box-shadow: 0px 8px 16px 0px rgba(0, 0, 0, 0.2);
    z-index: 1;
}

.table th,
.table td {
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

.modal-enter,
.modal-leave-active {
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