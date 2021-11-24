<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>修改密码</title>
<link rel="stylesheet" type="text/css" href="./css/mystyle.css" />
</head>
<body>
	<%
		String name= (String)session.getAttribute("uname");
	%>

	<center class="frame">

		<form>
		<div class="inpGroup">
			<input class="onlyread" readonly value=<%= name %> type="text" name="bookid" placeholder="用户名" title="用户名">
		</div><br>
		<div class="inpGroup">
			<input type="password" name="oldPwd" placeholder="原 密 码" title="原 密 码">
		</div><br>
		<div class="inpGroup">
			<input type="password" name="newPwd" placeholder="新 密 码" title="新 密 码">
		</div><br>
		<div class="inpGroup">
			<input type="password" name="newPwd2" placeholder="确 认 密 码" title="确 认 密 码">
		</div><br>
		<input type="button" value="修 改" class="submit" id="sub">
		</form>
	</center>
	
	<script type="text/javascript" src="./js/jquery.min.js"></script>
	<script type="text/javascript">
	$(function(){
		$("#sub").click(function(){
			var newPwd = $("input[name='newPwd']").val();
			var newPwd2 = $("input[name='newPwd2']").val();
			var oldPwd = $("input[name='oldPwd']").val();
			if(oldPwd==""){
				alert("旧密码不可为空！");
			}else if(newPwd==''){
				alert("新密码不可为空！");
			}else if(newPwd!=newPwd2){
				alert("两次密码不一致！");
			}else{
				$.ajax({
					url:"UpdatePwdServlet",
					type:"post",
					dataType:"text",
					data:$("form").serialize(),
					success:function(result)
					{
						if("true"==result){
							alert("密码修改成功！");
							window.location.href = "updatePwd.jsp";
						}else if("false"==result){
							alert("密码修改失败！系统发生错误！");
						}
						else
							alert(result);
					}
				})
			}
		})
		
		
	})
	</script>
</body>

</html>