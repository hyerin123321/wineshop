<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<% session.invalidate(); %>  //=>session을 무효화 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
</head>
<body>
<script>
	alert("로그아웃 되었습니다.");
	location.href="shopMain.jsp";
</script>
</body>
</html>