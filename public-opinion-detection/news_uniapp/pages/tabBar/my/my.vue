<template>
	<view class="wrap">
	<!-- #ifndef APP-PLUS -->
		<view class="status-bar"></view>
	<!-- #endif -->
		
		<view class="content">
			<view class="user">
				<view class="base-info">
					<view class="user-info">
						<view class="avatar" :class="[user.userId > 0 && !user.avatarUrl ? 'default-avatar' : '']">
							<navigator v-if="user.avatarUrl" url="../../my/personal-info" hover-class="none"><image :src="user.avatarUrl"></image></navigator>
							<image v-else src="../../../static/img/default_user_photo.jpg" @tap="login()"></image>
						</view>
						<navigator v-if="user.userId > 0" class="info" hover-class="none" url="../../my/personal-info">
							<view class="nickname">{{ user.nickName }}</view>
						</navigator>
						<view v-else class="info">
							<view class="btn-login" @tap="login()">{{ loginText }}</view>
						</view>
					</view>
				</view>
			</view>
			<view class="nav">
				<view class="list">
					<navigator class="item" url="../../my/collected-articles">
						<view class="info">
							<view class="name">
								<iconfont type="round_favor_fill"></iconfont>
								<text>我的收藏</text>
							</view>
							<iconfont type="go"></iconfont>
						</view>
					</navigator>
					<navigator class="item" url="../../my/my-question">
						<view class="info">
							<view class="name">
								<iconfont type="tiwen"></iconfont>
								<text>我的提问</text>
							</view>
							<iconfont type="go"></iconfont>
						</view>
					</navigator>
				</view>
				<view class="list">
					<navigator class="item" url="../../my/personal-info" v-show="user.userId">
						<view class="info">
							<view class="name ">
								<iconfont type="profile"></iconfont>
								<text>个人资料</text>
							</view>
							<iconfont type="go"></iconfont>
						</view>
					</navigator>
					<navigator class="item" url="../../my/binding">
						<view class="info">
							<view class="name">
								<iconfont type="bangdingshouji"></iconfont>
								<text>绑定手机</text>
							</view>
							<iconfont type="go"></iconfont>
						</view>
					</navigator>
					<navigator class="item" url="../../my/setting">
						<view class="info">
							<view class="name">
								<iconfont type="shezhi-o"></iconfont>
								<text>设置</text>
							</view>
							<iconfont type="go"></iconfont>
						</view>
					</navigator>
				</view>
			</view>
			<view class="tab-bar"></view>
		</view>
	</view>
</template>

<script>
import iconfont from '@/components/iconfont/iconfont.vue';

export default {
	components: {
		iconfont
	},
	data() { 
		return {
			user: {},
			loginText: '登录'
		};
	},
	onShow() {
		/*来源是登录时更新*/
		let source = uni.getStorageSync('source');
		if(source == 'login' || 'logout' || 'update'){
			uni.removeStorageSync('source');
			this.getUserInfo()
		}
	},
	onLoad(e) {this.getUserInfo();},
	onPullDownRefresh() {
		uni.stopPullDownRefresh();
		uni.showLoading({
			title: '刷新中'
		});
		this.getUserInfo(); //获取用户信息
		setTimeout(()=>{
			uni.hideLoading();
		},1000)
	},
	methods: {
		/*获取用户信息*/
		async getUserInfo(){
			const  res = await this.$myRuquest({
				url: this.$api.my.getUserInfo,
				method: 'POST'
			});
		
			if (res.data.msg == "success") {
				this.user = res.data.data;
			}else{
				/*清除登录缓存*/
				uni.removeStorageSync('isLogin');
				uni.removeStorageSync('accessToken');
				uni.removeStorageSync('currentUser');
				uni.removeStorageSync('platform');
				this.user={};
				this.$alert(res.data.msg)
			}
		},

		/*登录*/
		login() {
			this.$app.login();
		},

	}
};
</script>

