<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<jsp:include page="/WEB-INF/views/layout/header.jsp" />

<script type="text/javascript">
function checkedAll(){
	// checkbox들
   var $checkboxes=$("input:checkbox[name='checkRow']");

   // checkAll 체크상태 (true:전체선택, false:전체해제)
   var check_status = $("#checkAlls").is(":checked");
   
   if( check_status ) {
      // 전체 체크박스를 checked로 바꾸기
      $checkboxes.each(function() {
         this.checked = true;   
      });
   } else {
      // 전체 체크박스를 checked 해제하기
      $checkboxes.each(function() {
         this.checked = false;   
      });
   }
}
</script>

<style type="text/css">
#writereplylistheader {
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
		<h4 id="writereplylistheader">"${usernick }"님이 쓴 댓글 </h4>
	</div>
</div>

<div class="container" style="margin-top: 50px;">
	<div class="innercon2">
		<div class="src" style="text-align: right;">
			<form action="" method="get">
				<input type="text" name="search" id="search"/>
				<button id="btnSearch" class="btn btn-secondary" style="text-align: right;">검색</button>
			</form>
		</div>
		<br>
		<form action="/mypage/writelist" method="get">
			<table class="table table-hover">
				<thead>
					<tr class = "info" style="text-align: center;" >
						<th style="width: 5%">
							<input type="checkbox" id="checkAlls" name="checkAlls" onclick="checkedAll();"/>
						</th>
						<th style="width: 10%">번호</th>
						<th style="width: 15%">게시판 명</th>
						<th style="width: 15%">제목</th>
						<th style="width: 35%">댓글내용</th>					
						<th style="width: 20%">댓글 작성일</th>
					</tr>
				</thead>
				
				<tbody>
					<c:forEach items="${replylist }" var="replylist">
					<c:if test="${replylist.BOARDNAME == '자유게시판'}">
						<tr onclick="location.href='/board/freeview?boardno=${replylist.BOARDNO }';" style="text-align: center;">
					</c:if>
					<c:if test="${replylist.BOARDNAME == 'PR게시판'}">
						<tr onclick="location.href='/prboard/view?boardno=${replylist.BOARDNO }';" style="text-align: center;">
					</c:if>
					<c:if test="${replylist.BOARDNAME == '예술정보게시판'}">
						<tr onclick="location.href='/artboard/view?boardno=${replylist.BOARDNO }';" style="text-align: center;">
					</c:if>
							<td>
								<input type="checkbox" name="checkRow" id="checkRow" value="${replylist.BOARDNO  }"/>
							</td>
							<td>${replylist.RNUM }</td>
							<td>${replylist.BOARDNAME }</td>
							<td>${replylist.TITLE }</td>
							<td>${replylist.RECONTENTS }</td>
							<td>${replylist.REPLYDATE }</td>
						</tr>
					</c:forEach>
				</tbody>
				
			</table>
			<button class="btn btn-dark">삭제</button>
		</form>
	</div>
	
	<jsp:include page="/WEB-INF/views/layout/mypaging.jsp"/>
</div> <!-- container -->


<jsp:include page="/WEB-INF/views/layout/footer.jsp" />    