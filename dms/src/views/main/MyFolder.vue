<template>
	<div >
      <div class="myFolder">
          <div class="folder-file">
              <div  class="folder">
                  <div class="folder-header">
                      <div class="folder-title">
                      </div>
                      <div class="folder-list" >
                          <MainView class="list-folder-item" :folders="documentState.children" :files="documentState.folder.files" :layoutProps="layout"  />
                      </div>
                  </div>
              </div>
          </div>
      </div>


<!---->
        <div class="pl-4 pr-4 pt-3" v-if="!documentState.isLoading">
            <div class="row">
                <div class="col">
                    <div class="dropdown">
                        <button class="btn btn-primary btn-lg" type="button" id="dropdownMenuButton" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                            <i class="mdi mdi-plus text-light"></i> New &nbsp;
                        </button>
                        <div class="dropdown-menu" aria-labelledby="dropdownMenuButton"> </div>
                    </div>
                </div>
            </div>
        </div>
        <div v-else class="pl-4 pr-4">
            <div class="spinner-border text-dark" role="status">
                <span class="sr-only">Loading...</span>
            </div>
        </div>

        <!-- component form add -->
        <ModalAddNewFolder v-if="documentState.folder" :parentId="documentState.folder._id"/>

      <!-- component form upload -->

<!--      <a data-toggle="modal" data-target="#modalUploadFile" class="dropdown-item" href="#"><i class="mdi mdi-upload text-dark"></i> Upload File</a>-->
        <ModalUploadFile/>
      <!-- component form upload -->
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
    components: { ModalAddNewFolder, ModalUploadFile, ModalFileDetails, FolderDetail, NavBar, MainView },
    mounted() {
        // this.$router.push(this.$route.path)
        // this.layout = getLayoutOfPage(this.authState.user.publicAddress, this.$route)
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
            transition: 'slide-fade',

            itemSelectedID:null
        }
    },
    computed: {

        documentState() {return this.$store.state.document },
        authState() {return this.$store.state.auth },
    },
    methods: {
        btnShowCheckBox(id) {
          this.isShowDetail = !this.isShowDetail
            this.itemSelectedID = id
            console.log(this.itemSelectedID = id)
        },
        isShowDetailClick(isShowDetail) {
          this.isShowDetail = isShowDetail
        },
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

<style lang="scss" scoped>
@import "@/assets/style/_reset.scss";
ol , ul {
    margin: 0;
}



.myFolder {
    display: flex;
    width: 100%;
}
.folder-file {
    width: 100%;

}
// folder detail


.folder-detail {
    max-width: 288px;
    width: 100%;
    background: var(--backgroud);
    border-left:1px solid var(--border-color);
}



//
.my-folder {
    color:#6F7180 ;
    max-width: calc( 100% - 106px);
    float: left;
    display: flex;
}
.folder-content {
    border-right: 1px solid #EDEDED;
}

.folder-header-name {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 20px;
}
.folder-header_option {
    display: flex;
    justify-content: center;
    align-items: center;
    gap: 8px;
}
.folder-Starred {
    font-weight: 500;
    font-size: 14px;
    color: #3C46F5;
    cursor: pointer;
}
.folder-Starred {
    cursor: pointer;
    margin-left: 16px;
}
.folder-arrow-down {
    cursor: pointer;
}
.folder-Starred {
    cursor: pointer;
}
.folder-header_title {
    display: flex;
    justify-content: center;
    align-items: center;
    gap: 0 8px;
}
.folder-header_name {
    color: #6F7180;
    font-weiht: 400;
    font-size: 12px;
}
.arrow-right {
    color: #C1C0C9;

}
.BlockChain {
    font-weight: 600;
    font-size: 12px;
    color: var(--text-color--1);

}


.folder-list {
    width: 100%;
}


.list-folder {
    display: flex;
    flex-wrap:wrap;
    justify-content: space-around;
    gap: 16px;
    width: 100%;
}
.folder-item_title {
    font-weight: 600;
    font-size: 14px;
    color: var(--text-color--1);
    display: -webkit-box;
    -webkit-box-orient: vertical;
    overflow: hidden;
    -webkit-line-clamp: 1;
}

.folder-item_active {
    display: flex;
    align-items: center;
    gap: 0 8px;
}
.list-folder-active {
    background-color: #E7F3FF;
}

.folder-item_header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    gap: 0 8px;
    margin-bottom: 4px;
}
.folder-item_txt {
    display: flex;
    align-items: center;
    gap: 0 8px;
    margin-bottom: 8px;
}
.folder-item_file {
    font-size: 12px;
    color: #6F7180;
}
.folder-item_distance {
    width: 4px;
    height: 4px;
    background-color: #6F7180;
    border-radius: 50%;
}
.folder-item_MB {
    font-size: 12px;
    color: #6F7180;
}
.item-icon_number {
}
#icon-member {
    z-index: 1;
    width: 24px;
    height: 24px;
    border: 1.5px solid #FFFFFF;
    border-radius: 50%;
}
#icon-member:nth-child(2) {
    margin-left: -10px;
    z-index: 2;
    border: 1.5px solid #FFFFFF;
    border-radius: 50%;
}
#icon-member:nth-child(3) {
    margin-left: -10px;
    border-radius: 50%;
    border: 1.5px solid #FFFFFF;
    z-index: 3;
}
.item-icon_Eval {
    display: flex;
    align-items: center;
    justify-content: space-around;
    gap: 0 4px;
}
.item-icon_member {
    font-size: 12px;
    color: #6F7180;
}
.folder-item-icon {
    display: flex;
    align-items: center;
    gap: 0 6px;
}

