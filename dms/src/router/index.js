
import jwt_decode from "jwt-decode";
import LandingPage from '../views/main/LandingPage.vue'
//import LandingPage from '../views/test/LandingPage1.vue'
import Test from '../views/test/Test.vue'
import Home from '../views/main/Home.vue'
import MyFolder from '../views/main/MyFolder.vue'
import Hidden from "../views/main/Hidden.vue";
import Starred from "../views/main/Starred.vue";
import Sign from "../views/main/Sign.vue";
import Share from "../views/main/Share.vue";
import Recent from '../views/main/Recent.vue'
import ShareWithMe from '../views/main/SharedWithMe.vue'
import Directory from '../views/main/Directory.vue'
import AdminPage from '../views/main/AdminPage.vue'
import ModalFileDetails from '../views/main/modal/ModalFileDetails.vue'
import ModalFile from '../views/test/ModalFile.vue'
import NotFound from '../components/NotFound.vue'
import store from '../store'
import {UrlParams} from '../helpers/UrlParams'
// import { ABE_MODULE } from '../helpers/abe';
import Vue from "vue";
import VueRouter from "vue-router";
import Router from 'vue-router';
import Setting from "@/views/main/Setting.vue";


const originalPush = Router.prototype.push;
Router.prototype.push = function push(location) {
  return originalPush.call(this, location).catch(err => err)
};
Vue.use(VueRouter);

async function oAuth2Flow(urlParams, redirect_uri) {
	const code = urlParams.get("code");
	if (code) {
		await store.dispatch("auth/getAuthToken", {code, redirect_uri})
	} else {
		console.log("redirect");
		await store.dispatch("auth/doAuthRedirect", {redirect_uri})
	}
}
const fileRoute = {
	path: 'file/:fileId',
	name: 'ModalFileDetails',
	component: ModalFileDetails,
	props: true,
	meta: { requiresAuth: true, requiresAdmin: false, showModal: true }
}
const routes = [
  {
    path: '/home',
    name: 'LandingPage',
    component: LandingPage,
	meta: { requiresAuth: false, requiresAdmin: false },
  },
  {
    path: '/test',
    name: 'Test',
    component: Test,
	meta: { requiresAuth: false, requiresAdmin: false },
  },
  {
    path: '/',
    name: 'Home',
	component: Home,
	meta: { requiresAuth: true, requiresAdmin: false },
	children: [fileRoute]
  },
  {
    path: '/my-folder',
    name: 'My Folder',
    component: MyFolder,
	meta: { requiresAuth: true, requiresAdmin: false },
	children: [fileRoute]
  },
  {
    path: '/shared-with-me',
    name: 'Shared With Me',
    component: ShareWithMe,
	meta: { requiresAuth: true, requiresAdmin: false }
  },
	{
		path: '/recent',
		name: 'Recent',
		component: Recent,
		meta: { requiresAuth: true, requiresAdmin: false },
		children: [fileRoute]
	},
	{
		path: '/hidden',
		name: 'Hidden',
		component: Hidden,
		meta: { requiresAuth: true, requiresAdmin: false },
		children: [fileRoute]
	},
	{
		path: '/share',
		name: 'Share',
		component: Share,
		meta: { requiresAuth: true, requiresAdmin: false },
		children: [fileRoute]
	},
	{
		path: '/sign',
		name: 'Sign',
		component: Sign,
		meta: { requiresAuth: true, requiresAdmin: false },
		children: [fileRoute]
	},
	{
		path: '/setting',
		name: 'Setting',
		component: Setting,
		meta: { requiresAuth: true, requiresAdmin: false },
		children: [fileRoute]
	},
	{
		path: '/starred',
		name: 'Starred',
		component: Starred,
		meta: { requiresAuth: true, requiresAdmin: false },
		children: [fileRoute]
	},
  {
	path: '/admin',
    name: 'Admin',
    component: AdminPage,
	meta: { requiresAuth: true, requiresAdmin: true }
  },
  { 
	path: '/folder/:id', 
	name: 'Directory',
  	component: Directory,
	meta: { requiresAuth: true, requiresAdmin: false },
	children: [fileRoute]
  },

  // will match everything and put it under `$route.params.pathMatch`
  { 
	path: '/:pathMatch(.*)*', 
  	name: 'NotFound', 
	component: NotFound,
	meta: { requiresAuth: true, requiresAdmin: false }
  },

 
 

]
const router = new VueRouter({
	mode: 'history',
  	routes,
})
// const handleRequestKey = async () => {
// 	try {
// 		let data= {}
// 		// console.log(ABE_MODULE);
// 		//init request key, get account and nonce
// 		await store.dispatch("user/initRequestKey")

