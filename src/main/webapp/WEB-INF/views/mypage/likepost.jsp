<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<jsp:include page="/WEB-INF/views/layout/header.jsp" />

<style type="text/css">
#likepostheader {
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
		<h4 id="likepostheader">"${usernick }"님이  좋아요한 글</h4>
	</div>
</div>

<div class="container" style="margin-top: 50px;">
	<div class="innercon2">
		<br>
		<form action="/mypage/likepost" method="get">
			<table class="table table-hover">
				<thead>
					<tr class = "info" style="text-align: center;" >
						<th style="width: 5%">번호</th>
						<th style="width: 15%">게시판 명</th>
						<th style="width: 30%">제목</th>					
						<th style="width: 15%">작성자</th>
						<th style="width: 20%">작성일</th>
						<th style="width: 15%">조회수</th>
					</tr>
				</thead>
				
				<tbody>
					<c:forEach items="${likelist }" var="likelist">
					<c:if test="${likelist.BOARDNAME == '자유게시판'}">
						<tr onclick="location.href='/board/freeview?boardno=${likelist.BOARDNO }';" style="text-align: center;">
					</c:if>
					<c:if test="${likelist.BOARDNAME == 'PR게시판'}">
						<tr onclick="location.href='/prboard/view?boardno=${likelist.BOARDNO }';" style="text-align: center;">
					</c:if>
					<c:if test="${likelist.BOARDNAME == '예술정보게시판'}">
						<tr onclick="location.href='/artboard/view?boardno=${likelist.BOARDNO }';" style="text-align: center;">
					</c:if>
							<td>${likelist.RNUM }</td>
							<td>${likelist.BOARDNAME }</td>
							<td>${likelist.TITLE }</td>
							<td>${likelist.USERNICK }</td>
							<td>${likelist.WRITTENDATE }</td>
							<td>${likelist.VIEWS }</td>
						</tr>
					</c:forEach>
				</tbody>
				
			</table>
		</form>
	</div>
	
	<jsp:include page="/WEB-INF/views/layout/mypaging.jsp"/>
</div> <!-- container -->

<jsp:include page="/WEB-INF/views/layout/footer.jsp"/>