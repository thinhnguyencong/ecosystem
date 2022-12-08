<template>
  <!-- <div class="about">
    <div class="card app-card" style="width: 18rem;">
      <img :src="logoURL" class="card-img-top"  alt="Vue" />  
      <div class="card-body">
        <a href="/" class="card-title stretched-link">Document Management System</a>
      </div>
    </div>
  </div> -->
  <div>
    <nav aria-label="breadcrumb">
      <ol class="breadcrumb">
        <li class="breadcrumb-item active" aria-current="page">Home</li>
      </ol>
    </nav>
    <div v-if="documentState.rootFolders.length > 0" class="item-grid-card">
      <FolderVue
        v-for="(folder, index) in documentState.rootFolders"
        :key="index"
        :name="folder.name"
        :id="folder._id"
      />
    </div>
    
  </div>

</template>
<script setup>

import logoURL from '../assets/img-doc.png'
import FolderVue from '../components/Folder.vue';

</script>
<script>
  export default {
    data() {
      return {
       
      }
    },
    created() {
        this.$store.dispatch("document/getRootFolders")       
    },
    methods: {
      
    },
    computed: {
        documentState() {return this.$store.state.document },
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
