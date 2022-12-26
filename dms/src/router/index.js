
import jwt_decode from "jwt-decode";
import LandingPage from '../views/LandingPage.vue'
import Home from '../views/Home.vue'
import MyFolder from '../views/MyFolder.vue'
import ShareWithMe from '../views/SharedWithMe.vue'
import Directory from '../views/Directory.vue'
import AdminPage from '../views/AdminPage.vue'
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
const routes = [
  {
    path: '/home',
    name: 'LandingPage',
    component: LandingPage,
	meta: { requiresAuth: false, requiresAdmin: false },
	children: [
		{
		  // UserProfile will be rendered inside User's <router-view>
		  // when /user/:id/profile is matched
		  path: 'file/:id',
		  name: 'ModalFile',
		  component: ModalFile,
		  meta: { requiresAuth: false, requiresAdmin: false }
		},
	  ],
  },
  {
    path: '/',
    name: 'Home',
	component: Home,
	meta: { requiresAuth: true, requiresAdmin: false }
  },
  {
    path: '/my-folder',
    name: 'My Folder',
    component: MyFolder,
	meta: { requiresAuth: true, requiresAdmin: false }
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
	meta: { requiresAuth: true, requiresAdmin: false }
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
  	routes
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
	console.log("to", to.matched.some(record => record.meta.requiresAuth));
	if (to.matched.some(record => record.meta.requiresAuth)){
		const HREF = window.location.href.trim();
		const urlParams = new UrlParams(HREF);
		console.log("urlParams", HREF.split('?')[0]);
		if (!window.sessionStorage.getItem("authToken")) {
			await oAuth2Flow(urlParams, HREF.split('?')[0]);
		} else {
			await store.dispatch("auth/reAuth")
		}
		if(store.state.auth.isAuthenticated) {
			let access_token = jwt_decode(window.sessionStorage.getItem("authToken"))
			if(!access_token?.resource_access?.dms?.roles) {
				alert('Your account need to be verified by admin')
				return next(false)
			}else {
				if(access_token.resource_access.dms.roles.includes('admin')) {
					await store.dispatch("auth/setRole", "admin") 
				}else {
					await store.dispatch("auth/setRole", "user")
				}
				// check if route require admin role
				if(to.matched.some(record => record.meta.requiresAdmin)) {
					if(store.state.auth.role === "admin") {
						// if(!localStorage.getItem('dms-storage')) {
						// 	await handleRequestKey()
						// }
						return next()
					}else {
						return next({name: 'NotFound'})
					}
				}
				else {
					// if(!localStorage.getItem('dms-storage')) {
					// 	await handleRequestKey()
					// }
					return next()
				}
			}
			
		}else {
			return next(false)
		}
		
	} 
  	else {
		return next()
	}
})
export default router