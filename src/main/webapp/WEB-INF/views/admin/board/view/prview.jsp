<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<jsp:include page="/WEB-INF/views/admin/layout/etcheader.jsp" />
<link rel="stylesheet" href="/resources/css/css.css" />

<script type="text/javascript">
$(document).ready(function() {
	
	//삭제버튼 동작
	$("#btnDelete").click(function() {
		$("#prdeleteModal").modal({backdrop: 'static', keyboard: false});
	});
	
	//삭제모달 확인 버튼 눌렀을때
	$("#prDeleteCheckBtn").click(function() {
		$(location).attr("href", "/admin/board/view/prview/delete?boardno=${viewpr.boardno }");
	});

})
</script>


<style type="text/css">
.info {
	background-color:#4b5055; 
	color: #fff;
}

#content {
	width: 95%;
}

#h3title {
	text-align: center;
	padding: 20px;
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
}
.commentBox {
	position: relative;
	padding: 5px;
}
.btnBox {
	position: absolute;
	right: 5px;
	bottom: 5px;
}
/*  .commentBox:first-child {  */
/*  	border-top: 1px solid #ccc; */
/*  }  */
.commentBox {
	border-bottom: 1px solid #ccc;
}

.reReplyBox{
	border-bottom: 1px solid #ccc;
	border-top: 1px solid #ccc;
}



/*RereplyBox라는 이름을 id가 포함하는 div 태그*/
div[id*=RereplyBox]{
	border-top: 1px solid;
    border-bottom: 1px solid;
	margin-top: 15px;
    margin-bottom: 10px;
    background-color: rgb(240,240,240);
}

div[class*=reReplyBox]{
	position: relative;
	border-bottom: 1px solid #ccc;
    border-top: 1px solid #ccc;
}

.reReplyDelete{
	position: absolute;
	bottom: 0;
    right: 3px;
}

.reReplyModify{
	  position: absolute;
	  bottom: 0;
	  right: 45px;
}

.RereplyBox {
	min-height: 200px;
}

#replySort{
	padding-left: 3px;
    padding-bottom: 10px;
}

#new{
	 cursor: pointer;
}

#reMost{
	 padding: 20px;
	 cursor: pointer;
}

#best{
	 cursor: pointer;
}

span[class=more] {
  display:block; 
  width: 55px;
  height: 16px;
  background-image:url('https://s.pstatic.net/static/www/img/2017/sp_nav_v170523.png');
  background-position: 0px -78px;
}

span[class=blind] {
  position: absolute;
  overflow: hidden;
  clip: rect(0 0 0 0);
  margin: -1px;
  width: 1px;
  height: 1px;
}

.more:hover, .close:hover {
  cursor:pointer;
}

span[class=close] {
  display:block;
  background-image:url('https://s.pstatic.net/static/www/img/2017/sp_nav_v170523.png');
  width: 42px;
  height: 16px;
  background-position: -166px -78px;
}

.reply{
	display:none;
}

</style>

<div class="container">

	<h3 id ="h3title">PR 게시판</h3>

	<div>
			<table class="table table-bordered">
				<tr>
					<td class="info" id ="Title">게시글 번호</td>
					<td colspan="4" id="Content">${viewpr.boardno}</td>
<!-- 				</tr> -->
<!-- 				<tr> -->
					<td class="info" id ="Title">작성자</td>
					<td colspan="4" id="Content">${viewpr.usernick}</td>
				</tr>
				<tr>
					<td class="info" id="Title">유형</td>
					<td colspan="4" id="Content">${viewpr.prname}</td>
<!-- 				</tr> -->
<!-- 				<tr> -->
					<td class="info" id="Title">제목</td>
					<td colspan="4" id="Content">${viewpr.title}</td>
				</tr>
				<tr>
					<td class="info" id ="Title">조회수</td>
					<td colspan="4"id="Content">${viewpr.views }</td>
<!-- 				</tr> -->
<!-- 				<tr> -->
					<td class="info" id = "Title">작성일</td>
					<td colspan="4" id="Content">${viewpr.writtendate }</td>
				</tr>
				<tr>
					<td colspan="12" class="info" id = "Title">내용</td>
				</tr>
				<tr>
				<td colspan="12" id="Content" style="height: 500px;">
					
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
						${viewpr.content }
					</td>
				</tr>
			</table>
			<div class="list-group" id="fileTitle">
				  <a class="list-group-item" id="fileContent" style="background-color: #4b5055;">
				   첨부파일
				  </a>
				  <c:choose>
					<c:when test="${!empty fileList}">
						<c:forEach items="${fileList }" var="fileList">
							<a href="/prboard/download?fileno=${fileList.fileno}" class="list-group-item">${fileList.originname}</a>
						</c:forEach>
	 				</c:when>	
	 				<c:otherwise>
	 					<p style="padding: 5px;">첨부파일이 없습니다.</p>
	 				</c:otherwise>
 				</c:choose>		
			</div>
	</div>	
</div> <!-- 컨테이너 -->

<div class="container">
	<div id ="replyComment">
	    <span><strong>Comments</strong></span> <span id="cCnt"></span>
	</div>
	<br>
	
	
	
</div>


<div class="container" style ="margin-top: 15px; margin-bottom: 50px;">
	<div class="text-center">	
		<button id="btnDelete" class="btn btn-secondary">삭제</button>
	</div>
</div>


<!-- 삭제 여부 확인 모달-->
<div class="modal fade" id="prdeleteModal">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content">

      <!-- Modal Header -->
      <div class="modal-header">
        <h4 class="modal-title">PR 게시글 삭제</h4>
        <button id="inputPwX" type="button" class="close" data-dismiss="modal">&times;</button>
      </div>

      <!-- Modal body -->
      <div class="modal-body content">
     	 정말 게시글을 삭제하시겠습니까?
      </div>

      <!-- Modal footer -->
      <div class="modal-footer">
        <button type="submit" id="prDeleteCheckBtn"class="btn btn-danger" data-dismiss="modal">확인</button>
      </div>

    </div>
  </div>
</div>
