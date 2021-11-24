<template>
	<view class="container">
		<view class="content">
			<view class="list">
				
				<view  class="item photo-item">
					<view class="name">
						<imageCropper @ok="confirm" @cancel="cancel" :fixed="true" :url="tempFilePath" :width="200" :height="200"></imageCropper>
						<image v-if="!user.avatarUrl" src="../../static/img/default_user_photo.jpg" mode="aspectFill" @tap="upload"></image>
						<image v-else :src="cropFilePath" mode="aspectFill" @tap="upload"></image>
					</view>
					<view class="value" @tap="upload"><text class="tip">修改头像</text></view>
					<view class="go"><iconfont type="go"></iconfont></view>
				</view>

				<view class="item" >
					<view class="name">用户名</view>
					<view class="value">{{ user.userName }}</view>
				</view>
				
				<view class="item" >
					<view class="name">昵称</view>
					
					<view class="value"><input type="text" v-model="user.nickName" /></view>
				</view>

				<navigator class="item" url="binding">
					<view class="name">手机号码</view>
					<view class="value">{{ user.tel }}</view>
					<view class="go"><iconfont type="go"></iconfont></view>
				</navigator>
				
				<navigator class="item"  url="revise" hover-class="none">
					<view class="name">修改密码</view>
					<text class="value"></text>
					<view class="go"><iconfont type="go"></iconfont></view>
				</navigator>
				
			
			</view>
			<view class="submit">
				<view class="button" hover-class="button-hover" @tap="submit()">保存</view>
			</view>
		</view>

	</view>
</template>

<script>
import util from '@/common/util.js';
import validator from '@/common/validator.js';
import iconfont from '@/components/iconfont/iconfont.vue';
import imageCropper from '@/components/image/cropper.vue';
export default {
	components: {
		// pageLoading,
		iconfont,
		imageCropper
	},
	data() {
		return {
			// second: 0,
			tempFilePath: '',
			cropFilePath: '',
			user: {},
			showPageLoading: true
		};
	},
	onShow() {

	},
	onLoad(e) {
		this.loadData();
	},
	computed: {
	},
	onPullDownRefresh() {
		uni.showLoading({
			title: '刷新中'
		});
		this.loadData();
	},
	methods: {
		/*加载数据*/
		loadData() {
			this.getData();
		},

		/*获取数据*/
		getData() {
			this.user = uni.getStorageSync('currentUser')
			this.cropFilePath = this.user.avatarUrl;
		},
		
		upload() {
			uni.chooseImage({
				count: 1, //默认9
				sizeType: ['original', 'compressed'], //可以指定是原图还是压缩图，默认二者都有
				sourceType: ['album'], //从相册选择
				success: res => {
					this.tempFilePath = res.tempFilePaths.shift();
				}
			});
		},
		/* 剪切成功后的回调  上传图片 */
		confirm(e) {
			this.tempFilePath = '';
			this.cropFilePath = e.path;
		
			this.$loading('图片上传…');
			this.$app.uploadFile({
				url: this.$api.my.uploadAvatar,
				filePath: e.path,
				name: 'file',
				formData: {},
				success: res => {
					console.log(res.data);
					if (res.msg == "success") {
						this.user.avatarUrl = res.data;
						// this.cropFilePath = res.data;  //
						uni.setStorageSync('source', 'update');
					}
					uni.hideLoading();
				}
			});
			
		},
		cancel() {
			this.tempFilePath = '';
		},

		/*保存*/
		async submit() {
			uni.showLoading({
				title: '提交中…'
			});
			const res = await this.$myRuquest({
				url:  this.$api.my.updateUserInfo,
				method: 'POST',
				data: {
					nickName: this.user.nickName,
					tel: this.user.tel,
					avatarUrl : this.user.avatarUrl
				}
			})
			if (res.data.msg=="success"){
				this.$alert('保存成功', 'success');
				uni.setStorageSync('currentUser',this.user)
			}else{
				this.$alert(res.data.msg, 'warning');
			}
			uni.hideLoading();

		},
		
	}
};
</script>

