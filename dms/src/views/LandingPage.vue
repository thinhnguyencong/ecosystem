<template>
	<div >
	  Landing Page
    <button @click="handleLogin">Login</button>
	</div>
</template>
  
<script>
export default {
	methods: {
		handleLogin() {
			window.location.assign(`${import.meta.env.VITE_CLIENT_URL}`)
		}
	},
}

</script>