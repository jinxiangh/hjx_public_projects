<template>
	<view class="container">
		<view class="content">
			<view class="list">
				<view class="item">
					<view class="name">手机号码</view>
					<view class="value">
						<input  placeholder="请输入手机号码" v-model="tel" type="number" maxlength="11" />
					</view>
				
				</view>
				<view class="item">
					<view class="name">短信验证码</view>
					<input class="input" v-model="verify_code" placeholder-class="tip" type="text" maxlength="4" placeholder="请输入验证码" />
					<view class="btn-verify" @tap="getVerifyCode()">{{ verify_text }}</view>
				</view>
			</view>
			
			<view class="submit">
				<view class="button" hover-class="button-hover" @tap="submit()">保存</view>
			</view>
		</view>
	</view>
</template>

<script>
	import validator from '@/common/validator.js';
	export default{
		data() {
			return {
				second: 0,
				tel:'',
				verify_code:''
			}
		},
		onLoad() {
			
		},
		computed: {
			verify_text() {
				if (this.second == 0) {
					return '验证码';
				} else {
					if (this.second < 10) {
						return '0' + this.second + '秒后重新获取';
					} else {
						return this.second + '秒后重新获取';
					}
				}
			}
		},
		methods:{
			/*获取验证码*/
			async getVerifyCode() {
				if (this.second > 0) {
					return;
				}
				if (!validator.checkMobile(this.tel)) {
					return;
				}
				this.second = 60;
				timing = setInterval(() => {
					this.second--;
					if (this.second == 0) {
						clearInterval(timing);
					}
				}, 1000);
				// 未实现接口
				const res = await this.$myRuquest({
					url: this.$api.my.getVerifyCode ,
					method: 'POST',
					data: {
						tel: this.tel,
						type: 'userSetting'
					}
				})
				if (res.data.msg != 'sussess'){
					this.$alert(res.msg, 'warning');
				}
			},
			/*保存*/
			async submit() {
				if (!this.tel && !this.verify_code) {
					this.$alert('请输入短信验证码', 'warning');
					return false;
				}
				uni.showLoading({
					title: '提交中…'
				});
				let data = {
					tel: this.tel
				};
				this.$alert('未实现接口')
				// 未实现接口
				// const res = await this.$myRuquest({
				// 	url: this.$api.my.binding,
				// 	method: 'POST',
				// 	data:''
				// })
				// if (res.data.msg == 'sussess'){
				// 	this.$alert('保存成功', 'success');
				// } else {
				// 	this.$alert(res.msg, 'warning');
				// }
				// uni.hideLoading();
				
			}
		}
	}
</script>

<style lang="scss">
	.list {
		margin-top: 2rpx;
		padding-left: 24rpx;
		padding-right: 24rpx;
		border-bottom: 1rpx solid #eee;
		background: #fff;
		.item {
			display: flex;
			flex-direction: row;
			align-items: center;
			justify-content: space-between;
			min-height: 76rpx;
			border-top: 1rpx solid #eee;
			padding: 10rpx 0;
			&:first-child {
				border: 0;
			}
		}
		.name {
			flex-grow: 0;
			flex-shrink: 0;
			display: flex;
			flex-direction: row;
			align-items: center;
			font-size: 30rpx;
			width: 200rpx;
			color: #555;
			/deep/ .icon {
				color: #0b88ff;
				margin-right: 10rpx;
			}
			/deep/ .icon-mobile-01 {
				font-size: 38rpx;
				margin-right: 5rpx;
				margin-left: -5rpx;
			}
			/deep/ .icon-policy-file {
				font-size: 30rpx;
				margin-right: 14rpx;
				margin-left: -2rpx;
				margin-top: 2rpx;
			}
			text {
				color: #555;
			}
		}
		.value {
			flex-grow: 1;
			flex-shrink: 1;
			display: flex;
			flex-direction: row;
			align-items: center;
			font-size: 30rpx;
			width: 100%;
			justify-content: flex-start;
			text-align: left;
			/deep/.icon {
				margin-left: 20rpx;
				font-size: 20rpx;
				color: #c1c4c9;
			}
			input {
				padding-right: 30rpx;
				font-size: 30rpx;
				width: 100%;
			}
			image {
				width: 60rpx;
				height: 60rpx;
				border-radius: 50%;
				margin-right: 10rpx;
			}
			text {
				margin-right: 15rpx;
				text-align: left;
				line-height: normal;
				padding: 10rpx 0 10rpx 0;
			}
		}
		.btn-verify {
			display: flex;
			justify-content: center;
			align-items: center;
			border: 1rpx solid #848c98;
			background: #fff;
			height: 46rpx;
			line-height: 46rpx;
			padding: 0 20rpx;
			border-radius: 55rpx;
			font-size: 26rpx;
			color: #999;
			width: 220rpx;
		}

	}
	.submit {
		padding: 30rpx 0 70rpx;
		background: #fff;
		.btn-text {
			display: flex;
			justify-content: center;
			margin-top: 24rpx;
			font-size: 32rpx;
			color: #f76260;
		}
	}
</style>
