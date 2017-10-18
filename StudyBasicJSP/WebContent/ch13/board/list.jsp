<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="ch13.board.BoardDBBean" %>
<%@ page import="ch13.board.BoardDataBean" %>
<%@ page import="java.util.List" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ include file="../etc/color.jspf" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판</title>
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
<body bgcolor="<%=bodyback_c%>">

<%!
int pageSize = 10;
SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
%>

<%
	String pageNum = request.getParameter("pageNum");

	if(pageNum == null) {
		pageNum = "1";
	}

	int currentPage = Integer.parseInt(pageNum);              // 현재 페이지 번호
	int startRow = (currentPage-1)* pageSize + 1;             // 현재 페이지의 시작 번호
	int endRow = currentPage * pageSize;              // 현재 페이지의 끝 번호
	int count = 0;                                    // 전체 글 수
	int number = 0;
	List<BoardDataBean> articleList = null;
	
	BoardDBBean dbPro = BoardDBBean.getInstance();
	count = dbPro.getArticleCount();
	
	if(count>0) {
		articleList = dbPro.getArticles(startRow, endRow);
	}
	
	number = count-(currentPage-1)*pageSize;
%>

<h2>책 서평 커뮤니티 게시판</h2>
<p>글목록(전체 글:<%=count%>)</p>

<table>
	<tr>
		<td align="right" bgcolor="<%=value_c%>">
			<a href="../board/writeForm.jsp">글쓰기</a>
		</td>
	</tr>
</table>

<% if(count==0){ %>

<table>
<tr>
	<td align="center">
	게시판에 저장된 글이 없습니다.
	</td>
</table>
<% } else { %>

<table>
	<tr height="30" bgcolor="<%=value_c %>">
		<td width ="50" align="center">번 호</td>
		<td width ="250" align="center">제 목</td>
		<td width ="100" align="center">작성자</td>
		<td width ="150" align="center">작성일</td>
		<td width ="50" align="center">조 회</td>
		<td width ="100" align="center">IP</td>
	</tr>
<%
	for(int i=0; i<articleList.size(); i++) {
		BoardDataBean article = articleList.get(i);
%>
	<tr height="30">
	<td width="50"><%=number-- %></td>
	<td width="250" align="left">
<%
	int wid=0;
	if(article.getRe_level()>0) {
		wid=5*(article.getRe_level());
%>
	<img src="../images/level.png" width="<%=wid%>" height="16">
	<img src="../images/re.png">
<% } else { %>
	<%-- <img src="../images/level.png" width="<%=wid%>" height="16"> --%>
<% } %>
	
<a href="content.jsp?num=<%=article.getNum()%>&pageNum=<%=currentPage %>">
<%=article.getSubject() %></a>
<% if(article.getReadcount()>=10){%>
		<img src="../images/hot.png" border="0" height="16"><% } %></td>
		<td width="100" align="left">
			<a href="mailto:<%=article.getEmail()%>">
				<%=article.getWriter() %></a></td>
		<td width="150"><%=sdf.format(article.getReg_date()) %></td>
		<td width="50"><%=article.getReadcount()%></td>
		<td width="150"><%=article.getIp() %></td>
		</tr>
	<%}%>
</table>
<% } %>

<%
	if(count>0) {
		// 전체 페이지 수, 전체 글이 125건이면 13
		int pageCount = count / pageSize + (count%pageSize == 0 ? 0 :1);
		int startPage = 1;
		
		// 시작페이지 설정, pageBlock이 10이면, 1, 11, 21
		if(currentPage % 10 != 0)
			startPage = (int)(currentPage/10)*10+1;
		else 
			startPage = ((int)(currentPage/10)-1)*10 + 1;
		
		int pageBlock = 10; // 한 페이지에 나타낼 페이지 수
		int endPage = startPage + pageBlock - 1; // 한 페이지에 나타낼 마지막 페이지 번호
		
		// pageCount가 13이면, 마지막 페이지는 20이 아니라 13이 되게끔 함.
		if(endPage > pageCount) 
			endPage = pageCount;
		
		// 시작페이지가 10보다 크면 [이전]이 나타나게 함
		if(startPage > 10) { %>
		<b><a href="list.jsp?pageNum=<%=startPage - 10%>">[이전]</a></b>
<% 	}
		// 페이지 번호를 출력
		for(int i=startPage; i <= endPage; i++) { %>
			<font color="red"><b><a href="list.jsp?pageNum=<%=i%>">[<%=i %>]</a></b></font>
<%	}
		// 마지막 페이지가 pageCount보다 작다면 나타나게끔 함
		if(endPage < pageCount) { %>
		<b><a href="list.jsp?pageNum=<%=startPage + 10%>">[다음]</a></b>

<%
		}
	}

%>
		
	
</body>
</html>