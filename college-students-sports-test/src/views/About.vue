<template>
  <div >
	<br />
	<h2>体测小帮手</h2>
	<h3>v.1.1.0</h3>
	<br />
	<hr />
	<br />
	<transition name="box">
		<div style="margin-top: 10%;" v-if="show">
			<h4>实现技术</h4>
			<br />
			<p>web基础</p>
			<p>Vue基础语法</p>
			<p>Vue CLI</p>
			<p>vue-router、vuex、transition</p>
			<p>MintUI、MUI</p>
			
			<br />
		</div>
	</transition>
  </div>
</template>

<script>
	export default{
		data() {
			return {
				show: false
			}
		},
		mounted() {
			setTimeout(()=>{this.show=true}, 100);
		}
	}
	
</script>

<style>
	/* 进入和离开的过程 */
	.box-enter-active, .box-leave-active {
		transition: opacity 3s;  
	}
	/* 进入初始状态 和 离开的结束状态*/
	.box-enter, .box-leave-to {
		opacity: 0;
	}
	/* 进入的结束状态 和 离开的初始状态 */
	.box-enter-to, .box-leave {
		opacity: 1;
	}
</style>
