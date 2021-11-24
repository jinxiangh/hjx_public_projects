
const BASE_URL = 'http://127.0.0.1:8000/app/'
// const BASE_URL = 'http://124.70.185.31:8082/app/'
// 
export const api = {
	hot:{
		getNewsList: BASE_URL + 'getNewsList',
		getNewsDetails: BASE_URL + 'getNewsDetails',
		getArticleLike: BASE_URL + 'getArticleLike'
	},
	QA:{
		getQuestions: BASE_URL + 'getQuestions',
		getQuestionsDetails: BASE_URL + 'getQuestionsDetails',
		getAnswer: BASE_URL + 'getAnswer',
		getAnswerDetail: BASE_URL + 'getAnswerDetail',
		getAnswerLike: BASE_URL + 'getAnswerLike',
		addAnswer: BASE_URL + 'addAnswer',
		addReply: BASE_URL + 'addReply',
		issueQuestion: BASE_URL + 'issueQuestion'
	},
	my:{
		login: BASE_URL + 'login',
		logout: BASE_URL + 'logout',
		regist: BASE_URL + 'regist',
		updatePassword: BASE_URL + 'updatePassword',
		updateUserInfo: BASE_URL + 'updateUserInfo',
		getUserInfo: BASE_URL + 'getUserInfo',
		uploadAvatar: BASE_URL + 'uploadAvatar',
		getCaptcha: BASE_URL + 'regist/get_captcha',
		queryMyQuestions: BASE_URL + 'queryMyQuestions',
		queryCollectedActicles: BASE_URL + 'queryCollectedActicles',
		getVerifyCode: BASE_URL + 'getVerifyCode', //
		binding: BASE_URL + 'binding' //
	}
}

export const myRequest = (options)=>{
	return new Promise((resolve,reject)=>{
		// let accessToken = uni.getStorageSync("accessToken");
		let header = {
			// 'accessToken': accessToken,
			'Content-Type': 'application/x-www-form-urlencoded'
		};
		uni.request({
			url:options.url,
			method: options.method || 'GET',
			header: header,
			data: options.data,
			success: (res)=>{
				if(res.statusCode !== 200) {
					return uni.showToast({
						icon: 'loading',
						title: '获取数据失败'
					})
				}
				resolve(res)
			},
			fail: (err)=>{
				uni.showToast({
					icon: 'none',
					title: '服务器请求失败'
				})
				reject(err)
			}
		})
	})
}
