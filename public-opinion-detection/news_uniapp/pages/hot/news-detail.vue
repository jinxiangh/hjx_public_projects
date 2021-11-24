<template>
	<view class="content">
		<view class="news_detail">
			<text class="title">{{detail.title}}</text>
			<view class="info">
				<text>{{detail.time }}</text>
				<article-tag :tag="detail.tag"></article-tag>
				<!-- <text>Tag：{{detail.tag}}</text> -->
			</view>
			<view class="content">
				<parser :html="detail.content" ></parser>
			</view>

		</view>
		
	</view>
</template>

<script>
	import parser from '@/components/parser/parser.vue';
	import articleTag from '@/components/article/article-tag.vue';
	export default {
		components: {
			parser,
			"article-tag":articleTag},
		data() {
			return {
				newsid: 1,
				detail: {}
			}
		},
		onLoad(options){
			this.newsid = options.newsid
			this.getNewsDetail()
			this.initLike(this.detail.islike)
		},
		methods: {
			async getNewsDetail () {
				const res = await this.$myRuquest({
					url: this.$api.hot.getNewsDetails + '?newsid='+this.newsid
				})
				console.log(res)
				this.detail = res.data.data
			},
			async getArticleLike () {
				const res = await this.$myRuquest({
					url: this.$api.hot.getArticleLike,
					method: 'POST',
					data: {
						newsid: this.detail.newsid,
					}
				})
				if (res.data.msg=="success"){
					if(this.detail.islike==0){
						this.initLike(1)
						this.detail.islike=1
						this.$alert('收藏成功');
					}else{
						this.initLike('0')
						this.detail.islike=0
						this.$alert('取消收藏');
					}
				}else{
					this.$alert(res.data.msg);
				}
			},
			initLike(islike){
				if(islike==1){
					// #ifdef APP-PLUS
						const pages = getCurrentPages();
						const page = pages[pages.length - 1];
						const currentWebview = page.$getAppWebview();
						webView.setTitleNViewButtonStyle(0, {  
							"color":"#f0f000"
						});
					// #endif
					// #ifdef H5
						document.querySelector('.uni-page-head-ft .uni-page-head-btn .uni-btn-icon').setAttribute("style","color: rgb(240, 240, 0); font-size: 22px; font-weight: normal; font-family: font1618232701742;")
					// #endif
				}else{
					// #ifdef APP-PLUS
						const pages = getCurrentPages();
						const page = pages[pages.length - 1];
						const currentWebview = page.$getAppWebview();
						webView.setTitleNViewButtonStyle(0, {  
							"color":"#FFFFFF"
						});
					// #endif
					// #ifdef H5
						document.querySelector('.uni-page-head-ft .uni-page-head-btn .uni-btn-icon').setAttribute("style","color: rgb(255, 255, 255); font-size: 22px; font-weight: normal; font-family: font1618232701742;")
					// #endif
				}
				
			}
		},
		
		onNavigationBarButtonTap(e) {
			this.$app.initLogin()
			if(this.$app.isLogin()){
				this.getArticleLike()
			}
			
		}
	}
</script>

<style lang="scss">
	.news_detail{
		padding: 0 20rpx;
		.title{
			text-align: center;
			display: block;
			margin: 20rpx 0;
			font-size: 25px;
			font-weight: 1000;
		}
		.info{
			display: flex;
			justify-content: space-between;
		}
		.content{
			margin-top: 20upx;
			font-size:  18px;
		}
	}
	.page_bottom{
		display: flex;
		justify-content: space-between;
		margin: 20rpx;
		color: "#c1c1c1";
	}
</style>
