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
        <li class="ml-auto">
            <button @click="switchLayout">
                <span v-if="layout == 'grid'" class="material-icons ml-auto pr-4">
                    list
                </span>
                <span v-if="layout == 'list'" class="material-icons ml-auto pr-4">
                    grid_view
                </span>
            </button>
            <span class="material-icons ">
                info
            </span>
        </li>
      </ol>
    </nav>
    <div v-if="!documentState.isLoading">
      <div v-if="layout == 'grid'">
          <GridView :folders="[]" :files="documentState.files"/>
      </div>
      <div v-if="layout == 'list'">
          <ListView :folders="[]" :files="documentState.files"/>
      </div>
    </div>
    <div v-else class="spinner-border text-dark" role="status">
        <span class="sr-only">Loading...</span>
    </div>
    <div v-if="showModal">
        <router-view v-slot="{ Component }">
          <transition name="modal">
            <component :is="Component" />
          </transition>
        </router-view>
    </div>
  </div>

</template>
<script setup>
import ModalFileDetails from './ModalFileDetails.vue';
import GridView from '../components/GridView.vue';
import ListView from '../components/ListView.vue';
import logoURL from '../assets/img-doc.png'
import FolderVue from '../components/Folder.vue';
import { IpfsClient } from '../helpers/ipfs';
import { CID } from 'ipfs-http-client'
</script>
<script>
  export default {
    components: {ModalFileDetails},
    data() {
      return {
        showModal: false,
        layout: localStorage.getItem("layout") ? localStorage.getItem("layout") : "grid",
      }
    },
    mounted() {
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
      }
    },
    computed: {
        documentState() {return this.$store.state.document },
    },
    watch: {
      '$route': {
        immediate: true,
        handler: function(newVal, oldVal) {
          this.showModal = newVal.meta && newVal.meta.showModal;
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
.material-icons{
    cursor: pointer;
}
.material-icons:hover {
    background: transparent;
	color: #0f85f4;
}
/*
 * The following styles are auto-applied to elements with
 * transition="modal" when their visibility is toggled
 * by Vue.js.
 *
 * You can easily play with the modal transition by editing
 * these styles.
 */
 .modal-enter, .modal-leave {
    opacity: 0;
}

.modal-enter .modal-container,
.modal-leave .modal-container {
    -webkit-transform: scale(1.1);
    transform: scale(1.1);
}
</style>
