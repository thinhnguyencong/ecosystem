
import LandingPage from '../views/LandingPage.vue'
import DMS from '../views/DMS.vue'
import Home from '../views/Home.vue'
import store from '../store'
import {UrlParams} from './support/UrlParams'

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
	meta: { requiresAuth: false }
  },
  {
    path: '/',
    name: 'Home',
    component: Home,
	meta: { requiresAuth: true }

  },
  {
    path: '/dms',
    name: 'Document',
	component: DMS,
	meta: { requiresAuth: true }
  },
]
const router = new VueRouter({
	mode: 'history',
  	routes
})

router.beforeEach(async (to, from, next) => {
	if (to.matched.some(record => record.meta.requiresAuth)){
		const HREF = window.location.href.trim();
		const urlParams = new UrlParams(HREF);

		if (!window.sessionStorage.getItem("authToken")) {
			await oAuth2Flow(urlParams, HREF.split('?')[0]);
		} else {
			await store.dispatch("auth/reAuth")
		}
		if(store.state.auth.isAuthenticated) {
			return next()
		}else {
			return next({name: 'Home'})
		}
	} 
  	else {
		return next()
	}
})
export default router