<style scoped lang="scss">
.top {
	/*页面标题*/
	.page-title {
		display: flex;
		justify-content: center;
		align-items: center;
		height: 90rpx;
		text-align: center;
		z-index: 9999;
		font-size: 38rpx;
		font-weight: bold;
		color: #ffffff;
	}
}
.user {
	.base-info {
		//background-image: linear-gradient(top, #e4edec 20%, #e4edec 80%);
		background: #f76260;
		height: 280rpx;
	}
	.user-info {
		padding: 64rpx 32rpx;
		display: flex;
		align-item: center;
		justify-content: space-between;
		.avatar {
			flex-grow: 0;
			flex-shrink: 0;
			line-height: 0;
			border-radius: 50%;
			image {
				width: 144rpx;
				height: 144rpx;
				border-radius: 50%;
				border: 1rpx solid #fff;
			}
		}
		.default-avatar {
			margin-top: -12rpx;
		}
		.info {
			flex-grow: 1;
			flex-shrink: 1;
			padding-left: 28rpx;
			display: flex;
			flex-direction: column;
			justify-content: center;
			.nickname {
				font-size: 44rpx;
				color: #ffffff;
				margin-top: -14rpx;
			}
			.mobile {
				font-size: 34rpx;
				color: #fff;
				display: flex;
				align-items: center;
				line-height: normal;
				/deep/ .icon {
					margin-left: 30rpx;
					font-size: 28rpx;
					display: block;
				}
			}
			.user-type {
				display: flex;
				margin-top: 6rpx;
				text {
					font-size: 24rpx;
					color: #fff;
					background-color: #cd8202;
					padding: 0 24rpx;
					border-radius: 55px;
				}
			}
			.btn-login {
				font-size: 42rpx;
				background: transparent;
				color: #fff;
				text-align: left;
				width: 200rpx;
			}
		}
		.setting {
			flex-grow: 0;
			flex-shrink: 0;
			.btn-setting {
				margin-top: 10rpx;
				/deep/ .icon {
					color: #fff;
					font-size: 48rpx;
				}
			}
		}
	}
}
.nav {
	margin-top: -15rpx;
	margin-bottom: calc(var(--window-bottom) + 20rpx);
	.list {
		margin-top: 15rpx;
		margin-bottom: 20rpx;
		.item {
			padding-left: 24rpx;
			background: #ffffff;
			.info {
				display: flex;
				flex-direction: row;
				align-items: center;
				justify-content: space-between;
				border-bottom: 1rpx solid #e9ebee;
				padding: 4rpx 24rpx 4rpx 0;
				height: 100rpx;
				.name {
					display: flex;
					flex-direction: row;
					align-items: center;
					justify-content: center;
					font-size: 34rpx;
					line-height: normal;
					image {
						width: 45rpx;
						height: 45rpx;
						margin-right: 16rpx;
					}
					/deep/ .icon {
						color: #f76260;
						font-size: 44rpx;
						margin-right: 16rpx;
						line-height: normal;
					}
					/deep/ .icon-car {
						font-size: 35rpx;
						margin-right: 14rpx;
					}

					/deep/ .icon-profile-o {
						font-size: 48rpx;
						margin-right: 12rpx;
					}

					/deep/ .icon-user-info {
						font-size: 50rpx;
						margin-left: -5rpx;
						margin-right: 10rpx;
					}
					/deep/ .icon-favorite {
						font-size: 42rpx;
					}
					/deep/ .icon-about {
						font-size: 44rpx;
						margin-left: -4rpx;
						margin-right: 12rpx;
					}
					/deep/ .icon-question {
						margin-right: 16rpx;
					}
				}

				/deep/ .icon {
					color: #c1c4c9;
					font-size: 24rpx;
				}
			}
			&:last-child {
				.info {
					border-bottom: 0;
				}
			}
		}
	}
}

.status-bar {
	background: #f76260;
}


</style>
