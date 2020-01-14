<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<jsp:include page="/WEB-INF/views/layout/header.jsp" />

<style type="text/css">
#writelistsheader {
	margin-bottom: 3%; 
	margin-top: 3%; 
	margin-left: 30%;
	margin-right: 30%;
	border: 1px solid #ccc;
	padding-top: 2%;
	padding-bottom: 2%;
}
</style>

<div class="container">
	<div class="container text-center">
		<h4 id="writelistsheader">${usernick } 님이 쓴 글 </h4>
	</div>
</div>

<div class="container" style="margin-top: 50px;">
	<div class="innercon2">
		<br>
		<form action="/mypage/writelist" method="get">
			<table class="table table-hover">
				<thead>
					<tr class = "info" style="text-align: center;" >
						<th style="width: 10%">번호</th>
						<th style="width: 20%">게시판 명</th>
						<th style="width: 35%">제목</th>					
						<th style="width: 20%">작성일</th>
						<th style="width: 15%">조회수</th>
					</tr>
				</thead>
				
				<tbody>
					<c:forEach items="${writelist }" var="writelist">
					<c:if test="${writelist.BOARDNAME == '자유게시판'}">
						<tr onclick="location.href='/board/freeview?boardno=${writelist.BOARDNO }';" style="text-align: center;">
					</c:if>
					<c:if test="${writelist.BOARDNAME == 'PR게시판'}">
						<tr onclick="location.href='/prboard/view?boardno=${writelist.BOARDNO }';" style="text-align: center;">
					</c:if>
					<c:if test="${writelist.BOARDNAME == '예술정보게시판'}">
						<tr onclick="location.href='/artboard/view?boardno=${writelist.BOARDNO }';" style="text-align: center;">
					</c:if>
							<td>${writelist.RNUM }</td>
							<td>${writelist.BOARDNAME }</td>
							<td>${writelist.TITLE }</td>
							<td>${writelist.WRITTENDATE }</td>
							<td>${writelist.VIEWS }</td>
						</tr>
					</c:forEach>
				</tbody>
				
			</table>
		</form>
	</div>
	
	<jsp:include page="/WEB-INF/views/layout/mypaging.jsp"/>
</div> <!-- container -->

<jsp:include page="/WEB-INF/views/layout/footer.jsp" />    