<template>
    <div>
        <br>
        <h4 class="font-weight-bold">Folders</h4>
        <hr>
        
        <div v-if="folders.length > 0" class="item-grid-card">
            
            <FolderVue
                v-for="(folder, index) in folders"
                :key="index"
                :name="folder.name"
                :id="folder._id"
            />
        </div>
        <br>
        <br>
        <h4 class="font-weight-bold">File</h4>
        <hr>
        
        <div v-if="files.length > 0" class="item-grid-card">
            <FileVue
                v-for="(file, index) in files"
                :key="index"
                :name="JSON.parse(file.tokenURI).name"
                :fileType="JSON.parse(file.tokenURI).fileType"
                :id="file._id"
                :file="file"
            />
        </div>
    </div>
</template>

<script setup>
import FileVue from '../components/File.vue'
import FolderVue from '../components/Folder.vue';
</script>

<script>
import $ from 'jquery' 

export default {
    props: {
        folders: Array,
        files: Array
    },
    data() {
        return {
        }
    },
    mounted() {
        console.log("folders", this.folders);
        console.log("files", this.files);
    },
    methods: {
        // openModal(id) {
        //     $("#"+id).modal('toggle');
        // },
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