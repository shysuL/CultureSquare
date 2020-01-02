<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!-- Header -->
<jsp:include page="/WEB-INF/views/layout/header.jsp"/>


<style type="text/css">
.container{
	margin-top: 5%;
}
.btn-primary {
    color: white;
    background-color: #343a40;
    border-color: #343a40!important;
}
.btn-primary:hover {
    color: white;
    background-color: #343a40;
    border-color: rgba(255,255,255,.75);
}
.btn-info {
    color: rgba(255,255,255,.75);
    background-color: #212529;
    border-color: #212529;
}
.btn-info:hover {
    color: rgba(255,255,255,.75);
    background-color: #5a6268;
    border-color: #5a6268;
}
.btn-info:not(:disabled):not(.disabled).active, .btn-info:not(:disabled):not(.disabled):active, .show>.btn-info.dropdown-toggle {
    color: rgba(255,255,255,.75);
    background-color: #5a6268;
    border-color: #5a6268;
}
</style>

<script type="text/javascript">	
// 정규식
	// 아이디(이메일) 검사 정규식
	var idJ = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
	// 비밀번호 정규식 - 암호길이 8자 이상 16 이하, 영문숫자특수문자조합
//	var pwJ = /^[A-Za-z0-9]{4,12}$/;
	var pwJ = /^(?=.*[a-zA-Z])(?=.*[^a-zA-Z0-9])(?=.*[0-9]).{8,16}$/;
	// 이름 정규식
	var nameJ = /^[가-힣]{2,6}$/;
	//닉네임 정규식
	var nickJ = /^[0-9a-zA-Z가-힣]{2,12}$/;
	// 휴대폰 번호 정규식
	var phoneJ = /^01([0|1|6|7|8|9]?)?([0-9]{3,4})?([0-9]{4})$/;
	// 생년월일 정규식
	var birthJ = /^(19[0-9][0-9]|20\d{2})(0[0-9]|1[0-2])(0[1-9]|[1-2][0-9]|3[0-1])$/
	//모든 공백 체크 정규식
	var blankJ = /\s/g;
	function showLoadingBar() {
//		console.log("이미지 보여줘")
	    var maskHeight = $(document).height();
	    var maskWidth = window.document.body.clientWidth;
	    var mask = "<div id='mask' style='position:absolute; z-index:9000; background-color:#000000; display:none; left:0; top:0;'></div>";
	    var loadingImg = '';
	    loadingImg += "<div id='loadingImg' style='position:absolute; left:50%; top:40%; display:none; z-index:10000; margin-top:23%;'>";
	    loadingImg += "    <img src='/resources/img/loadimg.gif'>";
	    loadingImg += "</div>";
	    $('body').append(mask).append(loadingImg);
	    
	    $('#mask').css({
	        'width' : maskWidth
	        , 'height': maskHeight
	        , 'opacity' : '0.3'
	    });
	    $('#mask').show();
	    $('#loadingImg').show();
	}
	
	
