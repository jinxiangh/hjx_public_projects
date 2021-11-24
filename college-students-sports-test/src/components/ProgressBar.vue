<template>
	<div class="content">
		<div class="circle" style="left:0">
			<div class="pie_left" ><div class="left" ref="pl" style=""></div></div>
			<div class="pie_right" ><div class="right" ref="pr" style=""></div></div>
			<div class="mask"><span>{{grade}}</span>分</div>
		</div>
	</div>
</template>

<script>
export default{
	name:'ProgressBar',
	props:{
		grade: {
			type: String,
			default: "0"
		},
	},
	data() {
		return {
			num:0
		}
	},
	mounted() {
		this.plt()
	},
	computed:{
		my_grade(){
			return this.grade * 3.6
		}
		
	},
	created() {
		
	},
	methods:{
		plt(){
			this.num = this.my_grade
			console.log("num:"+this.num)
			if (this.num<=180) {
				this.$refs.pr.style.transform = "rotate(" + this.num + "deg)";
			}else if(this.num>=360){
				this.$refs.pr.style.transform = "rotate(180deg)";
				this.$refs.pl.style.transform = "rotate(" + (360 - 180) + "deg)";
			} 
			else {
				this.$refs.pr.style.transform = "rotate(180deg)";
				this.$refs.pl.style.transform = "rotate(" + (this.num - 180) + "deg)";
			}
		}
	}
}

</script>

<style>
	.content{
		
	}
	.circle {
		width: 150px;
		height: 150px;
		position: absolute;
		margin-left: 32%;
		border-radius: 50%;
		background: #ff6739;
	}
	.pie_left, .pie_right {
		width:150px; 
		height:150px;
		position: absolute;
		top: 0;left: 0;
	}
	.left, .right {
		width:150px; 
		height:150px;
		background:#00a1c1;
		border-radius: 50%;
		position: absolute;
		top: 0;
		left: 0;
	}
	.pie_right, .right {
		clip:rect(0,auto,auto,75px);
	}
	.pie_left, .left {
		clip:rect(0,75px,auto,0);
		transition: 1.5s all;
	}
	.mask {
		width: 140px;
		height: 140px;
		border-radius: 50%;
		left: 5px;
		top: 5px;
		background: #FFF;
		position: absolute;
		text-align: center;
		line-height: 140px;
		font-size: 20px;
		font-weight: bold;
		color: #00aacc;
	}
	
</style>
