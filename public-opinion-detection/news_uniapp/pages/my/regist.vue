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
					<input class="input" v-model="username" type="text" maxlength="32" placeholder="请输入账号"/>
				</view>
				<view class="item">
					<iconfont type="pwd1"></iconfont>
					<input class="input" v-model="password1" type="text" maxlength="32" placeholder="请输入密码" password="true"/>
				</view>
				<view class="item">
					<iconfont type="pwd1"></iconfont>
					<input class="input" v-model="password2" type="text" maxlength="32" placeholder="请确认密码" password="true" />
				</view>
				<view class="item verify-item">
					<view class="verfiy-code-icon">
						<iconfont type="yanzhengma"></iconfont>
					</view>
					<input class="input" v-model="verify_code" type="text" maxlength="4" placeholder="请输入验证码" />
					<view class="verify-btn" @click="getCaptcha()">
						<image class="captchaImg" :src="captchaUrl" mode="aspectFit"></image>
					</view>
				</view>
			</view>
			<view class="protocol">
				<view class="agree-box">
					<checkbox-group @change="agreeChange">
						<label>
							<checkbox value="1" v-model="agree" name="agree" checked="true" />
						</label>
					</checkbox-group>
				</view>
				<navigator url="/pages/my/protocol">
					<view class="name">同意用户协议和隐私政策</view>
				</navigator>
			</view>
			<view class="button" hover-class="button-hover" @tap="register">
				<text>注册</text>
			</view>

		</view>
	</view>
</template>

<script>
	import { mapState, mapMutations } from 'vuex';
	import iconfont from '@/components/iconfont/iconfont.vue'
	import validator from '@/common/validator'

	export default {
		components: {iconfont},
		onShow() {
	
		},
		onLoad() {
			this.getCaptcha()
		},
		onUnload() {

		},
		data() {
			return {
				username: '',
				password1: '',
				password2: '',
				verify_code: '',
				captchaUrl: '',
				agree: '1',
				uuid:''
			};
		},
		computed: {
		},
		methods: {
			...mapMutations(['login']),
			/*是否同意选择*/
			agreeChange(e) {
				if (e.detail.value.length > 0) {
					this.agree = '1';
				} else {
					this.agree = '0';
				}
			},

			async getCaptcha(){
				const  res = await this.$myRuquest({
					url:  this.$api.my.getCaptcha,
				});
				this.uuid = res.data.msg
				this.captchaUrl = res.data.data;
				console.log(res);
			},

			/*注册*/
			async register() {
				if (!validator.checkUsername(this.username)) {
					return;
				} else if (!validator.checkPassword(this.password1)) {
					return;
				} else if (!validator.checkPassword2(this.password1,this.password2)) {
					return;
				} else if (this.verify_code.length==0) {
					this.$alert('请输入验证码')
					return;
				}else if(this.agree==0){
					this.$alert('需同意用户协议和隐私政策')
					return;
				}
				
				uni.showLoading({
					title: '注册中…'
				})
				console.log("this.verify_code :"+this.verify_code)
				const  res = await this.$myRuquest({
					url: this.$api.my.regist,
					method: 'POST',
					data: {
						uuid:this.uuid,
						username: this.username,
						password: this.password1,
						captcha: this.verify_code
					}
				});
				if (res.data.msg == "success") {
					uni.hideLoading();
					uni.showToast({
						icon:"success",
						title:"注册成功"
					});
					setTimeout(() =>{
						uni.navigateBack({
							delta: 1,
								animationType: 'pop-out',
								animationDuration: 200,
						})
					},1500)
				}else{
					this.$alert(res.data.msg);
					setTimeout(() =>{this.getCaptcha()},1500)
				}
			
			}
		}
	}
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
			padding-top: 40rpx;
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

				.verfiy-code-icon {
					.icon {
						font-size: 52rpx;
						margin-right: -6rpx;
						margin-left: -4rpx;
					}
				}

				.input {
					flex: 1;
					text-align: left;
					font-size: 30rpx;
					margin-left: 16rpx;
				}
			}

			.verify-item {
				// position: relative;
				.verify-btn {
				// 	position: absolute;
				// 	top: 22rpx;
				// 	right: 10rpx;
				// 	font-size: 30rpx;
					height: 77rpx;
					line-height: 77rpx;
					
				}
				.captchaImg{
					height: 77rpx;
					width: 200rpx;
	
				}
			}
		}

		.protocol {
			display: flex;
			flex-direction: row;
			align-items: center;
			margin-top: 65rpx;
			padding-left: 100rpx;
			text-align: left;

			.agree-box {
				width: 55rpx;
			}

			.name {
				margin-left: 5rpx;
			}
		}




	}
</style>
