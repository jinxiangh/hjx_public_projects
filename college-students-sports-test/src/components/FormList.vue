<template>
	<div class="content">
		<div class="grade_board">
			<!-- <ProgressBar :grade="user_grade.grade" v-if="user_grade.grade"></ProgressBar> -->
			<div class="circle" >
				<div class="pie_left" ><div class="left" ref="pl" style=""></div></div>
				<div class="pie_right" ><div class="right" ref="pr" style=""></div></div>
				<div class="mask">
					<transition name="box">
						<span>{{user_grade.grade}}</span>
					</transition>分
				</div>
			</div>
			<div class="btn_div">
				<button type="button" class="mui-btn mui-btn-primary my_btn" @click="to_standard_detail"><span class="mui-icon mui-icon mui-icon mui-icon mui-icon-arrowleft">评分指标</span></button>
				<button type="button" class="mui-btn mui-btn-primary my_btn" @click="to_grade_detail">成绩构成<span class="mui-icon mui-icon mui-icon mui-icon-arrowright"></span></button>
			</div>
		</div>
		<div class="list">
			<div class="item">
				<label>性别：</label>
				<div class="r_input_div">
					<div class="mui-input-row mui-radio mui-left">
						<label>男</label>
						<input name="xb" type="radio" v-model="user.xb" value="男" checked @change="getGradeList">
					</div> 
					<div class="mui-input-row mui-radio mui-left">
						<label>女</label>
						<input name="xb" type="radio" v-model="user.xb" value="女" @change="getGradeList">
					</div> 
				</div>
			</div>
			<div class="item">
				<label>年级：</label>
				<div class="r_input_div">
					<div class="mui-input-row mui-radio mui-left ">
						<label>大一大二</label>
						<input name="nj" type="radio" v-model="user.nj" value="大一大二" checked @change="getGradeList">
					</div> 
					<div class="mui-input-row mui-radio mui-left">
						<label>大三大四</label>
						<input name="nj" type="radio" v-model="user.nj" value="大三大四" @change="getGradeList">
					</div> 
				</div>
			</div>
			<div class="item">
				<label>身高(cm)：</label>
				<div class="r_input_div">
					<div class="mui-input-row mui-input-group">
						<input name="sg" type="number" v-model="user.sg" placeholder="cm" class="myinput"  @blur="getGradeList">
					</div> 
				</div>
			</div>
			<div class="item">
				<label>体重(kg)：</label>
				<div class="r_input_div">
					<div class="mui-input-row  mui-input-group" >
						<input name="tz" type="number" v-model="user.tz"  placeholder="kg"  @blur="getGradeList">
					</div> 
				</div>
			</div>
			<div class="item">
				<label>BMI：</label>
				<div class="r_input_div">
					<div class="mui-input-row  mui-input-group" >
						<input name="bmi" type="number" v-model="user.bmi"  readonly="readonly" @blur="getGradeList">
					</div> 
				</div>
			</div>
			<div class="item">
				<label>肺活量(ml)：</label>
				<div class="r_input_div">
					<div class="mui-input-row mui-input-group">
						<input name="fhl" type="number" v-model="user.fhl" placeholder="ml" @blur="getGradeList">
					</div> 
				</div>
			</div>
			<div class="item">
				<label>立定跳(cm)：</label>
				<div class="r_input_div">
					<div class="mui-input-row mui-input-group">
						<input name="ldt" type="number" v-model="user.ldt" placeholder="cm" @blur="getGradeList">
					</div> 
				</div>
			</div>
			<div class="item">
				<label>体前屈(cm)：</label>
				<div class="r_input_div">
					<div class="mui-input-row mui-input-group">
						<input name="zwtqq" type="number" v-model="user.tqq" placeholder="cm" @blur="getGradeList">
					</div> 
				</div>
			</div>
			<div class="item">
				<label>50米跑(')：</label>
				<div class="r_input_div" @click="popupVisible_wsmp = true">
					<div class="mui-input-row mui-input-group">
						<input name="50mp" type="text" v-model="user.wsmp" placeholder="'" readonly="readonly" >
					</div> 
				</div>
			</div>
			<div class="item">
				<label v-if="user.xb=='男'||user.xb==''">1000米跑(')：</label>
				<label v-if="user.xb=='女'">800米跑(')：</label>
				<div class="r_input_div" @click="popupVisible_ykmp = true">
					<div class="mui-input-row mui-input-group">
						<input name="1000mp" type="text" v-model="user.ykmp" placeholder="'" readonly="readonly">
					</div> 
				</div>
			</div>
			<div class="item">
				<label v-if="user.xb=='男'||user.xb==''">引体向上：</label>
				<label v-if="user.xb=='女'">仰卧起坐：</label>
				<div class="r_input_div">
					<div class="mui-input-row mui-input-group">
						<input name="ytxs" type="number" v-model="user.ytxs" placeholder="个" @blur="getGradeList">
					</div>
				</div>
			</div>
			
		</div>
		<!-- 50米时间选择器 -->
		<mt-popup v-model="popupVisible_wsmp" position="bottom" class="mint-popup " popup-transition="popup-fade" closeOnClickModal="true">
			<mt-picker :slots="wsmp_data"  :visible-item-count="5" :show-toolbar="true"  ref="picker1" value-key="cName">
				<div class="picker-toolbar-title">
					<div class="usi-btn-cancel" @click="popupVisible_wsmp = !popupVisible_wsmp">取消</div>
					<div class="">请选择时间</div>
					<div class="usi-btn-sure" @click="handleConfirm_wsmp">确定</div>
				</div>
			</mt-picker>
		</mt-popup>
		<!-- 1000米时间选择器 -->
		<mt-popup v-model="popupVisible_ykmp" position="bottom" class="mint-popup " popup-transition="popup-fade" closeOnClickModal="true">
			<mt-picker :slots="ykmp_data"  :visible-item-count="5" :show-toolbar="true"  ref="picker2" value-key="cName">
				<div class="picker-toolbar-title">
					<div class="usi-btn-cancel" @click="popupVisible_ykmp = !popupVisible_ykmp">取消</div>
					<div class="">请选择时间</div>
					<div class="usi-btn-sure" @click="handleConfirm_ykmp">确定</div>
				</div>
			</mt-picker>
		</mt-popup>
		
	</div>
</template>

<script>
import tc from "../util/tc.js" 
// import ProgressBar from '@/components/ProgressBar.vue'
import { mapState, mapMutations } from 'vuex';

export default{
	name: 'FormList',
	components: {
		// ProgressBar
	},
	computed:{
		...mapState(["isFirst","user_test_info","user_test_grade"]),
		},
	data() {
		return {
			num:0,
			user:{"xb":"","xm":"","sg":"","tz":"","bmi":"","fhl":"","ldt":"","tqq":"","wsmp":"","wsmp_s":"","wsmp_ss":"","ykmp":"","ykmp_m":"","ykmp_s":"","ytxs":""},
			user_grade:{"bmi":"","fhl":"","ldt":"","tqq":"","wsmp":"","ykmp":"","ytxs":"","grade":"0"},
			popupVisible_wsmp:false,
			popupVisible_ykmp:false,
			wsmp_data: [
				{
					flex: 1,
					values: ['5', '6', '7', '8','7','8','9','10','11','12'],
					className: 'wsmp_data1',
					textAlign: 'center'
				}, {
					divider: true,
					content: '.',
					className: 'wsmp_data2'
				}, {
					flex: 1,
					values: ['0','1', '2', '3', '4', '5', '6', '7', '8', '9', '10'],
					className: 'wsmp_data3',
					textAlign: 'center'
				},
				{
					divider: true,
					content: '秒',
					className: 'wsmp_data4'
				}
			],
			ykmp_data: [
				{
					flex: 1,
					values: ['2', '3', '4', '5', '6', '7', '8'],
					className: 'ykmp_data1',
					textAlign: 'center'
				}, {
					divider: true,
					content: '分',
					className: 'ykmp_data2'
				}, {
					flex: 1,
					values: ['1', '2', '3', '4', '5', '6', '7', '8', '9', '10', '11', '12', '13', '14', '15', '16', '17', '18', '19', '20', '21', '22', '23', '24', '25', '26', '27', '28', '29', '30', '31', '32', '33', '34', '35', '36', '37', '38', '39', '40', '41', '42', '43', '44', '45', '46', '47', '48', '49', '50', '51', '52', '53', '54', '55', '56', '57', '58', '59'],
					className: 'ykmp_data3',
					textAlign: 'center'
				},
				{
					divider: true,
					content: '秒',
					className: 'ykmp_data4'
				}
			]
		}
	},
	created() {
		this.setIsFirst(false);
	},
	mounted() {
		if(!this.isFirst){
			this.user = this.user_test_info;
			this.user_grade = this.user_test_grade;
			this.plt();
		}
	},
	methods: {
		...mapMutations(["setIsFirst","setUserTestInfo","setUserTestGrade"]),
		getBIM(){
			this.user.bmi = tc.getBMI(this.user);
		},
		getGradeList(){
			this.getBIM()
			this.user_grade.bmi = tc.BMIdrade(this.user,this.user.bmi);
			this.user_grade.fhl = tc.lungCapacity(this.user);
			this.user_grade.ldt = tc.standingLongJump(this.user)
			this.user_grade.tqq = tc.zwtqq(this.user)
			this.user_grade.wsmp = tc.fifyMetre(this.user)
			this.user_grade.ykmp = tc.thousandMetre(this.user)
			this.user_grade.ytxs = tc.ytxsOrywqz(this.user)
			if (this.user_grade.ykmp>100)
				this.user_grade.ykmp = 100
			if (this.user_grade.ytxs>100)
				this.user_grade.ytxs = 100
			this.user_grade.grade = tc.check(this.user)
			this.setStateData()
			this.plt()
		},
		setStateData(){
			this.setUserTestInfo(this.user)
			this.setUserTestGrade(this.user_grade)
			
		},
		plt(){
			this.num = this.user_grade.grade * 3.6
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
		},
		handleConfirm_wsmp() {
			let values = this.$refs.picker1.getValues();
			this.user.wsmp_m = values[0];
			this.user.wsmp_s = values[1];
			this.user.wsmp = values[0] + "." + values[1] + "''";
			console.log("wsmp:"+this.user.wsmp);
			this.popupVisible_wsmp = false;
			this.getGradeList()
		},
		handleConfirm_ykmp() {
			let values = this.$refs.picker2.getValues();
			this.user.ykmp_m = values[0];
			this.user.ykmp_s = values[1];
			this.user.ykmp = values[0] + "'" + values[1] + "''";
			console.log(this.user.ykmp);
			this.popupVisible_ykmp = false;
			this.getGradeList()
		},
		to_standard_detail(){
			this.$router.push({path: "/StandardDetail"});
	
		},
		to_grade_detail(){
			this.$router.push({name: "GradeDetail"});
		}
	}
}
</script>

<style>
	body,.content{
		background-color: #FFFFFF;
	}
	.grade_board{
		background-color: #26a2ff;
		width: 100%;
		height: 200px;
	}

	.btn_div{
		margin: 0 10px 0 10px;
		padding-top: 155px;
		display: flex;
		flex-direction: row;
		justify-content: space-between;
		align-items: center;
	}
	.my_btn{
		width: 50%;
		height: 40px;
	}
	.circle {
		width: 150px;
		height: 150px;
		position: absolute;
		left: 50%;
		margin-left: -75px;
		border-radius: 50%;
		background: #00ff00;
		box-shadow:  0px 10px 40px 15px #aaaaff;
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
		background:#8a8acf;
		border-radius: 50%;
		position: absolute;
		top: 0;
		left: 0;
		
	}
	.pie_right, .right {
		clip:rect(0,auto,auto,75px);
		transition: 1.5s all;
	}
	.pie_left, .left {
		clip:rect(0,75px,auto,0);
		transition: 2.0s all;
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
		color: #ff5500;
		box-shadow:  10px 10px 50px 20px #007aff inset;
	}
	.mask span{
		font-size: 50px;
		
	}
	
	.list {
		display: flex;
		flex-direction: column;
		padding-top: 10px;
		padding-left: 10px;
		padding-right: 10px;
	}
	.item {
		display: flex;
		flex-direction: row;
		justify-content: space-between;
		align-items: center;
		height: 40px;
		line-height: 40px;
		border-bottom: 1px solid rgba(230, 230, 230, 1);
		}
	.r_input_div{
		display: flex;
	}
	.mui-input-group {
		color: #007AFF;
		text-align: center;
	}
	
	.mint-popup{
		width: 100%;
	}
	.picker-toolbar-title {
		display: flex;
		flex-direction: row;
		justify-content: space-around;
		align-items: center;
		background-color: #eee;
		height: 44px;
		line-height: 44px;
		font-size: 16px;
	}
	.picker-toolbar-title .usi-btn-cancel,.usi-btn-sure{
		color:#26a2ff;
		font-size: 16px;
	}
</style>
