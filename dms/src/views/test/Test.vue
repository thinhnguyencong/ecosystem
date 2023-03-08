<template>
    <div class="p-4 w-25">
        <h2>Decrypt file</h2>
        <br>
        Key: 
        <input class="form-control" placeholder="type key here" v-model="key" type="text">
        <br>
        File type: 
        <select class="form-control" v-model="selected">
            <option disabled value="">Select type</option>
            <option v-for="(type, index) in selectType">{{ type }}</option>
        </select>
        <br>
        Select file:
        <br>
        <input type="file" accept="*/*" @change="handleUploadFile">
        <br>
        <br>
        <button class="btn btn-primary" @click="handleDownload">Decrypt</button>
    </div>
</template>
<script>
            let key = "6d7755655279537235316e4b6e513239"
import { decrypt, encrypt } from '../../helpers/encrypt-decrypt';
import { FILE_TYPE_CAN_BE_PREVIEWED } from '../../helpers/index.js'
export default {
    created() {

    },
  mounted() {
    
  },
  data () {
    return {
      key: "",
      selected: "",
      selectType: FILE_TYPE_CAN_BE_PREVIEWED
    }
  },

  methods: {
    
    handleUploadFile(event) {
        const files = event.target.files
        console.log(files[0]);
        if (files[0]) {
            this.file = files[0]
        }
    },
    handleDownload() {
        let reader = new FileReader();
        let app = this
        reader.readAsArrayBuffer(this.file);
        reader.onloadend = async function () {
            let msgBytes = new Uint8Array(reader.result);
            console.log(msgBytes);
            if (msgBytes && app.key) {
                let resultDecrypt = decrypt(msgBytes, app.key);
                console.log("resultDecrypt", resultDecrypt);
                let blob = new Blob([resultDecrypt.buffer], {type: app.selected});
                let link = document.createElement('a');
                link.href = window.URL.createObjectURL(blob);
                let fileName = "users";
                link.download = fileName;
                link.click();
            }
        }
    },
  },
}
</script>


<style>
textarea.form-control:focus {
    background-color: transparent;
}
</style>