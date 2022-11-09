import { createRouter, createWebHistory } from 'vue-router'
import LandingPage from '../views/LandingPage.vue'
import Applications from '../views/Applications.vue'
import DMS from '../views/DMS.vue'
import Home from '../views/Home.vue'
import store from '../store'
import {UrlParams} from './support/UrlParams'


async function oAuth2Flow(urlParams, redirect_uri) {
	const code = urlParams.get("code");
	if (code) {
		console.log("code", code);
		await store.dispatch("auth/getAuthToken", {code, redirect_uri})
	} else {
		console.log("redirect");
		await store.dispatch("auth/doAuthRedirect", {redirect_uri})
	}
}
console.log("router load");
const routes = [
  {
    path: '/home',
    name: 'LandingPage',
    component: LandingPage,
	meta: { requiresAuth: false }
  },
  {
    path: '/',
    name: 'Home',
    component: Home,
	meta: { requiresAuth: true }

  },
  {
    path: '/applications',
    name: 'Applications',
	component: Applications,
	meta: { requiresAuth: true }
  },
  {
    path: '/dms',
    name: 'Document',
	component: DMS,
	meta: { requiresAuth: true }
  }
]
const router = createRouter({
  history: createWebHistory(),
  routes
})

router.beforeEach(async (to, from, next) => {
	console.log(to.matched.some(record => record.meta.requiresAuth));

	console.log("to", to);
	if (to.matched.some(record => record.meta.requiresAuth)){
		const HREF = window.location.href.trim();
		const urlParams = new UrlParams(HREF);

		if (!window.sessionStorage.getItem("authToken")) {
			await oAuth2Flow(urlParams, HREF.split('?')[0]);
		} else {
			await store.dispatch("auth/reAuth")
		}
		console.log("isAuthenticated", store.state.auth.isAuthenticated);
		if(store.state.auth.isAuthenticated) {
			return next()
		}else {
			console.log("next2");
			return next({name: 'Home'})
		}
	} 
  	else {
		console.log("next3");
		return next()
	}
})
export default router