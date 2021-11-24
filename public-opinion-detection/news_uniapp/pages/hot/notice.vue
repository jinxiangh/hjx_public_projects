<template>
	<view class="content">
		
		<noData v-if="showNoData" text="暂无通知~"></noData>
	</view>
</template>

<script>
	import noData from '@/components/noData/noData.vue';
	export default {
		components: {
			noData
			},
		data() {
			return {
				showNoData: false
			};
		},
		onLoad() {
			this.showNoData=true
		}
	}
</script>

<style>
</style>
