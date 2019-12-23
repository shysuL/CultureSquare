<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<h1>관리자 로그인 (헤더 푸터 추가 예정)</h1>
<hr>

<form action="/admin/login" method="post">
	아이디 : <input type="text" name="adminid"><br>
	비밀번호 : <input type="password" name="adminpw"><br>
	
	<button type="submit" id="adminlogin">로그인</button>
</form>

</body>
</html>