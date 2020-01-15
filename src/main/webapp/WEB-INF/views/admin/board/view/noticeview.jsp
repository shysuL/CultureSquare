<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>      

<jsp:include page="/WEB-INF/views/admin/layout/etcheader.jsp" />

<script type="text/javascript">
$(document).ready(function() {
		
	//수정버튼 동작
	$("#btnUpdate").click(function() {
		$(location).attr("href", "/admin/board/view/noticeupdate?boardno=${notice.boardno }");
	});

	//삭제버튼 동작
	$("#btnDelete").click(function() {
		$("#freedeleteModal").modal({backdrop: 'static', keyboard: false});
	});
	
	//삭제모달 확인 버튼 눌렀을때
	$("#freeDeleteCheckBtn").click(function() {
		$(location).attr("href", "/admin/board/view/userview/delete?boardno=${notice.boardno }");
	});
	
});
</script>

<style type="text/css">
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
  background-position: 0 -78px;
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

.info {
	background-color: #4b5055;
	color: #fff;
}
</style>

<div class="container" style="margin-top: 40px; margin-bottom:40px;">

<h2 style="text-align: center; margin-bottom:40px;">공지사항</h2>

<div class="container">
	<table class="table table-bordered">
		<tr>
			<td class="info">제목</td>
			<td colspan="4" style="width: 45%; padding-top: 16px;">${notice.title }</td>
			<td class="info">작성자</td>
			<td colspan="4" style="width: 45%; padding-top: 16px;">
				[ 관리자 ]
			</td>
		</tr>
		<tr>
			<td class="info">작성일</td>
			<td colspan="4" style="width: 25%; padding-top: 16px;">
				${notice.writtendate }
			</td>
			<td class="info">조회수</td>
			<td colspan="4" style="width: 15%; padding-top: 16px;">
			${notice.views }</td>
		</tr>
		
		<tr>
			<td class="info" colspan="12">본문</td>
		</tr>
		<tr>
			<td colspan="12" style="height: 500px;">${notice.contents }</td>
		</tr>

		<tr>
			<td colspan="12" class="info">첨부파일</td>
		</tr>
		<tr>
			<td colspan="12">
					<c:if test="${empty fileinfo}">
	 					<strong style="padding: 5px;">첨부파일이 없습니다.</strong>
	 				</c:if>	

					<a href="/admin/noticeboard/download?fileno=${fileinfo.fileno}">${fileinfo.originname}</a>
			</td>
		</tr>
</table>
                   
</div>
<br>

	<div style="text-align: center;">
		<button onclick="location.href='/admin/main';" class="btn btn-secondary">메인</button>
		<button id="btnUpdate" class="btn btn-secondary" >수정</button>
		<button id="btnDelete" class="btn btn-secondary" >삭제</button>
	</div>	
</div>


<!-- 게시글 삭제 모달창 -->
<div class="modal fade" id="freedeleteModal">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content">

      <!-- Modal Header -->
      <div class="modal-header">
        <h4 class="modal-title">게시글 삭제</h4>
        <button id="inputPwX" type="button" class="close" data-dismiss="modal">&times;</button>
      </div>

      <!-- Modal body -->
      <div class="modal-body content">
      	게시글을 삭제 하시겠습니까?
      </div>

      <!-- Modal footer -->
      <div class="modal-footer">
      <c:choose>
      	<c:when test="${fileinfo.fileno eq null }">
      	<p onclick="location.href='/admin/board/view/noticeview/delete?boardno=${notice.boardno }';" class="btn btn-dark" >확인</p>
      	</c:when>
      	<c:otherwise>
        <p onclick="location.href='/admin/board/view/noticeview/delete?boardno=${notice.boardno }&fileno=${fileinfo.fileno }';" class="btn btn-dark">확인</p>
      	</c:otherwise>
      </c:choose>
        <button type="submit" id="freeCancelBtn"class="btn btn-secondary" data-dismiss="modal" >취소</button>
      </div>

    </div>
  </div>
</div>

<br>
<br>
