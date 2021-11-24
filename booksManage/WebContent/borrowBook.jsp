<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css" href="css/mystyle.css" />
<title>借书操作</title>
</head>
<body>
	<center class="updateFrame">

		 <form name="myform">
		 	<div class="inpGroup">
		        <span class="">借 书 人:</span>
		        <input type="text" name="userName" placeholder="userName">
			</div><br>
		 	<div class="inpGroup">
		        <span class="">图书编号 :</span>
		        <input type="text" name="bookId" placeholder="bookId">
			</div><br>
			
			<input type="button" value="提 交" class="submit">
		 </form>
	</center>
	<script src="js/jquery.min.js" ></script>
	<script type="text/javascript">
	$(function(){
		$(":button").click(function(){
			var userName = $("input[name='userName']").val();
			var bookId = $("input[name='bookId']").val();
			if(userName==''){
				alert("借 书 人 不可为空！");
			}
			else if(bookId==''){
				alert("图 书 编 号 不可为空！");
			}else{
				$.ajax({
					url:"BorrowBookServlet",
					type:"post",
					dataType:"text",
					data:$("form").serialize(),
					success:function(result)
					{	
						
						if("true"==result)
						{	
							alert("借书成功！")
							window.location.href = "borrowBook.jsp";
						}
						else
							alert("借书失败,本书已被借走！请检查输入信息是否有误！");
					}
				})
			}
		})
	})
	</script>
	
</body>
</html>