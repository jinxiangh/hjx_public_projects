<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css" href="css/mystyle.css" />
<title>查看已借图书</title>
</head>
<body>
	<center class="updateFrame">
		<br><br>
		 <form name="myform" action="QueryUserBorrowedServlet" method="post">
		 	<div class="inpGroup">
		        <span class="">还 书 人:</span>
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
				alert("还 书 人 不可为空！");
			}else{
				$("form").submit();
			}
		})
	})
	</script>
	
</body>
</html>