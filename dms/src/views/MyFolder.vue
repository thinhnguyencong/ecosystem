<template>
	<div >
        <nav aria-label="breadcrumb">
            <ol class="breadcrumb">
                <li class="breadcrumb-item active" aria-current="page">
                    My Folder
                </li>
                <li class="ml-auto">
                    <button @click="switchLayout">
                        <span v-if="layout == 'grid'" class="material-icons ml-auto pr-4">
                            list
                        </span>
                        <span v-if="layout == 'list'" class="material-icons ml-auto pr-4">
                            grid_view
                        </span>
                    </button>
                    <span class="material-icons" @click="handleDrawer">
                        info
                    </span>
                </li>
                
                
            </ol>
             
        </nav>
        
        <ModalAddNewFolder v-if="documentState.folder" :parentId="documentState.folder._id"/>
        <ModalUploadFile/>
        <div v-if="!documentState.isLoading">
            <!-- <div data-toggle="modal" data-target="#modalCreateFolder" class="tile folder">
                        <span class="material-icons">add</span>
                        <h4>Add</h4>
                    </div> -->
            <div class="row">
                <div class="col">
                    <div class="d-flex justify-content-between">
                        <div class="p-2">
                            <div class="dropdown">
                                <button class="btn btn-primary btn-lg" type="button" id="dropdownMenuButton" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                    <i class="mdi mdi-plus text-light"></i> New &nbsp;
                                </button>
                                <div class="dropdown-menu" aria-labelledby="dropdownMenuButton">
                                    <a data-toggle="modal" data-target="#modalCreateFolder" class="dropdown-item" href="#"><i class="mdi mdi-folder text-dark"></i> New Folder </a>
                                    <a data-toggle="modal" data-target="#modalUploadFile" class="dropdown-item" href="#"><i class="mdi mdi-upload text-dark"></i> Upload File</a>
                                </div>
                            </div>
                        </div>
                        <div class="p-2">
                            <!-- <ManageKey/> -->
                        </div>
                    </div>
                    <div v-if="layout == 'grid'">
                        <GridView :folders="documentState.children" :files="documentState.folder.files"/>
                    </div>
                    <div v-if="layout == 'list'">
                        <ListTable :folders="documentState.children" :files="documentState.folder.files"/>
                    </div>
                </div>
                <transition :name="transition">
                    <div v-if="drawerVisible" class="col-3">
                        <div style="text-align: right; margin: 5px">
                            <button class="close" @click="handleDrawer">&#9587;</button>
                        </div>
                        <FolderDetail :drawerVisible="drawerVisible"/>
                    </div>
                </transition>
            </div>        
        </div>
        <div v-else class="spinner-border text-dark" role="status">
            <span class="sr-only">Loading...</span>
        </div>
        
	</div>
</template>
<script setup>
import ModalFileDetails from './ModalFileDetails.vue';
import GridView from '../components/GridView.vue';
import ListTable from '../components/ListView.vue';
import ManageKey from '../components/ManageKey.vue'
import ModalAddNewFolder from './ModalAddNewFolder.vue';
import ModalUploadFile from './ModalUploadFile.vue';
import FolderDetail from '../components/FolderDetail.vue';
import $ from "jquery"
$(document).ready(function() {
  $('#modalCreateFolder').on('shown.bs.modal', function() {
    $('#newFolderName').trigger('focus');
    $('#newFolderName').select()
  });
});
</script>
<script>

export default {
    components: { ModalAddNewFolder, ManageKey, ModalUploadFile, ListTable, GridView, ModalFileDetails, FolderDetail },
    mounted() {
        this.$router.push(this.$route.path)
    },
    created() {
        this.callAPI()
    },
    data() {
        return {
            name: "Untitled Folder",
            layout: localStorage.getItem("layout") ? localStorage.getItem("layout") : "grid",
            drawerVisible: false,
            showModal: false,
            transition: 'slide-fade'
        }
    },
    computed: {
        documentState() {return this.$store.state.document },
    },
    methods: {
        async callAPI() {
            this.$store.dispatch("auth/sidebarActive", "my-folder")
            await this.$store.dispatch("document/getMyFolders") 
            await this.$store.dispatch("document/getTreeFolder")
        },
        switchLayout() {
            if(this.layout === "list"){
                this.layout = "grid"
                localStorage.setItem("layout", "grid")
            }else if (this.layout === "grid"){
                this.layout = "list"
                localStorage.setItem("layout", "list")
            }
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
        }
    },
  }
</script>

<style scoped>
.float-right {
    float: right;
}
.material-icons{
    cursor: pointer;
}
.material-icons:hover {
    background: transparent;
	color: #0f85f4;
}
/* Prev Scrolling */
.slide-fade-enter-active,
.slide-fade-leave-active {
    transition: all .5s ease;
}

.slide-fade-leave-from,
.slide-fade-leave-to {
    transform: translateX(-100px);
    opacity: 0;
}

.slide-fade-reverse-enter-active,
.slide-fade-reverse-leave-active {
    transition: all .3s ease;
}

.slide-fade-reverse-leave-from,
.slide-fade-reverse-leave-to {
    transform: translateX(100px);
    opacity: 0;
}
</style>