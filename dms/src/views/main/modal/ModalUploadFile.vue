<template>
    <div class="modal fade" id="modalUploadFile" tabindex="-1" role="dialog" aria-labelledby="modalUploadFileTitle" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered modal-lg" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Upload File</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <form>
                        <!-- <div class="form-group">
                            <input type="file" id="myFile" name="filename" @change="uploadFile" ref="file" multiple=false>
                        </div> -->
                        <div>
                            <v-text-field 
                                label="Select..."
                                @click='onPickFile'
                                v-model='fileName'
                                prepend-icon="attach_file"
                            ></v-text-field>
                                <!-- Hidden -->
                            <input
                                type="file"
                                style="display: none"
                                ref="fileInput"
                                accept="*/*"
                                @change="handleUploadFile">
                        </div>
                        <div class="form-group">
                            <div>
                                <v-select
                                    v-model="reviewersSelected"
                                    :items="userState.signerList"
                                    item-text="name"
                                    item-value="publicAddress"
                                    attach
                                    chips
                                    multiple
                                    label="Reviewer List"
                                ></v-select>
                            </div>
                        </div>
                        <div class="form-group">
                            <v-select
                                v-model="signerSelected"
                                :items="userState.signerList"
                                item-text="name"
                                item-value="publicAddress"
                                attach
                                chips
                                multiple
                                label="Signer List"
                            ></v-select>
                        </div>
                        <div class="form-group">
                            <label for="description"><h5>Description</h5></label>
                            <quill-editor 
                                v-model="description"
                                ref="myQuillEditor"
                                @blur="onEditorBlur($event)"
                                @focus="onEditorFocus($event)"
                                @ready="onEditorReady($event)">
                            </quill-editor>
                        </div>
                        <div class="form-check">
                            <input class="form-check-input" type="checkbox" value="" id="flexCheckDefault" v-model="shared">
                            <label class="form-check-label" for="flexCheckDefault">
                                Share
                            </label>
                        </div>
                        <br>
                        <div v-if="shared" class="dropdown">
                            <DataTableVue @handleSelectRow="handleSelectRow" :headersProps="headers" :itemsProps="adminState.users" />
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                    <button type="button" class="btn btn-primary" @click="uploadFile" data-dismiss="modal">Create</button>
                </div>
            </div>
        </div>
    </div>
</template>
<script setup>
// import Multiselect from '@vueform/multiselect'

import {encrypt, decrypt} from "../../../helpers/encrypt-decrypt"
import DataTableVue from "../../../components/DataTable.vue";
import { IpfsClient } from "../../../helpers/ipfs";
</script>
<script>
export default {
    // components: { Multiselect },
    props: {
        
    },
    mounted() {
        this.$store.dispatch("admin/getAllUsers")
        this.$store.dispatch("user/getDeptList")
        this.$store.dispatch("user/getRoleList")
        this.$store.dispatch("user/getSignerList")
    },
    created() {
        if(IpfsClient()) {
            IpfsClient().version().then(res => console.log(res))
            this.ipfs = IpfsClient()
        }
    },
    data() {
        return {
            shared: false,
            signerSelected: null,
            reviewersSelected: null,
            file: null,
            fileName: '',
            sharedList: [],
            headers: [
                { text: 'NAME', value: 'name',filter: true },
                // { text: 'USERNAME', value: 'username', filter: true, align: ' d-none' },
                { text: 'EMAIL', value: 'email', filter: true },
                { text: 'PUBLIC ADDRESS', value: 'publicAddress', filter: true },
                { text: 'ROLE', value: 'role', filter: true },
                {
                    text: 'ID',
                    align: 'left',
                    value: '_id',
                    filter: true, 
                    align: ' d-none'
                },
            ],
            ipfs: null,
            description: '<h2>I am Example</h2>',
        }
    },
    computed: {
        documentState() {return this.$store.state.document },
        userState() {return this.$store.state.user },
        adminState() {return this.$store.state.admin },
        editor() {
            return this.$refs.myQuillEditor.quill
        }
    },
    methods: {
        saveByteArray(reportName, byte) {
            var blob = new Blob([byte], {type: "application/pdf"});
            var link = document.createElement('a');
            link.href = window.URL.createObjectURL(blob);
            var fileName = reportName;
            link.download = fileName;
            console.log("link", link);
            // link.click();
        },
        onPickFile () {
            this.$refs.fileInput.click()
        },
        async handleUploadFile(event) {
            const files = event.target.files
            if (files[0]) {
                this.file = files[0]
                this.fileName = files[0].name
                console.log("upload", this.file);
            }else {
                this.fileName = ''
                this.file = null
            }
           
        },
        handleSelectRow(data) {
            console.log(data);
            this.sharedList = data.map(x => x._id)
            console.log(this.description);
        },
        uploadFile() {
            if(!this.file) {
                alert("Please select 1 file")
            }
            console.log(this.signerSelected, this.file);
            if(this.ipfs){
                let reader = new FileReader();
                let app = this
                reader.readAsArrayBuffer(this.file);
                reader.onloadend = function() {
                    let msgBytes = new Uint8Array(reader.result);
                    let resultEncrypt = encrypt(msgBytes)
                    let {encryptedData, key} = resultEncrypt
                    if(encryptedData && key) {
                        app.ipfs.add(encryptedData).then(res => {
                            console.log(res[0].hash)
                            const json = {
                                hash : res[0].hash,
                                time: Date.now(),
                                name: app.file.name,
                                size: app.file.size,
                                fileType: app.file.type ? app.file.type : app.file.name.split('.').pop(),
                                lastModified:app.file.lastModified,
                                signers: app.signerSelected,
                                reviewers: app.reviewersSelected,
                                folder: app.documentState.folder._id
                            }
                            // console.log("json", json); 

                            let data = {
                                tokenURI: JSON.stringify(json),
                                signerList: app.signerSelected,
                                reviewerList: app.reviewersSelected,
                                key: key,
                                shared: app.shared,
                                sharedList: app.sharedList,
                                description: app.description

                            }
                            console.log("data", data);
                            app.$store.dispatch("document/uploadFile", data)
                        })
                        .catch(err => console.log(err))
                        }
                    else {
                        alert("Error when encrypt document")
                    }
                    
                }
            } else {
                alert("Error when connect to IPFS Server")
            }
            
        },
        onEditorBlur(quill) {
            console.log('editor blur!', quill)
        },
        onEditorFocus(quill) {
            console.log('editor focus!', quill)
        },
        onEditorReady(quill) {
            console.log('editor ready!', quill)
        },
        onEditorChange({ quill, html, text }) {
            console.log('editor change!', quill, html, text)
            this.description = html
            console.log("this.description", this.description);
        }
    },
}
  </script>

<style scoped>
.multiselect-blue {
  --ms-tag-bg: #DBEAFE;
  --ms-tag-color: #2563EB;
}
</style>