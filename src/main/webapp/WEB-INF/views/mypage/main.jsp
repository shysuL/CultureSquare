<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<jsp:include page="/WEB-INF/views/layout/header.jsp" />

<script type="text/javascript">
$(document).ready(function(){
	
	//예술인 신청을 눌렀을 때
	$("#artistsapply").click(function(){
		$("#pwAuthenticationModal").modal({backdrop: 'static', keyboard: false});
		
		$("#inputPwCheckBtn").click(function(){
			$("#pwAuthenticationModal2").modal({backdrop: 'static', keyboard: false});
		})
	})
});

//--- 비밀번호수정 모달 ---
$(document).ready(function() {
	console.log("비밀번호 ${userinfo.userpw}")
	
	//비밀번호 정규식 - 암호길이 8자 이상 16 이하, 영문숫자특수문자조합
	var pwJ = /^(?=.*[a-zA-Z])(?=.*[^a-zA-Z0-9])(?=.*[0-9]).{8,16}$/;
	var cur_Check = true;
	var pw_Check = true;
	var pw_Check2 = true;
	
	//경고 모달 호출 메서드
    function warningModal(content) {
       $(".modal-contents").text(content);
       $("#defaultModal").modal('show');
       console.log("나는 경고모달창");
    }
	
	$("#updateUserPw").click(function(){
		$("#updateUserPwModal").modal({backdrop: 'static', keyboard: false});
	})
	
	$("#changepw").blur(function(){
		if(pwJ.test($('#changepw').val())){
			console.log("특수문쟈");
			$('#pw_check').text('사용가능한 비밀번호입니다.');
			$('#pw_check').css('color', 'green');
			pw_Check = true;
			
		} else {
			console.log("다시입력");
			$('#pw_check').text('숫자, 문자, 특수문자를 이용해 8~16자리를 입력해주세요. ');
			$('#pw_check').css('color', 'red');
			pw_Check = false;
		}
	});
		
	$("#changepw2").blur(function(){
		
		if(!pwJ.test($('#changepw2').val())){
			$('#pw_check2').text('숫자, 문자, 특수문자를 이용해 8~16자리를 입력해주세요.');
			$('#pw_check2').css('color', 'red');
			pw_Check2 = false;
			
		} else if ($('#changepw').val() != $(this).val()){
			$('#pw_check2').text('비밀번호가 일치하지 않습니다. 다시 입력해주세요.');
			$('#pw_check2').css('color', 'red');
			pw_Check2 = false;
			
		} else {
			$('#pw_check2').text('비밀번호가 일치합니다.');
			$('#pw_check2').css('color', 'green');
			pw_Check2 = true;
		}
	});
	
	
	$("#updatePw").click(function(){

		var userpw = $('#userpw').val();
		var changepw = $('#changepw').val();
		var changepw2 = $('#changepw2').val();
		
		$.ajax({
			type: "post",
			url: "/mypage/curpwCheck",
			data: {"userpw" : userpw},
			datatype: "json",
			success: function(res){
				
				if(!res.lock){ 
					warningModal('현재 비밀번호를 다시 입력해주세요.')
					$("#userpw").focus();
					return false;
				}
			}
		})
		
		//현재 비밀번호 입력
		if(userpw == ""){
			warningModal('현재 비밀번호를 입력해주세요.')
			$("#userpw").focus();
			return false;
		}
		
		//변경할 비밀번호
		if(changepw == ""){
			warningModal('변경할 비밀번호를 입력해주세요.')
			$("#changepw").focus();
			return false;
		}
		
		//변경할 비밀번호 다시 입력
		if(changepw2 == ""){
			warningModal('변경할 비밀번호를 한 번 더 입력해주세요.')
			$("#changepw2").focus();
			return false;
		}
		
		// 변경할 비밀번호와 재확인이 같지 않을 때
		if(userpw == changepw){
	    	warningModal('현재 비밀번호와 다르게 입력하세요');
	    	return false;
		}
       	
		if(changepw != changepw2){
	    	warningModal('변경하실 비밀번호가 일치하지 않습니다');
	    	return false;
		}
		
			$.ajax({
				type: "post",
				url: "/mypage/main",
				data: {"userpw" : userpw, "changepw" : changepw, "changepw2" :changepw2},
				datatype: "json",
				success: function(res){
					
					console.log(res.userInfo)
					
				}
			})

			$("#pwAuthenticationModal3").modal({backdrop: 'static', keyboard: false});
		})
			
});

