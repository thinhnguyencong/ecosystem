<template>
	<aside :class="`${is_expanded ? 'is-expanded' : ''}`">
<!--		<div class="menu-toggle-wrap">-->
<!--			<button class="menu-toggle" @click="ToggleMenu">-->
<!--				<span class="material-icons md-18">keyboard_arrow_right</span>-->
<!--			</button>-->
<!--		</div>-->

		<router-link to="/" >
			<div class="logo">
				<img :src="logoURL" alt="Vue" />
			</div>
		</router-link>

		<div class="menu">
			<router-link v-if="authState.role === 'admin'" to="/admin" :class="authState.active === 'admin' ? 'button sidebar-active' : 'button'">
				<span class="material-icons">admin_panel_settings</span>
				<span class="text">Admin</span>
			</router-link>
			<router-link to="/" :class="authState.active === 'home' ? 'button sidebar-active' : 'button'">
				<div class="iconMenu">
					<img id="iconMenu" class="custom-icon" src="@/assets/img/home.svg" alt="error-home">
				</div>

				<span class="text">Home</span>
			</router-link>
			<router-link to="/my-folder" :class="authState.active === 'my-folder' ? 'button sidebar-active' : 'button'">
				<div class="iconMenu">
					<img id="iconMenu" src="@/assets/img/folder.svg" alt="error-folder">
				</div>
				<span class="text">My Folder</span>
			</router-link>
			<router-link to="/share" :class="authState.active === 'share' ? 'button sidebar-active' : 'button'">
				<div class="iconMenu">
					<img id="iconMenu" src="@/assets/img/share.svg" alt="error-share">
				</div>
				<span class="text">share</span>
			</router-link>
			<router-link to="/sign" :class="authState.active === 'sign' ? 'button sidebar-active' : 'button'">
				<div class="iconMenu">
					<img id="iconMenu" src="@/assets/img/sign.svg" alt="error-sign">
				</div>
				<span class="text">sign</span>
			</router-link>
			<router-link to="/starred" :class="authState.active === 'starred' ? 'button sidebar-active' : 'button'">
				<div class="iconMenu">
					<img id="iconMenu" src="@/assets/img/star.svg" alt="error-starred">
				</div>
				<span class="text">starred</span>
			</router-link>
			<router-link to="/hidden" :class="authState.active === 'hidden' ? 'button sidebar-active' : 'button'">
				<div class="iconMenu">
					<img id="iconMenu" src="@/assets/img/hidden.svg" alt="error-hidden">
				</div>
				<span class="text">hidden</span>
			</router-link>
			<router-link to="/recent" :class="authState.active === 'recent' ? 'button sidebar-active' : 'button'">
				<div class="iconMenu">
					<img id="iconMenu" src="@/assets/img/clock.svg" alt="error-clock">
				</div>
				<span class="text">Recent</span>
			</router-link>


<!--			<router-link to="/shared-with-me" :class="authState.active === 'shared-with-me' ? 'button sidebar-active' : 'button'">-->
<!--				<span class="material-icons">folder_shared</span>-->
<!--				<span class="text">Shared With Me</span>-->
<!--			</router-link>-->


		</div>

		<div class="flex"></div>
		

	</aside>
</template>

<script setup>
import { ref } from 'vue'
import logoURL from '../../assets/img/logo.svg'

const is_expanded = ref(localStorage.getItem("is_expanded") === "true")

// const ToggleMenu = () => {
// 	is_expanded.value = !is_expanded.value
// 	localStorage.setItem("is_expanded", is_expanded.value)
// }
</script>
<script>
export default {
  methods: {
    handleLogout() {
      this.$store.dispatch("auth/logout")
    },

  },
  computed: {
    authState () {
      return this.$store.state.auth
    }
  }
}
</script>

<style lang="scss" scoped>
@import "@/assets/style/_theme.scss";
aside {
	position: fixed;
	background-color: var(--backgroud);
	overflow: hidden;
	height: 100vh;
	width: 106px;
	padding: 24px 16px;
	transition: 0.3s ease-in-out;
	border-right: 0.5px solid #EDEDED;
	float: left;

	.flex {
		flex: 1 1 0%;
	}

	.logo {
		// align-items: center;
		img {
			width: 40px;
			height: 40px;
			display: block;
			margin-left: auto;
			margin-right: auto;
			cursor: pointer;
		}
	}

	.menu-toggle-wrap {
		display: flex;
		justify-content: flex-end;
		margin-bottom: 1rem;

		// position: relative;
		top: 0;
		transition: 0.2s ease-in-out;

		.menu-toggle {
			transition: 0.4s ease-in-out;
			.material-icons {
				font-size: 3rem;
				color: var(--light);
				transition: 0.4s ease-out;
			}
		}
	}

	h3, .button .text {
		opacity: 0;
		transition: opacity 0.3s ease-in-out;
	}

	h3 {
		color: var(--grey);
		font-size: 0.875rem;
		margin-bottom: 0.5rem;
		text-transform: uppercase;
	}

	.menu {
		display: grid;
		gap: 24px 0;
		margin-top: 32px;

		.button {
      cursor: pointer;
			display: grid;
			align-items: center;
			justify-content: center;
			text-decoration: none;
			gap: 4px 0;
			transition: 0.2s ease-in-out;
			padding: 8px 0;
			.material-icons {
				color: var(--text-color--1);
				transition: 0.2s ease-in-out;
				text-align: center;

			}
			.text {
				color: var(--text-color--1);
				transition: 0.2s ease-in-out;
				font-weight: 600;
				font-size: 12px;
			}
		}
		.button .badge-noti{
			position: absolute;
			left: 32px;
			padding: 8px;
			border-radius: 50%;
			background: #dc3545;
			color: white;
		}
	}

	.footer {
		opacity: 0;
		transition: opacity 0.3s ease-in-out;

		p {
			font-size: 0.875rem;
			color: var(--grey);
		}
	}

	&.is-expanded {
		.menu-toggle-wrap {
			.menu-toggle {
				transform: rotate(-180deg);
			}
		}

		h3, .button .text {
			opacity: 1;
		}

		.footer {
			opacity: 0;
		}
	}
	@media only screen and (max-width: 1100px) {
		display: none;
	}
}
.router-link-exact-active {
	background-color: var(--bgc-active-menu);
	border-radius: 8px;
	.text {
		color: var(--text-color-active) !important;
	}
}

.custom-icon.active {
	filter: invert(1);
	color: var(--text-color-active);
}

.button:hover {
	background: var(--bgc-hover);
	border-radius: 8px;
}
.iconMenu {
	display: flex;
	align-content: center;
	justify-content: center;
}
</style>