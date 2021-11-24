import Vue from 'vue'
import Vuex from 'vuex'


Vue.use(Vuex)

export default new Vuex.Store({
	state: {
		isFirst:true,
		user_test_info:{"xb":"","xm":"","sg":"","tz":"","bmi":"","fhl":"","ldt":"","tqq":"","wsmp":"","wsmp_s":"","wsmp_ss":"","ykmp":"","ykmp_m":"","ykmp_s":"","ytxs":""},
		user_test_grade:{"bmi":"","fhl":"","ldt":"","tqq":"","wsmp":"","ykmp":"","ytxs":"","grade":"0"}
  },
	mutations: {
	setIsFirst(state,flag){
		state.isFirst = flag
		console.log("isFirst:",state.isFirst)
	},
	setUserTestInfo(state,user){
		console.log("updata vuex.state.user_test_info");
		state.user_test_info = user;
	},
	setUserTestGrade(state,grade){
		console.log("updata vuex.state.user_test_grade");
		state.user_test_grade = grade;
	}
  },
	actions: {
  },
	modules: {
  }
})
