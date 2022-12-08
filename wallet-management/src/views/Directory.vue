<template>
	<div >
        <nav aria-label="breadcrumb">
            <ol class="breadcrumb">
                <li class="breadcrumb-item" aria-current="page">
                    <a href='/applications'>Home</a>
                </li>
                <li v-for="(folder, index) in documentState.ancestors" :key="index" 
                    class="breadcrumb-item " aria-current="page">
                    <a :href="'/folder/'+ folder._id">{{folder.name}}</a>
                </li>
                <li v-if="documentState.folder" class="breadcrumb-item active" aria-current="page">{{documentState.folder.name}}</li>
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
                <div v-if="documentState.children.length > 0" class="item-grid-card">
                    <FolderVue
                        v-for="(folder, index) in documentState.children"
                        :key="index"
                        :name="folder.name"
                        :id="folder._id"
                    />
                    <FileVue
                        v-for="(file, index) in mockData"
                        :key="index"
                        :name="file.name"
                        :type="file.fileType"
                        :id="file._id"
                    />
                </div>
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
                        <tbody>
                            <tr>
                                <th scope="row">
                                    <i class="mdi mdi-folder text-custom-color-blue"></i> CA
                                </th>
                                <td>-</td>
                                <td>26 Aug 2022</td>
                                <td>Nguyễn Văn A</td>
                                <td>-</td>
                                <td>
                                    
                                </td>
                            </tr>
                            <tr>
                                <th scope="row">
                                    <i class="mdi mdi-folder text-custom-color-blue"></i> AI
                                </th>
                                <td>-</td>
                                <td>2 Feb 2022</td>
                                <td>Vũ Văn D</td>
                                <td>-</td>
                                <td>
                                    
                                </td>
                            </tr>
                            <tr>
                                <th scope="row">
                                    <i class="mdi mdi-file-pdf-box text-danger"></i> Head First python.pdf
                                </th>
                                <td>1</td>
                                <td>18 Aug 2022</td>
                                <td>Nguyễn Văn A</td>
                                <td>101 MB</td>
                                <td>
                                    <span class="material-icons">visibility</span>&nbsp;&nbsp;
                                    <span class="material-icons">download</span>&nbsp;&nbsp;
                                    <span class="material-icons text-secondary">info</span>&nbsp;&nbsp;
                                    <span class="material-icons text-success">edit_calendar</span>
                                </td>
                            </tr>
                            <tr>
                                <th scope="row">
                                    <i class="mdi mdi-microsoft-powerpoint text-danger"></i> Weekly Report.pptx
                                </th>
                                <td>2</td>
                                <td>01 Jan 2022</td>
                                <td>Nguyễn Thị B</td>
                                <td>202 MB</td>
                                <td>
                                    <span class="material-icons">visibility</span>&nbsp;&nbsp;
                                    <span class="material-icons">download</span>&nbsp;&nbsp;
                                    <span class="material-icons text-secondary">info</span>&nbsp;&nbsp;
                                    <span class="material-icons text-success">edit_calendar</span>
                                </td>
                            </tr>
                            <tr>
                                <th scope="row">
                                    <i class="mdi mdi-file-pdf-box text-danger"></i> Monthly Report.pdf
                                </th>
                                <td>3</td>
                                <td>18 Aug 2022</td>
                                <td>Nguyễn Văn A</td>
                                <td>70 MB</td>
                                <td>
                                    <span class="material-icons">visibility</span>&nbsp;&nbsp;
                                    <span class="material-icons">download</span>&nbsp;&nbsp;
                                    <span class="material-icons text-secondary">info</span>&nbsp;&nbsp;
                                    <span class="material-icons text-success">edit_calendar</span>
                                </td>
                            </tr>
                            <tr>
                                <th scope="row">
                                    <i class="mdi mdi-microsoft-excel text-success"></i> Testcase.xlsx
                                </th>
                                <td>4</td>
                                <td>18 Aug 2022</td>
                                <td>Trần Văn C</td>
                                <td>700 MB</td>
                                <td>
                                    <span class="material-icons">visibility</span>&nbsp;&nbsp;
                                    <span class="material-icons">download</span>&nbsp;&nbsp;
                                    <span class="material-icons text-secondary">info</span>&nbsp;&nbsp;
                                    <span class="material-icons text-success">edit_calendar</span>
                                </td>
                            </tr>
                            <tr>
                                <th scope="row">
                                    <i class="mdi mdi-microsoft-word text-primary"></i> Reading CAM 13.docx
                                </th>
                                <td>3</td>
                                <td>19 Jun 2022</td>
                                <td>Nguyễn Văn A</td>
                                <td>230 MB</td>
                                <td>
                                    <span class="material-icons">visibility</span>&nbsp;&nbsp;
                                    <span class="material-icons">download</span>&nbsp;&nbsp;
                                    <span class="material-icons text-secondary">info</span>&nbsp;&nbsp;
                                    <span class="material-icons text-success">edit_calendar</span>
                                </td>
                            </tr>

                        
                        <tr>
                            <td class="text-center" colspan="6" scope="row"><a href="">See more ...</a></td>
                        </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
        <div v-else className="spinner-border text-dark" role="status">
            <span className="sr-only">Loading...</span>
        </div>
        
	</div>
</template>
  
<script>
export default {
  components: { File },
    mounted() {
        // Call the API query method on page load
        
    },
    created() {
        this.$store.dispatch("document/getFolderById", {id: this.$route.params.id})       
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
    watch: {
    '$route.params.id': {
      handler() {
        console.log("abc");
        this.$store.dispatch("document/getFolderById", {id: this.$route.params.id})
      },
      immediate: true
    } 
  }

}
</script>
<script setup>
import FolderVue from '../components/Folder.vue';
import FileVue from '../components/File.vue'
import File from '../components/File.vue'
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