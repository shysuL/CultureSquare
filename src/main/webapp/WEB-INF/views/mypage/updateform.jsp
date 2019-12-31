<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="/WEB-INF/views/layout/header.jsp" />  

<script type="text/javascript">

//닉네임 정규식
var nickJ = /^[0-9a-zA-Z가-힣]{2,12}$/;
//휴대폰 번호 정규식
var phoneJ = /^01([0|1|6|7|8|9]?)?([0-9]{3,4})?([0-9]{4})$/;

$(document).ready(function(){
	//정규식 검사 변수
	var nick_Check = true;
	var phone_Check = true;
	
	$("#updatesuccess").click(function(){ 
		//닉네임 검사
		if(!nick_Check || $('#usernick').val() == ""){
			$(".content").text('닉네임을 확인해주세요.');
			$("#NickAuthenticationModal").modal({backdrop: 'static', keyboard: false});
			$("#usernick").focus();
	
			return false;
			
		//핸드폰 번호 검사
		} else if(!phone_Check ||  $('#usernick').val() == ""){
			$(".content").text('핸드폰 번호를 확인해주세요.');
			$("#PhoneAuthenticationModal").modal({backdrop: 'static', keyboard: false});
			$("#userphone").focus();
			
			return false;
		} 		
		
	})
	
	
	// 닉네임 중복 검사 ( AJAX )
	$('#usernick').blur(function(){
	
		var usernick = $('#usernick').val();
		$.ajax({
			url : "/mypage/usernickCheck",
			type : 'post',
			data: {"usernick" : usernick},
			datatype:"json",
			success : function(res){
				console.log(res.nickCheck);
				if(res.nickCheck == 1){
					$('#nick_check').text('중복된 닉네임입니다')
					$('#nick_check').css('color', 'red')
					nick_Check = false;
				} else {
					if(nickJ.test(usernick)){
						$('#nick_check').text('사용가능한 닉네임입니다')
						$('#nick_check').css('color','green')
						nick_Check = true;
					} else if ($('#usernick').val() == ''){
						$('#nick_check').text('닉네임을 입력해주세요')
						$('#nick_check').css('color','red')
						nick_Check = false;
					}else {
						$('#nick_check').text('올바른 닉네임 형식이 아닙니다')
						$('#nick_check').css('color', 'red')
						nick_Check = false;
					}
				}
			}
			
		})
		
	})
	
	$('#userphone').blur(function(){
		
		if(phoneJ.test($(this).val())){
			console.log(phoneJ.test($(this).val()));
			$('#phone_check').text('올바른 형식입니다.');
			$('#phone_check').css('color', 'green');
			phone_Check = true;
		} else {
			$('#phone_check').text('휴대폰번호를 확인해주세요("-"없이 번호만 입력해주세요)')
			$('#phone_check').css('color', 'red')
			phone_Check = false;
		}
		
	})
})

</script>  
    
<style type="text/css">
#updateform {
	margin-bottom: 3%; 
	margin-top: 3%; 
	margin-left: 30%;
	margin-right: 30%;
	border: 1px solid #ccc;
	padding-top: 2%;
	padding-bottom: 2%;
}

#updateform2 {
	width: 500px;
/* 	margin-left: 300px; */
/* 	margin-right: 300px; */
}
</style>

<div class="container container-center">
	<div class="container text-center">
		<h4 id="updateform">개인정보 수정</h4>
	</div>
	
	<form action="/mypage/updateform" method="post">
		<div class="container container-center" id="updateform2">
			<input type="hidden" name = "userno" value="${getUser.userno }"/>
			
			<label>이름 &nbsp;:&nbsp;</label>${getUser.username }<br>
			
			<label>성별 &nbsp;:&nbsp;</label>${getUser.usergender }<br>
			
			<label>생년월일 &nbsp;:&nbsp;</label>${getUser.userbirth }<br>
			
			<label>아이디 &nbsp;:&nbsp;</label>${getUser.userid }<br>
			
			<label>닉네임 &nbsp;:&nbsp;</label><input type="text" id="usernick" name="usernick" value="${getUser.usernick }"/>
