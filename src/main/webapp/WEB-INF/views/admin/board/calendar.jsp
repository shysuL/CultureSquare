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
					"category" : 3,
				},
				datatype: "html",
				success : function(res){
					console.log(res);
					$("#artboard").html(res);
				},
				error: function(e){
				console.log(e);
				}
			});
			
			return false;
		});
	});
	
</script>

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

    <div class="container" style="margin-top: 50px;">
			<div class="innercon2">
				<div class="src" style="text-align: right;">
					<form action="" method="get">
					<input type="text" name="search" id="search"/>
					<button id="btnSearch" class="btn btn-secondary" style="text-align: right;">검색</button>
					</form>
				</div>
				<br>
				<form action="" method="get">
					<table class="table table-hover">
						<thead>
							<tr class = "info" style="text-align: center;" >
								<th style="width: 5%">
									<input type="checkbox" id="checkAlls" name="checkAlls" onclick="checkedAll();"/>
								</th>
								<th style="width: 10%">번호</th>
								<th style="width: 10%">분야</th>					
								<th style="width: 35%">제목</th>					
								<th style="width: 15%">날짜</th>
								<th style="width: 15%">작성자번호</th>
								<th style="width: 10%">조회수</th>
							</tr>
						</thead>
						
						<tbody>
							<c:forEach items="${pflist }" var="pflist">
<%-- 							onclick="location.href='/admin/pfboard?boardno=${pflist.boardno }';" --%>
								<tr onclick="location.href='/artboard/view?boardno=${pflist.boardno}';" style="text-align: center;">
									<td>
										<input type="checkbox" name="checkRow" id="checkRow" value="${pflist.boardno  }"/>
									</td>
									<td>${pflist.rnum }</td>
									<td>${pflist.performname }</td>
									<td>${pflist.title }</td>
									<td>${pflist.performdate }</td>
									<td>${pflist.userno }</td>
									<td>${pflist.views }</td>
								</tr>
							</c:forEach>
						</tbody>
						
					</table>
					<button class="btn btn-secondary">삭제</button>
				</form>
			</div>
			
			<jsp:include page = "/WEB-INF/views/admin/layout/pfpaging.jsp" />
		</div> <!-- container -->