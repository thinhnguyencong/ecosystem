<template>
    <div :id="fileId" class="modal-mask">
        <div class="modal-wrapper" @click="$router.go(-1)">
            <div class="modal-container" role="document" @click.stop="">
                <div class="modal-content">
                    <div class="modal-header d-flex flex-row justify-content-center align-items-center text-center">
                        <button type="button" class="close" @click="$router.go(-1)" aria-label="Close">
                            <p class="h1" aria-hidden="true">
                                <span class="material-icons">arrow_back</span>
                            </p>
                        </button>
                        <h5  class="modal-title w-100">{{file.tokenURI ? JSON.parse(file.tokenURI).name : ""}}</h5>
                        <router-link :to="'..'">
                            <button @click="test" type="button" class="close" aria-label="Close">
                                <p class="h1" aria-hidden="true">&times;</p>
                            </button>
                        </router-link>
                    </div>
                    <div v-if="!documentState.file.isLoading" class="modal-body" style="height: 80vh;">
                        <div class="container h-100">
                            <div class="row h-100">
                                <div class="col-7 h-100">
                                    <div :class="file.tokenURI !== undefined && 
                                    (JSON.parse(file.tokenURI).fileType == 'application/vnd.openxmlformats-officedocument.wordprocessingml.document' || JSON.parse(file.tokenURI).fileType == 'application/vnd.openxmlformats-officedocument.presentationml.presentation'
                                    ? 'w-100 h-100 overflow-auto': 'w-100 h-100')">
                                        <div v-if="isLoadingFile">
                                            <div class="spinner-border text-dark" role="status">
                                                <span class="sr-only">Loading...</span>
                                            </div>
                                            <span class="h5">Decrypting file...</span>
                                        </div>
                                        <iframe v-if="link.length" style="overflow: hidden;" width="100%" height="100%" class="frame" :src="link" frameborder="0"></iframe>
                                        <div id="wrap" class="w-100 h-100"></div>  
                                    </div>
                                    <div v-if="error">{{ error }}</div>
                                </div>
                                <div class="col-5 h-100">
                                    <v-tabs icons-and-text class="h-100" fixed-tabs grow v-model="active" color="#f7f7f7">
                                        <v-tabs-slider color="blue"></v-tabs-slider>
                                        <v-tab class="file-detail-tab" active-class="tab-active text-primary font-weight-bold" :key="0" >
                                            Document Details
                                        </v-tab>
                                        <v-tab class="file-detail-tab" active-class="tab-active text-primary font-weight-bold" :key="1">
                                            Comments
                                        </v-tab>
                                        <v-tab class="file-detail-tab" active-class="tab-active text-primary font-weight-bold" :key="2">
                                            Status
                                        </v-tab>
                                        <v-tab-item :key="0">
                                            <div class="doc-info mt-4">
                                                    <div class="row">
                                                        <div class="col-4">
                                                            <p class="font-weight-bold">Owner :</p>
                                                        </div>
                                                        <div class="col-8">
                                                            <p>{{ file.owner.name }}</p>
                                                        </div>
                                                    </div>
                                                    <div class="row">
                                                        <div class="col-4">
                                                            <p class="font-weight-bold">Upload At :</p>
                                                        </div>
                                                        <div class="col-8">
                                                            <p>{{(new Date(file.createdAt)).toLocaleTimeString()+ " " + (new Date(file.createdAt)).toDateString()}}</p>
                                                        </div>
                                                    </div>
                                            </div>
                                            <div class="description">
                                                <p class="font-weight-bold">Description :</p>
                                                <div class="border border-muted description-box scrollbar">
                                                    <div class="card-body">
                                                        <div v-html="file.description"></div>
                                                    </div>
                                                </div>
                                            </div>
                                                
                                        </v-tab-item>
                                        <v-tab-item :key="1">
                                            <br>
                                            <div class="border border-muted comment-box">
                                                <div class="input-group">
                                                    <textarea v-on:keyup.enter="handleAddComment" v-model="content" placeholder="Write your comment..." class="form-control shadow-none" autofocus="true"></textarea>
                                                </div>
                                                <!-- <hr class="divider" /> -->
                                                <div class="d-flex action">
                                                    <div class="p-2 mr-auto">
                                                        <div class="align-self-center">
                                                            <v-menu
                                                                transition="slide-y-transition"
                                                                bottom
                                                                content-class="my-menu"
                                                            >
                                                                <template v-slot:activator="{ on }">
                                                                    <div class="align-self-center ">
                                                                        <v-badge
                                                                            left
                                                                            overlap
                                                                            color="orange"
                                                                            >
                                                                            <template v-slot:badge v-if="attachments.length">
                                                                                <span>{{ attachments.length }}</span>
                                                                            </template>
                                                                            
                                                                            <v-btn flat icon color="indigo" v-on="on">
                                                                                <v-icon
                                                                                    data-toggle="tooltip" 
                                                                                    title="Add attachment"
                                                                                    color="black"
                                                                                >
                                                                                attach_file
                                                                                </v-icon>
                                                                            </v-btn>
                                                                                
                                                                        </v-badge>
                                                                    </div>
                                                                </template>
                                                                
                                                                <div @click.stop="" class="attachment">
                                                                    <treeselect
                                                                        v-model="attachments"
                                                                        :multiple="true" 
                                                                        :options="documentState.treeFolder" 
                                                                        :value-consists-of="valueConsistsOf"
                                                                        placeholder="Add attachments.." 
                                                                        :normalizer="normalizer"
                                                                    />
                                                                </div>
                                                                
                                                            </v-menu>
                                                        </div>
                                                    </div>
                                                    <div class="p-2">
                                                        <div class="align-self-center ml-auto ">
                                                            <button v-if="!documentState.file.isLoadingComment" style="float: right;" type="button" class="btn btn-primary" @click="handleAddComment"><span class="material-icons">send</span></button>
                                                            <button v-else class="btn btn-primary" type="button" disabled style="float: right;">
                                                                <span class="spinner-border spinner-border" role="status" aria-hidden="true"></span>
                                                            </button>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <br>
                                            <div class="comment-div">
                                                <h5 class="font-weight-bold">All comments</h5>
                                                <div class="border border-muted comment-list scrollbar">
                                                    <div class="p-3" :id="'comments-'+file._id">
                                                       <Comment />
                                                    </div>
                                                </div>
                                            </div>
                                           
                                        </v-tab-item>
                                        <v-tab-item :key="2">
                                            <br>
                                            <h5 class="font-weight-bold">Document Information</h5>
                                            <div class="card border border-muted">
                                                <div class="card-body">
                                                    <span>Status: &nbsp;</span>
                                                    <span v-if="file.status === 'waiting-to-review'" class="font-weight-bold text-warning">Waiting to review</span>
                                                    <span v-if="file.status === 'waiting-to-sign'" class="font-weight-bold text-info">Waiting to sign</span>
                                                    <span v-if="file.status === 'rejected'" class="font-weight-bold text-danger">Rejected</span>
                                                    <span v-if="file.status === 'signed'" class="font-weight-bold text-success">Signed</span>
                                                    <p></p>
                                                    <p class="font-weight-bold">Review History: </p>
                                                    <p v-for="(reviewer, index) in file?.statusDetail?.reviewerList" :key="index+reviewer.name">{{reviewer.name}}: &nbsp; 
                                                        <span v-if="reviewer.status === 'not-yet-reviewed'" class="font-weight-bold text-muted">Not reviewed yet</span>
                                                        <span v-if="reviewer.status === 'reviewed'" class="font-weight-bold text-success">Reviewed at {{formatDateTime(reviewer.time)}}</span>
                                                        <span v-if="reviewer.status === 'rejected'" class="font-weight-bold text-danger">Rejected at {{formatDateTime(reviewer.time)}}</span>
                                                    </p>
                                                    <p class="font-weight-bold">Sign History: </p>
                                                    <p v-for="(signer, index) in file?.statusDetail?.signerList" :key="index+signer.name">{{signer.name}}: &nbsp; 
                                                        <span v-if="signer.status === 'not-yet-signed'" class="font-weight-bold text-muted">Not signed yet</span>
                                                        <span v-if="signer.status === 'signed'" class="font-weight-bold text-info">Signed at {{formatDateTime(signer.time)}}</span>
                                                        <span v-if="signer.status === 'rejected'" class="font-weight-bold text-danger">Rejected at {{formatDateTime(signer.time)}}</span>
                                                    </p>
                                                </div>
                                            </div>
                                            <br>
                                            <div class="row">
                                                <div class="col-md-4 text-center">
                                                    
                                                </div>
                                                <div class="col-md-8 text-center">
                                                    <span class="float-md-right">
                                                        <button v-if="documentState.file.isLoadingReject" class="btn btn-danger btn-lg" type="button" disabled>
                                                            <span class="spinner-border spinner-border-sm" role="status" aria-hidden="true"></span>
                                                            Rejecting...
                                                        </button>
                                                        <span v-else>
                                                            <button v-if="file.canSign" class="btn btn-danger btn-lg" aria-disabled="false" @click="handleReject('sign')">Reject</button>
                                                            <button v-else-if="file.canReview" class="btn btn-danger btn-lg" role="button" aria-disabled="false" @click="handleReject('review')">Reject</button>
                                                        </span>
                                                        <button v-if="documentState.file.isLoadingSign && file.canReview" class="btn btn-warning btn-lg" type="button" disabled>
                                                            <span class="spinner-border spinner-border-sm" role="status" aria-hidden="true"></span>
                                                            Reviewing...
                                                        </button>
                                                        <button v-else-if="documentState.file.isLoadingSign && file.canSign" class="btn btn-success btn-lg" type="button" disabled>
                                                            <span class="spinner-border spinner-border-sm" role="status" aria-hidden="true"></span>
                                                            Signing...
                                                        </button>
                                                        <span v-else>
                                                            <button v-if="file.canReview" class="btn btn-warning btn-lg" role="button" aria-disabled="false" @click="handleSign('review')">Review</button>
                                                            <button v-if="file.canSign" class="btn btn-success btn-lg" role="button" aria-disabled="false" @click="handleSign('sign')">Sign</button>
                                                        </span>
                                                    </span>
                                                </div>
                                            </div>
                                        </v-tab-item>
                                    </v-tabs>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div v-else class="modal-body" style="height: 80vh;">
                        <div class="spinner-border text-dark" role="status">
                            <span class="sr-only">Loading...</span>
                        </div>
                    </div>
                    
                </div>
            </div>
        </div>
    </div>
