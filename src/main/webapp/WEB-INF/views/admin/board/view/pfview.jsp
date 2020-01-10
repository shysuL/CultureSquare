<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>

<jsp:include page="/WEB-INF/views/admin/layout/etcheader.jsp" />
<link rel="stylesheet" href="/resources/css/css.css" />
    
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
				</div>
				<div id="view_writer" class="col-xs-12 col-sm-6 col-md-8">
					<div id="writer_nick" class="col-md-4">${writer.usernick }</div>
					<div id="recommendtd">
						<div id="write_date" class="col-md-4">
							${viewpf.writtendate }
							<div id="viewcount">${viewpf.views }</div>
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
								style="width: 725px; padding-bottom: 50px;">
						</c:if>
						<c:if test="${fn:contains(image, '.png')}">
							<img src="/upload/${fn:trim(image)}"
								style="width: 725px; padding-bottom: 50px;">
						</c:if>
						<c:if test="${fn:contains(image, '.JPG')}">
							<img src="/upload/${fn:trim(image)}"
								style="width: 725px; padding-bottom: 50px;">
						</c:if>
						<c:if test="${fn:contains(image, '.PNG')}">
							<img src="/upload/${fn:trim(image)}"
								style="width: 725px; padding-bottom: 50px;">
						</c:if>
					</c:forEach>
					<!-- 내용 보여줌 -->
					${viewpf.contents }
	
					<hr>
					<div class="list-group" id="fileTitle">
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