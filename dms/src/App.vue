<template>
  <div class="app" >
		<!-- Sidebar -->
		<Sidebar v-if="store.state.auth.isAuthenticated" />
    
		<!-- Content -->
		<div id="layout">
			<Header v-if="store.state.auth.isAuthenticated" @openNav="openNav" @closeNav="closeNav"/>
			<div id="content">
				<router-view />
			</div>
		</div>
	</div>
</template>

<script setup>
import Sidebar from './components/layout/Sidebar.vue'
import Header from './components/layout/Header.vue';
import store from './store';
import socket from './helpers/socket';

/* Set the width of the sidebar to 250px and the left margin of the page content to 250px */
function openNav() {
  document.getElementById("mySidebar").style.width = "250px";
  document.getElementById("content").style.marginLeft = "250px";
}

/* Set the width of the sidebar to 0 and the left margin of the page content to 0 */
function closeNav() {
  document.getElementById("mySidebar").style.width = "0";
  document.getElementById("content").style.marginLeft = "0";
}
</script>
<script>
	export default {
		created() {
			socket.on("connect_error", (err) => {
				console.log("Socket io error", err);
			});
		},

		destroyed() {
			socket.off("connect_error");
		},
	}
</script>

<style lang="scss">
:root {
	--primary: #4d9ceb;
	--primary-alt: #6594d1;
	--grey: #64748b;
	--dark: #1e293b;
	--dark-alt: #334155;
	--light: #f1f5f9;
	--sidebar-width: 300px;
}
* {
	margin: 0;
	padding: 0;
	box-sizing: border-box;
	font-family: 'Fira sans', sans-serif;
}

body {
	background: var(--light);
}
button {
	cursor: pointer;
	appearance: none;
	border: none;
	outline: none;
	background: none;
}
.app {
	display: flex;
	main {
		flex: 1 1 0;
		padding: 2rem;
		@media (max-width: 1024px) {
			padding-left: 6rem;
		}
	}
}
#content {
	transition: margin-left .5s;
}
#layout {
	width: 100%;
	transition: margin-left .5s; /* If you want a transition effect */
}
</style>  
<style lang="scss">
.ql-align-right {
	text-align: right;
}
.ql-align-center {
	text-align: center;
}
.ql-align-left {
	text-align: left;
}
.v-window {
    height: 90% !important;
}
.v-window__container {
	height: 100% !important;
}
.v-window-item {
	height: 100% !important;
}
.v-tabs__div a {
  text-decoration: none !important;
}
.tab-active {
	background-color: #eee !important;
}
.vue-treeselect__input {
	width: 5rem !important;
}
</style>