.folder-bottom {
    display: flex;
    justify-content: center;
    align-items: center;
}

.border-dropdown {
    padding: 10px 15px;
    border-radius: 50%;
    border: 1.5px solid #EDEDED;
    cursor: pointer;
}


// file


.files-header {
    padding:0 16px;

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
}
.arrow-right {
    color: #C1C0C9;

}
.BlockChain {
    font-weight: 600;
    font-size: 12px;
    color: var(--text-color--1);

}
.files-title {
    font-weight: 700;
    font-size: 18px;
    color: var(--text-color--1);
    margin-bottom: 16px;
}

.files-list {
    display: flex;
    gap: 0 16px;
    width: 100%;
    margin-bottom: 16px;
}
.files-add {
    width: calc( 100% / 5 - 16px );
}
.item-files_border {
    background: #FBFCFD;
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
    justify-content: space-around;
    gap: 16px;
    width: 100%;
}
.list-files-item {
    width: calc( 100% / 5 - 16px );
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
    color: var(--text-color--1);
    display: -webkit-box;
    -webkit-box-orient: vertical;
    overflow: hidden;
    -webkit-line-clamp: 1;
}


//
.my-folder {
    color:#6F7180 ;
    width: calc( 100% - 106px);
    float: right;
}
.dropdown-item {
    padding: 0;
}
.folder-content {
    max-width: 1014px;
    width: 100%;
}

.folder-header-name {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 20px;
}
.folder-header_option {
    display: flex;
    justify-content: center;
    align-items: center;
    gap: 8px;
}
.folder-Starred {
    font-weight: 500;
    font-size: 14px;
    color: #3C46F5;
    cursor: pointer;
}
.folder-Starred {
    cursor: pointer;
    margin-left: 16px;
}
.folder-arrow-down {
    cursor: pointer;
}
.folder-Starred {
    cursor: pointer;
}
.folder-header_title {
    display: flex;
    justify-content: center;
    align-items: center;
    gap: 0 8px;
}
.folder-header_name {
    color: #6F7180;
    font-size: 12px;
}
.arrow-right {
    color: #C1C0C9;

}
.BlockChain {
    font-weight: 600;
    font-size: 12px;
    color: var(--text-color--1);

}
//.folder-title {
//    font-weight: 700;
//    font-size: 18px;
//    color: var(--text-color--1);
//    margin-bottom: 16px;
//}

.folder-add {
    width: calc(100% / 6 - 16px);
}


.list-folder {
    display: flex;
    flex-wrap: wrap;
    gap: 16px;
    width: 100%;
}


