<template>
  <div id="app">
	<mt-header fixed :title="$route.meta.title">
		<span slot="left" @click="goBack" v-show="flag">
			<mt-button icon="back">返回</mt-button>
		</span>
	</mt-header>
	<router-view class="r_v"/>
    <!-- <div id="nav">
		<keep-alive>
		<router-link to="/"></router-link>
		</keep-alive> 
    </div> -->
	<nav class="mui-bar mui-bar-tab">
		<router-link  v-if="tap" class="mui-tab-item mui-active" to="/">
			<span class="mui-icon mui-icon-home"></span>
			<span class="mui-tab-label">首页</span>
		</router-link>
		<router-link v-else class="mui-tab-item" to="/" >
			<span class="mui-icon mui-icon-home"></span>
			<span class="mui-tab-label">首页</span>
		</router-link>
		
		<router-link v-if="!tap" class="mui-tab-item mui-active" to="/about">
			<span class="mui-icon mui-icon-person"></span>
			<span class="mui-tab-label">关于</span>
		</router-link>
		<router-link v-else class="mui-tab-item " to="/about">
			<span class="mui-icon mui-icon-person"></span>
			<span class="mui-tab-label">关于</span>
		</router-link>
	</nav>
  </div>
</template>

<script>
export default{
	data() {
		return {
			flag: false,
			tap:true,
		}
	},
	methods:{
		goBack(){
			this.$router.go(-1)
		},
		updata_tap(){
			this.tap = !this.tap
		}
	},
	watch:{
		"$route.path":function(newVal){
			if (newVal === "/" ){
				this.flag = false 
				this.tap = true
			}else if(newVal === "/about"){
				this.tap = false
			}
			else{
				this.flag = true
			}
		}
	}
}
	
</script>

<style>
body{
	background-color: #FFFFFF;
}
#app {
  font-family: Avenir, Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;
}

#nav {';'
  padding: 30px;
}

#nav a {
  font-weight: bold;
  color: #2c3e50;
}

#nav a.router-link-exact-active {
  color: #42b983;
}
.r_v{
	margin-top: 40px;
	margin-bottom: 50px;
}
</style>
