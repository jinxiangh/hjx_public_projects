<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>学生用户</title>
<link rel="stylesheet" type="text/css" href="css/mystyle.css" />

</head>
<body>
	<center class="updateFrame">
		<br><br>
		 <form name="myform">
		 	<div class="inpGroup">
		        <span class="">注销账号:</span>
		        <input type="text" name="userName" placeholder="userName">
			</div><br>
			<input type="button" value="提 交" class="submit">
		 </form>
	</center>
	<script src="js/jquery.min.js" ></script>
	<script type="text/javascript">
	$(function(){
		$(":button").click(function(){
			var userName = $("input[name='userName']").val();
			if(userName==''){
				alert("注销账号不可为空！");
			}else{
				$.ajax({
					url:"DelStuUserServlet",
					type:"post",
					dataType:"text",
					data:$("form").serialize(),
					success:function(result)
					{	
						if("true"==result){
							alert("用户信息注销成功！");
							changeTip();
						}
						else if("false"==result)
							alert("用户仍有图书未归还！");
						else
							alert("系统发生错误！");
					}
				})
			}
		})
	})
	</script>
</body>
</html>