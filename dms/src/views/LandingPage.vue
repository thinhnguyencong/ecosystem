<template>
	<div >
	  Landing Page
    <!-- <button @click="handleLogin">Login</button> -->
	<ul>
		<li  v-for="(post, index) in listPost" :key="index">
			<a @click="openModal(post.id)">
				{{post.title}}
			</a>
		</li>
		<modal-file />
	</ul>
	</div>
</template>
  
<script>
import ModalFile from './ModalFile.vue'
import $ from 'jquery' 

export default {
  components: { ModalFile },
	data() {
		return {
			listPost: []
		}
	},
	created() {
		fetch('https://jsonplaceholder.typicode.com/posts')
      .then(response => response.json())
      .then(json => {
		this.listPost=json.map(x=> ({id: x.id, title: x.title}))
		console.log("this.listPost", this.listPost)
		})
	},
	methods: {
		handleLogin() {
			// window.location.assign(`${import.meta.env.VITE_CLIENT_URL}`)
		},
		openModal(id) {
			// $('#'+id).modal('show')
			console.log(this.$route);
			this.$router.push('/home'+ '/file/'+ id).catch(()=>{})
		}
	},
	watch: {

	}
	
}

</script>