$(document).ready(function(){
	
	//경고 모달 호출 메서드
    function warningModal1(content) {
       $(".modal-contents").text(content);
       $("#defaultModal2").modal('show');
       console.log("나는 경고모달창2");
    }		
	
// 	var pwdCheck1 = true;
// 	var pwdCheck2 = true;
	
	//회원 탈퇴 모달
	$("#deleteuser").click(function(){
		$("#deleteUserIdModal").modal({backdrop: 'static', keyboard: false});
	})
	
	$("#deleteUserCheckBtn1").click(function(){
		$("#checkUserPwModal").modal({backdrop: 'static', keyboard: false});
// 	})
		$("#deleteUserCheckBtn2").click(function(){
			
			var userpw = $('#pw1').val();
			var userpw2 = $('#pw2').val();
			
			console.log("1")
			console.log(userpw)
			console.log("2")
			console.log(userpw2)
			
			$.ajax({
				type: "post",
				url: "/mypage/deleteuser",
				data: {"userpw" : userpw, "userpw2" : userpw2},
				datatype: "json",
				success: function(res){
					
					console.log("userpw나와")
					console.log(userpw)
					
					if(!res.lock){
						warningModal1('비밀번호를 다시 입력해주세요.')
						$("#pw1").focus();
						return false;
					}
					
// 					$("#pw1").blur(function(){
						
// 						if(userpw != res){
// 							$('#pwdcheck1').text('현재 비밀번호가 올바르지 않습니다.');
// 							$('#pwdcheck1').css('color', 'red');
// 							pwdCheck1 = false;
							
// 						} else if (userpw != userpw2){
// 							$('#pwdcheck2').text('비밀번호가 일치하지 않습니다. 다시 입력해주세요.');
// 							$('#pwdcheck2').css('color', 'red');
// 							pwdCheck1 = false;
							
// 						} else {
// 							$('#pwdcheck2').text('비밀번호가 일치합니다.');
// 							$('#pwdcheck2').css('color', 'green');
// 							pwdCheck1 = true;
// 						}
// 					});
					
					
				}
			})
			
			//현재 비밀번호 입력
			if(pw1 == ""){
				warningModal1('현재 비밀번호를 입력해주세요.')
				$("#pw1").focus();
				return false;
			}
			
			if(pw2 == ""){
				warningModal1('비밀번호 확인을 입력해주세요.')
				$("#pw2").focus();
				return false;
			}
			
			if(pw1 != pw2){
		    	warningModal1('비밀번호가 일치하지 않습니다');
		    	return false;
			}
			
			$("#userdeleteform").submit();
		})
	})
})	

</script>

<script type="text/javascript">

//사용자 사진 업로드
function ajaxFileUpload() {
	
 // 업로드 버튼이 클릭되면 파일 찾기 창을 띄운다.
 jQuery("#ajaxFile").click();
}

function ajaxFileChange() {
 // 파일이 선택되면 업로드를 진행한다.
 ajaxFileTransmit();
}

function ajaxFileTransmit() {
 var form = jQuery("ajaxFrom")[0];
 var formData = new FormData(form);
 formData.append("message", "파일 확인 창 숨기기");
 formData.append("file", jQuery("#ajaxFile")[0].files[0]);

 jQuery.ajax({
       url : "/mypage/main/profile"
     , type : "POST"
     , processData : false
     , contentType : false
     , data : formData
     , dataType : "text"
     , success:function(data) {
     	$("#profileImg").attr("src", "/upload/" + data);
     	$("#headeruserimg").attr("src", "/upload/" + data);
     	console.log(data)
     	
     	FileReload();
     }
 });
}

//새로고침
function FileReload(){
	location.reload();
}
</script>

<script type="text/javascript">

