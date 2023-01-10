<template>
	<div>
        <nav aria-label="breadcrumb">
            <ol class="breadcrumb">
                <li class="breadcrumb-item active d-flex flex-row ml-4" aria-current="page"><span class="material-icons">folder_shared</span><span class="align-self-center">&nbsp;Share With Me</span></li>
                <li class="ml-auto mr-5">
                    <button @click="switchLayout">
                        <span v-if="layout == 'grid'" class="material-icons action-icon ml-auto pr-4">
                            list
                        </span>
                        <span v-if="layout == 'list'" class="material-icons action-icon ml-auto pr-4">
                            grid_view
                        </span>
                    </button>
                    <!-- <span class="material-icons action-icon">
                        info
                    </span> -->
                </li>

            </ol>
             
        </nav>

        <div class="pl-4 pr-4" v-if="!documentState.isLoading">
            <div v-if="layout == 'grid'">
                <GridViewVue :folders="documentState.children" :files="[]"/>
            </div>
            <div v-if="layout == 'list'">
                <ListView :folders="documentState.children" :files="[]" :hasStatus="false"/>
            </div>
        </div>
        <div v-else class="pl-4 pr-4">
            <div class="spinner-border text-dark" role="status">
                <span class="sr-only">Loading...</span>
            </div>
        </div>
        
	</div>
</template>
<script setup>
import GridViewVue from '../components/GridView.vue';
import ListView from '../components/ListView.vue';
</script>
<script>

export default {
  components: { File, ListView },
    mounted() {
        // Call the API query method on page load
        this.$router.push(this.$route.path)
    },
    created() {
        this.$store.dispatch("auth/sidebarActive", "shared-with-me")
        this.$store.dispatch("document/getSharedWithMeFolders")       
    },
    data() {
        return {
           layout: "grid",
        }
    },
    computed: {
        documentState() {return this.$store.state.document },
    },
    methods: {
        switchLayout() {
            if(this.layout === "list"){
                this.layout = "grid"
            }else if (this.layout === "grid"){
                this.layout = "list"
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
.float-right {
    float: right;
}
.text-custom-color-blue {
    color: #00A8FF
}
.action-icon {
    cursor: pointer;
}
.action-icon:hover {
    background: transparent;
	color: #0f85f4;
}
</style>