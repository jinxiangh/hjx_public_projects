/**
 * Computational results
 * @version 1.0.0
 * @author Ghuilrei [sunyh512@163.com] 
 * @author2 hjx 
 */


//单项得分
const gradeArray = [100,95,90,85,80,78,76,74,72,70,68,66,64,62,60,50,40,30,20,10]
const extraGradeArray = [10,9,8,7,6,5,4,3,2,1]

/**
 * 获取评分标准
 */
const getInFo = function(gender,grade) {
	if (gender == "男") {
		if (grade == "大一大二") {
			// 大一大二男生
			return 1;
		} else {
			// 大三大四男生
			return 2;
		}
	} else {
		if (grade == "大一大二") {
			// 大一大二女生
			return 3;
		} else {
			// 大三大四女生
			return 4;
		}
	}
}

/**
 * BMI计算
 */
const getBMI = function(user) {
	// 身高
	var height = user.sg / 100;
	// 体重
	var weight = user.tz;
	// 如果为空
	if(height == '' || weight == ''){
		return 0;
	}
	// BMI
	var BMI = weight / (height * height);
	return BMI.toFixed(3);
};
// BMI计算分数
const BMIdrade = function(user,BMI){
	var grade;
	switch(getInFo(user.xb,user.nj)) {
		case 1:
		case 2:
			// 男生
			if (BMI <= 17.8) {
				grade = 80;
			} else if (BMI > 17.8 && BMI < 24) {
				grade = 100;
			} else if (BMI >= 24 && BMI < 28) {
				grade = 80;
			} else if (BMI >= 28) {
				grade = 60;
			}
			break;
		case 3:
		case 4:
			// 女生
			if (BMI <= 17.1) {
				grade = 80;
			} else if (BMI > 17.1 && BMI <= 23.9) {
				grade = 100;
			} else if (BMI > 23.9 && BMI <= 27.9) {
				grade = 80;
			} else if (BMI > 27.9) {
				grade = 60;
			}
			break;
	}
	return grade;
};

/**
 * 肺活量计算
 */
const lungCapacity = function (user) {
	var value = user.fhl;
	if(value == ''){
		return 0;
	}
	var standard = [[5040,4920,4800,4550,4300,4180,4060,3940,3820,3700,3580,3460,3340,3220,3100,2940,2780,2620,2460,2300],
					[5140,5020,4900,4650,4400,4280,4160,4040,3920,3800,3680,3560,3440,3320,200,3030,2860,2690,2520,2350],
					[3400,3350,3300,3150,3000,2900,2800,2700,2600,2500,2400,2300,2200,2100,2000,1960,1920,1880,1840,1800],
					[3450,3400,3350,3200,3050,2950,2850,2750,2650,2550,2450,2350,2250,2150,2050,2010,1970,1930,1890,1850]]
	var grade = upCalculateScore(user,value,standard);
	return grade;
}

/**
 * 50米跑计算
 */
const fifyMetre = function(user) {
	var value = user.wsmp_m + "." + user.wsmp_s;
	if(user.wsmp_m == ''){
		return 0;
	}
	var standard = [[6.7,6.8,6.9,7,7.1,7.3,7.5,7.7,7.9,8.1,8.3,8.5,8.7,8.9,9.1,9.3,9.5,9.7,9.9,10.1],
					[6.6,6.7,6.8,6.9,7,7.2,7.4,7.6,7.8,8,8.2,8.4,8.6,8.8,9,9.2,9.4,9.6,9.8,10],
					[7.5,7.6,7.7,8,8.3,8.5,8.7,8.9,9.1,9.3,9.5,9.7,9.9,10.1,10.3,10.5,10.7,10.9,11.1,11.3],
					[7.4,7.5,7.6,7.9,8.2,8.4,8.6,8.8,9,9.2,9.4,9.6,9.8,10,10.2,10.4,10.6,10.8,11,11.2]];
	var grade = downCalculateScore(user,value,standard);
	return grade;
}

/**
 * 立定跳远计算
 */
function standingLongJump(user) {
	var value = user.ldt;
	if(value == ''){
		return 0;
	}
	var standard = [[273,268,263,256,248,244,240,236,232,228,224,220,216,212,208,203,198,193,188,183],
					[275,270,265,258,250,246,242,238,234,230,226,222,218,214,210,205,200,195,190,185],
					[207,201,195,188,181,178,175,172,169,166,163,160,157,154,151,146,141,136,131,126],
					[208,202,196,189,182,179,176,173,170,167,164,161,158,155,152,147,142,137,132,127]]
	var grade = upCalculateScore(user,value, standard);
	return grade;
}

