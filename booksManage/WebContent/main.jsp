<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>图书管理系统</title>
<style>
	*{margin:0px;padding: 0px}
	body{background: url(./images/loginBg.jpg);
	background-size: 100% 100%;}
	.top {width:100%;height:150px;}
	.top font {font-size: 50px;color: white;}
	.center {width:100%;height:630px;}
	.left{float:left;width:200px;height:100%;border-right:1px dashed black;color:#BCCDD6;border-color: #BCCDD6}
	.left dl{margin-left: 20%}
	.left dd{display:block;}
	.left tr td{line-height: 40px}
	a {text-decoration: none}
	a:link{color:#FA625F;}
	a:visited{color:#FA625F;}
	.right {float:left;display:inline;padding-left:5%;width:60%;height: 100%;}
	.right iframe{width:70%;height:630px;display:inline;position: absolute}
	.bottom{float:right;width:100%;color: #BCCDD6;}
	#particles-js{
	position: absolute;
	top: 0;
	left: 0%;
	width: 100%;
	height: 100%;
	z-index: -1;
	opacity: 0.5;}
</style>
</head>
<body>
	<%
		String name = (String)session.getAttribute("uname");
		String utype = (String)session.getAttribute("utype");
	%>
	<div class="top">
		<br>
		<br>
		<center><font>欢迎 <%= name %> 使用图书管理系统</font></center>
		<hr>
	</div>
	
	<div class="center">
		<div class="left">
			<dl>
				<dt ><b>图书信息管理</b></dt>
				<dd>
					<table>
						<tr>
							<%=("admin".equals(utype))?("<td><a href='addBook.jsp' target='show'>添加图书</a></td>"):""  %>
						</tr>
						<tr>
							<td><a href="queryBookById.jsp" target="show">查找图书</a></td>
						</tr>
						<tr>
							<%=("admin".equals(utype))?("<td><a href='QueryBookByPageServlet?currentPage=1' target='show'>查看所有</a></td>"):""  %>
						</tr>
						<tr>
							<%=("admin".equals(utype))?("<td><a href='borrowBook.jsp' target='show'>借书</a></td>"):""  %>
						</tr>
						<tr>
							<%=("admin".equals(utype))?("<td><a href='userBorrowed_inp.jsp' target='show'>还书</a></td>"):""  %>
						</tr>
						<tr>
							<%=("stu_user".equals(utype))?("<td><a href='ShowAllBooksServlet' target='show'>查看所有</a></td>"):""  %>
						</tr>
						<tr>
							<%=("stu_user".equals(utype))?("<td><a href='QueryBorrowedBookServlet' target='show'>查看已借图书</a></td>"):""  %>
						</tr>
						
						<tr><td> &nbsp; </td></tr>
					</table>
				</dd>
			</dl>
			<%=("admin".equals(utype))?("<dl><dt><b>用户信息管理</b></dt><dd><table><tr><td><a href='delStuUser.jsp' target='show'>注销用户</a></td></tr><tr><td> &nbsp; </td></tr></table></dd></dl>"):"" %>
			
			<dl>
				<dt><b>个人信息管理</b></dt>
				<dd>
					<table>
						<tr>
							<td><a href="updatePwd.jsp" target="show">修改密码</a></td>
						</tr>
						<tr>
							<td><a href="#" onclick="confirmHref()" id="exit">退出系统</a></td>
						</tr>
					</table>
				</dd>
			</dl>
		</div>
		<div class="right">
			<iframe src="" name="show" frameborder="0">
			
			</iframe>
		</div>
	</div>
	<br><br>
	<hr>
	<div class="bottom">
		<center>&copy;hjx</center>
	</div>
	<div id="particles-js"></div>
	
	<script type="text/javascript">
		function confirmHref(){
			var exit=document.getElementById('exit');
			if(window.confirm("您确定要退出系统吗？"))
		    {	
				exit.setAttribute("href","ExitLoginServlet")
				return true;
		    }else{
		    	return false; 
		    }
		}
	
	</script>
	<script type="text/javascript" src="./js/particles.min.js" ></script>
	<script type="text/javascript" src="./js/app.js"></script>
</body>
</html>