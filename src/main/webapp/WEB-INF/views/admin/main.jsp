<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
<jsp:include page="/WEB-INF/views/admin/layout/header.jsp" />  

<h1>관리자 페이지 메인</h1>

<c:if test="${not empty login }">
	<h5>${adminid }님, 반갑습니다.</h5>
	<button onclick="location.href='/admin/logout';" class="btn btn-info">로그아웃</button>
	<br>
</c:if>


