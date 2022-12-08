<template>
	<div >
        <nav aria-label="breadcrumb">
            <ol class="breadcrumb">
                <li class="breadcrumb-item active" aria-current="page">
                    Shared with me
                </li>
                <li class="ml-auto pr-5">
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
                <GridViewVue :folders="documentState.children" :files="[]"/>
            </div>
            <div v-if="layout == 'list'">
                <div class="table-responsive">
                    <table id="transactionsTable" class="table table-hover" data-pagination="true">
                        <thead>
                        <tr>
                            <th scope="col">Name &nbsp; <i class="mdi mdi-arrow-down text-dark"></i></th>
                            <th scope="col">Token Id</th>
                            <th scope="col">Date Modified</th>
                            <th scope="col">Owner</th>
                            <th scope="col">Size</th>
                            <th scope="col">Action</th>
                        </tr>
                        </thead>
                        
                    </table>
                </div>
            </div>
        </div>
        <div v-else class="spinner-border text-dark" role="status">
            <span class="sr-only">Loading...</span>
        </div>
        
	</div>
</template>
<script setup>
import FileVue from '../components/File.vue'
import FolderVue from '../components/Folder.vue';

</script>
<script>

export default {
  components: { File },
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
           mockData: [
             {
                name: "Head First python.pdf",
                type: "pdf"
            },
            {
                name: "Weekly Report.pptx",
                type: "pptx"
            },
            {
                name: "Monthly Report.pdf",
                type: "pdf"
            },
            {
                name: "Testcase.xlsx",
                type: "xlsx"
            },
            {
                name: "Reading CAM 13.docx",
                type: "docx"
            },
            {
                name: "index.html",
                type: "html"
            },
            {
                name: "style.css",
                type: "css"
            },
            {
                name: "Timetable 20221.xlsx",
                type: "xlsx"
            },
            {
                name: "script.js",
                type: "javascript"
            },
            {
                name: "Testcase 2.xlsx",
                type: "xlsx"
            },
           ]
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
</style>