<template>
  <div>
    <NavBar @onLayoutChange="onLayoutChange"/>
    <div class="container">
      <v-tabs icons-and-text class="h-100" fixed-tabs grow v-model="active">
        <v-tabs-slider :color="active==2 ? 'green' : active== 1 ? 'red' : 'blue'"></v-tabs-slider>
        <v-tab color="success" class="document-tab-0 border-bottom" active-class="text-primary font-weight-bold" :key="0" >
              <span class="text-primary">All Documents</span>
              <span class="text-primary material-icons">assignment</span>
        </v-tab>
        <v-tab class="document-tab-1 border-bottom" active-class="text-danger font-weight-bold" :key="1">
          <span class="text-danger">Needs to sign</span>
          <span class="text-danger material-icons">history_edu</span>
        </v-tab>
        <v-tab class="document-tab-2 border-bottom text-success" active-class="text-success font-weight-bold" :key="2">
           <span class="text-success">Signed</span>
           <span class="text-success material-icons">assignment_turned_in</span>
        </v-tab>
        <v-tab-item :key="0">
          <br>
          <div v-if="active==0">
            <MainView :folders="[]" :files="files" :layoutProps="layout"/>
          </div>
        </v-tab-item>
        <v-tab-item :key="1">
          <br>
          <div v-if="active==1">
            <MainView :folders="[]" :files="getPendingDocs()" :layoutProps="layout"/>
          </div>
        </v-tab-item>
        <v-tab-item :key="2">
          <br>
          <div v-if="active==2">
            <MainView :folders="[]" :files="getSignedDocs()" :layoutProps="layout"/>
          </div>
        </v-tab-item>
      </v-tabs>
     
    </div>
  </div>

</template>
<script setup>
import ModalFileDetails from './modal/ModalFileDetails.vue';

import NavBar from '../../components/layout/NavBar.vue';
import MainView from '../../components/MainView.vue';
</script>
<script>
  export default {
    components: { ModalFileDetails, NavBar, MainView },
    data() {
      return {
        files: [],
        folders: [],
        showModal: false,
        active: 1,
        layout: ""
      }
    },
    mounted() {
      this.$router.push(this.$route.path)
      console.log("home");
    },
    created() {
        this.$store.dispatch("auth/sidebarActive", "home")
        // this.$store.dispatch("document/getRootFolders")  
        this.callAPI()
    },
    methods: {
      async callAPI() { 
        if(!this.documentState.files.length) {
          await this.$store.dispatch("document/getAllFiles")
        }
        console.log("this.documentState", this.documentState);
        this.files = this.documentState.files
        this.folders = this.documentState.folders
      },
      getPendingDocs() {
        return this.files.filter((file) => this.documentState.pendingDocs.includes(file.tokenId));
      },
      getSignedDocs() {
        return this.files.filter((file) => this.documentState.signedDocs.includes(file.tokenId));
      },
      onLayoutChange(layout) {
        this.layout = layout
      }
    },
    computed: {
        documentState() {return this.$store.state.document },
    },
    watch: {
    },
  }
</script>
<style scoped>
.item-grid-card {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(200px, 1fr));
  gap: 1rem;
}
.action-icon {
    cursor: pointer;
}
.action-icon:hover {
    background: transparent;
	color: #0f85f4;
}

</style>
<style lang="scss">

.content-categories {
  display: flex;
  justify-content: space-evenly;
  width: 100%;
  border-bottom: 1px solid #ddd;
  padding: 20px 0;
}

.nav-item { display: none; }

.category { 
  font-weight: 500; 
  color: var(--secondary); 
  border-bottom: 1px solid #ddd;
  transition: .1s ease-in;
  padding: 20px 30px;
  cursor: pointer;
}

#opt-1:checked + label ,
#opt-2:checked +  label ,
#opt-3:checked +  label ,
#opt-4:checked +  label {
  color: var(--blue);
  border-bottom: 2px solid ;
}
.document-tab {
    cursor: pointer;
}
.document-tab-0:hover {
    background-color: rgb(250, 249, 249);
    cursor: pointer;
}
.document-tab-1:hover {
    background-color: rgb(250, 249, 249);
    cursor: pointer;
}
.document-tab-2:hover {
    background-color: rgb(250, 249, 249);
    cursor: pointer;
}

</style>
