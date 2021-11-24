<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="entity.Page"%>
<%@page import="entity.Book"%>
<%@page import="java.util.ArrayList"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>图书列表</title>
<style type="text/css">
	.data ul,li{list-style: none;text-align: center;line-height: 35px;}
	.data ul:nth-child(1){font-size: large;font-weight: 800;}
	.data ul{width: 80%;height: 35px;margin:0px 0px 10px 0px;border-radius: 25px;background: rgba(255,255,255,0.1);}
	.data ul:hover{opacity: 1;background: #459fcf;}
	.data li{float: left;display: inline-block;width: 20%;height: 100%;color:#c6d8e1}
	.data ul:nth-child(1)>li{color:white}
	
	a {text-decoration: none;}
	a:link{color:#FA625F;}
	a:visited{color:#FA625F;}
	p{color:#c6d8e1}
</style>
</head>

<body>
	<center>
		<div class="data">
		<ul>
			<li>编号</li>
			<li>书名</li>
			<li>出版社</li>
			<li>价格</li>
			<li>操作</li>
		</ul>
			
		<%
			//获取request域中的数据
		 	Page p  = (Page)request.getAttribute("p") ; 
			for(Book b:p.getBooks()){
		%>

		<ul>
			<li><%=b.getBookid() %></li>
			<li><a href="UpdateBookInfoServlet?flag=inp&id=<%=b.getBookid()%>"><%=b.getBookname() %></a></li>
			<li><%=b.getPublish() %></li>
			<li><%=b.getPrice() %></li>
			<li><a href="DelBookServlet?id=<%=b.getBookid()%>">[删除]</a></li>
		</ul>
		<%
			}
		%>
		</div>
	<p>点击书名可修改信息  </p>
	
	
	<p>第<select id="cp">
				<%for(int i=1;i<=p.getTotalPage();i++){ 
					if(i==p.getCurrentPage())
						out.print("<option value="+i+" selected>"+i+"</option>");
					else
						out.print("<option value="+i+">"+i+"</option>");
				}%>
		   </select>
	页,
		每页显示
			<select id="ps">
				<option value="10" <%=(10==p.getPageSize())?"selected":null %>>10</option>
				<option value="15"<%=(15==p.getPageSize())?"selected":null %>>15</option>
				<option value="20"<%=(20==p.getPageSize())?"selected":null %>>20</option>
				<option value="100"<%=(100==p.getPageSize())?"selected":null %>>100</option>
			</select>
		 条,
		共<%=p.getTotalCount() %>条数据
	</p>
	
	<%
		if(p.getCurrentPage() ==p.getTotalPage()){ //尾页
	%>	
			<a href="QueryBookByPageServlet?currentPage=1">首页</a>
			<a href="QueryBookByPageServlet?currentPage=<%=p.getCurrentPage()-1%>    ">上一页</a>
			
	<% 		
		}

		else if(p.getCurrentPage() ==1){//首页
	%>		<a href="QueryBookByPageServlet?currentPage=<%=p.getCurrentPage()+1%> ">下一页</a>
			<a href="QueryBookByPageServlet?currentPage=<%=p.getTotalPage()%>">尾页</a>
	<%		
		}else{//中间
	%>	
				<a href="QueryBookByPageServlet?currentPage=1">首页</a>
				<a href="QueryBookByPageServlet?currentPage=<%=p.getCurrentPage()-1%>">上一页</a>
				<a href="QueryBookByPageServlet?currentPage=<%=p.getCurrentPage()+1%> ">下一页</a>
				<a href="QueryBookByPageServlet?currentPage=<%=p.getTotalPage()%>">尾页</a>
	<%			
		}
	%>

	</center>
	<script type="text/javascript" src="./js/jquery.min.js"></script>
	<script type="text/javascript">
		$("#cp").change(function(){
			window.location.href = "QueryBookByPageServlet?currentPage="+$("#cp").val()+"&pageSize="+$("#ps").val();
		    });
		$("#ps").change(function(){
			window.location.href = "QueryBookByPageServlet?pageSize="+$("#ps").val();
		    });
	</script>
</body>

</html>