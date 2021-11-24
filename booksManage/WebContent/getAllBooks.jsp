<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="entity.Book"%>
<%@page import="java.util.ArrayList"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>图书列表</title>
<style type="text/css">
	ul,ol,li{list-style: none;text-align: center;line-height: 35px;}
	ul:nth-child(1){font-size: large;font-weight: 800;}
	ul{width: 80%;height: 35px;margin:10px 0px 0px 0px;border-radius: 25px;background: rgba(255,255,255,0.1);}
	ul:hover{opacity: 1;background: #459fcf;}
	li{float: left;display: inline-block;width: 20%;height: 100%;color:#c6d8e1}
	ul:nth-child(1)>li{color:white}
	a {text-decoration: none;}
	a:link{color:#FA625F;}
	a:visited{color:#FA625F;}
	p{color:#c6d8e1}
</style>
</head>
<% 
	String utype = (String)session.getAttribute("utype"); 
	ArrayList<Book> books = (ArrayList<Book>)request.getAttribute("books") ;
	String flag = (String)request.getAttribute("flag");
	String userName = (String)request.getAttribute("userName");
%>
<body>
	<center>
		<ul>
			<li>编号</li>
			<li>书名</li>
			<li>出版社</li>
			<li>价格</li>
			<%=("admin".equals(utype))?("<li>操作</li>"):""  %>
			
		</ul>
			
		<%
			
			for(Book b:books){
				out.print("<ul>");
				out.print("<li>"+b.getBookid()+"</li>");
				if("admin".equals(utype)){
					out.print("<li><a href='UpdateBookInfoServlet?flag=inp&id="+b.getBookid()+"'>"+b.getBookname()+"</a></li>");
					out.print("<li>"+b.getPublish()+"</li>");
					out.print("<li>"+b.getPrice()+"</li>");
					if("re".equals(flag))
						out.print("<li><a href='QueryUserBorrowedServlet?action_=returnBook&userName="+userName+"&id="+b.getBookid()+"'>[还书]</a></li>");
					else
						out.print("<li><a href='DelBookServlet?id="+b.getBookid()+"'>[删除]</a></li>");
					
				}
				else{
					out.print("<li>"+b.getBookname()+"</li>");
					out.print("<li>"+b.getPublish()+"</li>");
					out.print("<li>"+b.getPrice()+"</li>");
				}
				out.print("</ul>");	
			}
		%>


	
	</center>
</body>
</html>