</template>

<script>
import xlsxPreview from 'xlsx-preview';
import Comment from "../components/Comment.vue"
import { IpfsClient } from "../helpers/ipfs";
import {encrypt, decrypt} from "../helpers/encrypt-decrypt"
// import the component
import Treeselect from '@riophae/vue-treeselect'
import {renderAsync} from "docx-preview/dist/docx-preview"
console.log("ABCCCCCC");
export default {
    props: ["fileId"],
    components: { Treeselect, Comment },
    data() {
        return {
            showAttach: false,
            ipfs: null,
            file: {},
            link: "",
            error: null,
            content: "",
            active: 0,
            normalizer(node) {
                return {
                    id: node._id,
                    label: node.name,
                    children: node.children,
                }
            },
            attachments: [],
            valueConsistsOf: 'LEAF_PRIORITY',
            isLoadingFile: false
        }
    },

    mounted() {
        this.initData(this.fileId)
    },
    methods: {
        test() {
            console.log(this.$router);
            console.log(this.$route);
        },
        async initData(fileId) {
            this.$set(this, 'isLoadingFile', true);
            if(fileId) {
                try {
                    await this.$store.dispatch("document/getFileById", {id: fileId})
                    this.file = this.documentState.file
                } catch (error) {
                    console.log(error);
                    this.$set(this, 'isLoadingFile', false);
                    this.error="No file to preview"
                }
            }
            if(this.file.hash) {
                this.error=null
                IpfsClient().get(this.file.hash).then(async (res) =>{
                    console.log("res", res);
                    let resultDecrypt = decrypt(res[0].content, this.file.key)
                    let tokenUri = JSON.parse(this.file.tokenURI)
                    if(tokenUri.fileType == 'application/vnd.openxmlformats-officedocument.wordprocessingml.document') {
                        renderAsync(resultDecrypt, document.getElementById("wrap"))
                        .then(x => {
                            console.log(this.isLoadingFile);
                            this.$set(this, 'isLoadingFile', false);
                            console.log("docx: finished")
                        });
                    }
                    else if (tokenUri.fileType == 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet') {
                        const buffer = resultDecrypt.buffer
                        const result = await xlsxPreview.xlsx2Html(buffer, {
                            output: 'arrayBuffer',
                            minimumRows: 50,
                            minimumCols: 30,
                        });
                        const url = URL.createObjectURL(new Blob([result], {
                            type: 'text/html'
                        }));
                        document.querySelector('#wrap').innerHTML =
                            `<object class="res-obj w-100 h-100" type="text/html" data="${url}"></object>`
                            console.log(this.isLoadingFile);
                        this.$set(this, 'isLoadingFile', false);
                    }
                    else if (tokenUri.fileType == 'application/vnd.openxmlformats-officedocument.presentationml.presentation') {
                        let fileData = new File([resultDecrypt], tokenUri.name, {type:tokenUri.fileType})
                        $("#wrap").pptxToHtml({
                            fileData: fileData,
                        });
                        this.$set(this, 'isLoadingFile', false);
                    }else {
                        let b64 = this.b64EncodeUnicode(resultDecrypt)
                        let abc = await this.bufferArrayToBlob(b64, tokenUri.fileType)
                        this.link = abc
                        this.$set(this, 'isLoadingFile', false);
                    }
                })
                .catch(error =>  {
                    this.$set(this, 'isLoadingFile', false);
                    this.error="No file to preview"
                })
            } else {
                this.$set(this, 'isLoadingFile', false);
                this.error="No file to preview"
            }
        },

        formatDateTime(time) {
            return dayjs.unix(time).format('HH:mm:ss DD MMMM YYYY')
        },
        
        async bufferArrayToBlob(base64, type ) {
            const typeNew = 'data:' + type + ';base64'
            const base64Response = await fetch(`${typeNew},${base64}`)
            const blob1 = await base64Response.blob()
            const blob = new Blob([blob1], { type: type })
            const link = window.URL.createObjectURL(blob)
            console.log(link);
            return link
        },
        b64EncodeUnicode(bytes) {
            // let bytes = new Uint8Array( data );
            let len = bytes.byteLength;
            let binary = ''
            for (var i = 0; i < len; i++) {
                binary += String.fromCharCode( bytes[ i ] );
            }
            return btoa(  binary);
        },
        handleAddComment() {
            if(!this.content) {
                alert("Please write some content")
                return
            }
            let data = {
                fileId: this.file._id,
                content: this.content,
                attachments: this.attachments
            }
            this.$store.dispatch("document/addComment", data)
            this.content = ""
            this.attachments= []
            // this.scrollToEnd()
        },
        handleSign(type) {
            this.$swal({
                title: 'Are you sure signing this doc?',
                text: "You won't be able to revert this action!",
                icon: 'info',
                showCancelButton: true,
                confirmButtonColor: '#3085d6',
                cancelButtonColor: '#d33',
                confirmButtonText: 'Sign'
                }).then((result) => {
                if (result.isConfirmed) {
                    this.$store.dispatch("document/signDoc", {type, tokenId: this.file.tokenId})
                }
            });
            
        },
        handleReject(type) {
            this.$swal({
                title: 'Are you sure reject this doc?',
                text: "You won't be able to revert this action!",
                icon: 'warning',
                showCancelButton: true,
                confirmButtonColor: '#3085d6',
                cancelButtonColor: '#d33',
                confirmButtonText: 'Reject'
                }).then((result) => {
                if (result.isConfirmed) {
                    this.$store.dispatch("document/rejectDoc", {type, tokenId: this.file.tokenId})
                }
            });
        },
    },
    computed: {
        documentState() {return this.$store.state.document },
    },
    watch: { 
        '$route.params.fileId': {
            handler(newVal, oldVal) {
                if(newVal) {
                    console.log("newVal", newVal, oldVal);
                    this.link = ""
                    this.file = {}
                    this.$set(this, 'isLoadingFile', true);
                    console.log("2");
                    this.initData(newVal)
                }
            },
        },
        '$store.state.document.file': {
            handler(newVal, oldVal) {
                this.file = newVal
            },
            immediate: true
        },
    }
}
</script>
<style scoped>
.modal-lg {
    max-width: 80%;
    max-height: 80vh;
}
.list {
    height: 110px;
    overflow-y: scroll; /* Add the ability to scroll */
}
.scrollbar {
    overflow-y: scroll; /* Add the ability to scroll */
}
/* Hide scrollbar for Chrome, Safari and Opera */
.scrollbar::-webkit-scrollbar {
    display: none;
}

