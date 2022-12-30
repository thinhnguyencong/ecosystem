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
                    <span class="material-icons ">
                        info
                    </span>
                </li>
                
                
            </ol>
             
        </nav>
        <div class="d-flex justify-content-between">
            <div class="p-2">
                <div class="dropdown">
                    <button class="btn btn-primary dropdown-toggle" type="button" id="dropdownMenuButton" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                        <i class="mdi mdi-plus text-light"></i> New  
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
        <ModalAddNewFolder v-if="documentState.folder" :parentId="documentState.folder._id"/>
        <ModalUploadFile/>
        <div v-if="!documentState.isLoading">
            <!-- <div data-toggle="modal" data-target="#modalCreateFolder" class="tile folder">
                        <span class="material-icons">add</span>
                        <h4>Add</h4>
                    </div> -->
            <div v-if="layout == 'grid'">
                <GridView :folders="documentState.children" :files="documentState.folder.files"/>
            </div>
            <div v-if="layout == 'list'">
                <ListTable :folders="documentState.children" :files="documentState.folder.files"/>
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
</script>
<script>

export default {
    components: { ModalAddNewFolder, ManageKey, ModalUploadFile, ListTable, GridView, ModalFileDetails },
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
            showModal: false,
        }
    },
    computed: {
        documentState() {return this.$store.state.document },
    },
    methods: {
        async callAPI() {
            await this.$store.dispatch("auth/sidebarActive", "my-folder")
            await this.$store.dispatch("document/getMyFolders") 
        },
        switchLayout() {
            if(this.layout === "list"){
                this.layout = "grid"
                localStorage.setItem("layout", "grid")
            }else if (this.layout === "grid"){
                this.layout = "list"
                localStorage.setItem("layout", "list")
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
</style>