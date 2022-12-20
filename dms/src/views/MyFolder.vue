<template>
	<div >
        <nav aria-label="breadcrumb">
            <ol class="breadcrumb">
                <li class="breadcrumb-item active" aria-current="page">
                    My Folder
                </li>
                <li class="ml-auto pr-5">
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

        <div v-if="!documentState.isLoading">
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
        <ModalFileDetails v-for="(file, index) in documentState.folder.files" :ref="(file._id)" :fileProps="file" :key="file._id" modal_id='main'/>
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
        this.$store.dispatch("auth/sidebarActive", "my-folder")
        this.$store.dispatch("document/getMyFolders")       
    },
    data() {
        return {
            name: "Untitled Folder",
           layout: localStorage.getItem("layout") ? localStorage.getItem("layout") : "grid",
           mockData: [
             {
                name: "Head First python.pdf",
                fileType: "application/pdf"
            },
            {
                name: "Weekly Report.pptx",
                fileType: "application/vnd.openxmlformats-officedocument.presentationml.presentation"
            },
            {
                name: "Document.doc",
                fileType: "application/msword"
            },
            {
                name: "testcase.xls",
                fileType: "application/vnd.ms-excel"
            },
           ],
           
        }
    },
    computed: {
        documentState() {return this.$store.state.document },
    },
    methods: {
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
/* .text-custom-color-blue {
    color: #00A8FF
} */
/* .tile {
    border-radius: 3px;
    width: 200px;
    height: 100%;
    margin-bottom: 23px;
    text-align: center;
    border: 1px solid #eeeeee;
    transition: 0.2s all cubic-bezier(0.4, 0.0, 0.2, 1);
    position: relative;
    padding: 35px 16px 25px;
    margin-right: 17px;
    cursor: pointer;
}
.tile:hover{
  box-shadow: 0px 7px 5px -6px rgba(0, 0, 0, 0.12);
  background-color: #eeeeee;
  border: 1px solid #dddddd;
}
.tile .material-icons{
    color: #00A8FF;
    height: 55px;
    margin-bottom: 20px;
    font-size: 55px;
    display: block;
    line-height: 54px;
    cursor: pointer;
} */
</style>