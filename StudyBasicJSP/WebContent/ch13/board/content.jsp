<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="ch13.board.BoardDBBean" %>
<%@ page import="ch13.board.BoardDataBean" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ include file="../etc/color.jspf" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판 내용보기</title>
<link href="../etc/style.css" rel="stylesheet" type="text/css">
<style>
body {
background: url('../images/3.jpg') no-repeat left top;
background-size: cover;
}
a {
	text-decoration: none;
	
}
/*  a:visited {
	color:white;
}  */
</style>
</head>
<body>

<%
int num = Integer.parseInt(request.getParameter("num"));
String pageNum=request.getParameter("pageNum");

SimpleDateFormat sdf = 
	new SimpleDateFormat("yyyy-MM-dd HH:mm");

try {
	BoardDBBean dbPro = BoardDBBean.getInstance();
	BoardDataBean article = dbPro.getArticle(num);
	int ref=article.getRef();
	int re_step=article.getRe_step();
	int re_level=article.getRe_level();
%>

<p>글내용 보기</p>

<form>
<table>
	<tr height="30">
		<td align="center" width="80" bgcolor="<%=value_c%>">글번호</td>
		<td align="center" width="80"><%=article.getNum() %></td>
		<td align="center" width="80" bgcolor="<%=value_c%>">조회수</td>
		<td align="center" width="260"><%=article.getReadcount() %></td> 
	</tr>
	<tr height="30">
		<td align="center" width="80" bgcolor="<%=value_c%>">작성자</td>
		<td align="center" width="80"><%=article.getWriter() %></td>
		<td align="center" width="80" bgcolor="<%=value_c%>">작성일</td>
		<td align="center" width="260"><%=sdf.format(article.getReg_date()) %></td> 
	</tr>
	<tr height="30">
		<td align="center" width="80" bgcolor="<%=value_c%>">글제목</td>
		<td align="center" width="420" colspan="3">
		<%=article.getSubject() %></td>
	</tr>
	<tr height="30">
		<td align="center" width="80" bgcolor="<%=value_c%>">글내용</td>
		<td align="left" width="420" colspan="3">
			<%-- <textarea cols="70" rows="20"><%=article.getContent()%></textarea> --%>
			<!-- <p style="font-size:15px; font-weight:normal; padding:10px;"> -->
			<%=article.getContent().replaceAll("\r\n", "<br>")%>
		</td>
	</tr>
	<tr height="30">
		<td width="500" colspan="4" bgcolor="<%=value_c %>" align="right">
		<input type="button" value="글수정" 
		onclick="document.location.href='updateForm.jsp?num=<%=article.getNum() %>&pageNum=<%=pageNum %>'">
		&nbsp;&nbsp;&nbsp;&nbsp;
		<input type="button" value="글삭제" 
		onclick="document.location.href='deleteForm.jsp?num=<%=article.getNum() %>&pageNum=<%=pageNum %>'">
		&nbsp;&nbsp;&nbsp;&nbsp;
		<input type="button" value="댓글쓰기" 
		onclick="document.location.href='writeForm.jsp?num=<%=num%>&ref=<%=ref%>&re_step=<%=re_step%>&re_level=<%=re_level%>'">
		&nbsp;&nbsp;&nbsp;&nbsp;
		<input type="button" value="글목록" 
		onclick="document.location.href='list.jsp?pageNum=<%=pageNum%>'">
		</td>
	</tr>
</table>
<%
}catch(Exception e) {}
%>
</form>

</body>
</html>