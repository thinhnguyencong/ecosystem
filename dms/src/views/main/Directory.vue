<template>
	<div class="detailFolder">
        <div class="detail-folder" v-if="!documentState.isLoading">
            <div class="row dricetoryFlex">

                <div class="col ">
                    <ModalAddNewFolder v-if="documentState.folder" :parentId="documentState.folder._id"/>
                    <MainView :folders="documentState.children" :files="documentState.folder.files" :layoutProps="layout"/>
                    <ModalUploadFile/>

                </div>

                <div class="folder-detail" v-if="isShowDetail">

                    <FolderDetail @ClickOffDetail="isDetail"/>
                </div>
            </div>
        </div>
        <div v-else class="">
            <div class="spinner-border text-dark" role="status">
                <span class="sr-only">Loading...</span>
            </div>
        </div>
	</div>
</template>
<script setup>
import ModalAddNewFolder from './modal/ModalAddNewFolder.vue';
import ModalUploadFile from './modal/ModalUploadFile.vue'
import ManageKey from '../../components/ManageKey.vue'
import ModalFileDetails from './modal/ModalFileDetails.vue';
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
  components: { ModalAddNewFolder, ModalFileDetails, NavBar, MainView },
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
            isShowDetail:false,
        }
    },
    computed: {
        documentState() {return this.$store.state.document },
        authState() {return this.$store.state.auth },
    },
    methods: {
        isDetail(isShowDetail) {
            this.isShowDetail = isShowDetail
        },

        async callAPI() {
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
                    this.layout = getLayoutOfPage(this.authState.user.publicAddress, this.$route)
                }
            },
            immediate: true
        },
    },


}
</script>

<style lang="scss" scoped>
@import "@/assets/style/_reset.scss";

.dricetoryFlex {
  display: flex;
  align-items: center;
  justify-content: space-between;
}
.detailFolder {
}
.nav-content {
  margin: 0;
}
.detail-option {
  border-left: 1px solid var(--border-color);
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