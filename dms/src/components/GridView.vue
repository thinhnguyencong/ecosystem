<template>
    <div>
        <div v-if="!documentState.isLoading">
            <br>
            <div v-if="folderList.length">
                <h4 class="font-weight-bold">Folders</h4>
                <hr>
                
                <div class="item-grid-card">
                    <div v-for="(folder, index) in folderList" class="tile">
                        <div class="float-right">
                            <div class="dropdown">
                                <div v-if="folder.owner && folder.owner._id == authState.user._id" class="align-self-center" @click="openDropdown(folder._id)">
                                    <v-btn flat icon color="indigo">
                                        <v-icon data-toggle="tooltip" title="" color="#818181">
                                            more_vert
                                        </v-icon>
                                    </v-btn> 
                                </div>
                                <div v-click-outside="(event) => closeDropdown(folder._id, event)" v-if="showMenu == folder._id" :id="'myDropdown-'+folder._id" class="dropdown-content">
                                    <div class="list-group">
                                        <a href="#" class="list-group-item list-group-item-action">@ Rename </a>
                                        <a href="#" class="list-group-item list-group-item-action">@ Share </a>
                                    </div>
                                </div>
                            </div>
                           
                        </div>
                        
                        <div class="folder" @click="handleAccessFolder(folder._id)">
                            <FolderVue
                                :key="index"
                                :name="folder.name"
                                :id="folder._id" 
                            />
                        </div>
                    </div>
                </div>
                
                <br>
                <br>
            </div>
            <div v-if="fileList.length">
                
                <h4 class="font-weight-bold">Files</h4>
                <hr>
                
                <div class="item-grid-card">
                    <router-link
                        tag="tr"
                        class="item" 
                        v-for="(file, index) in fileList"
                        :key="file._id"
                        :to="$route.path == '/' ? `${$route.path}file/${file._id}`: `${$route.path}/file/${file._id}`"
                    >
                        <FileVue
                            :name="JSON.parse(file.tokenURI).name"
                            :fileType="JSON.parse(file.tokenURI).fileType"
                            :id="file._id"
                            :file="file"
                        />
                    </router-link>
                </div>
            </div>
            <div v-if="fileList?.length == 0 && folderList?.length == 0">
                <h5>This folder is empty</h5>
            </div>
        </div>
        <div v-else class="pl-4 pr-4">
            <div class="spinner-border text-dark" role="status">
                <span class="sr-only">Loading...</span>
            </div>
        </div>
        <Transition name="modal">
            <router-view v-if="showModal"></router-view>
        </Transition>
    </div>
</template>

<script setup>
import FileVue from '../components/File.vue'
import FolderVue from '../components/Folder.vue';
import $ from "jquery"
</script>

<script> 

export default {
    props: {
        folders: {
            type: Array,
            default() {return []}
        },
        files: {
            type: Array,
            default() {return []}
        }
    },
    data() {
        return {
            showModal: false,
            fileList: [],
            folderList: [],
            showMenu: ""
        }
    },
    mounted() {
        
    },
    methods: {
        handleAccessFolder(id) {
            console.log(id);
            this.$router.push("/folder/" + id);
        },
       openDropdown(id) {
        this.showMenu = id
       },
       closeDropdown(id) {
        this.showMenu = ""
       }
    },
    computed: {
        documentState() {return this.$store.state.document },
        authState() {return this.$store.state.auth },
    },
    watch: {
      '$route': {
        immediate: true,
        handler: function(newVal, oldVal) {
            this.showModal = newVal.meta && newVal.meta.showModal;
        }
      },
      files: {
        immediate: true,
        handler: function(newVal, oldVal) {
            this.fileList = newVal
        }
      },
      folders: {
        immediate: true,
        handler: function(newVal, oldVal) {
            this.folderList = newVal
        }
      }
    },
}
</script>
<style scoped>
.tile {
    border-radius: 3px;
    width: 200px;
    height: 100%;
    transition: 0.2s all cubic-bezier(0.4, 0.0, 0.2, 1);
    position: relative;
    cursor: pointer;
}
.folder {
    height: 100%;
    padding: 3.5rem 1rem 3rem;
    text-align: center;
    border: 1px solid #eeeeee;;
}
.folder:hover{
  box-shadow: 0px 7px 5px -6px rgba(0, 0, 0, 0.12);
  background-color: #eeeeee;
  border: 1px solid #dddddd;;
}

.item-grid-card {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(200px, 1fr));
  gap: 1rem;
}
.modal-enter, .modal-leave-active {
    opacity: 0;
}

.modal-enter .modal-container,
.modal-leave-active .modal-container {
  -webkit-transform: scale(1.1);
  transform: scale(1.1);
}

.dropdown {
  position: relative;
  display: inline-block;
}

.dropdown-content {
  top: 3rem;
  left: 20px;
  display: block;
  position: absolute;
  background-color: #f1f1f1;
  width: 110px;
  height: 5rem;
  box-shadow: 0px 8px 16px 0px rgba(0,0,0,0.2);
  z-index: 1;
}
</style>