<template>
	<aside :class="`${is_expanded ? 'is-expanded' : ''}`">
		<div class="logo">
			<!-- <img :src="logoURL" alt="Vue" />  -->
		</div>
		
		<div class="menu-toggle-wrap">
			<button class="menu-toggle" @click="ToggleMenu">
				<span class="material-icons md-18">keyboard_double_arrow_right</span>
			</button>
		</div>

		<h3>Menu</h3>
		<div class="menu">
			<router-link to="/" class="button">
				<span class="material-icons">home</span>
				<span class="text">Home</span>
			</router-link>
			<router-link to="/dms" class="button">
				<span class="material-icons">description <span class="badge-noti"></span></span>
				<span class="text">Document</span>
				
			</router-link>
		</div>

		<div class="flex"></div>
		
		<div class="menu">
			<p @click="handleLogout" class="button logout-btn">
				<span class="material-icons">logout</span>
				<span class="text">Logout</span>
            </p>
		</div>
	</aside>
</template>

<script setup>
import { ref } from 'vue'
import logoURL from '../assets/img-doc.png'

const is_expanded = ref(localStorage.getItem("is_expanded") === "true")

const ToggleMenu = () => {
	is_expanded.value = !is_expanded.value
	localStorage.setItem("is_expanded", is_expanded.value)
}
</script>
<script>
export default {
  methods: {
    handleLogout() {
      this.$store.dispatch("auth/logout")
    }
  },
}
</script>

<style lang="scss" scoped>
aside {
	display: flex;
	flex-direction: column;

	background-color: var(--dark);
	color: var(--light);

	width: calc(4rem + 32px);
	overflow: hidden;
	min-height: 100vh;
	padding: 1rem;

	transition: 0.3s ease-in-out;

	.flex {
		flex: 1 1 0%;
	}

	.logo {
		margin-bottom: 1rem;

		img {
			width: 2rem;
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
			
			&:hover {
				.material-icons {
					color: var(--primary);
				}
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
		margin: 0 -1rem;

		.button {
            cursor: pointer;
			display: flex;
			align-items: center;
			text-decoration: none;

			transition: 0.2s ease-in-out;
			padding: 1.5rem 2rem;

			.material-icons {
				font-size: 2rem;
				color: var(--light);
				transition: 0.2s ease-in-out;
			}
			.text {
				color: var(--light);
				transition: 0.2s ease-in-out;
			}

			&:hover {
				background-color: var(--dark-alt);

				.material-icons, .text {
					color: var(--primary);
				}
			}

			&.router-link-exact-active {
				background-color: var(--dark-alt);
				border-right: 5px solid var(--primary);

				.material-icons, .text {
					color: var(--primary);
				}
			}
		}
		.button .badge-noti{
			position: absolute;
			left: 32px;
			padding: 6px;
			border-radius: 50%;
			background: #dc3545;
			color: white;
		}
		// .logout-btn {
		// 	position: fixed;
		// 	bottom: 0;
		// 	right: 0;
		// }
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
		width: var(--sidebar-width);

		.menu-toggle-wrap {
			top: -3rem;
			
			.menu-toggle {
				transform: rotate(-180deg);
			}
		}

		h3, .button .text {
			opacity: 1;
		}

		.button {
			.material-icons {
				margin-right: 1rem;
			}
		}

		.footer {
			opacity: 0;
		}
	}

	@media only screen and (max-width: 1100px) {
		display: none;
	}
}

</style>