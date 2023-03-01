<template>
    <div>
        <input class="form-control" placeholder="type key here" v-model="key" type="text">
        <br>
        <input type="file" accept="*/*" @change="handleUploadFile">
        <button class="btn btn-primary" @click="handleDownload">Decrypt</button>
    </div>
</template>
<script>
            let key = "6d7755655279537235316e4b6e513239"
import { decrypt, encrypt } from '../../helpers/encrypt-decrypt';
export default {
    created() {

    },
  mounted() {
    
  },
  data () {
    return {
      key: "",
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
                let blob = new Blob([resultDecrypt.buffer], { type: "application/json" });
                let link = document.createElement('a');
                link.href = window.URL.createObjectURL(blob);
                let fileName = "users.json";
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