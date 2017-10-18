<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>책분류 메뉴</title>
</head>
<body>

<p>책분류</p>
<br>
<a href="../shopping/list.jsp?book_kind=all">전체목록보기</a></br>
<a href="../shopping/list.jsp?book_kind=100">동남아시아</a></br>
<a href="../shopping/list.jsp?book_kind=200">미국</a></br>
<a href="../shopping/list.jsp?book_kind=300">스페인</a></br>
<a href="../shopping/list.jsp?book_kind=400">유럽</a></br>
<a href="../shopping/list.jsp?book_kind=500">호주</a></br>
<br><br><br>
<%
String buyer = (String) session.getAttribute("id");
if(buyer==null) {
%>
<%} else {%>
<a href="../../ch13/board/list.jsp">게시판 보기</a>
<%} %>
</body>
</html>