/**
 * 1000米跑计算
 */
const thousandMetre = function (user) {
	var min = user.ykmp_m;
	var sec = user.ykmp_s;
	// 1 * min是将min转为int类型
	var value = 1 * min + 0.01 * sec;
	if(value == 0){
		return 0;
	}
	var standard = [[3.17,3.22,3.27,3.34,3.42,3.47,3.52,3.57,4.02,4.07,4.12,4.17,4.22,4.27,4.32,4.52,5.12,5.32,5.52,6.12],
					[3.15,3.2,3.25,3.32,3.4,3.45,3.5,3.55,4,4.05,4.1,4.15,4.2,4.25,4.3,4.5,5.1,5.3,5.5,6.1],
					[3.18,3.24,3.3,3.37,3.44,3.49,3.54,3.59,4.04,4.09,4.14,4.19,4.24,4.29,4.34,4.44,4.54,5.04,5.14,5.24],
					[3.16,3.22,3.28,3.35,3.42,3.47,3.52,3.57,4.02,4.07,4.12,4.17,4.22,4.27,4.32,4.42,4.52,5.02,5.12,5.22],
					[35,32,29,23,20,16,12,8,4],
					[50,45,40,35,30,25,20,15,10,5]]
	var grade = downCalculateScore(user,value, standard);
	if(grade == 100){
		value = min*60 + sec*1
		grade = ykmpExtraCalculateScore(user,value, standard);
	}	
	return grade;
}

/**
 * 坐位体前屈计算
 */
const zwtqq = function (user) {
	var value = user.tqq
	if(value == 0){
		return 0;
	}
	var standard = [[24.9,23.1,21.3,19.5,17.7,16.3,14.9,13.5,12.1,10.7,9.3,7.9,6.5,5.1,3.7,2.7,1.7,0.7,-0.3,-1.3],
					[25.1,23.3,21.5,19.9,18.2,16.8,15.4,14,12.6,11.2,9.8,8.4,7,5.6,4.2,3.2,2.2,1.2,0.2,-0.8],
					[25.8,24,22.2,20.6,19,17.7,16.4,15.1,13.8,12.5,11.2,9.9,8.6,7.3,6,5.2,4.4,3.6,2.8,2],
					[26.3,24.4,22.4,21,19.5,18.2,16.9,15.6,14.3,13,11.7,10.4,9.1,7.8,6.5,5.7,4.9,4.1,3.3,2.5,]]
	var grade = upCalculateScore(user,value, standard);
	return grade;
}

/**
 * 引体向上或者仰卧起坐计算
 */
const ytxsOrywqz = function (user) {
	var value = user.ytxs
	if(value == 0){
		return 0;
	}
	var standard = [[19,18,17,16,15,15,14,14,13,13,12,12,11,11,10,9,8,7,6,5,],
					[20,19,18,17,16,16,15,15,14,14,13,13,12,12,11,10,9,8,7,6,],
					[56,54,52,49,46,44,42,40,38,36,34,32,30,28,26,24,22,20,18,16,],
					[57,55,53,50,47,45,43,41,39,37,35,33,31,29,27,25,23,21,19,17,],
					[10,9,8,7,6,5,4,3,2,1],
					[13,12,11,10,9,8,7,6,4,2]]

	var grade = upCalculateScore(user,value, standard);
	if (grade==100){
		grade = ytxsExtraCalculateScore(user,value, standard); 
	}
	
	return grade;
}


/**
 * 综合计算
 */
const check = function (user) {
	var a = BMIdrade(user,getBMI(user));
	var b = lungCapacity(user);
	var c = fifyMetre(user);
	var d = standingLongJump(user); 
	var f = thousandMetre(user); //1000m
	var g = zwtqq(user);
	var h = ytxsOrywqz(user);  //
	var f_extra = 0;
	var h_extra = 0;
	if (f>100){
		f_extra = f - 100;
		f = f - f_extra;
	}
	if(h>100){
		h_extra = h - 100;
		h = h - h_extra;
	}
	var grade = (15 * a + 15 * b + 20 * c + 20 * f + 10 * g + 10 * d + 10 * h)/100 + f_extra + h_extra;
	
	return grade.toFixed(1)
}

/* eslint-disable */
/**
 * 计算分数（大到小）
 */
