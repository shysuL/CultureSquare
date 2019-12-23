<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>

<jsp:include page="/WEB-INF/views/layout/header.jsp" />  

<h1> 예술 게시판 </h1>
<hr>

<table>
<tr>
<!-- 	<th>번호</th> -->
	<th>제목</th>
	<th>작성날짜</th>
	<th>조회수</th>
	<th>작성자 번호</th>


</tr>
<tr>
<%-- 	<td>${list.boardno }</td> --%>
	<td>${list.title }</td>
	<td>${list.writtendate }</td>
	<td>${list.views }</td>
	<td>${list.userno }</td>
</tr>
</table>

<jsp:include page = "/WEB-INF/views/layout/paging.jsp" />


<jsp:include page="/WEB-INF/views/layout/footer.jsp" />
