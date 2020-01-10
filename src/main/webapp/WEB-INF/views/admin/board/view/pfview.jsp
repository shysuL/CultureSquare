<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>

<jsp:include page="/WEB-INF/views/admin/layout/etcheader.jsp" />
<link rel="stylesheet" href="/resources/css/css.css" />

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
    
<div class="h2" style="text-align: center;">
	<h2> CALENDAR </h2>
</div>
	<hr>
	<br>
	<div class="row">
		<div class="container container-center">
			<div class="container container-fluid" style="margin-bottom: 50px">
				<div id="view_head" class="col-xs-12 col-sm-6 col-md-8">
					<span>${viewpf.title }</span>
					<small></small>
				</div>
				<div id="view_writer" class="col-xs-12 col-sm-6 col-md-8">
					<div id="recommendtd">
						<div class="col-md-12">
							작성자 : ${writer.usernick }&emsp;&emsp;
							작성날짜 : ${viewpf.writtendate }
							<div style="float: right;">조회수 : ${viewpf.views }</div>
						</div>
					</div>
				</div>
				<!-- 글내용 -->
				<div id=view_content class="col-xs-12 col-sm-6 col-md-8">
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
					<!-- 내용 보여줌 -->
					${viewpf.contents }
	
					<hr>
					<div class="list-group" id="fileTitle" style="margin-bottom: 10px;">
						<a class="list-group-item" id="fileContent"> 첨부파일 </a>
						<c:forEach items="${fileList }" var="fileList">
							<a href="/pfboard/download?fileno=${fileList.fileno}"
								class="list-group-item">${fileList.originname}</a>
						</c:forEach>
					</div>
				</div>
				<!-- 버튼 -->
				<div id="view_buttonarea" class="btn col-md-4" role="group">
	
					<button id="btnDelete" class="btn btn-danger">삭제</button>
				</div>
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