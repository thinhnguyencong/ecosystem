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
		
		<div v-if="showModal">
			<router-view></router-view>
		</div>
	<!-- <modal-file/> -->
	</div>
</template>
  
<script>
import ModalFile from './ModalFile.vue'

export default {
  components: { ModalFile },
	data() {
		return {
			listPost: [],
			showModal: false
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
	},
	methods: {
		handleLogin() {
			// window.location.assign(`${import.meta.env.VITE_CLIENT_URL}`)
		},
	},
	
}

</script>
