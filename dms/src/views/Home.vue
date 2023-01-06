<template>
  <div>
    <nav aria-label="breadcrumb" class="mt-4">
      <ol class="breadcrumb">
        <li class="breadcrumb-item active d-flex flex-row ml-4" aria-current="page">
          <span class="material-icons">home</span>
          <span class="align-self-center">&nbsp;Home</span>
        </li>
        <li class="ml-auto mr-5">
            <button @click="switchLayout">
                <span v-if="layout == 'grid'" class="material-icons action-icon ml-auto pr-4">
                    list
                </span>
                <span v-if="layout == 'list'" class="material-icons action-icon ml-auto pr-4">
                    grid_view
                </span>
            </button>
            <span class="material-icons action-icon">
                info
            </span>
        </li>
      </ol>
    </nav>
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
          <div v-if="layout == 'grid'">
              <GridView :folders="[]" :files="files"/>
          </div>
          <div v-if="layout == 'list'">
              <ListView :folders="[]" :files="files"/>
          </div>
        </v-tab-item>
        <v-tab-item :key="1">
          <br>
          <div v-if="layout == 'grid'">
              <GridView :folders="[]" :files="getPendingDocs()"/>
          </div>
          <div v-if="layout == 'list'">
              <ListView :folders="[]" :files="getPendingDocs()" :hasStatus="false"/>
          </div>
        </v-tab-item>
        <v-tab-item :key="2">
          <br>
          <div v-if="layout == 'grid'">
              <GridView :folders="[]" :files="getSignedDocs()"/>
          </div>
          <div v-if="layout == 'list'">
              <ListView :folders="[]" :files="getSignedDocs()" :hasStatus="false"/>
          </div>
        </v-tab-item>
      </v-tabs>
     
    </div>
  </div>

</template>
<script setup>
import ModalFileDetails from './ModalFileDetails.vue';
import GridView from '../components/GridView.vue';
import ListView from '../components/ListView.vue';
import logoURL from '../assets/img-doc.png'
import socketIOClient from "socket.io-client";
</script>
<script>
  export default {
    components: {ModalFileDetails},
    data() {
      return {
        files: [],
        folders: [],
        showModal: false,
        layout: localStorage.getItem("layout") ? localStorage.getItem("layout") : "grid",
        active: 1,
      }
    },
    mounted() {
      // let x = socketIOClient(import.meta.env.VITE_SERVER_URL)
      // console.log("x", x);
      this.$router.push(this.$route.path)
    },
    created() {
        this.$store.dispatch("auth/sidebarActive", "home")
        // this.$store.dispatch("document/getRootFolders")  
        this.callAPI()
    },
    methods: {
      switchLayout() {
        if(this.layout === "list"){
            this.layout = "grid"
            localStorage.setItem("layout", "grid")
        }else if (this.layout === "grid"){
            this.layout = "list"
            localStorage.setItem("layout", "list")
        }
      },
      async callAPI() { 
        await this.$store.dispatch("document/getAllFiles")
        await this.$store.dispatch("document/getTreeFolder")
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
