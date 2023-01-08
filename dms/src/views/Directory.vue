<template>
	<div >
        <nav aria-label="breadcrumb" class="mt-4">
            <ol class="breadcrumb mt-2">
                <li v-if="documentState.folder.status=='my-folder'" class="ml-4" aria-current="page">
                    <router-link class="align-self-center d-flex flex-row" to="/my-folder"><span class="material-icons">folder</span><span class="align-self-center mt-1">&nbsp;My Folder</span></router-link>
                </li>
                <li v-else-if="documentState.folder.status=='shared-with-me'" class="ml-4" aria-current="page">
                    <router-link class="align-self-center d-flex flex-row" to="/shared-with-me"><span class="material-icons">folder</span><span class="align-self-center mt-1">&nbsp;Shared with me</span></router-link>
                </li>
                <li v-else class="ml-4" aria-current="page">
                    <router-link class="align-self-center d-flex flex-row" to="/"><span class="material-icons">folder</span><span class="align-self-center mt-1">&nbsp;Home</span></router-link>
                </li>
                <li v-for="(folder, index) in documentState.ancestors" :key="index" 
                    aria-current="page">
                    <router-link class="align-self-center d-flex flex-row" :to="'/folder/'+ folder._id">
                        <span class="material-icons">
                            &nbsp;/ folder
                        </span>
                        <span class="align-self-center mt-1">&nbsp;{{folder.name}}</span>
                    </router-link>
                </li>
                <li v-if="documentState.folder" class="d-flex flex-row mt-n-2" aria-current="page">
                    <span class="material-icons">
                        &nbsp;/ <i class="mdi mdi-folder-open text-secondary"></i>
                    </span>
                    <span class="align-self-center mt-1 text-secondary">
                        &nbsp;{{documentState.folder.name}}
                    </span>
                </li>
                <li class="ml-auto mr-5">
                    <button @click="switchLayout">
                        <span v-if="layout == 'grid'" class="material-icons action-icon ml-auto pr-4">
                            list
                        </span>
                        <span v-if="layout == 'list'" class="material-icons action-icon ml-auto pr-4">
                            grid_view
                        </span>
                    </button>
                    <span class="material-icons action-icon" @click="handleDrawer">
                        info
                    </span>
                </li>
            </ol>
             
        </nav>
        <ModalAddNewFolder v-if="documentState.folder" :parentId="documentState.folder._id"/>
        <ModalUploadFile/>
        <div class="pl-5 pr-5 pt-3" v-if="!documentState.isLoading">
            <div class="row">
                <div class="col">
                    <div class="dropdown">
                        <button class="btn btn-primary btn-lg" type="button" id="dropdownMenuButton" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                            <i class="mdi mdi-plus text-light"></i> New &nbsp;  
                        </button>
                        <div class="dropdown-menu" aria-labelledby="dropdownMenuButton">
                            <a data-toggle="modal" data-target="#modalCreateFolder" class="dropdown-item" href="#"><i class="mdi mdi-folder text-dark"></i> New Folder </a>
                            <a data-toggle="modal" data-target="#modalUploadFile" class="dropdown-item" href="#"><i class="mdi mdi-upload text-dark"></i> Upload File</a>
                        </div>
                    </div>
                    <div v-if="layout == 'grid'">
                        <GridViewVue :folders="documentState.children" :files="documentState.folder.files"/>
                    </div>
                    <div v-if="layout == 'list'">
                        <ListTableVue :folders="documentState.children" :files="documentState.folder.files"/>
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
        <div v-else class="pl-4 pr-4">
            <div class="spinner-border text-dark" role="status">
                <span class="sr-only">Loading...</span>
            </div>
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
    import ModalFileDetails from './ModalFileDetails.vue';
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
  components: { ModalAddNewFolder, ManageKey, ModalFileDetails  },
    mounted() {
        // Call the API query method on page load
        
    },
    created() {
        this.callAPI()
        
    },
    data() {
        return {
            layout: localStorage.getItem("layout") ? localStorage.getItem("layout") : "grid",
            transition: 'slide-fade',
            drawerVisible: false,
        }
    },
    computed: {
        documentState() {return this.$store.state.document },
        authState() {return this.$store.state.auth },
    },
    methods: {
        async callAPI() {
            await this.$store.dispatch("document/getTreeFolder")
            await this.$store.dispatch("document/getFolderById", {id: this.$route.params.id})
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
    watch: {
        '$route.params.id': {
            handler(newVal, oldVal) {
                if(newVal !== oldVal) {
                    this.$store.dispatch("document/getFolderById", {id: newVal})
                }
            },
            immediate: true
        },
    },


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
.action-icon {
    cursor: pointer;
}
.action-icon:hover {
    background: transparent;
	color: #0f85f4;
}
.mt-n-2 {
    margin-top: -0.2rem;
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