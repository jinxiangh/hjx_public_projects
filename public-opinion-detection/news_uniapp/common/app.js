const objectToUrlParams = function(obj) {
	var str = "";
	for (var key in obj) {
		str += "&" + key + "=" + obj[key];
	}
	return str.substr(1);
}

/**
 * 是否登录
 */
const isLogin = function() {
	if (uni.getStorageSync("isLogin") == "1") {
		return true;
	}
	return false;
}

/**
 * 初始化登录
 */
const initLogin = function() {
	if (!isLogin()) {
		login();
	}
}

/**
 * 登录
 */
const login = function() {
	/*清除登录缓存*/
	uni.removeStorageSync('isLogin');
	uni.removeStorageSync('accessToken');
	uni.removeStorageSync('currentUser');
	uni.removeStorageSync('platform');
	
	console.log('跳转登录')

	/*储存当前页*/
	let pages = getCurrentPages();
	let currentPage = pages[pages.length - 1];
	let originUrl = '/' + currentPage.route;

	// #ifdef H5
	let urlParam = objectToUrlParams(currentPage.$route.query)
	if (urlParam) {
		originUrl = originUrl + '?' + urlParam;
	}
	// #endif

	uni.setStorageSync('loginOriginUrl', originUrl); //存储跳转前URL
	console.log('loginOriginUrl:' + originUrl)

	// #ifndef MP-WEIXIN
	if (getPlatform() == 'wechatMP') {
		initMPLogin(); //公众号登录
	} else {
		uni.navigateTo({
			url: '/pages/my/login'
		})
	}
	// #endif

}




/*获取平台类型 */
const getPlatform = function() {
	let platform = uni.getStorageSync('platform');

	// #ifdef MP-WEIXIN
	platform = 'wechatMiniApp'; //微信小程序
	// #endif

	// #ifdef H5
	if (!platform) {
		platform = 'h5'; //H5
	}
	// #endif

	// #ifdef APP-PLUS
	if (uni.getSystemInfoSync().platform == 'ios') {
		platform = 'ios';
	} else {
		platform = 'android';
	}
	// #endif

	return platform;
}

/*无状态提示信息*/
const alert = function(msg = '', icon = 'none', url = '', openType = 'navigate') {
	/*消息强制转字符串*/
	if (typeof(msg) != 'string') {
		msg = msg.toString();
	}

	if (msg.length > 7) {
		//长度超过7个字符，用示模态弹窗展示
		uni.showModal({
			title: '提示',
			content: msg,
			showCancel: false
		});
	} else {
		if (icon == 'warning') {
			uni.showToast({
				title: msg,
				image: "/static/img/icon/icon-warning.png"
			});
		} else {
			uni.showToast({
				title: msg,
				icon: icon
			})
		}
	}
	if (url || openType == 'back') {
		setTimeout(() => {
			if (openType == 'redirect') {
				uni.redirectTo({
					url: url
				});
			} else if (openType == 'switchTab') {
				uni.switchTab({
					url: url
				});
			} else if (openType == 'reLaunch') {
				uni.reLaunch({
					url: url
				});
			} else if (openType == 'back') {
				uni.navigateBack();
			} else {
				uni.navigateTo({
					url: url
				});
			}
		}, 1500)
	}
};

/*弹出加载框*/
const loading = function(msg = '', mask = true) {
	/*消息强制转字符串*/
	if (typeof(msg) != 'string') {
		msg = msg.toString();
	}
	uni.showLoading({
		title: msg,
		mask: mask
	})
};


/**
 * 网络请求
 * @param {Object} req
 */
const request = function(req) {
	let accessToken = uni.getStorageSync("accessToken");
	let platform = getPlatform();
	let header = {
		'platform': platform,
		'token': accessToken,
		'Content-type': 'application/x-www-form-urlencoded'
	};
	if (req.header) {
		header = Object.assign(header, req.header);
	}
	uni.request({
		url: req.url,
		data: req.data || {},
		header: header,
		method: req.method || "GET",
		dataType: req.dataType || "json",
		success: function(res) {
			if (res.data.code == '1000') {
				login(); //登录
			} else if (res.data.code == '1003') {
				bindMobile(); //绑定手机号码
			} else {
				if (req.success) {
					console.log(res)
					req.success(res.data);
				}
			}
		},
		fail: function(res) {
			console.warn('--- request fail >>>');
			console.warn(res);
			console.warn('<<< request fail ---');
			uni.showToast({
				title: '网络异常~',
				icon: 'none'
			});
			if (req.fail) {
				req.fail(res);
			}
		},
		complete: function(res) {
			if (res.statusCode != 200) {
				if (res.code == '1000') {
					login();
				}
				console.log('--- request http error >>>');
				console.log(res.statusCode);
				console.log(res.data);
				console.log('<<< request http error ---');
			}
			if (req.complete) {
				req.complete(res);
			}
		}
	});
}
/*上传文件*/
const uploadFile = function(req) {
	uni.uploadFile({
		url: req.url,
		filePath: req.filePath,
		file:req.filePath,
		name: req.name || 'file',
		formData: req.formData || {},
		success: (res) => {
			if (res.data.code == '1000') {
				login(); //登录
			} else if (res.data.code == '1003') {
				bindMobile(); //绑定手机号码
			} else {
				if (req.success) {
					req.success(JSON.parse(res.data));
				}
			}
		},
		fail: (res) => {
			console.warn('--- request fail >>>');
			console.warn(res);
			console.warn('<<< request fail ---');
			uni.showToast({
				title: '网络异常~',
				icon: 'none'
			});
			if (req.fail) {
				req.fail(res);
			}
		},
		complete: (res) => {
			if (res.statusCode != 200) {
				if (res.code == '1000') {
					login();
				}
				console.log('--- request http error >>>');
				console.log(res.statusCode);
				console.log(res.data);
				console.log('<<< request http error ---');
			}
			if (req.complete) {
				req.complete(res);
			}
		}
	});
}


export default {
	isLogin,
	initLogin,
	login,
	alert,
	loading,
	request,
	getPlatform,
	uploadFile
	}