<style lang="scss" scoped>
.list {
	margin-top: 2rpx;
	padding-left: 24rpx;
	padding-right: 24rpx;
	border-bottom: 1rpx solid #eee;
	background: #fff;
	.item {
		display: flex;
		flex-direction: row;
		align-items: center;
		justify-content: space-between;
		min-height: 76rpx;
		border-top: 1rpx solid #eee;
		padding: 10rpx 0;
		&:first-child {
			border: 0;
		}
		.name {
			flex-grow: 0;
			flex-shrink: 0;
			display: flex;
			flex-direction: row;
			align-items: center;
			font-size: 30rpx;
			width: 200rpx;
			color: #555;
			/deep/ .icon {
				color: #0b88ff;
				margin-right: 10rpx;
			}
			/deep/ .icon-tel-01 {
				font-size: 38rpx;
				margin-right: 5rpx;
				margin-left: -5rpx;
			}
			/deep/ .icon-policy-file {
				font-size: 30rpx;
				margin-right: 14rpx;
				margin-left: -2rpx;
				margin-top: 2rpx;
			}
			text {
				color: #555;
			}
		}
		.value {
			flex-grow: 1;
			flex-shrink: 1;
			display: flex;
			flex-direction: row;
			align-items: center;
			font-size: 30rpx;
			width: 100%;
			justify-content: flex-start;
			text-align: left;
			/deep/.icon {
				margin-left: 20rpx;
				font-size: 20rpx;
				color: #c1c4c9;
			}
			input {
				padding-right: 30rpx;
				font-size: 30rpx;
				width: 100%;
			}
			image {
				width: 60rpx;
				height: 60rpx;
				border-radius: 50%;
				margin-right: 10rpx;
			}
			text {
				margin-right: 15rpx;
				text-align: left;
				line-height: normal;
				padding: 10rpx 0 10rpx 0;
			}
			.nickname {
				font-size: 30rpx;
			}
		}
		.btn-verify {
			display: flex;
			justify-content: center;
			align-items: center;
			border: 1rpx solid #848c98;
			background: #fff;
			height: 46rpx;
			line-height: 46rpx;
			padding: 0 20rpx;
			border-radius: 55rpx;
			font-size: 26rpx;
			color: #999;
			width: 220rpx;
		}
		.tip {
			font-size: 30rpx;
			margin-right: 15rpx;
			color: grey;
		}
		.go {
			display: flex;
			flex-direction: row;
			align-items: center;
			justify-content: center;

			/deep/.icon {
				color: #dddddd;
				font-size: 20rpx;
			}
		}
		.location {
			display: flex;
			flex-direction: row;
			align-items: center;
			justify-content: center;
			/deep/.icon {
				color: grey;
			}
		}
		.drive-type {
			display: flex;
			align-items: center;
			.check-item {
				display: flex;
				align-items: center;
				margin-left: 30rpx;
				&:first-child {
					margin-left: 0;
				}
				.check-name {
					font-size: 30rpx;
					line-height: normal;
				}
			}
		}
	}
	.photo-item {
		height: 150rpx;
		image {
			width: 120rpx;
			height: 120rpx;
			border-radius: 50%;
		}
	}
	.textarea-item {
		padding-top: 10rpx;
		height: 110rpx;
		align-items: flex-start;
		.name {
			padding-top: 10rpx;
		}
		.value {
			textarea {
				padding-top: 12rpx;
				height: 100rpx;
				font-size: 30rpx;
				word-wrap: break-word;
				width: 524rpx;
				line-height: 1.5;
			}
		}
	}
}
.submit {
	padding: 30rpx 0 70rpx;
	background: #fff;
	.btn-text {
		display: flex;
		justify-content: center;
		margin-top: 24rpx;
		font-size: 32rpx;
		color: #f76260;
	}
}
</style>
