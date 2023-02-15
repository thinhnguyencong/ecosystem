<template>
	<div >
	  Landing Page
	  <input
		type="file"
		accept="*/*"
		@change="handleUploadFile"
		>
		<div>
			{{ JSON.stringify(nameArr) }}
		</div>
		<button class="btn btn-primary" @click="handleDownload">Download</button>
    </div>
	
</template>

<script>
import { decrypt, encrypt } from '../../helpers/encrypt-decrypt';
import JSZip from "jszip"

export default {
	data() {
		return {
			file: [],
			nameArr: []
		}
	},
	watch: {
		
	},
	created() {
		
	},
	methods: {
		handleUploadFile(event) {
			const files = event.target.files
			console.log(files[0]);
            if (files[0]) {
				let reader = new FileReader();
				let app = this
                reader.readAsArrayBuffer(files[0]);
                reader.onloadend = async function() {
                    let msgBytes = new Uint8Array(reader.result);

                    let resultEncrypt = encrypt(msgBytes)
                    let {encryptedData, key} = resultEncrypt
                    console.log(encryptedData);
                    if(encryptedData && key) {
						let resultDecrypt = decrypt(encryptedData, key);
                        console.log("resultDecrypt", resultDecrypt);
						app.file.push({name: files[0].name, data: resultDecrypt})
						app.nameArr.push(files[0].name)
					}
				}
                console.log("upload", this.file);
            }
		},
		handleDownload() {
			var zip = new JSZip();
            console.log(zip);
            zip.file("Hello.txt", "Hello World\n");
            var img = zip.folder("images");
			for (const file of this.file) {
				console.log(file.name);
				img.file(file.name, file.data, {base64: true});
			}
			console.log("123123123");
			zip.generateAsync({type:"blob"})
			.then(function(content) {
				console.log(content);
				let link = document.createElement('a');
                link.href = window.URL.createObjectURL(content);
                let fileName = "New Zip File";
                link.download = fileName;
                link.click();
			}).catch(error=> {
				console.log(error);
			});
		}
	},
	
}

</script>
<style scoped>

</style>