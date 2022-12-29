
import jwt_decode from "jwt-decode";
import LandingPage from '../views/LandingPage.vue'
import Home from '../views/Home.vue'
import MyFolder from '../views/MyFolder.vue'
import ShareWithMe from '../views/SharedWithMe.vue'
import Directory from '../views/Directory.vue'
import AdminPage from '../views/AdminPage.vue'
import ModalFileDetails from '../views/ModalFileDetails.vue'
import ModalFile from '../views/ModalFile.vue'
import NotFound from '../components/NotFound.vue'
import store from '../store'
import {UrlParams} from '../helpers/UrlParams'
// import { ABE_MODULE } from '../helpers/abe';
import { sendRequest } from '../helpers/sendRequest';
import Vue from "vue";
import VueRouter from "vue-router";
import Router from 'vue-router';

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
	children: [
		{
		  path: 'file/:id',
		  name: 'ModalFile',
		  component: ModalFile,
		  props: true,
		  meta: { requiresAuth: false, requiresAdmin: false, showModal: true }
		},
	],
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
const handleRequestKey = async () => {
	try {
		let data= {}
		// console.log(ABE_MODULE);
		//init request key, get account and nonce
		await store.dispatch("user/initRequestKey")

		// ABE gen nonce gen key
		await ABE_MODULE.then((ABE) => {
			// console.log("abe gen nonce gen key, get NewNonce {nonce, fgp}");
			// console.log("store.state.user.nonce", store.state.user.nonce);
			let newNonce = ABE.abe_gen_nonce_gen_key(store.state.user.nonce);
			data.nonce = newNonce.nonce
			data.fgp = newNonce.fgp
			return ABE
		}).then(async (ABE) => {
			// console.log("data", data);
			// confirm key, sign message(message, account), get signature
			await store.dispatch("user/signMessage", {message: data.nonce})
			// request key using signature, get encrypted key
			let request = {
				pubWallet: store.state.user.publicAddress,
				nonce:  data.nonce,
				sigWallet: store.state.user.signature,
				fgp: data.fgp
			}
			await store.dispatch("user/requestKey", request)
			// console.log("ABE", ABE, request);
			// import encrypted key to ABE
			let resultImportKey = await ABE.abe_import_key_from_kdc(store.state.user.encryptedKey, store.state.user.username)
            console.log('resultImportKey', resultImportKey);
			return;
		})
	} catch (error) {
		console.log(error);
		alert("error")
	}
	



}
router.beforeEach(async (to, from, next) => {
	if (to.matched.some(record => record.meta.requiresAuth)){
		const HREF = window.location.href.trim();
		const urlParams = new UrlParams(HREF);
		if (!window.sessionStorage.getItem("authToken")) {
			//console.log("1");
			await oAuth2Flow(urlParams, HREF.split('?')[0]);
		} else {
			//console.log("2");
			await store.dispatch("auth/reAuth")
		}
		if(store.state.auth.isAuthenticated) {
			
			let access_token = jwt_decode(window.sessionStorage.getItem("authToken"))
			if(!access_token?.resource_access?.dms?.roles) {
				//console.log("3");
				alert('Your account need to be verified by admin')
				return next(false)
			}else {
				if(access_token.resource_access.dms.roles.includes('admin')) {
					//console.log("4");
					await store.dispatch("auth/setRole", "admin") 
				}else {
					//console.log("5");
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