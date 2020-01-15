<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<jsp:include page="/WEB-INF/views/layout/header.jsp" />    

<style type="text/css">
#permitslistheader {
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
		<h4 id="permitslistheader">${usernick } 님이 후원한 내역 </h4>
	</div>
</div>

<div class="container" style="margin-top: 50px;">
	<div class="innercon2">
		<br>
		<form action="/mypage/likepost" method="get">
			<table class="table table-hover">
				<thead>
					<tr class = "info" style="text-align: center;" >
						<th style="width: 10%">번호</th>
						<th style="width: 35%">후원받은 게시글 제목</th>					
						<th style="width: 15%">후원받은 사람</th>
						<th style="width: 20%">금액</th>
						<th style="width: 20%">후원자</th>
					</tr>
				</thead>
				
				<tbody>
					<c:forEach items="${permitlist }" var="permitlist">
						<tr style="text-align: center;" onclick="location.href='/artboard/view?boardno=${permitlist.BOARDNO }';" >
							<td>${permitlist.RNUM }</td>
							<td>${permitlist.TITLE }</td>
							<td>${permitlist.RECIVE }</td>
							<td>${permitlist.DONPRICE }원</td>
							<td>${permitlist.USERNAME }</td>
						</tr>
					</c:forEach>
				</tbody>
				
			</table>
		</form>
	</div>
	
	<div style="text-align: center; margin-bottom:40px; margin-top:40px;">
		<button type="button" class="btn btn-secondary" onclick="location.href='/mypage/main';">돌아가기</button>
	</div>
	
	<jsp:include page="/WEB-INF/views/layout/mypaging.jsp"/>
</div> <!-- container -->

<jsp:include page="/WEB-INF/views/layout/footer.jsp" />