<template>
	<view class="content">
		<view class="" v-for="item in List" :key="item.questionid" @click="goDetail(item.questionid)">
			<uni-card
				:title="item.title"
				mode="title"
				:is-shadow="true"
				:thumbnail="item.avatarurl"
				:extra="item.time|formatDate"
				note="Tips"
			>
				<rich-text :nodes="item.content"></rich-text>
				<template v-slot:footer>
					<view class="footer-box">
						<view class="footer_text">回答 {{item.answerCount}}</view>
					</view>
				</template>
			</uni-card>
		</view>
		<!-- 我要提问 -->
		<navigator url="../../QA/issue-question"><view class="btn"></view></navigator>
		
		
		<mix-load-more :status="loadMoreStatus"></mix-load-more>
		<view class="page_bottom"></view>
	</view>
</template>

<script>
	import iconfont from '@/components/iconfont/iconfont.vue';
	import uniCard from '@/components/uni-card/uni-card.vue';
	import mixLoadMore from '@/components/mix-load-more/mix-load-more';
	export default{
		data(){
			return {
				pageIndex: 1,
				pageSize: 10,
				List: [],
				count: '',
				pageCount: '',
				loadMoreStatus: 0
			}
		},
		components:{
			"uni-card":uniCard,
			"mix-load-more":mixLoadMore},
		methods:{
			//获取列表数据
			async getList(){
				this.loadMoreStatus = 1;
				const res = await this.$myRuquest({
					url: this.$api.QA.getQuestions +'?pageIndex='+this.pageIndex +'&pageSize='+this.pageSize,
					method: 'GET'
				})
				this.List = [...this.List,...res.data.data.list]
				this.count = res.data.data.count
				this.pageCount = res.data.data.pageCount
				this.loadMoreStatus = 0;
		
			},
			//导航到详情页
			goDetail (questionid) {
				uni.navigateTo({
					url: '/pages/QA/QA-detail?questionid=' + questionid
				})
			}
			
		},
		onLoad() {
			this.getList()
		},
		//加载更多
		onReachBottom() {
			
			if(this.count<this.pageIndex*this.pageSize) return this.loadMoreStatus=2
			this.pageIndex++
			this.getList()
		},
		//下拉刷新
		onPullDownRefresh() {

			this.pageIndex = 1
			this.List = []
			setTimeout(()=>{
				this.getList(),
				uni.stopPullDownRefresh()
			},1000)
		}
	}
	
</script>

<style lang="scss">
	page{
		height: 100%;
		background-color: #f0f0f0;
	}
	.content{
	}
	.footer_text{
		color: #999;
	}
	.page_bottom{
		width: 100%;
		height: 50px;
		line-height: 50px;
		text-align: center;
	}
	.btn{
		position: fixed;
		bottom: 150upx;
		right: 50upx;
		width: 80upx;
		height: 80upx;
		border-radius: 50%;
		background-color: #93d0bd;
		color: #FFFFFF;
		font-size: 50upx;
		line-height: 80upx;
		text-align: center;
		box-shadow: 0 -2px 3px rgba(0,0,0,.04); 
		z-index: 99;
	}
	.btn:before{
		content: "+";
	}
</style>