function ajaxFileDelete() {

 $.ajax({
       url : "/mypage/main/photodelete"
     , type : "POST"
     , dataType : "text"
     , success:function(data) {
     	$("#profileImg").attr("src", "/resources/img/userdefaultprofile.png");
     	console.log(data)
     }
 	, error : function (e) {
 		console.log(e);
 	}
 });
}

$(document).ready(function(){
	$("#photodelete").on("click", function(){
		$("#checkUserPhotoModal").modal({backdrop: 'static', keyboard: false});
	})
})

</script>

<style type="text/css">
.inner_con1 {
	float: left;
	width: 45%;
	height: 800px;
	border: 1px solid #ddd;
	box-sizing: border-box;
	margin: 3%;
	padding: 16px;
}

.inner_con2 {
	float: right;
	width: 40%;
	height: 430px;
	padding: 16px;
	margin: 3%;
	border: 1px solid #ddd;
	margin-bottom: 30px;
}

.inner_con3 {
	float: right;
	width: 40%;
	height: 338px;
	padding: 16px;
	margin: 3%;
	border: 1px solid #ddd;
	margin-top: 0;
}

#profileImg{
	width:200px;
	height:200px;
	display: block;
	margin: 0 auto;
}

#mypageheader {
	margin-bottom: 3%; 
	margin-top: 3%; 
	margin-left: 30%;
	margin-right: 30%;
	border: 1px solid #ccc;
	padding-top: 2%;
	padding-bottom: 2%;
}

#myinfoheader {
	text-align: center;
}

.userinformation {
	padding-left: 16%;
	padding-right: 16%;
}

#mypageicon {
	height: 20px;
	width: 20px;
}
#joinName{
    height: 70px;
    text-align: center;
    padding: 1.5%;
    margin-bottom: 5%;
    color: rgba(255,255,255,.75);
    margin-top: 40px;
}
</style>


		
		

<div class="container myPageContainer" id="myPageContainer">
	<div class="container text-center" style="background-color: #343a40!important;">
		<h2 id="joinName">${getUser.usernick } 님의 마이페이지</h2>
	</div>
	<div class="container box" style="margin-bottom: 1%;">
		<!-- 나의 정보 -->
		<div class="inner_con1">
			<ul class="list-group">
				<li style="list-style: none;">
					<h4 id="myinfoheader">나의 프로필</h4>
				</li>
			</ul>
			<hr>
			<!-- 프로필 사진 -->
			<c:choose>
				<c:when test="${getUser.storedname eq null }">
					<p>
						<img id="profileImg" src="/resources/img/userdefaultprofile.png" class="img-responsive img-circle"
							alt="Responsive image">
					</p>
				</c:when>
				<c:otherwise>
					<p>
						<img id="profileImg" src="/upload/${getUser.storedname }"
							class="img-responsive img-circle" alt="Responsive image" style="border-radius: 100px;">
					</p>
				</c:otherwise>
			</c:choose>
			
			<div class="userinformation">
				<p class="font-weight-bold" style="font-size: 17px; text-align: left; margin-left: 5%;">
					이름 : ${getUser.username }
					<c:choose>
						<c:when test="${getUser.usertype == 1}">
							<small>[ 예술인 ]</small>
						</c:when>
						<c:otherwise>
							<small>[ 일반 사용자 ]</small>
						</c:otherwise>
					</c:choose>
				</p>
				<p class="font-weight-bold" style="font-size: 17px; text-align: left; margin-left: 5%;">
					아이디 : ${getUser.userid }
				</p>
				<p class="font-weight-bold" style="font-size: 17px; text-align: left; margin-left: 5%;">
					닉네임 : ${getUser.usernick }
				</p>
				<p class="font-weight-bold" style="font-size: 17px; text-align: left; margin-left: 5%;">
					관심분야 : ${getUser.interest }
				</p>
			</div>
			<button type="button" class="btn btn-outline-dark" style="width: 84%; display: block; margin: 0 auto;"
				onclick="location.href='/mypage/updateform';">
				 개인정보 수정
			</button>
			<br>
			<!-- display:none으로 화면상에서 파일 확인 창을 숨겨둔다 -->
			<input type="file" id="ajaxFile" onChange="ajaxFileChange();" style="display: none;" accept=".jpeg, .jpg, .png" /> 
			<input class="btn btn-outline-dark" type="button" onClick="ajaxFileUpload();"
				value="프로필사진 변경" style="width: 84%; display: block; margin: 0 auto;" />
			<br>
			<!-- <input type="text" id="ajaxFile" onChange="ajaxFileChange();" style="display:none";/> -->
			<input class="btn btn-outline-dark" type="button" id="photodelete"
				value="프로필사진 삭제" style="width: 84%; display: block; margin: 0 auto;" />
