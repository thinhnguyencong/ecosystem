<template>
    <div >
        <NavBar @onLayoutChange="onLayoutChange" @handleDrawer="handleDrawer"/>
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
                    <MainView :folders="documentState.children" :files="documentState.folder.files" :layoutProps="layout"/>
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

        <ModalAddNewFolder v-if="documentState.folder" :parentId="documentState.folder._id"/>
        <ModalUploadFile/>
    </div>
</template>
<script setup>
import ModalFileDetails from './modal/ModalFileDetails.vue';
import ModalAddNewFolder from './modal/ModalAddNewFolder.vue';
import ModalUploadFile from './modal/ModalUploadFile.vue';
import FolderDetail from '../../components/FolderDetail.vue';
import { getLayoutOfPage, setLayoutOfPage } from '../../helpers';
import $ from "jquery"
import NavBar from '../../components/layout/NavBar.vue';
import MainView from '../../components/MainView.vue';
$(document).ready(function() {
    $('#modalCreateFolder').on('shown.bs.modal', function() {
        $('#newFolderName').trigger('focus');
        $('#newFolderName').select()
    });
});
</script>
<script>

export default {
    components: { ModalAddNewFolder, ModalUploadFile, ModalFileDetails, FolderDetail, NavBar, MainView },
    mounted() {
        this.$router.push(this.$route.path)
        this.layout = getLayoutOfPage(this.authState.user.publicAddress, this.$route)
    },
    created() {
        this.callAPI()
    },
    data() {
        return {
            name: "Untitled Folder",
            layout: "",
            drawerVisible: false,
            showModal: false,
            transition: 'slide-fade'
        }
    },
    computed: {
        documentState() {return this.$store.state.document },
        authState() {return this.$store.state.auth },
    },
    methods: {
        async callAPI() {
            this.$store.dispatch("auth/sidebarActive", "my-folder")
            await this.$store.dispatch("document/getMyFolders")
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
        }
    },
    watch: {
        '$route': {
            immediate: true,
            handler: async function(newVal, oldVal) {
                console.log(newVal, oldVal);
                this.layout = await getLayoutOfPage(this.authState.user.publicAddress, newVal)
            }
        },
    }
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