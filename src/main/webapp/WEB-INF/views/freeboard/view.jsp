<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>      
<jsp:include page="/WEB-INF/views/layout/header.jsp"/> 

<script type="text/javascript">
$(document).ready(function() {
	//목록버튼 동작
	$("#btnList").click(function() {
		$(location).attr("href", "/freeboard/list");
	});
	
// 	//수정버튼 동작
// 	$("#btnUpdate").click(function() {
// 		$(location).attr("href", "/board/update")
// 	});

	//삭제버튼 동작
// 	$("#btnDelete").click(function() {
// 		$(location).attr("href", "/board/delete?boardno=?%{}")
// 	});
	
});
</script>

<div class="container" style="
    padding-left: 200px;
    padding-right: 200px;
">

<h1></h1>
<hr>
<h2>자유게시판</h2>

<div class="container">
	<table class="table table-bordered">
		<tr>
<!-- 			<td class="info">글번호</td> -->
<%-- 			<td colspan="4">${board.boardno }</td> --%>
		</tr>
	
		<tr>
<!-- 			<td class="info">제목</td> -->
			<td style="background-color: #343a40; color: #fff;" colspan="4">${board.title }</td>
		</tr>
	
		<tr>
<!-- 			<td class="info">닉네임</td> -->
<%-- 			<td>${board.usernick }</td> --%>
		</tr>
	
		<tr>
			<!-- <td class="info">닉네임</td> -->
			<td colspan="2" style="width: 60%"><i class="far fa-user" style="padding-right: 10px"></i>${board.usernick }</td>
			<td colspan="1" style="width: 25%"><i class="far fa-clock" style="padding-right: 10px"></i>${board.writtendate }</td>
<!-- 			<td class="info">추천수</td> -->
<!-- 			<td colspan="1" style="width: 15%">[ 1203 ]</td> -->
<!-- 			<td class="info">조회수</td> -->
			<td colspan="1" style="width: 15%"><i class="fas fa-eye" style="padding-right: 5px; width: 3.125em;"></i>${board.views }</td>
		</tr>
	
		<tr>
<%-- 			<td class="info">작성일</td><td colspan="3">${board.writtendate }</td> --%>
		</tr>
	
<!-- 		<tr><td class="info"  colspan="4">본문</td></tr> -->
	
		<tr><td colspan="4">${board.contents }</td></tr>

</table>	
	<div class="text-center" >
		<button id="btnList" class="btn btn-default" style="float: left; background-color: #343a40; color: white;">목록</button>
<%-- 		<c:if test="${loginid eq board.userid}">  --%>
<%-- 		<a class="btn btn-default" href="/board/update?boardno=${board.boardno }" role="button">수정</a> --%>
<%-- 		<a class="btn btn-default" href="/board/delete?boardno=${board.boardno }" role="button">삭제</a> --%>
<%-- 		</c:if> --%>
	</div>	
</div>
</div>

<jsp:include page="/WEB-INF/views/layout/footer.jsp"/> 
