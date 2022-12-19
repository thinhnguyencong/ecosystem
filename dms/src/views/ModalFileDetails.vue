<template>
    <div class="modal fade" :id="file._id" tabindex="-1" role="dialog" aria-labelledby="modalDetailFileTitle" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered modal-lg" role="document">
            <div class="modal-content">
                <div class="modal-header d-flex flex-row justify-content-center align-items-center text-center">
                    <h5 v-if="file.tokenURI" class="modal-title w-100">{{JSON.parse(file.tokenURI).name}}</h5>
                
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <p class="h1" aria-hidden="true">&times;</p>
                    </button>
                    
                </div>
                <div class="modal-body">
                    <div class="container">
                        <div class="row">
                            <div class="col-7">
                                <div class="">
                                    <!-- <embed :src="'https://drive.google.com/viewer?url='+ link + '.pdf&embedded=true'" class="w-100 vh-190" height="600px" frameborder="0"/> -->
                                    <!-- <VueDocPreview :url="link" type="office" /> -->
                                    <embed :src="link" class="w-100" height="600px" frameborder="0" id='embedDocument'>
                                </div>
                            </div>
                            <div class="col-5">
                                    <v-tabs fixed-tabs grow v-model="active" color="#eee" slider-color="cyan" :ref="'tabs-'+file._id">
                                        <v-tab :key="0" >
                                            Document Details
                                        </v-tab>
                                        <v-tab :key="1">
                                            Comments
                                        </v-tab>
                                        <v-tab :key="2">
                                            Status
                                        </v-tab>
                                        <v-tab-item :key="0">
                                            <div class="row">
                                                <div class="col-md-12">
                                                    <br>
                                                    <h5 class="font-weight-bold">Description</h5>
                                                    <div class="card border border-muted">
                                                        <div class="card-body description scrollbar">
                                                            <div v-html="file.description"></div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <br>
                                            <div class="row">
                                                <!-- <div class="col">
                                                    <div class="font-weight-bold">Reviewer List</div>
                                                    <ul class="list-group list-group-flush list">
                                                        <li class="list-group-item">Dapibus ac facilisis in</li>
                                                        <li class="list-group-item">Morbi leo risus</li>
                                                        <li class="list-group-item">Porta ac consectetur ac</li>
                                                        <li class="list-group-item">Vestibulum at eros</li>
                                                    </ul>
                                                </div>
                                                <div class="col">
                                                    <div class="font-weight-bold">Signer List</div>
                                                    <ul class="list-group list-group-flush  list">
                                                        <li class="list-group-item">Dapibus ac facilisis in</li>
                                                        <li class="list-group-item">Morbi leo risus</li>
                                                        <li class="list-group-item">Porta ac consectetur ac</li>
                                                        <li class="list-group-item">Vestibulum at eros</li>
                                                    </ul>
                                                </div> -->
                                                
                                            </div>
                                            
                                            
                                        </v-tab-item>
                                        <v-tab-item :key="1">
                                            <br>
                                            <h5 class="font-weight-bold">All comments</h5>
                                            <div class="card border border-muted">
                                                <div class="card-body" :id="'comments-'+file._id">
                                                    <div v-if="file?.comments?.length>0" class="comments scrollbar"> 
                                                        <div v-for="(comment, index) in file.comments" :key="index" class="list-group ">
                                                            <div class="d-flex w-100 justify-content-between">
                                                                <h5 class="mb-1">{{comment.name}}</h5>
                                                                <small>{{customTime(comment.createdAt)}}</small>
                                                            </div>
                                                            <p class="font-weight-bold mb-1">{{comment.content}}</p>
                                                        </div>
                                                    </div>
                                                    <div v-else> 
                                                        No comment yet
                                                    </div>
                                                </div>
                                                <button type="button" class="btn btn-primary" @click="openThis" >
                                                    Launch demo modal
                                                </button>
                                            </div>
                                            <br>
                                            <div v-if="file.canComment==true" class="input-group">
                                                <textarea v-model="content" placeholder="Add a comment..." class="form-control" aria-label="With textarea"></textarea>
                                                <button type="button" class="btn btn-primary" @click="handleAddComment">Add</button>
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
                                                    <p v-for="(reviewer, index) in file?.statusDetail?.reviewerList">{{reviewer.name}}: &nbsp; 
                                                        <span v-if="reviewer.status === 'not-yet-reviewed'" class="font-weight-bold text-muted">Not reviewed yet</span>
                                                        <span v-if="reviewer.status === 'reviewed'" class="font-weight-bold text-success">Reviewed at {{formatDateTime(reviewer.time)}}</span>
                                                        <span v-if="reviewer.status === 'rejected'" class="font-weight-bold text-danger">Rejected at {{formatDateTime(reviewer.time)}}</span>
                                                    </p>
                                                    <p class="font-weight-bold">Sign History: </p>
                                                    <p v-for="(signer, index) in file?.statusDetail?.signerList">{{signer.name}}: &nbsp; 
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
                                                        <a v-if="file.canSign" class="btn btn-danger btn-lg" role="button" aria-disabled="false" @click="handleReject('sign')">Reject</a>
                                                        <a v-else-if="file.canReview" class="btn btn-danger btn-lg" role="button" aria-disabled="false" @click="handleReject('review')">Reject</a>
                                                        <!-- <a v-else class="btn btn-danger btn-lg disabled" role="button" aria-disabled="true">Reject</a> -->
                                                        <a v-if="file.canReview" class="btn btn-warning btn-lg" role="button" aria-disabled="false" @click="handleSign('review')">Review</a>
                                                        <!-- <a v-else class="btn btn-warning btn-lg disabled" role="button" aria-disabled="true">Review</a> -->
                                                        <a v-if="file.canSign" class="btn btn-success btn-lg" role="button" aria-disabled="false" @click="handleSign('sign')">Sign</a>
                                                        <!-- <a v-else class="btn btn-success btn-lg disabled" role="button" aria-disabled="true">Sign</a> -->
                                                    </span>
                                                </div>
                                            </div>
                                        </v-tab-item>
                                    </v-tabs>
                            </div>
                        </div>
                    </div>
                    
                </div>
                <!-- <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                </div> -->
            </div>
        </div>

    </div>
