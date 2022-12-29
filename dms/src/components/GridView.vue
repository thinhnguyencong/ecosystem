<template>
    <div>
        <br>
        <div v-if="folders.length">
            <h4 class="font-weight-bold">Folders</h4>
            <hr>
            
            <div class="item-grid-card">
                
                <FolderVue
                    v-for="(folder, index) in folders"
                    :key="index"
                    :name="folder.name"
                    :id="folder._id"
                />
            </div>
            <br>
            <br>
        </div>
        <div v-if="files.length">
            
            <h4 class="font-weight-bold">Files</h4>
            <hr>
            
            <div class="item-grid-card">
                <router-link
                    tag="tr"
                    class="item" 
                    v-for="(file, index) in files"
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
        <div v-if="files?.length == 0 && folders?.length == 0">
            <h5>This folder is empty</h5>
        </div>
        
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

        }
    },
    mounted() {

    },
    methods: {
    },
}
</script>
<style scoped>
.item-grid-card {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(200px, 1fr));
  gap: 1rem;
}
</style>