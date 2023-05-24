<template>
    <div v-if="!documentState.isLoading">
        <div v-if="layout == 'grid'" class="item-folder--flex">
            <div class="folder-border">
                <div v-if="folders.length" class="itemFlex">
                    <NavBar @onLayoutChange="onLayoutChange" @handleDrawer="handleDrawer"/>
                    <span class="folder-title">Folders</span>
                    <div class="item-grid-card">
                        <div class="folder-add" :class="{ activeDetailFolder: itemSelectedID  }">
                            <div class="item-folder_border">
                                <div class="item-folder">
                                    <a data-toggle="modal" data-target="#modalCreateFolder" class="dropdown-item" href="#">
                                        <img class="iconAdd" src="@/assets/img/folderAdd.svg" alt="error-folderAdd">
                                    </a>
                                </div>
                            </div>
                        </div>
                        <div v-for="(folder, index) in folders" class="tile" :class="{ activeDetailFolder: itemSelectedID }">
                            <div class="float-right" >
                                <div class="dropdown">
                                    <div class="optionFolder" @click="openDropdown(folder._id)">
                                        <img src="@/assets/img/folder-option.svg" alt=""  >
                                    </div>
                                    <div v-click-outside="(event) => closeDropdown(folder._id, event)"
                                         v-if="showMenu == folder._id" :id="'myDropdown-' + folder._id"
                                         class="list-group" >

                                        <a v-if="folder.owner && folder.owner._id == authState.user._id"
                                           @click="handleOpenModalShare(folder)"
                                           class="modal-item">
                                            <div class="modal-item--option">
                                                <img src="@/assets/img/share2.svg" alt="error-icon">
                                                <span class="modal-item--name">Share</span>
                                            </div>
                                        </a>
                                        <a class="modal-item">
                                            <div class="modal-item--option">
                                                <img src="@/assets/img/star.svg" alt="error-icon">
                                                <div class="modal-item--name">Add to Starred</div>
                                            </div>
                                        </a>

                                        <a class="modal-item">
                                            <div class="modal-item--option">
                                                <img src="@/assets/img/link.svg" alt="error-link">
                                                <div class="modal-item--name">Copy link</div>
                                            </div>
                                        </a>

                                        <a @click="handleDownloadFolder(folder)"
                                           class="modal-item">
                                            <div class="modal-item--option">
                                                <img src="@/assets/img/arrow-down.svg" alt="error-arrowDown">
                                                <span class="modal-item--name">Download</span>
                                            </div>
                                        </a>

                                        <a class="modal-item">
                                            <div class="modal-item--option">
                                                <img src="@/assets/img/copyfile.svg" alt="error-icon">
                                                <div class="modal-item--name">Copy to</div>
                                            </div>
                                        </a>
                                        <a v-if="folder.owner && folder.owner._id == authState.user._id"
                                           @click="handleOpenModalRename(folder)"
                                           class="modal-item">
                                            <div class="modal-item--option">
                                                <img src="@/assets/img/share.svg" alt="error-icon">
                                                <span class="modal-item--name">Rename</span>
                                            </div>
                                        </a>
                                        <a class="modal-item">
                                            <div class="modal-item--option">
                                                <img src="@/assets/img/moveto.svg" alt="error-icon">
                                                <div class="modal-item--name">Move to</div>
                                            </div>

                                        </a>
                                        <a class="modal-item">
                                            <div class="modal-item--option">
                                                <img src="@/assets/img/Detail.svg" alt="error-icon">
                                                <div class="modal-item--name">Detail</div>
                                            </div>
                                        </a>
                                        <a @click="handleHideFolder(folder)"
                                           class="modal-item">
                                            <div class="modal-item--option">
                                                <img src="@/assets/img/hidden.svg" alt="error-icon">
                                                <span class="modal-item--name">Hide</span>
                                            </div>
                                        </a>
                                    </div>

                                </div>
                            </div>

                            <div class="folder" :class="{ bgcItem : itemSelectedID === folder.id}" @dblclick="handleAccessFolder(folder._id)" @click="showOptionFolder(folder)" >
                                <FolderVue class="list-folder-item" :key="index" :folder="folder" />
                            </div>
                        </div>
                    </div>

                    <div class="folder-bottom">
                        <a href="#">
                            <img id="border-dropdown" src="@/assets/img/arrow_bottom.svg" alt="error-arrowDown">
                        </a>
                    </div>

                </div>
                <div class="folder-detail" v-show="isShowDetail">
                    <FolderDetail @ClickOffDetail="isDetail"/>
                </div>
                <div v-if="files?.length == 0 && folders?.length == 0">
                    <div class="item-detail">
                        <a data-toggle="modal" data-target="#modalCreateFolder" class="dropdown-item" href="#">
                            <img class="iconAddDetail" src="@/assets/img/folderAdd.svg" alt="error-folderAdd">
                        </a>
                    </div>
                </div>
            </div>
        </div>

        <div v-if="layout == 'list'">
                          <NavBar @onLayoutChange="onLayoutChange" @handleDrawer="handleDrawer"/>
            <div class="table-responsive">
                <!-- folders search -->
                <div class="folders-input">
                    <div class="folders-input--add">
                        <a data-toggle="modal" data-target="#modalCreateFolder" class="dropdown-item flexItem" href="#">
                            <div class="folders-add--table"> + </div>
                            <div class="folders-input--add">

                                    <div class="folders-input--txt">Add new folder</div>
                            </div>
                        </a>
                    </div>
                    <div class="folders-input--search">
                        <img src="@/assets/img/search.svg" alt="error-icon">
                        <input type="text" placeholder="Search ">
                    </div>
                    <div class="folders-input--person">
                        <img src="@/assets/img/person.svg" alt="error-icon">
                        <input type="text" placeholder="Person ">
                    </div>
                    <div class="folders-input--date">
                        <img src="@/assets/img/date.svg" alt="error-icon">
                        <input type="text" placeholder="Dates ">
                    </div>
                </div>
                <!-- folders search -->

                <table id="listTable" class="table table-hover" data-pagination="true">
                    <thead>
                        <tr>
                            <th scope="col" class="checkboxTable">
                                <div class="head-item--checkbox"><input id="rd1" type="checkbox" name="rd" check></div>
                            </th>
                            <th scope="col">Name &nbsp; <i class="mdi mdi-arrow-down text-dark"></i></th>
                            <th scope="col">Created by </th>
                            <th scope="col">Size </th>
                            <th scope="col">Create </th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr role='button' @click="handleAccessFolder(folder._id)" v-for="(folder) in folders"
                            :key="folder._id">
                            <td>
                                <input id="rd1" type="checkbox" name="rd" check>
                            </td>
                            <td class="truncate" scope="row">
                                {{ folder.name }}
                            </td>
                            <td>-</td>
                            <td>-</td>
                            <td>{{(new Date(folder.createdAt)).toDateString()}}</td>
                            <td>
                                <img src="@/assets/img/star.svg" alt="error-icon">
                            </td>
                            <td @click.stop="">
                                <div class="dropdown optionTable">
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
import FolderDetail from "@/components/FolderDetail.vue";
import NavBar from "@/components/layout/NavBar.vue";
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
        },

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
            folderDownload: [],
            activeDetailClick: null,
            itemSelectedID: null,
            itemSelected: {},
            isShowOption:false,
            isShowDetail:false,

            fileList:[
                {
                    id:1,
                    title:'test1',
                    name:'PDF',
                    mb:'5MB',
                },
                {
                    id:2,
                    title:'test1',
                    name:'WORD',
                    mb:'2MB',
                },
                {
                    id:3,
                    title:'test1',
                    name:'Token',
                    mb:'4MB',
                },
                {
                    id:4,
                    title:'test1',
                    name:'PDF',
                    mb:'3MB',
                },
                {
                    id:5,
                    title:'test1',
                    name:'PDF',
                    mb:'2MB',
                },
                {
                    id:1,
                    title:'test1',
                    name:'PDF',
                    mb:'5MB',
                },
                {
                    id:2,
                    title:'test1',
                    name:'WORD',
                    mb:'2MB',
                },
                {
                    id:3,
                    title:'test1',
                    name:'Token',
                    mb:'4MB',
                },
                {
                    id:4,
                    title:'test1',
                    name:'PDF',
                    mb:'3MB',
                },
                {
                    id:5,
                    title:'test1',
                    name:'PDF',
                    mb:'2MB',
                },


            ]
        };
    },
    mounted() {
        this.layout = this.layoutProps;
    },
    methods: {
        isDetail(isShowDetail) {
            this.isShowDetail = isShowDetail
        },
        showOptionFolder(id) {
            this.itemSelectedID = id;
            this.isDetail(true);
            console.log(this.itemSelectedID = id);
        },
        handleAccessFolder(id) {
            this.$router.push("/folder/" + id);
            this.itemSelected = id;
        },
        openDropdown(id) {
            this.showMenu = id;

        },
        closeDropdown(id) {
            this.showMenu = "";
        },

        handleDrawer() {
            console.log(this.drawerVisible);
            this.drawerVisible = !this.drawerVisible
            console.log(this.drawerVisible);
            if(this.drawerVisible) {
                this.transition = 'slide-fade-reverse'
            }else {
                this.transition = 'slide-fade'
            }
        },
        onLayoutChange(layout) {
            this.layout = layout
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
    },
    components: { ModalRenameFolder, ModalShareFolder }
}
</script>
<style lang="scss" scoped>
@import "@/assets/style/_theme.scss";

