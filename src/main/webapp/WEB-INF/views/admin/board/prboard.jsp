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
					"category" : 2,
				},
				datatype: "html",
				success : function(res){
					console.log(res);
					$("#prboard").html(res);
				},
				error: function(e){
				console.log(e);
				}
			});
			
			return false;
		});
	});
</script>

<!-- pr게시판 -->
	<div class="container" style="margin-top: 50px;">
		<div class="innercon2">
		<h3 style="text-align: center;">PR BOARD</h3>
<!-- 			<div class="src" style="text-align: right;"> -->
<!-- 				<form action="/admin/main" method="get"> -->
<!-- 					<select name="searchType"  style="padding-top: 4px; padding-bottom: 5px;"> -->
<!-- 						<option value="title">제목</option> -->
<!-- 						<option value="usernick">닉네임</option> -->
<!-- 						<option value="prname">게시판 유형</option> -->
<!-- 					</select> -->
<!-- 					<input type="text" name="search" id="search"/> -->
<!-- 					<button id="btnSearch" class="btn btn-secondary" style="text-align: right;">검색</button> -->
<!-- 				</form> -->
<!-- 			</div> -->
			<br>
			<form action="" method="get">
				<table class="table table-hover">
					<thead> 
						<tr class = "info" style="text-align: center; background-color: #4b5055; color: #fff;" >
<!-- 							<th style="width: 5%"> -->
<!-- 								<input type="checkbox" id="checkAlls" name="checkAlls" onclick="checkedAll();"/> -->
<!-- 							</th> -->
							<th style="width: 10%">번호</th>
							<th style="width: 45%">제목</th>					
							<th style="width: 10%">작성자</th>
							<th style="width: 10%">조회수</th>
							<th style="width: 20%">작성일</th>
						</tr>
					</thead>
					
					<tbody style="text-align: center;">
						<c:forEach items="${prlist }" var="prlist">
<%-- 						/admin/prboard?boardno=${prlist.boardno } --%>
						
							<tr onclick="location.href='/admin/board/view/prview?boardno=${prlist.boardno }';">
<!-- 								<td> -->
<%-- 									<input type="checkbox" name="checkRow" value="${prlist.boardno  }"/> --%>
<!-- 								</td> -->
								<td>${prlist.rnum }</td>
								<td>
									<c:choose>
										<c:when test="${prlist.userno == 0 }">
											삭제된 게시물
										</c:when>
										<c:otherwise>
											${prlist.title }
										</c:otherwise>
									</c:choose>
								</td>
								<td>${prlist.usernick }</td>
								<td>${prlist.views }</td>
								<td>${prlist.writtendate }</td>
							</tr>
						</c:forEach>
					</tbody>
					
				</table>
			</form>
		</div>
		
		<br><br>
		<jsp:include page="/WEB-INF/views/admin/layout/prpaging.jsp"/>
	</div> <!-- container -->
