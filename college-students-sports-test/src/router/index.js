import Vue from 'vue'
import VueRouter from 'vue-router'
import Home from '../views/Home.vue'

Vue.use(VueRouter)

const routes = [
  {
    path: '/',
    name: 'Home',
    component: Home,
	meta:{title:"体测小帮手"}
  },
  {
    path: '/about',
    name: 'About',
    component: () => import(/* webpackChunkName: "about" */ '../views/About.vue'),
	meta:{
		title:"关于",
		keepAlive: true
	}
  },
  {
    path: '/StandardDetail',
    name: 'StandardDetail',
    component: () => import(/* webpackChunkName: "about" */ '../components/StandardDetail.vue'),
    meta:{title:"评分指标"}
  },
  {
    path: '/GradeDetail',
    name: 'GradeDetail',
    component: () => import(/* webpackChunkName: "about" */ '../views/GradeDetail.vue'),
    meta:{title:"成绩构成"}
  }
]

const router = new VueRouter({
  routes
})

export default router