function upCalculateScore(user,value, standard) {
	var grade = 0;
	switch(getInFo(user.xb,user.nj)) {
		case 1:
			// 大一大二男生
			for (var i = 0; i <= 19; i++) {
				if (value >= standard[0][i]) {
					grade = gradeArray[i];
					break;
				}
			}
				break;
		case 2:
			// 大三大四男生
		
			for (var i = 0; i <= 19; i++) {
				if (value >= standard[1][i]) {
					grade = gradeArray[i];
					break;
				}
			}
			
			break;
		case 3:
			//大一大二女
			for (var i = 0; i <= 19; i++) {
				if (value >= standard[2][i]) {
					grade = gradeArray[i];
					break;
				}
			}
			break;
		case 4:
			// 大三大四女生
			for (var i = 0; i <= 19; i++) {
				if (value >= standard[3][i]) {
					grade = gradeArray[i];
					break;
				}
			}
			break;
		default :
			grade = 0;
	}
	// console.log(grade);
	return grade;
}
/**
 * 计算分数（小到大）
 */
function downCalculateScore(user,value, standard) {
	var grade = 0;
	switch(getInFo(user.xb,user.nj)) {
		case 1:
			// 大一大二男生
			for (var i = 0; i <= 19; i++) {
				if (value <= standard[0][i]) {
					grade = gradeArray[i];
					break;
				}
			}
			break;
		case 2:
			// 大三大四男生
			for (var i = 0; i <= 19; i++) {
				if (value <= standard[1][i]) {
					grade = gradeArray[i];
					break;
				}
			}
			break;
		case 3:
			// 大一大二女生
			for (var i = 0; i <= 19; i++) {
				if (value <= standard[2][i]) {
					grade = gradeArray[i];
					break;
				}
			}
			break;
		case 4:
			// 大三大四女生
			for (var i = 0; i <= 19; i++) {
				if (value <= standard[3][i]) {
					grade = gradeArray[i];
					break;
				}
			}
			break;
		default :
			grade = 0;
	}
	// console.log(grade);
	return grade;
}

/**
 * 引体向上或者仰卧起坐的加分计算
 */
const ytxsExtraCalculateScore = function (user,value, standard) {
	var grade = 100;
	switch(getInFo(user.xb,user.nj)) {
		case 1:
			// 大一大二男生
			value = value - 19
			for (var i = 0; i <= 10; i++) {
				if (value >= standard[4][i]) {
					grade = extraGradeArray[i] + 100;
					break;
				}
			}
			break;
		case 2:
			// 大三大四男生
			value = value - 20
			for (var i = 0; i <= 10; i++) {
				if (value >= standard[4][i]) {
					grade = extraGradeArray[i] + 100;
					break;
				}
			}
			
			break;
		case 3:
			//大一大二女
			value = value - 56
			for (var i = 0; i <= 10; i++) {
				if (value >= standard[5][i]) {
					grade = extraGradeArray[i] + 100;
					break;
				}
			}
			break;
		case 4:
			// 大三大四女生
			value = value - 57
			for (var i = 0; i <= 10; i++) {
				if (value >= standard[5][i]) {
					grade = extraGradeArray[i] + 100;
					break;
				}
			}
			break;
		default :
			grade = 100;
	}
	return grade;
}
/**
 * 1000m或800m的加分计算
 */
const ykmpExtraCalculateScore = function (user,value, standard) {
	var grade = 100;
	switch(getInFo(user.xb,user.nj)) {
		case 1:
			// 大一大二男生
			value = 3*60 +17 -value
			for (var i = 0; i <= 10; i++) {
				if (value >= standard[4][i]) {
					grade = extraGradeArray[i] + 100;
					break;
				}
			}
			break;
		case 2:
			// 大三大四男生
			value = 3*60 +15 -value
			for (var i = 0; i <= 10; i++) {
				if (value >= standard[4][i]) {
					grade = extraGradeArray[i] + 100;
					break;
				}
			}
			
			break;
		case 3:
			//大一大二女
			value = 3*60 +18 -value
			for (var i = 0; i <= 10; i++) {
				if (value >= standard[5][i]) {
					grade = extraGradeArray[i] + 100;
					break;
				}
			}
			break;
		case 4:
			// 大三大四女生
			value = 3*60 +16 -value
			for (var i = 0; i <= 10; i++) {
				if (value >= standard[5][i]) {
					grade = extraGradeArray[i] + 100;
					break;
				}
			}
			break;
		default :
			grade = 100;
	}
	return grade;
}


/* eslint-enable */


export default {
	getInFo,
	getBMI,
	BMIdrade,
	lungCapacity,
	fifyMetre,
	standingLongJump,
	thousandMetre,
	zwtqq,
	ytxsOrywqz,
	check,
	upCalculateScore,
	downCalculateScore,
	ytxsExtraCalculateScore,
	ykmpExtraCalculateScore
}