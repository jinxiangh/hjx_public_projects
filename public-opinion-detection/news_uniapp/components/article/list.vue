<template>
	<view class="list">
		<view class="item" @click="navigator(item.newsid)" v-for="(item, index) in list" :key="item.newsid">
			<view class="info">
				<view class="text">
					<view class="title">
						<text class="tag tag0" v-if="item.tag==0">疑</text>
						<text class="tag tag1" v-if="item.tag==1">真</text>
						<text class="tag tag2" v-if="item.tag==2">假</text>
						{{ item.title }}
					</view>
					<view class="other">
						<view class="left">
							<view class="source" v-if="item.source">{{ item.source }}</view>
							<view class="time">{{ item.time | formatDate}}</view>
						</view>
						<view class="right" v-if="item.comment_count > 0">
							<image src="/static/images/icon_comment.png"></image>
							<text>{{ item.comment_count }}</text>
						</view>
						<view class="right view" v-if="item.read">
							<image src="/static/images/icon_view.png"></image>
							<text>{{ item.read }}</text>
						</view>
					</view>
				</view>
				<view class="photo" v-if="item.imageUrl">
					<image :src="item.imageUrl" mode="aspectFill" ></image>
				</view>
				<view class="photo" v-else>
					<image src="/static/img/default_photo.png" mode="aspectFill" ></image>
				</view>
				
			</view>
			<view class="line"></view>
		</view>
	</view>
</template>

<script>

export default {
	props: ['list'],
	methods:{
		navigator (newsid) {
			this.$emit('listItemClick',newsid)
		}
	}
};
</script>

<style lang="scss">
/*文章列表*/
.list {
	margin-top: 2rpx;
	.item {
		padding: 40rpx 24rpx 0 24rpx;
		.info {
			display: flex;
			flex-direction: row;
			justify-content: space-between;
			padding-bottom: 4rpx;
			.text {
				flex-grow: 1;
				flex-shrink: 1;
				display: flex;
				flex-direction: column;
				margin-right: 40rpx;
				.title {
					flex-grow: 1;
					flex-shrink: 1;
					font-size: 30rpx;
					line-height: 1.2;
					display: -webkit-box;
					text-overflow: ellipsis;
					word-break: break-all;
					-webkit-line-clamp: 3;
					-webkit-box-orient: vertical;
					overflow: hidden;
					height: 76rpx;
					margin-bottom: 8rpx;
					.tag{
						margin: 5upx;
						color: #FFFFFF;
						padding: 0 6upx;
						border-radius: 10upx;
					}
					.tag0{background-color: #ffaa00;}
					.tag1{background-color: #00e100;}
					.tag2{background-color: #ff0000;}
				}
				.other {
					flex-grow: 1;
					flex-shrink: 1;
					display: flex;
					align-items: center;
					font-size: 28rpx;
					color: #999;
					line-height: normal;
					.left {
						display: flex;
						flex-grow: 1;
						flex-shrink: 1;
						.source {
							display: -webkit-box;
							text-overflow: ellipsis;
							word-break: break-all;
							-webkit-line-clamp: 1;
							-webkit-box-orient: vertical;
							overflow: hidden;
							width: 140rpx;
							margin-right: 16rpx;
						}
					}
					.right {
						display: flex;
						flex-direction: row;
						justify-content: center;
						align-items: center;
						flex-grow: 0;
						flex-shrink: 0;
						margin-right: 5rpx;
						image {
							flex-grow: 1;
							flex-shrink: 1;
							width: 28rpx;
							height: 28rpx;
							margin-right: 12rpx;
						}
						text {
							flex-grow: 1;
							flex-shrink: 1;
							margin-top: -6rpx;
						}
					}
					.view {
						image {
							width: 40rpx;
							height: 40rpx;
							margin-right: 5rpx;
						}
					}
				}
			}
			.photo {
				image {
					height: 170rpx;
					width: 222rpx;
					border-radius: 10rpx;
				}
			}
		}
		.line {
			display: bock;
			width: 100%;
			height: 1rpx;
			margin-top: 22rpx;
			background: #e8e8e8;
		}
		&:last-child {
			.line {
				//display: none;
			}
			//padding-bottom: 30rpx;
		}
	}
}
</style>
