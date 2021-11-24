<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>添加图书</title>
<link rel="stylesheet" type="text/css" href="./css/mystyle.css" />

	
</head>
<body>
	
	<center class="frame">

		<form >
		<div class="inpGroup">
			<input type="text" name="bookid" placeholder="编 号" title="编 号">
		</div><br>
		<div class="inpGroup">
			<input type="text" name="bookname" placeholder="书 名" title="书 名">
		</div><br>
		<div class="inpGroup">
			<input type="text" name="publish" placeholder="出 版 社" title="出 版 社">
		</div><br>
		<div class="inpGroup">
			<input type="text" name="price" placeholder="价 格" title="价 格">
		</div><br>
		
		<input type="button" value="添 加" class="submit">
		</form>
	</center>
	<script src="js/jquery.min.js" ></script>
	<script type="text/javascript">
	$(function(){
		$(":button").click(function(){
			var bookid = $("input[name='bookid']").val();
			var bookName = $("input[name='bookName']").val();
			var publish = $("input[name='publish']").val();
			var price = $("input[name='price']").val()
			if(bookid ==''){
				alert("编 号 不可为空！");
			}else if(bookName==''){
				alert("书 名 不可为空！");
			}else if(publish==''){
				alert("出 版 社 不可为空！");
			}else if(price==''){
				alert("价 格 不可为空！");
			}else{
				alert($("form").serialize())
				$.ajax({
					url:"AddBookServlet",
					type:"post",
					dataType:"text",
					data:$("form").serialize(),
					success:function(result)
					{	
						
						if("true"==result)
							{
							alert("添加成功！");
							window.location.href = "QueryBookByPageServlet";
							}
						else
							alert("添加失败,系统发生异常！");
					}
				})
			}
		})
	})
	</script>
</body>

</html>