</template>
<script>
import { IpfsClient } from "../helpers/ipfs";
import {encrypt, decrypt} from "../helpers/encrypt-decrypt"
import $ from 'jquery' 
// import dayjs from 'dayjs/esm/index.js'

export default {
    props: {
        fileProps: Object,
    },
    data() {
        return {
            ipfs: null,
            file: {},
            link: "",
            error: null,
            content: "",
            active: 0
            // active: true
        }
    },
    created() {
        
    },
    mounted() {
       this.$set(this, 'file', this.fileProps)
       if(this.file) {
            this.error=null
            IpfsClient().get(this.file.hash).then(async (res) =>{
                if(res) {
                    let resultDecrypt = decrypt(res[0].content, this.file.key)
                    let tokenUri = JSON.parse(this.file.tokenURI)
                    let b64 = this.b64EncodeUnicode(resultDecrypt)
                    let abc = await this.bufferArrayToBlob(b64, tokenUri.fileType)
                    this.link = abc
                }
                else {
                    this.error="No file to preview"
                }
                // this.saveByteArray("Sample Report", res[0].content.buffer); // download button
            })
        }else {
            this.error="No file to preview"
        }
    },
    methods: {
        openThis() {
            $('#63a006aff195ec4567efe72d').modal({
                show: true
            })
        },
        customTime(time)  {
            return dayjs(time).fromNow();
        },
        formatDateTime(time) {
            return dayjs.unix(time).format('HH:mm:ss DD MMMM YYYY')
        },
        scrollToEnd() {
            var container = document.getElementById("comments-"+this.file._id)
            container.style.overflowY = "scroll"
            console.log("container", container);
            var scrollHeight = container.scrollHeight
            container.scrollTop = scrollHeight
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
            let data = {
                fileId: this.file._id,
                content: this.content,
            }
            this.$store.dispatch("document/addComment", data)
            this.content = ""
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
    // computed: {
        
    // },
    watch: { 
        fileProps: function(newVal, oldVal) { // watch it
            console.log("newVal", newVal);
            this.file = newVal
            if(this.file) {
                this.error=null
                IpfsClient().get(this.file.hash).then(async (res) =>{
                    if(res) {
                        console.log(res[0].content)
                        let resultDecrypt = decrypt(res[0].content, this.file.key)
                        console.log('resultDecrypt', resultDecrypt);
                        let tokenUri = JSON.parse(this.file.tokenURI)
                        console.log("tokenUri", tokenUri);
                        let b64 = this.b64EncodeUnicode(resultDecrypt)
                        let abc = await this.bufferArrayToBlob(b64, tokenUri.fileType)
                        this.link = abc
                    }
                    else {
                        this.error="No file to preview"
                    }
                    // this.saveByteArray("Sample Report", res[0].content.buffer); // download button
                })
            }else {
                this.error="No file to preview"
            }
        },
    }
}
</script>
<style scoped>
.modal-lg {
    max-width: 80%;
    max-height: 80vh;
}
.description {
    height: 350px; 
}
.comments {
    height: 350px; 
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
    /* display: none; */
}

/* Hide scrollbar for IE, Edge and Firefox */
.scrollbar {
  -ms-overflow-style: none;  /* IE and Edge */
  scrollbar-width: none;  /* Firefox */
}
/*  */
</style>