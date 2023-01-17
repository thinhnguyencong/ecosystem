<template>
	<div>
        <NavBar @onLayoutChange="onLayoutChange" @handleDrawer="handleDrawer"/>
        <ModalAddNewFolder v-if="documentState.folder" :parentId="documentState.folder._id"/>
        <ModalUploadFile/>
        <div class="pl-4 pr-4 pt-3" v-if="!documentState.isLoading">
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
                        <ListTableVue :folders="documentState.children" :files="documentState.folder.files" :hasStatus="false"/>
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
    import FolderVue from '../../components/Folder.vue';
    import FileVue from '../../components/File.vue'
    import ModalAddNewFolder from './modal/ModalAddNewFolder.vue';
    import ModalUploadFile from './modal/ModalUploadFile.vue'
    import ManageKey from '../../components/ManageKey.vue'
    import ListTableVue from '../../components/ListView.vue';
    import GridViewVue from '../../components/GridView.vue';
    import ModalFileDetails from './modal/ModalFileDetails.vue';
    import FolderDetail from '../../components/FolderDetail.vue';
    import { getLayoutOfPage, setLayoutOfPage } from '../../helpers';
    import $ from "jquery"
import NavBar from '../../components/layout/NavBar.vue';

    $(document).ready(function() {
        $('#modalCreateFolder').on('shown.bs.modal', function() {
            $('#newFolderName').trigger('focus');
            $('#newFolderName').select()
        });
    });
</script>
<script>
export default {
  components: { ModalAddNewFolder, ManageKey, ModalFileDetails, NavBar },
    mounted() {
        // Call the API query method on page load
        
    },
    created() {
        this.callAPI()
        this.layout = getLayoutOfPage(this.authState.user.publicAddress, this.$route)
    },
    data() {
        return {
            layout: null,
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
        onLayoutChange(layout) {
            this.layout = layout
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