<template>
	<div class="content">
		<div class="grade_div">
			<div class="g_d_l">
				总成绩：
				<span v-if="user_test_grade.grade<60" style="color: #FF0000;">{{user_test_grade.grade}} </span>
				<span v-if="60<user_test_grade.grade && user_test_grade.grade<80" style="color: #ffaa00;">{{user_test_grade.grade}} </span>
				<span v-if="user_test_grade.grade>80" style="color: #60d805;">{{user_test_grade.grade}} </span>
				分
			</div>
			<div class="g_d_r" v-if="user_test_grade.grade<60" style="background-color: #FF0000;">{{result}}</div>
			<div class="g_d_r" v-if="60<user_test_grade.grade && user_test_grade.grade<80" style="background-color: #ffaa00;">{{result}}</div>
			<div class="g_d_r" v-if="user_test_grade.grade>80" style="background-color: #60d805;">{{result}}</div>
		</div>
		
		<div class="p_bar_div">
			<mt-progress :value="user_test_grade.grade*1" :bar-height="5"></mt-progress>
		</div>
		<div class="table_div ">
			<table class="">
				<tr class="">
					<th v-for="(th_,index) in th_data" :key="index">{{th_}}</th>
				</tr>
				<tr v-for="(item,index) in table_data" :key="index">
					<td>{{item[0]}}</td>
					<td>{{item[1]}}</td>
					<td>{{item[2]}}</td>
					<td>{{item[3]}}</td>
					<td>{{item[4]}}</td>
					<td v-if="item[5]=='不及格'||item[5]=='肥胖'" style="color: #FF0000;">{{item[5]}}</td>
					<td v-if="item[5]=='及格'||item[5]=='低体重'||item[5]=='超重'" style="color: #ffaa00;">{{item[5]}}</td>
					<td v-if="item[5]=='良好'||item[5]=='优秀'||item[5]=='正常'" style="color: #60d805;">{{item[5]}}</td>
				</tr>
			</table>
		</div>
		<br>
		<p>总成绩 = 各项折算分数总和 + 附加分</p>
	</div>
</template>

<script>
import tj from "../util/tc.js"// eslint-disable-line
import { mapState, mapMutations } from 'vuex';
export default{
	data() {
		return {
			th_data:["单项指标","单项成绩","单项得分","单项占比","折算分数","评级"],
			index_data_boy : {"bmi":"体重指数(BMI)","fhl":"肺活量(毫升)","ldt":"立定跳远(厘米)","tqq":"坐位体前屈(厘米)","wsmp":"50米跑(秒)","ykmp":"1000米跑(分秒)","ytxs":"引体向上(次)"},
			index_data_girl : {"bmi":"体重指数(BMI)","fhl":"肺活量(毫升)","ldt":"立定跳远(厘米)","tqq":"坐位体前屈(厘米)","wsmp":"50米跑(秒)","ykmp":"800米跑(分秒)","ytxs":"仰卧起坐(次)"},
			zbdata:{"bmi":0.15,"fhl":0.15,"ldt":0.1,"tqq":0.1,"wsmp":0.2,"ykmp":0.2,"ytxs":0.1},
			table_data:[[],[],[],[],[],[],[]],
			result:"",
			row : 0
		}
	},
	computed:{
		...mapState(["isFirst","user_test_info","user_test_grade"]),
	},
	mounted() {
		this.getTableData(),
		this.getResult()
	},
	methods: {
		...mapMutations(["setIsFirst","setUserTestInfo","setUserTestGrade"]),
		getTableData(){
			
			for (let key in this.zbdata){
				let row_ = this.row
				if(this.user_test_info.xb=="男")
					this.table_data[row_].push(this.index_data_boy[key]);
				else
					this.table_data[row_].push(this.index_data_girl[key]);
				this.table_data[row_].push(this.user_test_info[key]);
				this.table_data[row_].push(this.user_test_grade[key]);
				this.table_data[row_].push(this.zbdata[key]*100+"%");
				this.table_data[row_].push((this.zbdata[key]*this.user_test_grade[key]).toFixed(1));
				if (key == "bmi"){
					console.log("zxcxzc:"+this.user_test_info[key])
					if (this.user_test_grade[key] == 60 ){
						this.table_data[row_].push("肥胖")
					}else if(24.0<=this.user_test_info[key] && this.user_test_info[key] <28.0){
						this.table_data[row_].push("超重")
					}else if(((17.9<=this.user_test_info[key] && this.user_test_info[key] <23.9) && (this.user_test_info.xb=="男")) || ((17.2<=this.user_test_info[key] && this.user_test_info[key] <23.9) && (this.user_test_info.xb=="女"))){
						this.table_data[row_].push("正常")
					}else{
						this.table_data[row_].push("低体重")
					}
				}else{
					if (this.user_test_grade[key] < 60 ){
						this.table_data[row_].push("不及格")
					}else if(this.user_test_grade[key] <80){
						this.table_data[row_].push("及格")
					}else if(this.user_test_grade[key] <90){
						this.table_data[row_].push("良好")
					}else{
						this.table_data[row_].push("优秀")
					}
				}
				this.row++;
			} 
			console.log(this.table_data)
		},
		getResult(){
			if (this.user_test_grade.grade<60){
				this.result = "不及格"
			}else if(this.user_test_grade.grade<80){
				this.result = "及格"
			}else if(this.user_test_grade.grade<90){
				this.result = "良好"
			}else{
				this.result = "优秀"
			}
		}
		
	}
}
</script>

<style>
	body{
		background-color: #FFFFFF;
	}
	.content{
	}
	.grade_div{
		margin: 0 10px 0 10px;
		height: 60px;
		line-height: 70px;
		display: flex;
		flex-direction: row;
		justify-content: space-between;
		align-items: center;
	}
	.g_d_l{
		font-weight: 600;
	}
	.g_d_l span{
		font-size: 30px;
	}
	.g_d_r{
		width: 70px;
		height: 30px;
		color: #FFFFFF;
		border-radius: 15px;
		line-height: 30px;
	}
	.table_div{
		margin: 10px 10px 0 10px;
	}
	table th, td{border: 1px solid #CCCCCC;}
	th,td{width: 16%;}
	th{
		background-color: #EEEEEE;
		width: ;
	}
	td{
		font-size: smaller
	}
</style>
