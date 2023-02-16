<template>
	<div>
		Landing Page
		<input type="file" accept="*/*" @change="handleUploadFile">
		<div>
			{{ JSON.stringify(nameArr) }}
		</div>
		<button class="btn btn-primary" @click="handleDownload">Download</button>
		<button class="btn btn-success" @click="downloadFolder">Generate from tree</button>
	</div>

</template>

<script>
import { decrypt, encrypt } from '../../helpers/encrypt-decrypt';
import JSZip from "jszip"
const treeFolder = {
	_id: 'company',
	name: 'Company 🏢',
	children: [{
		_id: 'team-i',
		name: 'Team I 👥',
		children: [{
			_id: 'person-a',
			name: 'Person A 👱',
			children: [
				{
					_id: 'person-xx',
					name: 'Person XX',
				}, {
					_id: 'person-yy',
					name: 'Person YY',
				}
			],
		}, {
			_id: 'person-b',
			name: 'Person B 🧔',
		}],
	}, {
		_id: 'team-ii',
		name: 'Team II 👥',
		children: [{
			_id: 'person-c',
			name: 'Person C 👳',
		}, {
			_id: 'person-d',
			name: 'Person D 👧',
		}],
	}, {
		_id: 'person-e',
		name: 'Person E 👩',
	}],
}
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
				reader.onloadend = async function () {
					let msgBytes = new Uint8Array(reader.result);

					let resultEncrypt = encrypt(msgBytes)
					let { encryptedData, key } = resultEncrypt
					console.log(encryptedData);
					if (encryptedData && key) {
						let resultDecrypt = decrypt(encryptedData, key);
						console.log("resultDecrypt", resultDecrypt);
						app.file.push({ name: files[0].name, data: resultDecrypt })
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
				img.file(file.name, file.data, { base64: true });
			}
			var img2 = img.folder("images2");
			console.log("123123123");
			zip.generateAsync({ type: "blob" })
				.then(function (content) {
					console.log(content);
					let link = document.createElement('a');
					link.href = window.URL.createObjectURL(content);
					let fileName = "New Zip File";
					link.download = fileName;
					link.click();
				}).catch(error => {
					console.log(error);
				});
		},
		async downloadFolder() {
			let zip = new JSZip()
			await this.zipFolder(treeFolder.children, zip)
			zip.generateAsync({ type: "blob" })
				.then(function (content) {
					console.log(content);
					let link = document.createElement('a');
					link.href = window.URL.createObjectURL(content);
					let fileName = "New Zip File";
					link.download = fileName;
					link.click();
				}).catch(error => {
					console.log(error);
				});
		},
		async zipFolder(treeFolder, zip) {
			console.log(treeFolder);
			for (let child of treeFolder) {
				if(!child.children){
					zip.file(child.name+".txt", `${child.name}`);
				}else {
					let folder = zip.folder(`${child.name}`);
					this.zipFolder(child.children, folder)
				}
			}
		}
	},

}

</script>
<style scoped>

</style>