.folder-item_header {
    display: flex;
    align-items: center;
    gap: 0 8px;
    margin-bottom: 4px;
}
.folder-item_txt {
    display: flex;
    align-items: center;
    gap: 0 8px;
    margin-bottom: 8px;
}
.folder-item_file {
    font-size: 12px;
    color: #6F7180;
}
.folder-item_distance {
    width: 4px;
    height: 4px;
    background-color: #6F7180;
    border-radius: 50%;
}
.folder-item_MB {
    font-weight: 400;
    font-size: 12px;
    color: #6F7180;
}
.item-icon_number {
}
.item-icon_member {
    font-size: 12px;
    color: #6F7180;
}

#icon-member {
    z-index: 1;
    width: 24px;
    height: 24px;
    border: 1.5px solid #FFFFFF;
    border-radius: 50%;
}
#icon-member:nth-child(2) {
    margin-left: -10px;
    z-index: 2;
    border: 1.5px solid #FFFFFF;
    border-radius: 50%;
}
#icon-member:nth-child(3) {
    margin-left: -10px;
    border-radius: 50%;
    border: 1.5px solid #FFFFFF;
    z-index: 3;
}
.folder-item-icon {
    display: flex;
    align-items: center;
    gap: 0 8px;
}

.folder-bottom {
    display: flex;
    justify-content: center;
    align-items: center;
}

.border-dropdown {
    padding: 10px 15px;
    border-radius: 50%;
    border: 1.5px solid #EDEDED;
    cursor: pointer;
}


// file


.files-header {
    padding:0 16px;

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
    color: var(--text-color--1);

}
.folder-item_title {
    font-weight: 600;
    font-size: 14px;
    color: var(--text-color--1);
    display: -webkit-box;
    -webkit-box-orient: vertical;
    overflow: hidden;
    -webkit-line-clamp: 1;
}
.files-title {
    font-weight: 700;
    font-size: 18px;
    color: var(--text-color--1);
    margin-bottom: 16px;
}

.files-list {
    display: flex;
    gap: 0 16px;
    width: 100%;
    margin-bottom: 16px;
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
    justify-content: space-around;
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
    color: var(--text-color--1);
    display: -webkit-box;
    -webkit-box-orient: vertical;
    overflow: hidden;
    -webkit-line-clamp: 1;
}
.tooltip-arrow  {
    content: "";
    position: absolute;
    right: 10px;
    border-style: solid;
    border-width: 0 12px 12px 12px;
    border-color: transparent transparent red transparent;
}
#border-dropdown {
    padding: 12px 10px;
    border: 1px solid #EDEDED;
    border-radius: 500px;
}
#sucss {
    width: 12px;
    height: 8px;

}
.folder-Starred {
    position: relative;
}
.menu-option {
    position: absolute;
    top: 30px;
    right: 0;
    background: #FFFFFF;
    box-shadow: 0 40px 64px -12px rgba(0, 0, 0, 0.08), 0px 0px 14px -4px rgba(0, 0, 0, 0.05), 0px 32px 48px -8px rgba(0, 0, 0, 0.1);
    border-radius: 16px;
    min-width: 238px;
    width: 100%;
    padding: 16px;
    &--item {
        display: flex;
        align-items: center;
        gap: 0 12px;
        cursor: pointer;
        padding: 8px;
    }
}
.menu-item--txt {
    font-weight: 600;
    font-size: 14px;
    color: var(--text-color--1);
    position: relative;
}
.activeMenu {
    background: #E7F3FF;
    border-radius: 12px;
}
#inputOption {
    max-width: 120px;
    width: 100%;
    float: right;
    font-weight: 500;
    font-size: 14px;
    color: #3C46F5;
    pointer-events: none;
    user-select: none;
    &::placeholder {
        font-weight: 500;
        font-size: 14px;
        color: #3C46F5;
    }
}
#inputOption::-webkit-input-placeholder {
    text-align: right;
}

#inputOption:-moz-placeholder {
    text-align: right;
}

#inputOption::-moz-placeholder {
    text-align: right;
}

#inputOption:-ms-input-placeholder {
    text-align: right;
}
.menu-item--icon {
    width: 8%;
}


//


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