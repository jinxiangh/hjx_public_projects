<template>
	<view>
		<view class="news_list">
			<article-list :list="List" @listItemClick="goDetail"></article-list>
			<mix-load-more :status="loadMoreStatus"></mix-load-more>
			<view class="isOver" ></view>
		</view>
	</view>
</template>

<script>
	import mixLoadMore from '@/components/mix-load-more/mix-load-more';
	import articleList from '@/components/article/list.vue';
	
	export default{
		data() {
			return {
				pageIndex: 1,
				pageSize:8,
				List: [],
				count: '',
				pageCount: '',
				loadMoreStatus: 0
			}
		},
		components:{"article-list":articleList},
		methods: {
			//获取列表数据
			async getCollectedActicles () {
				this.loadMoreStatus = 1;
				const res = await this.$myRuquest({
					url: this.$api.my.queryCollectedActicles,
					method: 'POST',
					data:{
						pageIndex:this.pageIndex,
						pageSize : this.pageSize
					}
				})
				if (res.data.msg=="success"){
					this.List = [...this.List,...res.data.data.list]
					this.count = res.data.data.count
					this.pageCount = res.data.data.pageCount
					this.loadMoreStatus = 0;
				}else{
					this.$alert(res.data.msg)
					this.loadMoreStatus = 3;
				}
			},
			//导航到详情页
			goDetail (newsid) {
				uni.navigateTo({
					url: '/pages/hot/news-detail?newsid=' + newsid
				})
			}
		},
		onLoad(){
			this.getCollectedActicles()
		},
		//加载更多
		onReachBottom() {
			
			if(this.count<this.pageIndex*this.pageSize) return this.loadMoreStatus=2
			this.pageIndex++
			this.getCollectedActicles()
		},
		//下拉刷新
		onPullDownRefresh() {
			console.log('下拉刷新了')
			this.pageIndex = 1
			this.List = []
			this.loadMoreStatus=1
			uni.stopPullDownRefresh()
			setTimeout(()=>{
				this.getCollectedActicles(),
				this.loadMoreStatus=0
			},1000)
		}
		
	}
</script>

<style lang="scss">

	.news_list{
		
	}
	.isOver {
		width: 100%;
		height: 50px;
		line-height: 50px;
		text-align: center;
		font-size: 28rpx;
	}
</style>