.item-detail {
    display: flex;
    flex-wrap: wrap;
    gap: 0 16px;
    padding: 16px;

}
.table-responsive {
    padding: 0 16px;
}
#listTable {
}
.dropdown-item {
    &:hover {
        background-color: var(--backgroud);
    }
}
.iconAddDetail {
    padding: 40px 80px;
    background-color: var(--bgc-item--folder);
    border: 1px solid var(--bgc-hover);
    border-radius: 20px;
}

.folder-title {
    font-weight: 700;
    font-size: 18px;
    color: var(--text-color--1);
    padding: 0 16px;
}
.folder-border {
    display: flex;
}
.folder-detail {
    border-left: 1px solid var(--border-color);
}
.itemFlex {
    width: 100%;
}
/* check radio */
input[type="radio"] {
    cursor: pointer;
    appearance: none;
    background-color: #FFFFFF;
    border: 1px solid #EDEDED;
    border-radius: 50%;
    width: 20px;
    height: 20px;
    margin-right: 10px;
}
input[type="radio"]:checked {
    background-color: #FFFFFF;
    border: 5px solid #3C46F5;
}


// checkbox
input[type="checkbox"]:checked ~ * {
    user-select: none;
}

input[type="checkbox"] {
    margin: 0;
}

input[type="checkbox"]:checked {
    position: relative;
}
input[type="checkbox"]:checked {
    position: relative;
}
input[type="checkbox"]:checked::before {
    content: "\2714";
    color: #FFFFFF;
    font-size: 12px;
    text-align: center;
    display: block;
    position: absolute;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%);
}

