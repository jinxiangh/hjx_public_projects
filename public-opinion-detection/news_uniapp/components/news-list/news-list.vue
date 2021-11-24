<template>
	<view>
		<view class="news_item" @click="navigator(item.newsid)" v-for="item in list" :key="item.newsid">
			<image :src="['http://127.0.0.1:8000'+item.imageUrl]"></image>
			<view class="right">
				<view class="tit">
					{{item.title}}
				</view>
				<view class="info">
					<text>发表时间：{{item.time | formatDate}}</text>
					<text>TAG：{{item.tag}}</text>
				</view>
			</view>
		</view>
	</view>
</template>

<script>
	export default {
		props: ['list'],
		filters: {
			formatDate (date) {
				const nDate = new Date(date)
				const year = nDate.getFullYear()
				const month = nDate.getMonth().toString().padStart(2,0)
				const day = nDate.getDay().toString().padStart(2,0)
				return year+'-'+month+'-'+day
			},
		},
		methods:{
			navigator (newsid) {
				this.$emit('newsItemClick',newsid)
			}
		}
	}
</script>

<style lang="scss">
	.news_item{
		display: flex;
		padding: 10rpx 20rpx;
		border-bottom: 1px solid $news-color;
		image{
			min-width: 200rpx;
			max-width: 200rpx;
			height: 150rpx;
		}
		.right{
			margin-left: 15rpx;
			display: flex;
			flex-direction: column;
			justify-content: space-between;
			.tit{
				font-size: 30rpx;
			}
			.info{
				font-size: 24rpx;
				text:nth-child(2){
					margin-left: 30rpx;
				}
			}
		}
	}
</style>
