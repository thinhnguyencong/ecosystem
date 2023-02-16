<template>
    <div class="modal fade" id="modalUploadFile" tabindex="-1" role="dialog" aria-labelledby="modalUploadFileTitle"
        aria-hidden="true">
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
                            <v-text-field label="Select..." @click='onPickFile' v-model='fileName'
                                prepend-icon="attach_file"></v-text-field>
                            <!-- Hidden -->
                            <input type="file" style="display: none" ref="fileInput" accept="*/*"
                                @change="handleUploadFile">
                        </div>
                        <div class="form-group">
                            <div>
                                <v-select v-model="reviewersSelected" :items="userState.signerList" item-text="name"
                                    item-value="publicAddress" attach chips multiple label="Reviewer List"></v-select>
                            </div>
                        </div>
                        <div class="form-group">
                            <v-select v-model="signerSelected" :items="userState.signerList" item-text="name"
                                item-value="publicAddress" attach chips multiple label="Signer List"></v-select>
                        </div>
                        <div class="form-group">
                            <label for="description">
                                <h5>Description</h5>
                            </label>
                            <quill-editor v-model="description" ref="myQuillEditor" @blur="onEditorBlur($event)"
                                @focus="onEditorFocus($event)" @ready="onEditorReady($event)">
                            </quill-editor>
                        </div>
                        <div class="form-check">
                            <input class="form-check-input" type="checkbox" value="" id="flexCheckDefault"
                                v-model="shared">
                            <label class="form-check-label" for="flexCheckDefault">
                                Share
                            </label>
                        </div>
                        <br>
                        <div v-if="shared" class="dropdown">
                            <DataTableVue @handleSelectRow="handleSelectRow" :headersProps="headers"
                                :itemsProps="adminState.users" />
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                    <button type="button" class="btn btn-primary" @click="uploadFile"
                        data-dismiss="modal">Create</button>
                </div>
            </div>
        </div>
    </div>
</template>
<script setup>
// import Multiselect from '@vueform/multiselect'

import { encrypt, decrypt } from "../../../helpers/encrypt-decrypt"
import DataTableVue from "../../../components/DataTable.vue";
import { IpfsClient, nftStorage } from "../../../helpers/ipfs";
</script>
<script>
export default {
    // components: { Multiselect },
    props: {

    },
    mounted() {
        // Call the API query method on page load
        if (!this.adminState.users.length) {
            this.$store.dispatch("admin/getAllUsers")
        }
        if (!this.userState.deptList.length) {
            this.$store.dispatch("user/getDeptList")
        }
        if (!this.userState.roleList.length) {
            this.$store.dispatch("user/getRoleList")
        }
        if (!this.userState.signerList.length) {
            this.$store.dispatch("user/getSignerList")
        }
    },
    created() {

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
                { text: 'NAME', value: 'name', filter: true },
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
            description: '<h2>I am Example</h2>',
        }
    },
    computed: {
        documentState() { return this.$store.state.document },
        userState() { return this.$store.state.user },
        adminState() { return this.$store.state.admin },
        editor() {
            return this.$refs.myQuillEditor.quill
        }
    },
    methods: {
        saveByteArray(reportName, byte) {
            var blob = new Blob([byte], { type: "application/pdf" });
            var link = document.createElement('a');
            link.href = window.URL.createObjectURL(blob);
            var fileName = reportName;
            link.download = fileName;
            console.log("link", link);
            // link.click();
        },
        onPickFile() {
            this.$refs.fileInput.click()
        },
        async handleUploadFile(event) {
            const files = event.target.files
            if (files[0]) {
                this.file = files[0]
                this.fileName = files[0].name
                console.log("upload", this.file);
            } else {
                this.fileName = ''
                this.file = null
            }

        },
        handleSelectRow(data) {
            console.log(data);
            this.sharedList = data.map(x => x._id)
            console.log(this.description);
        },
        async uploadFile() {
            if (!this.file) {
                alert("Please select 1 file")
            }
            console.log(this.signerSelected, this.file);
            const ipfs = await IpfsClient()
            if (!ipfs) {
                alert("Error when connect to IPFS Server")
                return
            }
            let reader = new FileReader();
            let app = this
            reader.readAsArrayBuffer(this.file);
            reader.onloadend = async function () {
                let msgBytes = new Uint8Array(reader.result);
                let resultEncrypt = encrypt(msgBytes)
                let { encryptedData, key } = resultEncrypt
                console.log(encryptedData);
                if (encryptedData && key) {
                    //upload to nft storage(test)
                    // const startTime = Date.now();
                    // const metadata = await nftStorage().storeBlob(new Blob([encryptedData.buffer]))
                    // console.log(metadata)
                    // const endTime = Date.now();
                    // const timeTaken = endTime - startTime;
                    // console.log(`Time taken to upload file using NFT Storage = ${timeTaken/1000} seconds`);

                    // const startTime1 = Date.now();
                    // let url = "https://"+metadata+".ipfs.nftstorage.link"
                    // let arrayBuffer = await fetch(url)
                    // console.log({arrayBuffer});
                    // const endTime1 = Date.now();
                    // const timeTaken1 = endTime1 - startTime1;
                    // console.log(`Time taken to get file using NFT Storage = ${timeTaken1/1000} seconds`);
                    // // let arrayBuffer = await new Response(blob).arrayBuffer()
                    // let resultDecrypt = decrypt(new Uint8Array(arrayBuffer), key)
                    // console.log(resultDecrypt);
                    // let blob2 = new Blob([resultDecrypt.buffer], { type: app.file.type });
                    // let link = document.createElement('a');
                    // link.href = window.URL.createObjectURL(blob2);
                    // let fileName = app.file.name;
                    // link.download = fileName;
                    // link.click();

                    //upload to ipfs
                    const startTime2 = Date.now();
                    let res = await ipfs.add(encryptedData)

                    const endTime2 = Date.now();
                    const timeTaken2 = endTime2 - startTime2;
                    console.log(`Time taken to upload file using IPFS = ${timeTaken2 / 1000} seconds`);
                    console.log(res[0].hash)
                    // const startTime3 = Date.now();
                    // let blob = await fetch('http://18.136.124.115:8080/ipfs/'+ res[0].hash) 
                    // console.log({blob});
                    // const endTime3 = Date.now();
                    // const timeTaken3 = endTime3 - startTime3;
                    // console.log(`Time taken to get file using IPFS = ${timeTaken3/1000} seconds`);

                    const json = {
                        hash: res[0].hash,
                        time: Date.now(),
                        name: app.file.name,
                        size: app.file.size,
                        fileType: app.file.type ? app.file.type : app.file.name.split('.').pop(),
                        lastModified: app.file.lastModified,
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
                }
                else {
                    alert("Error when encrypt document")
                }
            }
        },
        onEditorBlur(quill) {
            
        },
        onEditorFocus(quill) {
            
        },
        onEditorReady(quill) {
            
        },
        onEditorChange({ quill, html, text }) {
            console.log('editor change!', quill, html, text)
            this.description = html
            console.log("this.description", this.description);
        }
    }
}
</script>

<style scoped>
.multiselect-blue {
    --ms-tag-bg: #DBEAFE;
    --ms-tag-color: #2563EB;
}
</style>