input[type="checkbox"] {
    cursor: pointer;
    appearance: none;
    background-color: #FFFFFF;
    border: 2px solid #12131C;
    border-radius:4px;
    width: 17px;
    height: 17px;
    user-select: none;

}
input[type="checkbox"]:checked {
    background-color: #3C46F5;
    border: 2px solid #3C46F5;
}
input[type="checkbox"]:checked::before {
    content: "\2714";
    color: #FFFFFF;
    font-size: 12px;
    text-align: center;
    display: block;
    position: absolute;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%);
}

table tr th {
    font-weight: 600;
    font-size: 12px;
    color: var(--text-color-txt);

}
.checkboxTable {
    width: 40px;
}
table tr td {
    font-weight: 500;
    font-size: 14px;
    color: var(--text-color--1);

}
.table th, .table td {
    padding: 12px 0;
}

.folders-input {
    display: flex;
    align-items: center;
    gap: 0 48px;
    margin-bottom: 8px;
    &--search {
        display: flex;
        align-items: center;
        gap: 0 8px;
        background: #F7F7F8;
        padding: 6px 8px;
        max-width: 402px;
        width: 100%;
        border-radius: 20px;
    }
    &--person {
        display: flex;
        align-items: center;
        gap: 0 8px;
        background: #F7F7F8;
        padding: 6px 8px;
        max-width: 402px;
        width: 100%;
        border-radius: 20px;

    }
    &--date {
        display: flex;
        align-items: center;
        gap: 0 8px;
        background: #F7F7F8;
        padding: 6px 8px;
        max-width: 402px;
        width: 100%;
        border-radius: 20px;
    }
    input {
        background-color: #F7F7F8;
        color: #12131C;
        border-radius: 20px;
        &::placeholder {
            color: #C1C0C9;
        }
    }
}
.table thead th {
    border: none;
}
.folders-input--add {
    display: flex;
    align-items: center;
    gap:  0 8px;
    &:hover {
        background-color: var(--backgroud);
    }
    &:active {
        background-color: var(--backgroud);
    }
}
.flexItem {
    display: flex;
    align-items: center;
    gap:  0 8px;
    background-color: var(--backgroud);
    &:hover {
        background-color: var(--backgroud);
    }
    &:active {
        background-color: var(--backgroud);
    }
}
.optionTable {
    float: right;
}

