<template>
	<div >
        <nav aria-label="breadcrumb">
            <ol class="breadcrumb">
                <li v-if="documentState.folder.status=='my-folder'" class="breadcrumb-item" aria-current="page">
                    <router-link to="/my-folder">My Folder</router-link>
                </li>
                <li v-else-if="documentState.folder.status=='shared-with-me'" class="breadcrumb-item" aria-current="page">
                    <router-link to="/shared-with-me">Share with me</router-link>
                </li>
                <li v-else class="breadcrumb-item" aria-current="page">
                    <router-link to="/">Home</router-link>
                </li>
                <li v-for="(folder, index) in documentState.ancestors" :key="index" 
                    class="breadcrumb-item " aria-current="page">
                    <router-link :to="'/folder/'+ folder._id">{{folder.name}}</router-link>
                </li>
                <li v-if="documentState.folder" class="breadcrumb-item active" aria-current="page">{{documentState.folder.name}}</li>
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
                <!-- <div class="p-2">
                    <ManageKey/>
                </div> -->
            </div>
            <ModalAddNewFolder v-if="documentState.folder" :parentId="documentState.folder._id"/>
            <ModalUploadFile/>
            <div v-if="layout == 'grid'">
                <GridViewVue :folders="documentState.children" :files="documentState.folder.files"/>
            </div>
            <div v-if="layout == 'list'">
                <ListTableVue :folders="documentState.children" :files="documentState.folder.files"/>
            </div>
        </div>
        <div v-else class="spinner-border text-dark" role="status">
            <span class="sr-only">Loading...</span>
        </div>
        
	</div>
</template>
<script setup>
    import FolderVue from '../components/Folder.vue';
    import FileVue from '../components/File.vue'
    import ModalAddNewFolder from './ModalAddNewFolder.vue';
    import ModalUploadFile from './ModalUploadFile.vue'
    import ManageKey from '../components/ManageKey.vue'
    import ListTableVue from '../components/ListView.vue';
    import GridViewVue from '../components/GridView.vue';
</script>
<script>
export default {
  components: { ModalAddNewFolder, ManageKey  },
    mounted() {
        // Call the API query method on page load
        
    },
    created() {
        this.$store.dispatch("document/getFolderById", {id: this.$route.params.id})       
    },
    data() {
        return {
           layout: localStorage.getItem("layout") ? localStorage.getItem("layout") : "grid",
           mockData: [
             {
                name: "Head First python.pdf",
                type: "pdf"
            },
            {
                name: "Weekly Report.pptx",
                type: "pptx"
            },
            {
                name: "Monthly Report.pdf",
                type: "pdf"
            },
            {
                name: "Testcase.xlsx",
                type: "xlsx"
            },
            {
                name: "Reading CAM 13.docx",
                type: "docx"
            },
            {
                name: "index.html",
                type: "html"
            },
            {
                name: "style.css",
                type: "css"
            },
            {
                name: "Timetable 20221.xlsx",
                type: "xlsx"
            },
            {
                name: "script.js",
                type: "javascript"
            },
            {
                name: "Testcase 2.xlsx",
                type: "xlsx"
            },
           ]
        }
    },
    computed: {
        documentState() {return this.$store.state.document },
        authState() {return this.$store.state.auth },
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
    watch: {
    '$route.params.id': {
      handler() {
        console.log("abc");
        this.$store.dispatch("document/getFolderById", {id: this.$route.params.id})
      },
      immediate: true
    } 
  }

}
</script>

<style scoped>
.item-grid-card {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(200px, 1fr));
  gap: 1rem;
}
.float-right {
    float: right;
}
.text-custom-color-blue {
    color: #00A8FF
}
</style>