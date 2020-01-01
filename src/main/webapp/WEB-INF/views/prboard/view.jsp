<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<jsp:include page="../layout/header.jsp" />


<script type="text/javascript">

	$(document).ready(function() {
		//목록버튼 동작
		$("#btnList").click(function() {
			$(location).attr("href", "/prboard/prlist");
		});
		
		//수정버튼 동작
		$("#btnUpdate").click(function() {
			$(location).attr("href", "/prboard/modify?boardno=${viewBoard.boardno }");
		});

		//삭제버튼 동작
		$("#btnDelete").click(function() {
			$(location).attr("href", "/prboard/delete?boardno=${viewBoard.boardno }");
		});
	})
	
</script>

<style type="text/css">
#content {
	width: 95%;
}

@font-face {
	font-family: 'yg-jalnan';
	src:
		url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_four@1.2/JalnanOTF00.woff')
		format('woff');
	font-weight: normal;
	font-style: normal;
}

@font-face {
	font-family: 'YanoljaYacheR';
	src:
		url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_two@1.0/YanoljaYacheR.woff')
		format('woff');
	font-weight: normal;
	font-style: normal;
}

#h3title {
	font-family: '잘난체 폰트', 'Jalnan', yg-jalnan;
	text-align: center;
	padding: 20px;
}

#Title {
	font-family: '잘난체 폰트', 'Jalnan', yg-jalnan;
}

#Content {
	font-family: '야놀자', 'YanoljaYacheR', YanoljaYacheR;
	font-size: 25px;
}
#btnList{
	background-color:#343a40;
}

#fileTitle{
	padding-bottom: 20px;
}
#fileContent{
	background-color:#343a40; 
	color:white;
	font-family: '야놀자', 'YanoljaYacheR', YanoljaYacheR;
	font-size: 25px;
}

}
</style>

<div class="container">

	<h3 id ="h3title">게시글 보기</h3>

	<div>
			<table class="table table-bordered">
				<tr>
					<td class="info" id ="Title">게시글 번호</td>
					<td colspan="4" id="Content">${viewBoard.boardno}</td>
				</tr>
				<tr>
					<td class="info" id ="Title">닉네임</td>
					<td colspan="4" id="Content">${viewBoard.usernick}</td>
				</tr>
				<tr>
					<td class="info" id="Title">유형</td>
					<td colspan="4" id="Content">${viewBoard.prname}</td>
				</tr>
				<tr>
					<td class="info" id="Title">제목</td>
					<td colspan="4" id="Content">${viewBoard.title}</td>
				</tr>
				<tr>
					<td class="info" id ="Title">조회수</td><td id="Content">${viewBoard.views }</td>
					<td class="info" id = "Title">추천수</td><td id="Content">[ 추후 추가 ]</td>
				</tr>
				<tr>
					<td class="info" id = "Title">작성일</td><td colspan="3" id="Content">${viewBoard.writtendate }</td>
				</tr>
				<tr>
					<td colspan="4" class="info" id = "Title">내용</td>
				</tr>
				<tr>
				<td colspan="4" id="Content">
					
				<!-- 이미지 파일인 경우 내용에서 보여줌 -->
					<c:forEach items="${fileList }" var="fileList">
						<c:set var="image" value="${fileList.storedname}" />
						<c:if test="${fn:contains(image, '.jpg')}">
							<img src="/upload/${fn:trim(image)}" style="width: 1080px; padding-bottom: 50px;">
						</c:if>
						<c:if test="${fn:contains(image, '.png')}">
							<img src="/upload/${fn:trim(image)}" style="width: 1080px; padding-bottom: 50px;">
						</c:if>
						<c:if test="${fn:contains(image, '.JPG')}">
							<img src="/upload/${fn:trim(image)}" style="width: 1080px; padding-bottom: 50px;">
						</c:if>
						<c:if test="${fn:contains(image, '.PNG')}">
							<img src="/upload/${fn:trim(image)}" style="width: 1080px; padding-bottom: 50px;">
						</c:if>
					</c:forEach>
					<!-- 내용 보여줌 -->
						${viewBoard.content }
					</td>
				</tr>
			</table>
			<div class="list-group" id="fileTitle">
				  <a class="list-group-item" id="fileContent">
				   첨부파일
				  </a>
				<c:forEach items="${fileList }" var="fileList">
 					<a href="/prboard/download?fileno=${fileList.fileno}" class="list-group-item">${fileList.originname}</a>					
				</c:forEach>
			</div>
	</div>	
	
	<div class="text-center">	
		<button id="btnList" class="btn btn-primary">목록</button>
		<c:if test="${viewBoard.usernick eq usernick}">
			<button id="btnUpdate" class="btn btn-info">수정</button>
			<button id="btnDelete" class="btn btn-danger">삭제</button>
		</c:if>
	</div>
</div>
<!-- 컨테이너 -->

<jsp:include page="../layout/footer.jsp" />