.folders-add--table {
    font-size: 16px;
    font-weight: 600;
    padding: 3px 9px;
    border-radius: 8px;
    background-color: var(--text-color-active);
    color: var(--backgroud);
    cursor: pointer;
}

.folders-input--txt {
    font-weight: 600;
    font-size: 12px;
    color: var(--text-color--1);
}
// checkbox table
tr td input[type="checkbox"]:checked ~ * {
    user-select: none;
}
tr td {
    vertical-align: middle;
}

tr td input[type="checkbox"] {
    margin: 0;
}

tr td input[type="checkbox"]:checked {
    position: relative;
}
tr th input[type="checkbox"]:checked {
    position: relative;
}
tr th input[type="checkbox"]:checked::before {
    content: "\2714";
    color: #FFFFFF;
    font-size: 12px;
    text-align: center;
    display: block;
    position: absolute;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%);
}

input[type="checkbox"] {
    cursor: pointer;
    appearance: none;
    background-color: #FFFFFF;
    border: 2px solid #12131C;
    border-radius:4px;
    width: 17px;
    height: 17px;
    user-select: none;

}
input[type="checkbox"]:checked {
    background-color: #3C46F5;
    border: 2px solid #3C46F5;
}
tr td input[type="checkbox"]:checked::before {
    content: "\2714";
    color: #FFFFFF;
    font-size: 12px;
    text-align: center;
    display: block;
    position: absolute;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%);
}

.bgcItem {
    background: var(--bgc-hover);
    border: 1px solid #EDEDED;
    border-radius: 12px;
}
.activeDetailFolder {
    border-radius: 3px;
    position: relative;
    cursor: pointer;
    width: calc(100% /5 - 16px) !important;
}
.tile {
    border-radius: 3px;
    height: 100%;
    transition: 0.2s all cubic-bezier(0.4, 0.0, 0.2, 1);
    position: relative;
    cursor: pointer;
    width: calc(100% /6 - 16px);

}
.folder-add {
    width: calc(100% /6 - 16px);
    background: var(--bgc-item--folder);
    border: 1px solid var(--border-color);
    border-radius: 12px;
    position: relative;
}
.float-right {
    position: absolute;
    top: 16px;
    right: 16px;
}

.files-add {
    width: calc(100% /6 - 16px);
    background: var(--bgc-item--folder);
    border: 1px solid var(--border-color);
    border-radius: 12px;
    position: relative;
}
#fileAdd {
    position: absolute;
    top: 50%;
    left: 50%;
    transform: translate(-50%,-50%);
}
.folder-bottom {
    display: flex;
    justify-content: center;
    align-items: center;
}

#border-dropdown {
    padding:15px;
    border-radius: 50%;
    border: 1px solid var(--border-color);
    cursor: pointer;
}

.upload-file {
    font-weight: 700;
    font-size: 18px;
    color: var(--text-color--1);
    margin: 16px 0;
}


.iconAdd {
    position: absolute;
    top: 50%;
    left: 50%;
    transform: translate(-50%,-50%);
}
a {
    text-decoration: none;
    &:hover,
    &:focus {
        text-decoration: none;
        outline: none;
    }
}

.modal-item--name {
    font-weight: 600;
    font-size: 14px;
    color: var(--text-color--2);
}

// files

ul, li {
    margin: 0;
    padding: 0;
}

