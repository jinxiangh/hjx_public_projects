<template>
	<view>
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
		
	</view>
</template>

<script>
	import mixLoadMore from '@/components/mix-load-more/mix-load-more';
	import iconfont from '@/components/iconfont/iconfont.vue';
	import uniCard from '@/components/uni-card/uni-card.vue';
	
	export default{
		data() {
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
		methods: {
			//获取列表数据
			async getList () {
				this.loadMoreStatus = 1;
				const res = await this.$myRuquest({
					url: this.$api.my.queryMyQuestions,
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
			goDetail (questionid) {
				uni.navigateTo({
					url: '/pages/QA/QA-detail?questionid=' + questionid
				})
			}
		},
		onLoad(){
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

<style>
</style>
