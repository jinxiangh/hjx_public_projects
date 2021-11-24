<template>
	<view class="article_tag">
		
		<text class="tag0" v-if="tag==0">疑</text>
		<text class="tag1" v-if="tag==1">真</text>
		<text class="tag2" v-if="tag==2">假</text>
	</view>
</template>

<script>
	export default {
		props: {
			tag: Number
		}
	}
</script>

<style lang="scss">
	.article_tag{
		display: inline-block;
		margin: 5upx;
		color: #FFFFFF;

		text{
			margin: 5upx;
			padding: 0 5upx;
			border-radius: 10upx;
		}
		.tag0{
			background-color: #ffaa00;
		}
		.tag1{
			background-color: #00e100;
		}
		.tag2{
			background-color: #ff0000;
		}
	}
	
</style>