.files-header-name {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 20px;
}
.files-header_option {
    display: flex;
    justify-content: center;
    align-items: center;
    gap: 8px;
}
.files-Starred {
    font-weight: 500;
    font-size: 14px;
    color: #3C46F5;
    cursor: pointer;
}
.files-Starred {
    cursor: pointer;
    margin-left: 16px;
}
.files-arrow-down {
    cursor: pointer;
}
.files-Starred {
    cursor: pointer;
}
.files-header_title {
    display: flex;
    justify-content: center;
    align-items: center;
    gap: 0 8px;
}
.files-header_name {
    color: #6F7180;
    font-size: 12px;
    line-height: 16px;
}
.arrow-right {
    color: #C1C0C9;

}
.BlockChain {
    font-weight: 600;
    font-size: 12px;
    color: #12131C;

}
.folder-item_title {
    font-weight: 600;
    font-size: 14px;
    color: #12131C;
    display: -webkit-box;
    -webkit-box-orient: vertical;
    overflow: hidden;
    -webkit-line-clamp: 1;
}
.files-title {
    font-weight: 700;
    font-size: 18px;
    color: #12131C;
    margin-bottom: 16px;
}

.files-list {
    display: flex;
    gap: 0 16px;
    width: 100%;
    margin-bottom: 16px;
}
.files-add {
    width: calc( 100% / 6 - 16px );
}
.item-files_border {
    background: #FAFAFA;
    border: 1px solid #EDEDED;
    border-radius: 12px;
}
.item-files{
    display: flex;
    justify-content: center;
    align-items: center;
    padding: 39px 85px;
    background-color: #FAFAFA;
    border-radius: 12px;
}
.list-files{
    display: flex;
    flex-wrap:wrap;
    gap: 16px;
    width: 100%;
}
.list-files-item {
    width: calc( 100% / 6 - 16px );
    padding: 16px;
    border: 1px solid #EDEDED;
    border-radius: 12px;
    background: #FAFAFA;
    cursor: pointer;
}

.files-item_header {
    display: flex;
    align-items: center;
    gap: 0 8px;
    margin-bottom: 8px;
}
.files-item_txt {
    display: flex;
    align-items: center;
    gap: 0 8px;
    margin-bottom: 8px;
}
.files-item_file {
    font-weight: 400;
    font-size: 12px;
    color: #6F7180;
}
.files-item_distance {
    width: 4px;
    height: 4px;
    background-color: #6F7180;
    border-radius: 50%;
}
.files-item_MB {
    font-size: 12px;
    color: #6F7180;
}

#icon-file {
    width: 24px;
    height: 24px;
}
.files-item_title {
    font-weight: 600;
    font-size: 14px;
    color: #12131C;
    display: -webkit-box;
    -webkit-box-orient: vertical;
    overflow: hidden;
    -webkit-line-clamp: 1;
}

//


.dropdown {
    position: relative;
}

.list-group {
    position: absolute;
    top: 2.5rem;
    right: 0;
    padding: 24px;
    background: #FFFFFF;
    border-radius: 16px;
    min-width: 240px;
    width: 100%;
    z-index: 1;
    box-shadow: 0 40px 64px -12px rgba(0, 0, 0, 0.08), 0px 0px 14px -4px rgba(0, 0, 0, 0.05), 0px 32px 48px -8px rgba(0, 0, 0, 0.1);
    .modal-item {
        &--option {
            display: flex;
            align-items: center;
            padding: 8px;
            gap: 0 12px;
            cursor: pointer;
            &:hover {
                background: #EEEEEE;
                border-radius: 12px;
            }
        }
    }
}



.folder {
    padding: 16px;
    border: 1px solid var(--border-color);
    border-radius: 12px;
    background: var(--bgc-item--folder);
    cursor: pointer;


}
.dropdown-item {
    padding: 0;
    display: flex;
    justify-content: center;
    align-items: center;
    &:focus {
        background-color: var(--bgc-item--folder);

    }
}


.item-grid-card {
    display: flex;
    flex-wrap: wrap;
    width: 100%;
    gap: 16px;
    margin-bottom: 16px;
    padding: 16px;
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

.tile {
    position: relative;
    display: inline-block;
    overflow: visible;
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