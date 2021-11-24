<template>
	<view class="container">
		<view class="content">
			<view class="submit">
				<view class="btn-text" @tap="logout()">退出登录</view>
			</view>
		</view>
	</view>
</template>

<script>
	export default{
		data() {
			return {
				
			}
		},
		methods:{
			/*退出登录*/
			logout() {
				uni.showModal({
					title: '提示',
					content: '确认退出登录？',
					confirmText: '是',
					cancelText: '否',
					success: result => {
						if (result.confirm) {
							this.getlogout();
							uni.hideLoading();
						}
					}
				});
			},
			async getlogout(){
				const res = await this.$myRuquest({
					url: this.$api.my.logout,
					method: 'POST',
					data:''
				})
				console.log(res)
				if (res.data.msg=="success"){
					uni.removeStorageSync('isLogin');
					uni.removeStorageSync('accessToken');
					uni.removeStorageSync('currentUser');
					uni.removeStorageSync('platform');
					uni.setStorageSync('source', 'logout');
			
					this.$alert('退出登录成功', 'success', '/pages/tabBar/my/my', 'switchTab');	
				}else{
					this.$alert(res.data.msg);
				}
			}
			
		}
	}
	
</script>

<style lang="scss">
	.container{
		display: flex;
		flex-direction: column-reverse;
	}
	.content{
	}
	.submit {
		padding: 30rpx 0 70rpx;
		background: #fff;
		.btn-text {
			display: flex;
			justify-content: center;
			margin-bottom: 100rpx;
			font-size: 32rpx;
			color: #f76260;
		}
	}
</style>
