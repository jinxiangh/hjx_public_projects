<template>
	<view class="content">
	<!-- 问题信息 -->
		<view class="detail">
			<view class="title">{{ detail.title }}</view>
			<view class="info">
				<view class="source-date">
					<image :src="detail.avatarurl"></image>
					<text class="source" >{{ detail.nickname }}</text>
					
				</view>
				<view class="read">{{detail.time}}</view>
			</view>
			<view class="desc"><rich-text :nodes="detail.content"></rich-text></parser></view>
		</view>
		
		
		<!-- 评论 -->
		<view class="comment">
			<view class="title">
				<text>全部回答</text>
				<text class="count" v-if="answer.count > 0">({{ answer.count }})</text>
			</view>
			<view class="item" v-for="(item, index) in answer.list" :key="index">
				<view class="avatar"><image :src="item.avatarurl"></image></view>
				<view class="comment-info">
					<view class="nickname-like">
						<view class="nickname">{{ item.nickname }}</view>
						<view class="like">
							<image @tap="getAnswerLike(item.answerid, index)" v-show="!item.islike" src="/static/img/icon/icon_like_01.png"></image>
							<image @tap="getAnswerLike(item.answerid, index)" v-show="item.islike" src="/static/img/icon/icon_like_01_hover.png"></image>
							<view class="like-count">{{ item.favor }}</view>
						</view>
					</view>
					<navigator class="comment-desc" :url="'commentDetail?answerid=' + item.answerid" hover-class="none">{{ item.content }}</navigator>
					<view class="date-reply">
						<navigator class="date" :url="'commentDetail?answerid=' + item.answerid" hover-class="none">{{ item.time }}</navigator>
						<navigator class="reply" :url="'commentDetail?operate=reply' + '&answerid=' + item.answerid">回复TA</navigator>
					</view>
					<navigator class="reply-count" v-if="item.reply_count > 0" :url="'commentDetail?answerid=' + item.answerid" hover-class="none">
						全部{{ item.reply_count }}条回复 >
					</navigator>
				</view>
			</view>
			<view class="no-comment" v-if="answer.count == 0">暂无评论，快来抢占沙发吧~</view>
		</view>
		
		<view class="seat"><br><br><br><br></view>
		<!-- 输入框 -->
		<view class="bg-masker" v-if="showAddComment"></view>
		<view class="bottom">
			<view class="input-box">
				<iconfont type="modify" class="icon-huifu"></iconfont>
				<textarea
					class="input"
					:cursor-spacing="20"
					:show-confirm-bar="false"
					:auto-height="true"
					:fixed="true"
					maxlength=-1
					v-model.trim="commentContent"
					placeholder-class="input-bg"
					placeholder="答复一下吧..." 
					@focus = "showAddComment=true"
					@blur = "showAddComment=false"
					@confirm = "addAnswer"
				/>
			</view>
			<text class="confirm-btn" @click="addAnswer">提交</text>
		</view>
	</view>
</template>

<script>
	import iconfont from '@/components/iconfont/iconfont.vue';
	export default {
		components: {iconfont},
		data() {
			return {
				questionid: 1,
				detail: {},
				answer: {count: '',list: []},
				showAddComment: false,
				showCommenBar: true,
				commentContent:''
			}
		},
		onLoad(options){
			this.questionid = options.questionid
			this.getQuestionsDetails()
			this.getAnswer()
		},
		onPullDownRefresh() {
			uni.showLoading({
				title: '刷新中'
			});
			uni.stopPullDownRefresh();
			this.getQuestionsDetails();
		},
		methods: {
			// 获取问题详细
			async getQuestionsDetails () {
				const res = await this.$myRuquest({
					url: this.$api.QA.getQuestionsDetails + '?questionid='+ this.questionid
				})
				if (res.data.msg=="success"){
					this.detail = res.data.data
				}
				setTimeout(()=>{
					uni.hideLoading();
				},1000)
				
			},
			// 获取回答
			async getAnswer () {
				const res = await this.$myRuquest({
					url: this.$api.QA.getAnswer + '?questionid='+this.questionid
				})
				if (res.data.msg=="success"){
					this.answer.list = res.data.data
					this.answer.count = this.answer.list.length
				}
			},
			/*发表回答*/
			async addAnswer () {
				this.$app.initLogin()
				if (this.commentContent == '') {
					this.$alert('回复内容不能为空');
					return;
				}
				const res = await this.$myRuquest({
					url: this.$api.QA.addAnswer,
					method: 'POST',
					data: {
						questionid: this.questionid,
						content: this.commentContent
					}
				})
				if (res.data.msg=="success"){
					this.answer.list = res.data.data;
					this.answer.count = this.answer.list.length;
					this.showAddComment = false;
					this.commentContent = '';
					this.$alert('发表成功');
				}else{
					this.$alert(res.data.msg);
				}
			},
			/*发表评论*/
			async addComment () {
				if (this.commentContent == '') {
					this.$alert('回复内容不能为空');
					return;
				}
				const res = await this.$myRuquest({
					url: this.$api.QA.addReply,
					method: 'POST',
					data: {
						questionid: this.questionid,
						replyid : this.replyAnswerId,
						content: this.commentContent
					}
				})
				if (res.data.msg=="success"){
					this.answer.list = res.data.data;
					this.showAddComment = false;
					this.replyCommentId = 0;
					this.replyNickname = '';
					this.commentContent = '';
					this.$alert('评论成功');
				}else{
					this.$alert(res.data.msg);
				}
			},
			// 回答点赞
			async getAnswerLike (answerid,index) {
				this.$app.initLogin()
				const res = await this.$myRuquest({
					url: this.$api.QA.getAnswerLike,
					method: 'POST',
					data: {
						answerid: answerid
					}
				})
				if (res.data.msg=="success"){
					if (this.answer.list[index].islike){
						this.answer.list[index].islike = false;
						this.answer.list[index].favor -= 1;
					}else{
						this.answer.list[index].islike = true;
						this.answer.list[index].favor += 1;
					}
					let msg = this.answer.list[index].islike ? '点赞成功' : '已取消点赞';
					this.$alert(msg);
				}else{
					this.$alert(res.data.msg);
				}
			}
		}
		
	}
	
