<template>
	<view class="page">
		<view class="status-bar"></view>
		
		<view class="content">
			<view class="logo">
				<text >舆情查证平台</text>
			</view>
			<view class="list">
				<view class="item">
					<iconfont type="profileo"></iconfont>
					<input class="input" v-model="username" type="text" maxlength="20" placeholder="请输入账号" />
				</view>
				<view class="item">
					<iconfont type="pwd1"></iconfont>
					<input class="input" v-model="password" type="text" maxlength="32" placeholder="请输入密码" password="true" />
				</view>
			</view>
			<view class="button" hover-class="button-hover" @tap="bindLogin"><text>登录</text></view>
			<view class="other">
				<navigator url="regist" open-type="navigate">注册账户</navigator>
				<text>|</text>
				<navigator url="forget" open-type="navigate">忘记密码</navigator>
			</view>
		</view>
	</view>
</template>

<script>
import { mapState, mapMutations } from 'vuex';
import iconfont from '@/components/iconfont/iconfont.vue';
import validator from '@/common/validator';
export default {
	components: {
		iconfont
	},
	data() {
		return {
			username: '',
			password: '',
			originUrl: '',
			hasLogin: false
		};
	},
	onUnload() {
		if (this.originUrl.search('/pages/common/login') != '-1') {
			uni.reLaunch({
				url: '../article/index'
			});
		}
	},
	onShow() {},
	onLoad(e) {
		let loginOriginUrl = uni.getStorageSync('loginOriginUrl');
		if (loginOriginUrl) {
			this.originUrl = loginOriginUrl;
			setTimeout(() => {
				uni.removeStorageSync('loginOriginUrl');
			}, 1000);
			console.log(this.originUrl);
		}
	},
	computed: mapState(['isLogin']),
	methods: {
		...mapMutations(['login']),
		async bindLogin() {
			if (!validator.checkUsername(this.username)) {
				return;
			} else if (this.password == '') {
				this.$alert('请输入密码');
				return;
			}
			uni.showLoading({
				title: '登录中…'
			});
			
			const  res = await this.$myRuquest({
				url: this.$api.my.login ,
				method: 'POST',
				data: {
					username: this.username,
					password: this.password
				}
			});
			if (res.data.msg == "success") {
				uni.hideLoading();  /*隐藏加载框*/
				/*更新登录状态,保存用户数据*/
			
				this.login(res.data.data);
				uni.setStorageSync('source', 'login');
				
				setTimeout(() =>{
					uni.navigateBack({
						delta: 1,
						    animationType: 'pop-out',
						    animationDuration: 200,
					})
				},1500)
			}else{
				this.$alert(res.data.msg)
			}
			
		}
	}
};
</script>

<style lang="scss">
.content {
	display: flex;
	flex-direction: column;
	justify-content: center;

	.logo{
		margin-top: 143rpx;
		margin-left: auto;
		margin-right: auto;
		text{
			font-size: 30px;
			color: #f76260;
		}
	}

	.list {
		display: flex;
		flex-direction: column;
		padding-top: 120rpx;
		padding-left: 100rpx;
		padding-right: 100rpx;

		.item {
			display: flex;
			flex-direction: row;
			justify-content: space-between;
			align-items: center;
			height: 100rpx;
			border-bottom: 1upx solid rgba(230, 230, 230, 1);

			.icon {
				color: #ababab;
				margin-right: 5rpx;
				font-size: 40rpx;
			}

			.input {
				flex: 1;
				text-align: left;
				font-size: 30rpx;
				margin-left: 16rpx;
			}
		}
	}

	.button {
		margin-top: 100rpx;
	}

	.other {
		display: flex;
		flex-direction: row;
		justify-content: center;
		align-items: center;
		font-size: 30rpx;
		margin-top: 60rpx;
		color: #0A98D5;
		text-align: center;
		height: 40rpx;
		line-height: 40rpx;

		text {
			font-size: 24rpx;
			margin-left: 15rpx;
			margin-right: 15rpx;
		}
	}
}
</style>