/* Hide scrollbar for IE, Edge and Firefox */
.scrollbar {
  -ms-overflow-style: none;  /* IE and Edge */
  scrollbar-width: none;  /* Firefox */
}

hr.divider { 
  margin: 0em;
  border-width: 2px;
  opacity: 0.5;
} 
.form-control {
    border: 0;
}
.input-group {
    min-height: 60px;
}

.modal-mask {
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background-color: rgba(0, 0, 0, .5);
    display: table;
    transition: opacity .3s ease;
    z-index: 1;
}
.modal-wrapper {
  display: table-cell;
  vertical-align: middle;
} 
.modal-container {
  width: 80%;
  margin: 0px auto;
  background-color: #fff;
  border-radius: 2px;
  box-shadow: 0 2px 8px rgba(0, 0, 0, .33);
  transition: all .3s ease;
  font-family: Helvetica, Arial, sans-serif;
}

.frame {
    resize: both; 
}

.slide-enter, .slide-leave-to{
  transform: scaleY(0);
}
/* .icon-badge-container {
    position:relative;
}

.icon-badge-icon {
    font-size: 30px;
    position: relative;
    border-radius: 50%;
    padding: 5px;
}
.icon-badge-icon:hover {
    background-color: rgb(246, 239, 239);
    cursor: pointer;
    box-shadow: 0 5px 15px rgba(184, 165, 197, 0.4);
} */
.icon-badge {
    background-color: red;
    font-size: 12px;
    color: white;
    text-align: center;
    width:17px;
    height:17px;
    border-radius: 50%;
    position: absolute; /* changed */
    top: -5px; /* changed */
    left: 19px; /* changed */
} 
.attachment {
    position: absolute;
    z-index: 1;
    width: 400px;
}
.action {
    background-color: rgb(254, 254, 255);
}
textarea {
    min-height: 80%;
}
.comment-div {
    height: 75%;
}
.comment-list {
    height: 85%;
}
.description {
    height: 80%;
}
.description-box {
    height: 90%;
}
.doc-info {
    min-height: 15%;
}
.file-detail-tab {
    cursor: pointer;
}
.file-detail-tab:hover {
    background-color: #eee;
}
.tab-active {
    background-color: #eee;
}
.my-menu {
  margin-top: 40px;
  contain: initial;
  overflow: visible;
}
.my-menu::before {
  position: absolute;
  content: "";
  top: 0;
  right: 10px;
  transform: translateY(-100%);
  width: 10px; 
  height: 13px; 
  border-left: 10px solid transparent;
  border-right: 10px solid transparent;
  border-bottom: 13px solid rgb(233, 230, 230);
  margin-top: 5px;
}

</style>