</script>
	
<style lang="scss">
	page{
			height: 100%;
		}
	.content{
		display: flex;
		flex-direction: column;
		height: 100%;
		background: #fff;
	}
	.detail {
		padding: 40rpx 32rpx;
		background: #fff;
		.title {
			font-size: 44rpx;
			color: #262626;
			line-height: 70rpx;
			font-weight: bold;
		}
		.info {
			margin-top: 32rpx;
			display: flex;
			flex-direction: row;
			justify-content: space-between;
			align-items: center;
			.source-date {
				display: flex;
				image{
					width:60upx;height: 60upx;
					border-radius: 50%;
				}
				.source {
					margin-left: 15upx;
					color: #666;
				}
				.date {
					color: #999;
					margin-left: 24rpx;
				}
			}
			.read {
				color: #999;
			}
		}
		.desc {
			margin-top: 56rpx;
			overflow: hidden;
			color: #262626;
			.wxParse {
				color: #262626;
			}
		}
	}
	.comment {
		padding: 20rpx 32rpx 0;
		background: #fff;
		.title {
			display: flex;
			align-items: center;
			font-size: 36rpx;
			color: #262626;
			font-weight: bold;
			border-bottom: 1rpx solid #eee;
			text {
				padding-bottom: 20rpx;
				line-height: normal;
			}
			.count {
				padding-bottom: 20rpx;
				font-size: 30rpx;
				color: #999;
				margin-left: 10rpx;
				line-height: normal;
			}
		}
		.item {
			display: flex;
			justify-content: space-between;
			padding: 30rpx 0 20rpx;
			border-bottom: 1rpx solid #eee;
			&:last-child {
				border-bottom: 0;
			}
			.avatar {
				flex-grow: 0;
				flex-shrink: 0;
				margin-right: 20rpx;
				image {
					width: 45rpx;
					height: 45rpx;
					border-radius: 50%;
				}
			}
			.comment-info {
				flex-grow: 1;
				flex-shrink: 1;
				.nickname-like {
					display: flex;
					justify-content: space-between;
					.nickname {
						font-size: 32rpx;
						color: #444;
						font-weight: bold;
					}
					.like {
						display: flex;
						align-items: center;
						image {
							width: 32rpx;
							height: 32rpx;
							margin-right: 14rpx;
						}
						.like-count {
							color: #999;
							font-size: 30rpx;
						}
					}
				}
				.comment-desc {
					color: #444;
					font-size: 32rpx;
					line-height: 1.6;
					margin-top: 15rpx;
				}
				.reply-count {
					background: #f2f2f2;
					padding: 8rpx 20rpx;
					font-size: 30rpx;
					color: #999;
					margin: 20rpx 0 24rpx;
				}
				.date-reply {
					display: flex;
					justify-content: space-between;
					align-items: center;
					.date {
						display: flex;
						align-items: center;
						color: #b4b4b4;
						font-size: 28rpx;
						margin-right: 20rpx;
						margin-top: 4rpx;
					}
					.reply {
						flex-grow: 0;
						flex-shrink: 0;
						font-size: 28rpx;
						color: #999;
					}
				}
			}
		}
		.no-comment {
			padding: 40rpx 0;
			color: #999;
			font-size: 30rpx;
		}
	}
	.seat {
		height: 120upx;
		width: 100%;
		display: block;
		background: #fff;
	}
	
	/* 底部输入框 */
	.bottom{
		position: fixed;
		bottom: 0;
		left: 0;
		display: flex;
		align-items: center;
		min-height: 100upx;
		width: 100%;
		padding: 0upx 30upx;
		// margin: 0 30upx;
		box-shadow: 0 -1px 3px rgba(0,0,0,.04); 
		background-color: #ffffff;
		z-index: 999;
		
		.input-box{
			display: flex;
			align-items: center;
			flex: 5;
			min-height: 70upx;
			background: #f2f3f3;
			border-radius: 25px;
			padding-left: 30upx;
			margin: 15upx 0;
			.icon-huifu{
				font-size: 28upx;
				color: #909399;
			}
			.input{
				padding: 10upx 20upx;
				font-size: 28upx;
				color: #303133;
				
			}
		}
		.confirm-btn{
			display: flex;
			flex: 1;
			font-size: 30upx;
			padding-left: 20upx;
			color: #0d9fff;
		}
	}

</style>