<!-- 				onClick="ajaxFileDelete();" -->

			<!-- 비밀번호 수정 -->
			<br>
			<button type="button" class="btn btn-outline-dark" data-toggle="modal" id="updateUserPw" style="width: 84%; display: block; margin: 0 auto;">비밀번호 변경</button>
			
			<form action="/mypage/main" method="post" id="updateForm">	
				<!-- 비밀번호 모달 -->
				<div class="modal fade" id="updateUserPwModal">
					<div class="modal-dialog modal-dialog-centered">
						<div class="modal-content">
	
							<!-- Modal Header -->
							<div class="modal-header">
								<h4 class="modal-title">비밀번호 변경</h4>
								<button id="inputPwX" type="button" class="close"
									data-dismiss="modal">&times;</button>
							</div>
	
							<!-- Modal body -->
							<div class="modal-body content" id="modalBody">
								<input type="hidden" value="${userno }" id="userno" name="userno"/>
								<input type="hidden" value="${userid }" id="userid" name="userid"/>
								
								현재 비밀번호
								<input type="password" name="userpw" id="userpw" placeholder="현재 비밀번호 입력"/><br>
									<div class="check_font" id="cur_check"></div><br>
								변경할 비밀번호
								<input type="password" name="changepw" id="changepw" placeholder="변경할 비밀번호 입력"/><br>
									<div class="check_font" id="pw_check"></div><br>
								비밀번호 확인
								<input type="password" name="changepw2" id="changepw2" placeholder="변경할 비밀번호 재입력"/><br>
									<div class="check_font" id="pw_check2"></div><br>
							</div>
	
							<!-- Modal footer -->
							<div class="modal-footer">
								<button type="button" id="updatePw" class="btn btn-dark" data-dismiss="modal">변경하기</button>
								<button type="button" class="btn btn-danger" data-dismiss="modal">취소</button>
							</div>
	
						</div>
					</div>
				</div>
			</form>
			
			<!--모달창 -->
			<div class="modal fade" id="defaultModal">
				<div class="modal-dialog">
					<div class="modal-content ">
						<div class="modal-header panel-heading">
							<h4 class="modal-title">비밀번호 변경 알림</h4>
						</div>
						<div class="modal-body">
							<p class="modal-contents"></p>
						</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-dark" data-dismiss="modal">확인</button>
						</div>
					</div>
					<!-- /.modal-content -->
				</div>
				<!-- /.modal-dialog -->
			</div>
			<!-- /.modal -->
			
			<!-- 비밀번호 변경 완료를 눌렀을 떄 확인 모달 -->
			<div class="modal fade" id="pwAuthenticationModal3">
			  <div class="modal-dialog modal-dialog-centered">
			    <div class="modal-content">
			
			      <!-- Modal Header -->
			      <div class="modal-header">
			        <h4 class="modal-title">비밀번호 변경 완료</h4>
			      </div>
			
			      <!-- Modal body -->
			      <div class="modal-body content">
			      	비밀번호 변경이 완료되었습니다.
			      </div>
			
			      <!-- Modal footer -->
			      <div class="modal-footer">
			        <button type="button" class="btn btn-secondary" data-dismiss="modal">확인</button>
			      </div>
			
			    </div>
			  </div>
			</div>
						
			<!--모달창 -->
			<div class="modal fade" id="defaultModal2">
				<div class="modal-dialog">
					<div class="modal-content ">
						<div class="modal-header panel-heading">
							<h4 class="modal-title">회원탈퇴 알림</h4>
						</div>
						<div class="modal-body">
							<p class="modal-contents"></p>
						</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-dark" data-dismiss="modal">확인</button>
						</div>
					</div>
					<!-- /.modal-content -->
				</div>
				<!-- /.modal-dialog -->
			</div>
			<!-- /.modal -->


			<br>
			<form action="/mypage/deleteuser" method="post" id="userdeleteform">
				<button type="button" class="btn btn-outline-dark" id="deleteuser" 
						style="width: 84%; display: block; margin: 0 auto;">회원 탈퇴</button>
			</form>
		</div>

		<!-- 활동이력 -->
		<div class="inner_con2">
			<ul class="list-group">
				<li style="list-style: none;">
					<h4 style="text-align: center;">활동이력</h4>
				</li>
			</ul>
			<hr>
			<button type="button" class="btn btn-outline-dark" style="width: 84%; display: block; margin: 0 auto;" 
					onclick="location.href='/mypage/likepost';">
			<img id="mypageicon" src="/resources/img/hand.png"> 
			좋아요한 글
			</button><br>
			<button type="button" class="btn btn-outline-dark" style="width: 84%; display: block; margin: 0 auto;"
					onclick="location.href='/mypage/likeartists';">
			<img id="mypageicon" src="/resources/img/person.png"> 
			팔로우한 예술인
			</button><br>
			<button type="button" class="btn btn-outline-dark" style="width: 84%; display: block; margin: 0 auto;"
					onclick="location.href='/mypage/writelist';">
			<img id="mypageicon" src="/resources/img/note.png">
			내가 쓴 글
			</button><br>
			<button type="button" class="btn btn-outline-dark" style="width: 84%; display: block; margin: 0 auto;"
					onclick="location.href='/mypage/replylist';">
			<img id="mypageicon" src="/resources/img/pencil.png">
			내가 쓴 댓글
			</button><br>
			<button type="button" class="btn btn-outline-dark" style="width: 84%; display: block; margin: 0 auto;"
					onclick="location.href='/mypage/permitslist';">
			<img id="mypageicon" src="/resources/img/handheart.png"> 
			내가 후원한 내역
			</button>
		</div>
		<!-- 예술인 신청 -->
		<div class="inner_con3">
			<ul class="list-group">
				<li style="list-style: none;"> 
					<h4 style="text-align: center;">예술인 신청</h4>
				</li>
			</ul>
			<hr>
			
			<c:if test="${getUser.permit == 0 }">
				<small style="text-align: center; display: block; font-size: initial;">
				<br>예술인으로 신청할 수 있는 버튼입니다.<br>
				일반 사용자가 예술인으로 변경을 원할 시에만 눌러주세요.<br>
				공연, 연극, 버스킹등의 예술분야를 홍보할 수 있는<br>
				CALENDAL게시판 이용이 가능합니다.</small><br><br>
				<button type="submit" class="btn btn-outline-dark" id="artistsapply" 
						style="width: 84%; display: block; margin: 0 auto;">예술인 신청하기</button>
			</c:if>
			<c:if test="${getUser.permit == 1 }">
				<small style="text-align: center; display: block; font-size: initial;">
				<br>이미 신청을 한 후, 관리자의 승인을 기다리는 중입니다.<br>
					조금만 더 기다려주세요 :-)</small>
			</c:if>
			<c:if test="${getUser.permit == 2 }">
				<small style="text-align: center; display: block; font-size: initial;">
				<br>이미 예술인으로 등업이 완료되었습니다.<br></small>
			</c:if>
			
		</div>
		<div style="clear: both;"></div>
	</div>
