<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>      

<jsp:include page="/WEB-INF/views/admin/layout/etcheader.jsp" />

<script type="text/javascript">
$(document).ready(function() {
		
	//삭제버튼 동작
	$("#btnUserDelete").click(function() {
		$("#UserdeleteModal").modal({backdrop: 'static', keyboard: false});
	});
	
	//삭제모달 확인 버튼 눌렀을때
	$("#userDeleteOkBtn").click(function() {
// 		$(location).attr("href", "/board/freedelete?boardno=${board.boardno }");
	});
	
	//승인버튼 동작
	$("#btnPermit").click(function() {
		$("#userPermitModal").modal({backdrop: 'static', keyboard: false});
	});
	
	//승인모달 확인 버튼 눌렀을때
	$("#userPermitOkBtn").click(function() {
// 		$(location).attr("href", "/board/freedelete?boardno=${board.boardno }");
	});
	
	//일반사용자로 강등 버튼 동작
	$("#btnPermitDown").click(function() {
		$("#userPermitDownModal").modal({backdrop: 'static', keyboard: false});
	});
	
	//일반사용자로 강등 확인 버튼 눌렀을때
	$("#userPermitDownBtn").click(function() {
// 		$(location).attr("href", "/board/freedelete?boardno=${board.boardno }");
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

<h2 style="text-align: center; margin-bottom:40px;">사용자 정보</h2>

<div class="container">

	<div style="text-align: right; margin-bottom: 40px;">
		<button id="btnUserDelete" class="btn btn-secondary" >삭제</button>
	</div>	
	
	
	<table class="table table-bordered">
		<tr>
			<td class="info">유저번호</td>
			<td colspan="4" style="width: 45%; padding-top: 16px;">${userinfo.userno }</td>
			<td class="info">아이디</td>
			<td colspan="4" style="width: 45%; padding-top: 16px;">
				<c:choose>
					<c:when test="${userinfo.userid ==  'kakao'}">
						카카오로그인
					</c:when>
					<c:when test="${userinfo.userid == 'naver' }">
						네이버로그인
					</c:when>
					<c:when test="${userinfo.userid == 'google' }">
						구글로그인
					</c:when>
					<c:otherwise>
						${userinfo.userid }
					</c:otherwise>
				</c:choose>
			</td>
		</tr>
		<tr>
			<td class="info">이름</td>
			<td colspan="4" style="width: 25%; padding-top: 16px;">
				${userinfo.username }
			</td>
			<td class="info">닉네임</td>
			<td colspan="4" style="width: 15%; padding-top: 16px;">
			${userinfo.usernick }</td>
		</tr>
		<tr>
			<td class="info">성별</td>
			<td colspan="4" style="width: 25%; padding-top: 16px;">
				<c:choose>
					<c:when test="${userinfo.usergender ==  'kakao'}">
						제공되지 않음
					</c:when>
					<c:when test="${userinfo.usergender == 'naver' }">
						제공되지 않음
					</c:when>
					<c:when test="${userinfo.usergender == 'google' }">
						제공되지 않음
					</c:when>
					<c:otherwise>
						${userinfo.usergender }
					</c:otherwise>
				</c:choose>
			</td>
			<td class="info">전화번호</td>
			<td colspan="4" style="width: 15%; padding-top: 16px;">
				<c:choose>
					<c:when test="${userinfo.userphone ==  'kakao'}">
						제공되지 않음
					</c:when>
					<c:when test="${userinfo.userphone == 'naver' }">
						제공되지 않음
					</c:when>
					<c:when test="${userinfo.userphone == 'google' }">
						제공되지 않음
					</c:when>
					<c:otherwise>
						${userinfo.userphone }
					</c:otherwise>
				</c:choose>
			</td>
		</tr>
		<tr>
			<td class="info">생년월일</td>
			<td colspan="4" style="width: 25%; padding-top: 16px;">
				<c:choose>
					<c:when test="${userinfo.userbirth ==  0}">
						제공되지 않음
					</c:when>
					<c:otherwise>
						${userinfo.userbirth }
					</c:otherwise>
				</c:choose>
			</td>
			<td class="info">관심분야</td>
			<td colspan="4" style="width: 15%; padding-top: 16px;">
				<c:choose>
					<c:when test="${userinfo.interest ==  'kakao'}">
						제공되지 않음
					</c:when>
					<c:when test="${userinfo.interest == 'naver' }">
						제공되지 않음
					</c:when>
					<c:when test="${userinfo.interest == 'google' }">
						제공되지 않음
					</c:when>
					<c:otherwise>
						${userinfo.interest }
					</c:otherwise>
				</c:choose>
			</td>
		</tr>
		<tr style="height: 200px; padding-top: 100px;">
			<td class="info">승인여부</td>
			<td colspan="12" style="width: 25%; padding-top: 16px;">
				<c:choose>
					<c:when test="${userinfo.usertype == 0 }">
					
						<c:if test="${userinfo.permit == 0 }">
							일반사용자로써 예술인 신청을 하지 않음.
						</c:if>
						<c:if test="${userinfo.permit == 1 }">
							예술인으로 신청완료<br><br>
							<button id="btnPermitDown" class="btn btn-dark" >일반사용자로 강등시키기</button>
							<small>일반 사용자로 강등은 해당 사용자의 불필요한 글 배포, 허위사실 유포 등 부적절한 경우에만 사용하시길 바랍니다.</small>
						</c:if>
						<c:if test="${userinfo.permit == 2 }">
							일반사용자이거나 아직 관리자의 승인이 되지 않음<br><br>
							<button id="btnPermit" class="btn btn-dark" >예술인 승인</button>
						</c:if>
						
					</c:when>
					<c:when test="${userinfo.usertype == 5 }">
						해당 사용자의 계정은 소셜계정으로 회원가입한 계정으로 예술인 등업이 불가피한 계정입니다.
					</c:when>
					
					<c:otherwise>
						관리자의 승인을 받아 예술인으로 승인됨<br><br>
						<button id="btnPermitDown" class="btn btn-dark" >일반사용자로 강등</button>
						<small>일반 사용자로 강등은 해당 사용자의 불필요한 글 배포, 허위사실 유포 등 부적절한 경우에만 사용하시길 바랍니다.</small>
					</c:otherwise>
					
				</c:choose>
			</td>
		</tr>
	</table>
                   
</div>
<br>
</div>

<!-- 유저 삭제 모달창 -->
<div class="modal fade" id="UserdeleteModal">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content">

      <!-- Modal Header -->
      <div class="modal-header">
        <h4 class="modal-title">사용자 삭제</h4>
        <button id="inputPwX" type="button" class="close" data-dismiss="modal">&times;</button>
      </div>

      <!-- Modal body -->
      <div class="modal-body content">
      	사용자를 삭제 하시겠습니까?
      </div>

      <!-- Modal footer -->
      <div class="modal-footer">
        <button type="submit" id="userDeleteOkBtn" class="btn btn-dark" style="float: right;" data-dismiss="modal" >확인</button>
        <button type="submit" id="userDeleteCancelBtn" class="btn btn-secondary" style="float: right;" data-dismiss="modal" >취소</button>
      </div>

    </div>
  </div>
</div>

<!-- 유저 승인 모달창 -->
<div class="modal fade" id="userPermitModal">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content">

      <!-- Modal Header -->
      <div class="modal-header">
        <h4 class="modal-title">사용자 승인</h4>
        <button id="inputPwX" type="button" class="close" data-dismiss="modal">&times;</button>
      </div>

      <!-- Modal body -->
      <div class="modal-body content">
      	일반사용자인 ${userinfo.usernick }님이 예술인으로 등업신청하셨습니다.<br>
      	승인하시겠습니까?
      </div>

      <!-- Modal footer -->
      <div class="modal-footer">
        <button type="submit" id="userPermitOkBtn" class="btn btn-dark" style="float: right;" data-dismiss="modal" >확인</button>
        <button type="submit" id="userPermitCancelBtn" class="btn btn-secondary" style="float: right;" data-dismiss="modal" >취소</button>
      </div>

    </div>
  </div>
</div>

<!-- 일반사용자로 강등 모달창 -->
<div class="modal fade" id="userPermitDownModal">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content">

      <!-- Modal Header -->
      <div class="modal-header">
        <h4 class="modal-title">사용자 강등</h4>
        <button id="inputPwX" type="button" class="close" data-dismiss="modal">&times;</button>
      </div>

      <!-- Modal body -->
      <div class="modal-body content">
      	예술인으로 등록되어있는 ${userinfo.usernick }님을 일반사용자로 강등하시겠습니까?
      </div>

      <!-- Modal footer -->
      <div class="modal-footer">
        <button type="submit" id="userPermitDownBtn" class="btn btn-dark" style="float: right;" data-dismiss="modal" >확인</button>
        <button type="submit" class="btn btn-secondary" style="float: right;" data-dismiss="modal" >취소</button>
      </div>

    </div>
  </div>
</div>

<br>
<br>
