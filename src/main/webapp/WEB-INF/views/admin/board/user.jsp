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
					"category" : 6,
				},
				datatype: "html",
				success : function(res){
					console.log(res);
					$("#user").html(res);
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
$(document).ready(function() {
	
	//삭제버튼 동작
	$("#btnUserDelete").click(function() {
		$("#userdeleteModal").modal({backdrop: 'static', keyboard: false});
	});
	
	//삭제모달 확인 버튼 눌렀을때
	$("#UserDeleteCheckBtn").click(function() {
// 		$(location).attr("href", "/admin/board/freedelete?boardno=${board.boardno }");
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
		<h3 style="text-align: center;">사용자</h3>
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
					<tr class = "info" style="text-align: center; background-color: #4b5055; color: #fff;">
						<th style="width: 10%">유저번호</th>
						<th style="width: 15%">이름</th>
						<th style="width: 25%">아이디</th>
						<th style="width: 20%">전화번호</th>					
						<th style="width: 20%">승인여부</th>
						<th style="width: 10%">소셜로그인</th>
					</tr>
				</thead>
				
				<tbody>
					<c:forEach items="${userlist }" var="userlist">
						<tr style="text-align: center;" onclick="location.href='/admin/board/view/userview?userno=${userlist.userno }'">
							<td>${userlist.userno }</td>
							<td>${userlist.username }</td>
							<td>
								<c:choose>
									<c:when test="${userlist.userid == 'kakao'  }">
										카카오로그인
									</c:when>
									<c:when test="${userlist.userid == 'google' }">
										구글로그인
									</c:when>
									<c:when test="${userlist.userid == 'naver' }">
										네이버로그인
									</c:when>
									<c:otherwise>
										${userlist.userid }
									</c:otherwise>
								</c:choose>
							</td>
							<td>
								<c:choose>
									<c:when test="${userlist.userphone == 'kakao'  }">
										제공되지않음 [kakao]
									</c:when>
									<c:when test="${userlist.userphone == 'google' }">
										제공되지않음 [google]
									</c:when>
									<c:when test="${userlist.userphone == 'naver' }">
										제공되지않음 [naver]
									</c:when>
									<c:otherwise>
										${userlist.userphone }
									</c:otherwise>
								</c:choose>
							</td>
							<td>
								<c:choose>
									<c:when test="${userlist.permit == 2 }">
										예술인
									</c:when>
									<c:when test="${userlist.permit == 1 }">
										관리자 승인 필요
									</c:when>
									<c:otherwise>
										일반사용자
									</c:otherwise>
								</c:choose>
							</td>
							<td>${userlist.sociallogin }</td>
						</tr>
					</c:forEach>
				</tbody>
				
			</table>
		</form>
	</div>
	
	<br><br>
	<jsp:include page = "/WEB-INF/views/admin/layout/userpaging.jsp" />
	
</div> <!-- container -->	

<!-- 게시글 삭제 모달창 -->
<div class="modal fade" id="userdeleteModal">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content">

      <!-- Modal Header -->
      <div class="modal-header">
        <h4 class="modal-title">사용자 삭제</h4>
        <button id="inputPwX" type="button" class="close" data-dismiss="modal">&times;</button>
      </div>

      <!-- Modal body -->
      <div class="modal-body content">
      	[ 주의 ] 관리자계정으로 사용자를 삭제하시겠습니까?<br>
      	<small>사용자를 삭제하시면 해당 계정은 사용할 수 없게됩니다.</small>
      	
      </div>

      <!-- Modal footer -->
      <div class="modal-footer">
      	<button id="UserDeleteCheckBtn" class="btn btn-dark" style="float: right;">확인</button>
        <button type="submit" id="freeCancelBtn"class="btn btn-secondary" style="float: right;" data-dismiss="modal" >취소</button>
      </div>

    </div>
  </div>
</div>