</div>
<!-- container -->


<!-- 모달 -->
<!-- 예술인으로 신청하기를 눌렀을 떄 모달 -->
<div class="modal fade" id="pwAuthenticationModal">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content">

      <!-- Modal Header -->
      <div class="modal-header">
        <h4 class="modal-title">예술인 신청을 진행하시겠습니까?</h4>
        <button id="inputPwX" type="button" class="close" data-dismiss="modal">&times;</button>
      </div>

      <!-- Modal body -->
      <div class="modal-body content">
		일반 사용자가 예술인으로 변경신청을 했을 경우 관리자의 승인 후 정상적으로 변경됩니다.진행하시겠습니까:-o?
      </div>

      <!-- Modal footer -->
      <div class="modal-footer">
       	<button type="submit" id="inputPwCheckBtn"class="btn btn-dark" data-dismiss="modal">확인</button>
        <button type="button" class="btn btn-danger" data-dismiss="modal">취소</button>
      </div>

    </div>
  </div>
</div>

<!-- 두번째 모달 -->
<div class="modal fade" id="pwAuthenticationModal2">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content">
<!--       Modal Header -->
      <div class="modal-header">
        <h4 class="modal-title">신청완료</h4>
        <button id="inputPwX" type="button" class="close" data-dismiss="modal">&times;</button>
      </div>
