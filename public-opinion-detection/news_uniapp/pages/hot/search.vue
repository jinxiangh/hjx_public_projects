<template>
	<view class="page">
		<!-- #ifdef APP-PLUS -->
		<view class="status_bar">  
			<view class="top_view"></view>  
		</view> 
		<!-- #endif -->
		<view class="top">
			
			<search :name="searchName" :keyword.sync="keyword" :history.sync="history" :showHistory.sync="showHistory" @confirm="search" @focus="initSearch"></search>
			
		</view>
		<view class="content" v-if="!showHistory">
			<scroll-view class="scroll" scroll-y @scrolltolower="loadMore">
				<article-list :list="list" @listItemClick="goDetail"></article-list>
				<noData v-if="showNoData" text="暂无相关文章~"></noData>
				<mix-load-more :status="loadMoreStatus"></mix-load-more>
			</scroll-view>
		</view>

	</view>
</template>

<script>
import search from '@/components/search/search.vue';
import articleList from '@/components/article/list.vue';
import mixLoadMore from '@/components/mix-load-more/mix-load-more';
import noData from '@/components/noData/noData.vue';
import iconfont from '@/components/iconfont/iconfont.vue';
export default {
	components: {
		search,
		noData,
		iconfont,
		mixLoadMore,
		"article-list":articleList
	},
	data() {
		return {
			searchName: 'article-search',
			keyword: '',
			history: [],
			showHistory: true,
			pageIndex: 1,
			pageSize: 10,
			list: [],
			showNoData: false,
			loadMoreStatus: 0
		};
	},
	onShow() {
		
	},
	onLoad(e) {
		let history = uni.getStorageSync(this.searchName);
		if (Array.isArray(history)) {
			this.history = history;
		}
	},
	onReady() {},
	methods: {
		/*搜索*/
		initSearch() {
			this.showHistory = true;
		},
		search(keyword) {
			if (keyword != '') {
				this.keyword = keyword;
			}
			this.showHistory = false;
			if (!this.history.includes(this.keyword)) {
				this.history.push(this.keyword);
				uni.setStorageSync(this.searchName, this.history);
			}
			this.loadData();
		},

		/*加载数据*/
		loadData() {
			this.pageIndex = 1;
			this.showNoData = false;
			// this.slider = [];
			this.list = [];
			this.getData();
		},
		/*获取数据*/
		async getData () {
			this.loadMoreStatus = 1;
			const res = await this.$myRuquest({
				url: this.$api.hot.getNewsList + '?pageIndex='+this.pageIndex +'&pageSize='+this.pageSize +'&keyword='+this.keyword,
				method: 'GET'
			})
			if (res.data.msg=="success"){
				console.log(res.data.data)
				if (this.pageIndex == 1) {
					this.list = [];
				}

				this.list = [...this.list,...res.data.data.list]
				this.count = res.data.data.count
				this.pageCount = res.data.data.pageCount
				this.loadMoreStatus = 0;
				if (this.pageIndex == 1) {
					
					if (this.list.length > 0) {
						this.showNoData = false;
						this.loadMoreStatus = 2
					} else {
						this.showNoData = true;
						this.loadMoreStatus = 3
					}
				}
				
				
			}
		},
		//导航到详情页
		goDetail (newsid) {
			uni.navigateTo({
				url: '/pages/hot/news-detail?newsid=' + newsid
			})
		},
		/*加载更多*/
		loadMore() {
			if(this.count<this.pageIndex*this.pageSize) return this.loadMoreStatus=2
			this.pageIndex++
			this.getData()
		}
	}
};
</script>

<style scoped lang="scss">
page {
	height: 100%;
}
.page {
	display: flex;
	flex: 1;
	flex-direction: column;
	overflow: hidden;
	height: 100%;
}
.content {
	flex: 1;
	width: 100%;
	height: 100rpx;
}

/*头部*/
.top {
	/*页面标题*/
	padding-bottom: 20rpx;
	.page-title {
		padding: 16rpx 0 6rpx;
		display: flex;
		justify-content: center;
		align-items: center;
		height: 90rpx;
		text-align: center;
		border-bottom: 1rpx solid #efefef;
		z-index: 9999;
		.back {
			flex-grow: 0;
			flex-shrink: 0;
			line-height: normal;
			padding-left: 30rpx;
			/deep/.icon {
				color: #c1c4c9;
				font-size: 36rpx;
			}
		}
		.logo {
			flex-grow: 1;
			flex-shrink: 1;
			line-height: normal;
			image {
				height: 50rpx;
				width: 280rpx;
				margin-left: -110rpx;
			}
		}
	}

}

.scroll {
	height: 100%;
}
.status_bar {  
	height: var(--status-bar-height);  
	width: 100%;  
	background-color: #F0F0F0; 
}  
.top_view {  
	height: var(--status-bar-height);  
	width: 100%;  
	position: fixed;  
	background-color: #F76260;
	top: 0;  
	z-index: 999;  
}


</style>
