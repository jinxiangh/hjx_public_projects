<template>
	<view class="wrap">
		<view class="content">
			<view class="list">
				<view class="item"><input maxlength="50" v-model="title" placeholder="标题..." focus=true></textarea></view>
				<view class="item"><textarea v-model="content" placeholder="请输入您的问题..."></textarea></view>
				<view class="button" hover-class="button-hover" @tap="save"><text>提 交</text></view>
			</view>
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
			title: '',
			content: ''
		};
	},
	onShow() {

	},
	onLoad(e) {this.$app.initLogin()},
	onPullDownRefresh() {},
	methods: {
		/*提交*/
		async save() {
			if (this.title == '') {
				this.$alert('标题不能为空');
				return;
			}
			if(this.content.length<10){
				this.$alert('描述过于简单');
				return;
			}
			uni.showLoading({
				title: '提交中…'
			});
			/*回答点赞*/
			this.$app.initLogin()
			const res = await this.$myRuquest({
				url: this.$api.QA.issueQuestion,
				method: 'POST',
				data: {
					title: this.title,
					content:this.content
				}
			})
			if (res.data.msg=="success"){
				setTimeout(()=>{
					uni.hideLoading();
					uni.navigateBack({
						// #ifdef APP-PLUS
						animationType: 'pop-out',
						animationDuration: 200
						// #endif
					})
				},1000)
			}else{
				this.$alert(res.data.msg);
			}
			uni.stopPullDownRefresh();
		}
	}
};
</script>

<style scoped lang="scss">
.list {
	position: fixed;
	width: 100%;

	.item {
		padding: 50upx 40upx 20rpx;
		background: #fff;
		input{
			font-size: 40rpx;
		}
		textarea {
			height: 350rpx;
			font-size: 32rpx;
		}
	}

	.button {
		margin-top: 80rpx;
	}
}
</style>
