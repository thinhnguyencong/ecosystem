<template>
    <div>
        <br>
        <div v-if="folderList.length">
            <h4 class="font-weight-bold">Folders</h4>
            <hr>
            
            <div class="item-grid-card">
                
                <FolderVue
                    v-for="(folder, index) in folderList"
                    :key="index"
                    :name="folder.name"
                    :id="folder._id"
                />
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
        <Transition name="modal">
            <router-view v-if="showModal"></router-view>
        </Transition>
    </div>
</template>

<script setup>
import FileVue from '../components/File.vue'
import FolderVue from '../components/Folder.vue';
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
            folderList: []
        }
    },
    mounted() {
        
    },
    methods: {
    },
    watch: {
      '$route': {
        immediate: true,
        handler: function(newVal, oldVal) {
            console.log(newVal, oldVal);
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
</style>