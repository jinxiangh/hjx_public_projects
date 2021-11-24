<template>
	<view class="container">
		<view class="content">
			<view class="detail">
				<view class="comment">
					<view class="item">
						<view class="avatar"><image :src="info.avatarurl"></image></view>
						<view class="comment-info">
							<view class="nickname-like">
								<view class="nickname">{{ info.nickname }}</view>
								<view class="like">
									<image @tap="getAnswerLike(info.answerid)" v-show="!info.islike" src="../../static/img/icon/icon_like_01.png"></image>
									<image @tap="getAnswerLike(info.answerid)" v-show="info.islike" src="../../static/img/icon/icon_like_01_hover.png"></image>
									<view class="like-count">{{ info.favor }}</view>
								</view>
							</view>
							<view class="comment-desc">{{ info.content }}</view>
							
							<view class="date-reply">
								<view class="date">{{ info.time }}</view>
								<view @tap="initAddReply('commit', info.answerid, info.nickname)" class="reply">回复TA</view>
							</view>
						</view>
					</view>
				</view>
				<view class="comment replys">
					<view class="title">
						全部回复
						<text v-if="info.reply_count > 0">({{ info.reply_count }})</text>
					</view>
					<view class="item" v-for="(item, index) in info.reply" :key="index">
						<view class="avatar"><image :src="item.avatarurl"></image></view>
						<view class="comment-info">
							<view class="nickname-like">
								<view class="nickname">{{ item.nickname }}</view>
								<view class="like">
									<image @tap="getReplyLike(item.answerid, index)" v-show="!item.islike" src="../../static/img/icon/icon_like_01.png"></image>
									<image @tap="getReplyLike(item.answerid, index)" v-show="item.islike" src="../../static/img/icon/icon_like_01_hover.png"></image>
									<view class="like-count">{{ item.like_count }}</view>
								</view>
							</view>
							<view class="comment-desc">
							<!-- 	<text>{{ item.pid > 0 ? '回复@' + item.parent_nickname + '：' : '' }}</text> -->
								{{ item.content }}
							</view>
							
							<view class="reply-count" v-if="item.reply_count > 0">全部{{ item.reply_count }}条回复 ></view>
							<view class="date-reply">
								<view class="date">{{ item.time }}</view>
								<!-- <view @tap="initAddReply('reply', item.id, item.nickname)" class="reply">回复TA</view> -->
							</view>
						</view>
					</view>

					<view class="no-comment" v-if="info.reply_count == 0">暂无回复，快来抢占沙发吧~</view>
				</view>
			</view>
			<view class="float-empty"></view>
			
			<!-- 输入框 -->
			<view class="bg-masker" v-if="showAddReply" @tap="showAddReplyBg(false)"></view>
			<view class="bottom">
				<view class="input-box">
					<iconfont type="modify" class="icon-huifu"></iconfont>
					<textarea
						class="input"
						:cursor-spacing="20"
						:show-confirm-bar="false"
						:auto-height="true"
						:fixed="true"
						:maxlength="200"
						:focus="addReplyFocus"
						v-model.trim="commentContent"
						placeholder-class="input-bg"
						:placeholder= "'回复 ' + info.nickname + '：'"
						@focus = "showAddReplyBg(true)"
						@confirm = "addReply"
					/>
				</view>
				<text class="confirm-btn" @click="addReply">回复</text>
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
			answerid: 0,
			info: { reply: { count: 0, list: [] } },
			showAddReply: false,
			addReplyFocus: false,
			operate: '',
			commentContent: '',
			replyPid: 0,
			replyNickname: ''
		};
	},
	onShow() {
		
	},
	onLoad(e) {
		if (e.answerid > 0) {
			this.answerid = e.answerid;
		}
		if (e.operate == 'reply') {
			this.operate = e.operate;
		}
		this.getAnswerDetails();
	},
	onPullDownRefresh() {
		uni.showLoading({
			title: '刷新中'
		});

		this.getAnswerDetails();
	},
	onReachBottom: function() {
		
	},
	methods: {
		/*获取回答和评论*/
		async getAnswerDetails () {
			const res = await this.$myRuquest({
				url: this.$api.QA.getAnswerDetail + '?answerid='+this.answerid
			})
			if (res.data.msg == 'success'){
				this.info = res.data.data
				/*初始化回复*/
				if (this.operate == 'reply') {
					this.showAddReplyBg(true);
				}
			}else{
				this.$alert(res.data.msg)
			}
		},
		/*回答点赞*/
		async getAnswerLike (answerid) {
			this.$app.initLogin()
			const res = await this.$myRuquest({
				url:  this.$api.QA.getAnswerLike,
				method: 'POST',
				data: {
					answerid: answerid
				}
			})
			if (res.data.msg=="success"){
				if (this.info.islike){
					this.info.islike = false;
					this.info.favor -= 1;
				}else{
					this.info.islike = true;
					this.info.favor += 1;
				}
				let msg = this.info.islike ? '点赞成功' : '已取消点赞';
				this.$alert(msg);
			}else{
				this.$alert(res.data.msg);
			}
		},

		/*回复点赞*/
		async getReplyLike (answerid,index) {
			this.$app.initLogin()
			const res = await this.$myRuquest({
				url: this.$api.QA.getAnswerLike,
				method: 'POST',
				data: {
					answerid: answerid
				}
			})
			if (res.data.msg=="success"){
				if (this.info.reply[index].islike){
					this.info.reply[index].islike = false;
					this.info.reply[index].favor -= 1;
				}else{
					this.info.reply[index].islike = true;
					this.info.reply[index].favor += 1;
				}
				let msg = this.info.reply[index].islike ? '点赞成功' : '已取消点赞';
				this.$alert(msg);
			}else{
				this.$alert(res.data.msg);
			}
		},

		/*初始化回复*/
		initAddReply(type, id, nickname) {
			this.replyNickname = nickname;
			if (type == 'reply') {
				this.replyPid = id;
			}
			this.showAddReply = true;
			this.addReplyFocus = true;
		},

		/*添加回复*/
		async addReply () {
			if (this.commentContent == '') {
				this.$alert('回复内容不能为空');
				return;
			}
			const res = await this.$myRuquest({
				url: this.$api.QA.addReply,
				method: 'POST',
				data: {
					questionid: this.info.questionid,
					replyid : this.info.answerid,
					content: this.commentContent
				}
			})
			if (res.data.msg=="success"){
				this.info.reply = res.data.data;
				this.showAddComment = false;
				this.replyNickname = '';
				this.commentContent = '';
				this.info.reply_count = this.info.reply_count+ 1;
				this.$alert('回复成功');
			}else{
				this.$alert(res.data.msg);
			}
		},

		/*展示回复背景*/
		showAddReplyBg(status) {
			this.showAddReply = status;
			console.log(status);
			setTimeout(() => {
				this.addReplyFocus = status;
			}, 200);
		}

	
	}
};
</script>

<style scoped lang="scss">
.comment {
	padding: 15rpx 32rpx 20rpx;
	background: #fff;
	.title {
		display: flex;
		align-items: center;
		font-size: 34rpx;
		color: #444;
		font-weight: bold;
		padding-bottom: 15rpx;
		border-bottom: 1rpx solid #eee;
		text {
			font-size: 28rpx;
			color: #999;
			margin-left: 10rpx;
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
				width: 56rpx;
				height: 56rpx;
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
						width: 30rpx;
						height: 30rpx;
						margin-right: 14rpx;
					}
					.like-count {
						color: #999;
						font-size: 28rpx;
					}
				}
			}
			.comment-desc {
				color: #262626;
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
		padding: 20rpx 0;
		color: #999;
		font-size: 30rpx;
	}
}
.replys {
	border-top: 0;
	margin-top: 15rpx;
	padding-bottom: 0;
}

.float-empty {
	height: 120rpx;
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