$(document).ready(function(){
	
//	showLoadingBar();
	
// 	정규식 검사 변수
	var id_Check = true;
	var pw_Check = true;
	var pw_Check2 = true;
	var name_Check = true;
	var phone_Check = true;
	var nick_Check = true;
	var birth_Check = true;
	
	$("#joinBtn").click(function(){ // 가입 버튼 눌렀을 때
		
		
// 		정규식 만족 안했을때 or 입력값이 null일때 or 입력값 없을 때
//		1. 아이디 검사
		if(!id_Check || $('#userid').val() == ""){
			$(".content").text('아이디를 확인해주세요.');
			$("#joinAuthenticationModal").modal({backdrop: 'static', keyboard: false});
			$("#userid").focus();
		} 
		
//		2. 패스워드 검사	
		else if(!pw_Check || $('#userpw').val() == ""){
			$(".content").text('비밀번호를 확인해주세요.');
			$("#joinAuthenticationModal").modal({backdrop: 'static', keyboard: false});
			$("#userpw").focus();
		}
		
// 		3. 패스워드 확인 검사
		else if(!pw_Check2 || $('#userpw2').val() == "" || $('#userpw').val() != $('#userpw2').val()) {
				$(".content").text('비밀번호2를 확인해주세요.');
				$("#joinAuthenticationModal").modal({backdrop: 'static', keyboard: false});
				$("#userpw2").focus();
		}
		
// 		4. 이름 검사
		else if(!name_Check || $('#username').val() == "") {
			$(".content").text('이름을 확인해주세요.');
			$("#joinAuthenticationModal").modal({backdrop: 'static', keyboard: false});
			$("#username").focus();
		}
// 		5. 닉네임 검사
		else if(!nick_Check || $('#usernick').val() == ""){
				$(".content").text('닉네임을 확인해주세요.');
				$("#joinAuthenticationModal").modal({backdrop: 'static', keyboard: false});
				$("#usernick").focus();
		}
		
// 		6. 핸드폰 검사
		else if(!phone_Check ||  $('#usernick').val() == ""){
				$(".content").text('핸드폰 번호를 확인해주세요.');
				$("#joinAuthenticationModal").modal({backdrop: 'static', keyboard: false});
				$("#userphone").focus();
		} 		
//		7. 생년월일 검사
		else if(!birth_Check || $('#userbirth').val() == ""){
			$(".content").text('생년월일을 확인해주세요.');
			$("#joinAuthenticationModal").modal({backdrop: 'static', keyboard: false});
			$("#userbirth").focus();
		}
		
// 		8. 성별 체크 검사
		else if($("input:radio[name='usergender']").is(":checked") == false){
				var a = $("input:radio[name='usergender']").is(":checked");
				console.log("엘스 이 프 : " + a);
				$(".content").text('성별을 선택 해주세요');
				$("#joinAuthenticationModal").modal({backdrop: 'static', keyboard: false});
				$("#usergender").focus();
		}
		
// 		9. 관심분야 검사
		else if($("input:checkbox[name='interest']").is(":checked") == false){
				$(".content").text('관심분야를 한개 이상 선택 해주세요');
				$("#joinAuthenticationModal").modal({backdrop: 'static', keyboard: false});
				$("#interest").focus();	
		}
		
// 		10. 회원구분
		else if($("input:radio[name='usertype']").is(":checked") == false){
				$(".content").text('회원구분을  선택 해주세요');
				$("#joinAuthenticationModal").modal({backdrop: 'static', keyboard: false});
				$("#usertype").focus();	
		}
//		11. 이용약관
		else if($("input:checkbox[name='agree']").is(":checked") == false){			
				$(".content").text('이용약관에 동의 해주세요');
				$("#joinAuthenticationModal").modal({backdrop: 'static', keyboard: false});
				$("#agree").focus();	
		}
		else { 	
			
			$(this).parents("form").submit();
			$('#joinBtn').attr('disabled', true); // 버튼 비활성화
			console.log("버튼비활성화")
			
			showLoadingBar();
			// 로딩바 숨김
			function hideLoadingBar() { $('#mask, #loadingImg').hide(); $('#mask, #loadingImg').remove(); }
		}
		
    	
    	return false;
	})
	
	// 아이디 ( 이메일 ) 중복검사
	$("#userid").blur(function(){	
		var userid= $('#userid').val();
		$.ajax({
			
			type:"post",
			url:"/user/idCheck",
			data: {"userid" : userid},
			datatype:"json",
			success : function(res){
				// idCheck는 ModelAndView에서 지정해준 이름			
//				console.log("res")
//				console.log(res)
//				console.log("res.idCheck")
//				console.log(res.idCheck)
				
				if(res.idCheck>0){
					// 1 : 아이디가 중복되는 문구
					$("#id_check").text("사용중인 이메일입니다");
					$("#id_check").css("color", "red");
					
					id_Check = false;
					
				
				} else {
					
					if(idJ.test(userid)){
						// 0 : 아이디길이 / 문자열 검사
						$("#id_check").text("사용 가능한 이메일입니다");
						$("#id_check").css("color", "green");
						id_Check = true;
					} else if (userid == ""){
						$('#id_check').text('아이디를 입력해주세요');
						$('#id_check').css('color', 'red');
						id_Check = false;
					} else {
						$('#id_check').text("아이디는 이메일 주소로만 가능합니다");
						$('#id_check').css('color', 'red');
						id_Check = false;
					}
						
				}
			}, error : function(error){
					console.log("실패");
				}					
		})	
	})
	
	// 비밀번호 유효성 검사
	// 1-1 정규식 체크
	$("#userpw").blur(function(){
		if (pwJ.test($('#userpw').val())){
			console.log('true');
			$('#pw_check').text('사용가능한 비밀번호입니다');
			$('#pw_check').css('color', 'green')
			pw_Check = true;
		} else {
			console.log('false');
			$('#pw_check').text('비밀번호는 숫자 or 문자로만 8~16자리 입력해주세요');
			$('#pw_check').css('color', 'red');
			pw_Check = false;
		}		
	});
	
	// 1-2 비밀번호 확인
	$("#userpw2").blur(function(){
		if (!pwJ.test($('#userpw2').val())){
			$('#pw_check2').text('비밀번호는 숫자 or 문자로만 4~12자리 입력해주세요');
			$('#pw_check2').css('color', 'red')
			pw_Check2 = false;
		} else if($('#userpw').val() != $(this).val()) {
			$('#pw_check2').text('비밀번호가 일치하지 않습니다 다시 확인해 주세요')
			$('#pw_check2').css('color', 'red')
			pw_Check2 = false;
		} else {
			$('#pw_check2').text('비밀번호가 일치합니다')
			$('#pw_check2').css('color', 'green')
			pw_Check2 = true;
		}
	});
	
	
	
	// 이름 유효성 검사( 특수문자 들어가지 않도록 )
	$('#username').blur(function(){
	
		if(nameJ.test($(this).val())){
			console.log(nameJ.test($(this).val()))
			$("#name_check").text('');
			name_Check = true;
		} else {
			$('#name_check').text('이름을 확인해 주세요')
			$('#name_check').css('color', 'red')
			name_Check = false;
		}
	})
	
	// 닉네임 중복 검사 ( AJAX )
	$('#usernick').blur(function(){
	
		var usernick = $('#usernick').val();
		$.ajax({
			url : "/user/nickCheck",
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
	
	// 핸드폰
	$('#userphone').blur(function(){
		
		if(phoneJ.test($(this).val())){
			console.log(phoneJ.test($(this).val()));
			$('#phone_check').text('');
			phone_Check = true;
		} else {
			$('#phone_check').text('휴대폰번호를 확인해주세요("-"없이 번호만 입력해주세요)')
			$('#phone_check').css('color', 'red')
			phone_Check = false;
		}
		
	})
	
	// 생년월일 유효성 검사
	$('#userbirth').blur(function(){
		if(birthJ.test($(this).val())){
			console.log("생년월일 유효성 검사")
			console.log(birthJ.test($(this).val()))
			$('#birth_check').text('');
			birth_Check = true;
		} else {
			$('#birth_check').text('생년월일을 올바르게 입력해주세요')
			$('#birth_check').css('color', 'red')
			birth_Check = false;
		}
	})
})// document ready
</script>

<div class="container">
   
   <div class="innercon1" style="width: 40%;">
   
      <div style="background-color: #343a40!important;">
         <h2 style="color: rgba(255,255,255,.75);">회원가입</h2>
      </div>
      
      <div>
         <form action="/user/joinProc" method=post>
           
           <div class="form-group">
             <label for="userid">아이디</label>
             <input type="text" class="form-control" id="userid" placeholder="이메일 입력" name="userid" required>
             <div class="check_font" id="id_check"></div>
           </div>
           
           <div class="form-group">
             <label for="userpw">비밀번호</label>
             <input type="password" class="form-control" id="userpw" placeholder="8자 이상 16 이하, 영문 숫자 특수문자조합" name="userpw" required>
             <div class="valid-feedback">Valid.</div>
             <div class="invalid-feedback">Please fill out this field.</div>
             <div class="check_font" id="pw_check"></div>
           </div>

           <div class="form-group">
             <label for="userpw">비밀번호 확인</label>
             <input type="password" class="form-control" id="userpw2" placeholder="비밀번호 확인" name="userpw2" required>
             <div class="valid-feedback">Valid.</div>
             <div class="invalid-feedback">Please fill out this field.</div>
             <div class="check_font" id="pw_check2"></div>
           </div>
           
           <div class="form-group">
             <label for="username">이름</label>
             <input type="text" class="form-control" id="username" placeholder="이름 입력" name="username" required>
             <div class="valid-feedback">Valid.</div>
             <div class="invalid-feedback">Please fill out this field.</div>
             <div class="check_font" id="name_check"></div>
             
           </div>

           <div class="form-group">
             <label for="usernick">닉네임</label>
             <input type="text" class="form-control" id="usernick" placeholder="닉네임 입력" name="usernick" required>
             <div class="valid-feedback">Valid.</div>
             <div class="invalid-feedback">Please fill out this field.</div>
             <div class="check_font" id="nick_check"></div>
             
           </div>
           
           <div class="form-group">
             <label for="userphone">휴대전화</label>
             <input type="tel" class="form-control" id="userphone" placeholder="'-'없이 번호만 입력해주세요" name="userphone" required>
             <div class="valid-feedback">Valid.</div>
             <div class="invalid-feedback">Please fill out this field.</div>
             <div class="check_font" id="phone_check"></div>
             
           </div>
           
           <div class="form-group">
             <label for="userbirth">생년월일</label>
             <input type="text" class="form-control" id="userbirth" placeholder="생년월일 입력" name="userbirth" required>
             <div class="valid-feedback">Valid.</div>
             <div class="invalid-feedback">Please fill out this field.</div>
             <div class="check_font" id="birth_check"></div>
           </div>
           
           
           <div class="form-group">
           		성별
	            <div class="custom-control custom-radio">
	               <input type="radio" class="custom-control-input" id="customradiom" name="usergender" value="남자">
	               <label class="custom-control-label" for="customradiom">남자</label>
	            </div>
	            <div class="custom-control custom-radio">
	               <input type="radio" class="custom-control-input" id="customradiow" name="usergender" value="여자">
	               <label class="custom-control-label" for="customradiow">여자</label>
	            </div>
           </div> 
           
           <div class="form-group">
           		관심분야
           		<div class="custom-control custom-check">
	               <input type="checkbox" class="custom-control-input" id="busking" name="interest" value="버스킹">
	               <label class="custom-control-label" for="busking">버스킹</label>
	            </div>
	            <div class="custom-control custom-check">
	               <input type="checkbox" class="custom-control-input" id="perform" name="interest" value="공연/예술">
	               <label class="custom-control-label" for="perform">공연/예술</label>
	            </div>
	            <div class="custom-control custom-check">
	               <input type="checkbox" class="custom-control-input" id="etc" name="interest" value="기타">
	               <label class="custom-control-label" for="etc">기타</label>
	            </div>           		
           </div>
           
           <div class="form-group">
           		회원구분
	            <div class="custom-control custom-radio">
	               <input type="radio" class="custom-control-input" id="usualuser" name="usertype" value="0">
	               <label class="custom-control-label" for="usualuser">일반 사용자</label>
	            </div>
	            <div class="custom-control custom-radio">
	               <input type="radio" class="custom-control-input" id="perfomencer" name="usertype" value="1">
	               <label class="custom-control-label" for="perfomencer">예술인</label>
	            </div>
           </div> 
                           
           <div class="form-group form-check">
             <label class="form-check-label">
               <input class="form-check-input" type="checkbox" name="agree" required> 이용약관 및 개인정보처리방침에 동의
             </label>
           </div>
           
           <button id = "joinBtn" type="submit" class="btn btn-primary">가입</button>
           
         </form>
      </div>
   </div> <!-- innercon1 -->
   
   
<!-- 유효성 검사 실패시  모달창 -->
<div class="modal fade" id="joinAuthenticationModal">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content">

      <!-- Modal Header -->
      <div class="modal-header">
        <h4 class="modal-title">회원가입 오류</h4>
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
   
</div> <!-- container -->



<!-- footer -->
<jsp:include page="/WEB-INF/views/layout/footer.jsp"/>
