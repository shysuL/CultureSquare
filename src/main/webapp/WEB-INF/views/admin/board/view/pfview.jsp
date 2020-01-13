<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>

<jsp:include page="/WEB-INF/views/admin/layout/etcheader.jsp" />
<link rel="stylesheet" href="/resources/css/css.css" />
<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>

<script type="text/javascript">
$(document).ready(function(){
	
	//삭제버튼 동작
	$("#btnDelete").click(function() {
		$("#pfdeleteModal").modal({backdrop: 'static', keyboard: false});
	});	
	//삭제모달 확인 버튼 눌렀을때
	$("#pfDeleteCheckBtn").click(function() {
		$(location).attr("href", "/admin/board/view/pfview/delete?boardno=${viewpf.boardno }");
	});})


</script>

<style type="text/css">
.info {
	background-color: #4b5055;
	color: #fff;
}
</style>
    
<div class="h2" style="text-align: center;">
	<h2 style="margin-top: 40px; margin-bottom: 40px;"> CALENDAR </h2>
</div>
	<div class="row">
		<div class="container container-center">
			<div class="container container-fluid" style="margin-bottom: 50px">
				<table class="table table-bordered">
					<tr>
						<td class="info">제목</td>
						<td colspan="4" style="width: 45%; padding-top: 16px;">
							<c:if test="${writer.usernick == '관리자' }">
								[ 삭제된 게시물 ]
							</c:if>
							${viewpf.title }
						</td>
						<td class="info">작성자</td>
						<td colspan="4" style="width: 45%; padding-top: 16px;">
							${writer.usernick }
						</td>
					</tr>
					<tr>
						<td class="info">작성일</td>
						<td colspan="4" style="width: 25%; padding-top: 16px;">
							${viewpf.writtendate }
						</td>
						<td class="info">조회수</td>
						<td colspan="4" style="width: 15%; padding-top: 16px;">
						${viewpf.views }</td>
					</tr>
					
					<tr>
						<td class="info" colspan="12">본문</td>
					</tr>
					<tr>
						<td id="view_content" colspan="12" style="height: 500px; border: 1px solid #dee2e6;">
						<!-- 이미지 파일인 경우 내용에서 보여줌 -->
							<c:forEach items="${fileList }" var="fileList">
								<c:set var="image" value="${fileList.storedname}" />
								<c:if test="${fn:contains(image, '.jpg')}">
									<img src="/upload/${fn:trim(image)}"
										style="width: 300px; padding-bottom: 50px; margin-top: 20px;">
								</c:if>
								<c:if test="${fn:contains(image, '.png')}">
									<img src="/upload/${fn:trim(image)}"
										style="width: 300px; padding-bottom: 50px;">
								</c:if>
								<c:if test="${fn:contains(image, '.JPG')}">
									<img src="/upload/${fn:trim(image)}"
										style="width: 300px; padding-bottom: 50px;">
								</c:if>
								<c:if test="${fn:contains(image, '.PNG')}">
									<img src="/upload/${fn:trim(image)}"
										style="width: 300px; padding-bottom: 50px;">
								</c:if>
							</c:forEach>
							${viewpf.contents }
						</td>
					</tr>
			
					<tr>
						<td colspan="12" class="info" id="fileContent">첨부파일</td>
					</tr>
					<tr>
						<td colspan="12">
						<c:if test="${empty fileList }">
							 첨부파일이 없습니다.
						</c:if>
						<c:forEach items="${fileList }" var="fileList">
							<a href="/pfboard/download?fileno=${fileList.fileno}" class="list-group-item">${fileList.originname}</a>
						</c:forEach>
						</td>
					</tr>
				</table>

			<div style="text-align: center;">
				<button onclick="location.href='/admin/main';" class="btn btn-secondary">메인</button>
				<button id="btnDelete" class="btn btn-secondary">삭제</button>
			</div>
			
			

			
		<!-- 댓글view -->
		<div  id="commentList" class='container' style='mawrgin-bottom: 40px'>              
	
		</div><!--  댓글 처리 end --> 		
			
		</div>
	</div>
</div>

<!-- 삭제 여부 확인 모달-->
<div class="modal fade" id="pfdeleteModal">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content">

      <!-- Modal Header -->
      <div class="modal-header">
        <h4 class="modal-title">PF 게시글 삭제</h4>
        <button id="inputPwX" type="button" class="close" data-dismiss="modal">&times;</button>
      </div>

      <!-- Modal body -->
      <div class="modal-body content">
     	 정말 게시글을 삭제하시겠습니까?
      </div>

      <!-- Modal footer -->
      <div class="modal-footer">
        <button type="submit" id="pfDeleteCheckBtn"class="btn btn-danger" data-dismiss="modal">확인</button>
      </div>

    </div>
  </div>
</div>