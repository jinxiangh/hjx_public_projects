<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>条件查找</title>
<link rel="stylesheet" type="text/css" href="css/mystyle.css" />
</head>
<body>
	<center class="updateFrame">
	<h2>条件查找</h2>
	<br><br>
	<form action="QueryBookByIdServlet" method="post">
		<div class="inpGroup">
		<span>
			<select name="condition">
				<option value="bookId" selected>编号
				<option value="bookName">书名
				<option value="publish">出版社
				<option value="price">价格
			</select>
		</span>
			<input type="text" name="data" >
		</div>
	<br>
		<br>
		<br>
		<input type="submit" value="查 找" class="submit">
	</form>
	</center>
</body>
</html>