<!-- 			<button type="button" id="nicknameCheck" class="btn btn-outline-dark">중복확인</button> -->
			<div class="check-font" id="nick_check"></div><br>
			
			<label>전화번호 &nbsp;:&nbsp;</label><input type="text" id="userphone" name = "userphone" value="${getUser.userphone }"/>
<!-- 			<button type="button" id="phoneCheck" class="btn btn-outline-dark">번호확인</button><br> -->
			<small>'-'없이 번호만 입력해주세요.</small>
			<div class="check_font" id="phone_check"></div><br>
			
			<div class="form-group">
           		<label>관심분야</label>
	           		<c:forEach items="${list}" var="check">
		           			<c:if test="${check.interest == '버스킹'}">
		           				<div class="custom-control custom-check">
				           			<c:if test="${check.check}">
					                	<input type="checkbox" class="custom-control-input" id="busking" name="interest" value="버스킹" checked="checked">
					                </c:if>
				           			<c:if test="${empty check.check}">
					                	<input type="checkbox" class="custom-control-input" id="busking" name="interest" value="버스킹">
					                </c:if>
									<label class="custom-control-label" for="busking">버스킹</label>
			            		</div>
			                </c:if>
			                
	        				<c:if test="${check.interest == '공연/예술'}">
			            		<div class="custom-control custom-check">
				           			<c:if test="${check.check}">
										<input type="checkbox" class="custom-control-input" id="perform" name="interest" value="공연/예술" checked="checked">
				                	</c:if>	
				           			<c:if test="${empty check.check}">
										<input type="checkbox" class="custom-control-input" id="perform" name="interest" value="공연/예술">
				                	</c:if>
				                		<label class="custom-control-label" for="perform">공연/예술</label>
			            		</div>
		                	</c:if>
		                
	           				<c:if test="${check.interest == '기타'}">
			            		<div class="custom-control custom-check">
				           			<c:if test="${check.check}">
						                <input type="checkbox" class="custom-control-input" id="etc" name="interest" value="기타" checked="checked">
						            </c:if>
				           			<c:if test="${empty check.check}">
						                <input type="checkbox" class="custom-control-input" id="etc" name="interest" value="기타">
						            </c:if>
						                <label class="custom-control-label" for="etc">기타</label>
			            		</div>   
			                </c:if>
				</c:forEach>       		
			</div>
           
			<button id="updatecancel" class="btn btn-danger" >수정 취소</button>
			<button type="submit" id="updatesuccess" class="btn btn-dark">수정 완료</button>
		
		</div>
	</form>
	
	<!-- 닉네임 중복 검사 실패시  모달창 -->
	<div class="modal fade" id="NickAuthenticationModal">
	  <div class="modal-dialog modal-dialog-centered">
	    <div class="modal-content">
	
	      <!-- Modal Header -->
	      <div class="modal-header">
	        <h4 class="modal-title">닉네임 중복</h4>
	        <button id="inputPwX" type="button" class="close" data-dismiss="modal">&times;</button>
	      </div>
	
	      <!-- Modal body -->
	      <div class="modal-body content">
	      </div>
	
	      <!-- Modal footer -->
	      <div class="modal-footer">
	        <button type="submit" id="inputjoinCheckBtn"class="btn btn-info" data-dismiss="modal">확인</button>
	      </div>
	
	    </div>
	  </div>
	</div>
	
	<!-- 닉네임 중복 검사 실패시  모달창 -->
	<div class="modal fade" id="PhoneAuthenticationModal">
	  <div class="modal-dialog modal-dialog-centered">
	    <div class="modal-content">
	
	      <!-- Modal Header -->
	      <div class="modal-header">
	        <h4 class="modal-title">휴대폰 번호 </h4>
	        <button id="inputPwX" type="button" class="close" data-dismiss="modal">&times;</button>
	      </div>
	
	      <!-- Modal body -->
	      <div class="modal-body content">
	      </div>
	
	      <!-- Modal footer -->
	      <div class="modal-footer">
	        <button type="submit" id="inputjoinCheckBtn"class="btn btn-info" data-dismiss="modal">확인</button>
	      </div>
	
	    </div>
	  </div>
	</div>

</div>
    
<jsp:include page="/WEB-INF/views/layout/footer.jsp" />    