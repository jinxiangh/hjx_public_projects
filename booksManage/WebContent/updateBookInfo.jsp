<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="entity.Book"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>修改信息</title>
<link rel="stylesheet" type="text/css" href="css/mystyle.css" />
</head>
<body>
	<%
		Book b = (Book)request.getAttribute("book");
	%>
	<center class="updateFrame">

		 <form name="myform">
		 	<div class="inpGroup">
		        <span class="">编 号 :</span>
		        <input type="text" name="bookId" readonly value="<%=b.getBookid() %>">
			</div><br>
		 	<div class="inpGroup">
		        <span class="">书 名 :</span>
		        <input type="text" name="bookName" value="<%=b.getBookname()%>">
			</div><br>
			<div class="inpGroup">
		        <span class="">出 版 社 :</span>
		        <input type="text" name="publish" value="<%=b.getPublish()%>">
			</div><br>
			<div class="inpGroup">
		        <span class="">价 格 :</span>
		        <input type="text" name="price" value="<%=b.getPrice()%>">
			</div><br>
			
			<input type="button" value="修 改" class="submit">
		 </form>
	</center>
	<script src="js/jquery.min.js" ></script>
	<script type="text/javascript">
	$(function(){
		$(":button").click(function(){
			var bookName = $("input[name='bookName']").val();
			var publish = $("input[name='publish']").val();
			var price = $("input[name='price']").val()
			if(bookName==''){
				alert("书 名 不可为空！");
			}
			else if(publish==''){
				alert("出 版 社 不可为空！");
			}else if(price==''){
				alert("价 格 不可为空！");
			}else{
	
				$.ajax({
					url:"UpdateBookInfoServlet",
					type:"post",
					dataType:"text",
					data:$("form").serialize(),
					success:function(result)
					{	
						
						if("true"==result)
						{	
							alert("修改成功！")
							window.location.href = "QueryBookByPageServlet";
						}
						else
							alert("修改失败,系统发生异常！");
					}
				})
			}
		})
	})
	</script>
	
</body>
</html>