<!--       Modal body -->
      <div class="modal-body content">
      	예술인으로 신청이 완료되었습니다.
      	관리자의 승인 후 예술인으로 본 사이트를 이용하실 수 있습니다. 
      	감사합니다 :-)
      </div>
<!--       Modal footer -->
      <div class="modal-footer">
      	<form action="/mypage/main/updateartist" method="post">
        	<button type="submit" class="btn btn-danger">확인</button>
      	</form>
      </div>
    </div>
  </div>
</div>

<!-- 회원탈퇴를 눌렀을 떄 모달 -->
<div class="modal fade" id="deleteUserIdModal">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content">

      <!-- Modal Header -->
      <div class="modal-header">
        <h4 class="modal-title">회원 탈퇴를 진행하시겠습니까?</h4>
        <button id="inputPwX" type="button" class="close" data-dismiss="modal">&times;</button>
      </div>

      <!-- Modal body -->
      <div class="modal-body content">
		회원 탈퇴를 하실 경우, Culture Square의 서비스를 이용하실 수 없습니다 :-(
      </div>

      <!-- Modal footer -->
      <div class="modal-footer">
        <button type="submit" id="deleteUserCheckBtn1"class="btn btn-dark" data-dismiss="modal">확인</button>
        <button type="cancel" class="btn btn-danger" data-dismiss="modal">취소</button>
      </div>

    </div>
  </div>
</div>

<!-- 회원탈퇴를 눌렀을 떄  비밀번호 확인 모달 -->
<div class="modal fade" id="checkUserPwModal">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content">

      <!-- Modal Header -->
      <div class="modal-header">
        <h4 class="modal-title">비밀번호 확인</h4>
        <button id="inputPwX" type="button" class="close" data-dismiss="modal">&times;</button>
      </div>

      <!-- Modal body -->
      <div class="modal-body content">
		비밀번호 : <input type="password" id="pw1" placeholder="현재 비밀번호 입력"/><br>
				<div class="check_font" id="pwdcheck1"></div><br>
		비밀번호 확인 : <input type="password" id="pw2" placeholder="한번 더 입력"/>
				<div class="check_font" id="pwdcheck2"></div><br>
      </div>

      <!-- Modal footer -->
      <div class="modal-footer">
        <button type="submit" id="deleteUserCheckBtn2"class="btn btn-dark" data-dismiss="modal">탈퇴하기</button>
        <button type="cancel" class="btn btn-danger" data-dismiss="modal">탈퇴취소</button>
      </div>

    </div>
  </div>
</div>

<!-- 프로필 사진 삭제를 눌렀을 떄 확인 모달 -->
<div class="modal fade" id="checkUserPhotoModal">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content">

      <!-- Modal Header -->
      <div class="modal-header">
        <h4 class="modal-title">프로필 사진 삭제</h4>
        <button id="inputPwX" type="button" class="close" data-dismiss="modal">&times;</button>
      </div>

      <!-- Modal body -->
      <div class="modal-body content">
      	프로필 사진을 정말 삭제하시겠습니까?<br>
      	삭제 후에 다시 등록 하실 수 있습니다 :-)
      </div>

      <!-- Modal footer -->
      <div class="modal-footer">
        <button type="submit" id="userPhotoDelete" onclick="ajaxFileDelete();" class="btn btn-dark" data-dismiss="modal">삭제하기</button>
        <button type="submit" class="btn btn-secondary" data-dismiss="modal">취소</button>
      </div>

    </div>
  </div>
</div>


<jsp:include page="/WEB-INF/views/layout/footer.jsp" />