<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<script type="text/javascript">
	$(document).ready(function() {
		$("a[class='page-link']").on("click", function() {
			$.ajax({
				type:"post",
				url: $(this).attr("href"),
				data: {
					"category" : 5,
				},
				datatype: "html",
				success : function(res){
					console.log(res);
					$("#noticeboard").html(res);
				},
				error: function(e){
				console.log(e);
				}
			});
			
			return false;
		});
	});
	
</script>

<div class="container" style="margin-top: 50px;">
	<div class="innercon2">
	<h3 style="text-align: center;">공지사항</h3>
	
	<div style="text-align: right; margin-top: 30px;">
		<button type="button" class="btn btn-secondary" 
				onclick="location.href='/admin/board/noticewrite';">공지사항 작성</button>
	</div>
	
<!-- 		<div class="src" style="text-align: right;"> -->
<!-- 			<form action="" method="get"> -->
<!-- 			<input type="text" name="search" id="search"/> -->
<!-- 			<button id="btnSearch" class="btn btn-secondary" style="text-align: right;">검색</button> -->
<!-- 			</form> -->
<!-- 		</div> -->
		<br>
		<form action="" method="get">
			<table class="table table-hover">
				<thead>
				<tr class="info" style="text-align: center; background-color: #4b5055; color: #fff;">
					<th style="width: 10%">번호</th>
					<th style="width: 50%">제목</th>					
					<th style="width: 15%">작성자</th>
					<th style="width: 20%">작성일</th>
				</tr>
				</thead>
				
				<tbody>
					<c:forEach items="${noticelist }" var="noticelist">
						<tr style="text-align: center;"onclick="location.href='/admin/board/view/noticeview?boardno=${noticelist.boardno }';">
							<td>${noticelist.rnum }</td>
							<td>[ 공지사항 ] ${noticelist.title }</td>
							<td>관리자</td>
							<td>${noticelist.writtendate }</td>
						</tr>
					</c:forEach>
				</tbody>
				
			</table>
		</form>
	</div>
	
	<br><br>
	<jsp:include page = "/WEB-INF/views/admin/layout/nopaging.jsp" />
</div> <!-- container -->    