import Vue from 'vue'
import App from './App'
import store from './store'
import { myRequest,api } from './util/api.js'
import base from './common/app'

Vue.prototype.$store = store
Vue.prototype.$myRuquest = myRequest
Vue.prototype.$api = api
Vue.prototype.$app = base

/*过滤时间*/
Vue.filter('formatDate',(date)=>{
	const nDate = new Date(date)
	const year = nDate.getFullYear()
	const month = nDate.getMonth().toString().padStart(2,0)
	const day = nDate.getDay().toString().padStart(2,0)
	return year+'-'+month+'-'+day
})
/*无状态提示信息*/
Vue.prototype.$alert = function(msg = '', icon = 'none', url = '', openType = 'navigate') {
	base.alert(msg, icon, url, openType);
};
/*弹出加载框*/
Vue.prototype.$loading = function(msg = '', mask = true) {
	base.loading(msg, mask);
};

/*是否登录*/
Vue.prototype.$initLogin = function() {
	if (!uni.getStorageSync('isLogin')) {
		base.login();
	}
};

Vue.config.productionTip = false
App.mpType = 'app'

const app = new Vue({
	store,
	...App
})
app.$mount()
