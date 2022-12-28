<template>
	<div >
	  Landing Page
    <!-- <button @click="handleLogin">Login</button> -->
		<div class="post-items">
			<router-link
				tag="div"
				class="item"
				v-for="(post, index) in listPost"
				:to="`/home/file/${post.id}`"
				:key="post.id"
			>
				<strong><a href="#">{{ index+1+ ". " }}{{post.title}}</a></strong>
				<br />
			</router-link>
		</div>
		<Transition name="modal">
			<div v-if="showModal">
				<router-view></router-view>
			</div>
		</Transition>
		
	<!-- <modal-file/> -->
	<div id="container"></div>
	<!-- <iframe width="100%" height="100%" class="frame" :src="link" frameborder="0"></iframe> -->
	</div>
</template>

<script>
import ModalFile from './ModalFile.vue'
import { IpfsClient } from "../helpers/ipfs";
const file = {
  _id: "63a5255de6f94591502e9bf3",
  tokenId: "41",
  hash: "QmSTZMFidr1yLhhC673JVnKc25KMVcE7QZFzKpm1LoHghH",
  tokenURI: "{\"hash\":\"QmSTZMFidr1yLhhC673JVnKc25KMVcE7QZFzKpm1LoHghH\",\"time\":1671767386948,\"name\":\"test-case.docx\",\"size\":38149260,\"fileType\":\"application/vnd.openxmlformats-officedocument.wordprocessingml.document\",\"lastModified\":1667869056511,\"signers\":[\"0x09876c96f80247184921f24547c861c99083f602\"],\"reviewers\":[\"0xfe47e32e697532bba14ee50458055d1b80de4657\",\"0xff8ce8c35a2222c573352d182c50505010973244\"],\"folder\":\"63a40c31fb5a9ad179504748\"}",
  owner: "63a40c31fb5a9ad179504746",
  description: "<h2>I am Example</h2>",
  parentFolder: "63a40c31fb5a9ad179504748",
  shared: [
    "63a3f9f3f7e37b57eefce1cc",
    "63a3f9f3f7e37b57eefce1ce",
    "63a3f9f3f7e37b57eefce1d2"
  ],
  key: "53486161677165647233453142533567",
  isSharedPublic: false,
  comments: [],
  createdAt: "2022-12-23T03:49:49.356Z",
  updatedAt: "2022-12-23T03:50:49.229Z",
  __v: 0,
  statusDetail: {
    reviewerList: [
      {
        name: "Nguyen Minh Hien",
        address: "0xfe47e32e697532bba14ee50458055d1b80de4657",
        status: "not-yet-reviewed",
        time: "0"
      },
      {
        name: "Pham Van Dam",
        address: "0xff8ce8c35a2222c573352d182c50505010973244",
        status: "not-yet-reviewed",
        time: "0"
      }
    ],
    signerList: [
      {
        name: "Kim Si Chun",
        address: "0x09876c96f80247184921f24547c861c99083f602",
        status: "not-yet-signed",
        time: "0"
      }
    ]
  },
  status: "waiting-to-review",
  canComment: true,
  canReview: false,
  canSign: false
}
import {encrypt, decrypt} from "../helpers/encrypt-decrypt"
export default {
  components: { ModalFile },
	data() {
		return {
			listPost: [],
			showModal: false,
			link: ""
		}
	},
	watch: {
		'$route': {
			immediate: true,
			handler: function(newVal, oldVal) {
				this.showModal = newVal.meta && newVal.meta.showModal;
			}
		}
	},
	created() {
		fetch('https://jsonplaceholder.typicode.com/posts')
		.then(response => response.json())
		.then(json => {
			this.listPost=json.map(x=> ({id: x.id, title: x.title})).slice(0, 10)
			console.log("this.listPost", this.listPost)
		})
		this.initData()
	},
	methods: {
		handleLogin() {
			// window.location.assign(`${import.meta.env.VITE_CLIENT_URL}`)
		},
		async initData() {
			IpfsClient().get(file.hash).then(async (res) =>{
				if(res) {
					let resultDecrypt = decrypt(res[0].content, file.key)
					let tokenUri = JSON.parse(file.tokenURI)
					console.log("resultDecrypt", resultDecrypt);
					let x = new File([resultDecrypt], tokenUri.name, {type:tokenUri.fileType})
					console.log(x);
					window.docx.renderAsync(resultDecrypt, document.getElementById("container"))
        			.then(x => console.log("docx: finished"));
					// let b64 = this.b64EncodeUnicode(resultDecrypt)
					// let abc = await this.bufferArrayToBlob(b64, tokenUri.fileType)
					// this.link = abc
				}
				else {
					this.error="No file to preview"
				}
				// this.saveByteArray("Sample Report", res[0].content.buffer); // download button
			})
        },
		async bufferArrayToBlob(base64, type ) {
            const typeNew = 'data:' + type + ';base64'
            console.log(base64);
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
	},
	
}

</script>
<style scoped>
/*
 * The following styles are auto-applied to elements with
 * transition="modal" when their visibility is toggled
 * by Vue.js.
 *
 * You can easily play with the modal transition by editing
 * these styles.
 */

 .modal-enter {
  opacity: 0;
}

.modal-leave-active {
  opacity: 0;
}

.modal-enter .modal-container,
.modal-leave-active .modal-container {
  -webkit-transform: scale(1.1);
  transform: scale(1.1);
}
</style>