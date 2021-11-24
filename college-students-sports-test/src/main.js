import Vue from 'vue'
import App from './App.vue'
import router from './router'
import store from './store'
import MintUI from "mint-ui"
import "mint-ui/lib/style.css"
import "./lib/mui/css/mui.css"

Vue.use(MintUI)

Vue.config.productionTip = false

router.beforeEach((to, from, next) => {
	if(to.meta.title){
		document.title = to.meta.title
	}
	next()
})

new Vue({
  router,
  store,
  render: h => h(App),
  
}).$mount('#app')