// 		// ABE gen nonce gen key
// 		await ABE_MODULE.then((ABE) => {
// 			// console.log("abe gen nonce gen key, get NewNonce {nonce, fgp}");
// 			// console.log("store.state.user.nonce", store.state.user.nonce);
// 			let newNonce = ABE.abe_gen_nonce_gen_key(store.state.user.nonce);
// 			data.nonce = newNonce.nonce
// 			data.fgp = newNonce.fgp
// 			return ABE
// 		}).then(async (ABE) => {
// 			// console.log("data", data);
// 			// confirm key, sign message(message, account), get signature
// 			await store.dispatch("user/signMessage", {message: data.nonce})
// 			// request key using signature, get encrypted key
// 			let request = {
// 				pubWallet: store.state.user.publicAddress,
// 				nonce:  data.nonce,
// 				sigWallet: store.state.user.signature,
// 				fgp: data.fgp
// 			}
// 			await store.dispatch("user/requestKey", request)
// 			// console.log("ABE", ABE, request);
// 			// import encrypted key to ABE
// 			let resultImportKey = await ABE.abe_import_key_from_kdc(store.state.user.encryptedKey, store.state.user.username)
//             console.log('resultImportKey', resultImportKey);
// 			return;
// 		})
// 	} catch (error) {
// 		console.log(error);
// 		alert("error")
// 	}
// }
router.beforeEach(async (to, from, next) => {
	// check if route required authentication
	if (to.matched.some(record => record.meta.requiresAuth)){
		const HREF = window.location.href.trim();
		const urlParams = new UrlParams(HREF);

		// check if browser has auth token or not
		if (!window.sessionStorage.getItem("authToken")) {
			// start "Authorization Code Flow"
			await oAuth2Flow(urlParams, HREF.split('?')[0]);
		} else {
			// check token again
			await store.dispatch("auth/reAuth")
		}

		// check if user isAuthenticated
		if(store.state.auth.isAuthenticated) {
			// decode access_token to get 'role' of user (Roles config in Keycloak)
			let access_token = jwt_decode(window.sessionStorage.getItem("authToken"))
			if(!access_token?.resource_access?.dms?.roles) {
				alert('Your account need to be verified by admin')
				return next(false)
			}else {
				// Set role in vuex store
				if(access_token.resource_access.dms.roles.includes('admin')) {
					await store.dispatch("auth/setRole", "admin") 
				}else {
					await store.dispatch("auth/setRole", "user")
				}
				// check if route require admin role
				if(to.matched.some(record => record.meta.requiresAdmin)) {
					if(store.state.auth.role === "admin") {
						//console.log("6");
						// if(!localStorage.getItem('dms-storage')) {
						// 	await handleRequestKey()
						// }
						return next()
					}else {
						//console.log("7");
						return next({name: 'NotFound'})
					}
				}
				else {
					//console.log("8");
					// if(!localStorage.getItem('dms-storage')) {
					// 	await handleRequestKey()
					// }
					return next()
				}
			}
			
		}else {
			//console.log("9");
			return next(false)
		}
		
	} 
  	else {
		if(to.path == "/") {
			return next({name: 'Home'})
		}
		//console.log("10");
		return next()
	}
})
export default router