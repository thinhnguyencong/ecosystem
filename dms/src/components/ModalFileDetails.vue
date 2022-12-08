<template>
    <div class="modal fade" :id="file._id" tabindex="-1" role="dialog" aria-labelledby="modalDetailFileTitle" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered modal-lg" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 v-if="file.tokenURI" class="modal-title text-center">{{JSON.parse(file.tokenURI).name}}</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="container">
                        <div class="row">
                            <div class="col-7">
                                <div class="vh-90">
                                    <iframe :src="link" class="w-100 vh-190" height="600px" frameborder="0"></iframe>
                                </div>
                            </div>
                            <div class="col-5">
                                <div>
                                    <v-tabs color="#eee" slider-color="cyan">
                                        <v-tab :key="1" ripple >
                                            Document Details
                                        </v-tab>
                                        <v-tab :key="2" ripple>
                                            Comments
                                        </v-tab>
                                        <v-tab-item :key="1">
                                            <br>
                                            <h5 class="font-weight-bold">Description</h5>
                                            <div class="card border border-muted">
                                                <div class="card-body description">
                                                    <div v-html="file.description"></div>
                                                </div>
                                            </div>
                                            <br>
                                            <h5 class="font-weight-bold">Document Information</h5>
                                            <div class="card border border-muted">
                                                <div class="card-body">
                                                    <span>Status: </span>
                                                    <span v-if="file.status === 'waiting-to-review'" class="font-weight-bold text-warning">Waiting to review</span>
                                                    <span v-if="file.status === 'waiting-to-sign'" class="font-weight-bold text-info">Waiting to sign</span>
                                                    <span v-if="file.status === 'rejected'" class="font-weight-bold text-warning">Rejected</span>
                                                    <span v-if="file.status === 'signed'" class="font-weight-bold text-success">Signed</span>

                                                </div>
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
                                                
                                                
                                            </div>
                                        </v-tab-item>
                                        <v-tab-item :key="2">
                                            <div class="card border border-info">
                                                <div class="card-body description">
                                                    <div v-if="file?.comments?.length>0"> 
                                                        <div v-for="(comment, index) in file.comments" :key="index" class="list-group">
                                                            <div class="d-flex w-100 justify-content-between">
                                                                <h5 class="mb-1">{{comment.name}}</h5>
                                                                <small>{{new Date(comment.createdAt).toLocaleDateString()}}</small>
                                                            </div>
                                                            <p class="font-weight-bold mb-1">{{comment.content}}</p>
                                                        </div>
                                                    </div>
                                                    <div v-else> 
                                                        No comment yet
                                                    </div>
                                                </div>
                                            </div>
                                            <br>
                                            <div v-if="file.canComment==true" class="input-group">
                                                <textarea v-model="content" placeholder="Add a comment..." class="form-control" aria-label="With textarea"></textarea>
                                                <button data-dismiss="modal" type="button" class="btn btn-primary" @click="handleAddComment">Add</button>
                                            </div>
                                        
                                        </v-tab-item>
                                    </v-tabs>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                </div>
            </div>
        </div>
    </div>
</template>
<script>
import { IpfsClient } from "../helpers/ipfs";
import {encrypt, decrypt} from "../helpers/encrypt-decrypt"
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
            content: ""
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
    methods: {
        async bufferArrayToBlob(base64, type ) {
            const typeNew = 'data:' + type + ';base64'
            const base64Response = await fetch(`${typeNew},${base64}`)
            const blob1 = await base64Response.blob()
            const blob = new Blob([blob1], { type: type })
            const link = window.URL.createObjectURL(blob)
            console.log(link);
            return link
        },
        download() {
            IpfsClient().get(this.file.hash).then(async (res) =>{
                if(res) {
                    console.log(res[0].content)
                    let resultDecrypt = decrypt(res[0].content, this.file.key)
                    console.log('resultDecrypt', resultDecrypt);
                    let tokenUri = JSON.parse(this.file.tokenURI)
                    console.log("tokenUri", tokenUri);
                    let blob = new Blob([resultDecrypt.buffer], {type: tokenUri.fileType});
                    let link = document.createElement('a');
                    link.href = window.URL.createObjectURL(blob);
                    let fileName = tokenUri.name;
                    link.download = fileName;
                    console.log("link", link);
                    link.click();
                }
                else {
                    this.error="No file to preview"
                }
                // this.saveByteArray("Sample Report", res[0].content.buffer); // download button
            })
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
            return false;
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
    overflow-y: scroll;
}
/*  */
</style>