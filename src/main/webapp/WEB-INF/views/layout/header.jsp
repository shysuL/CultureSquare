<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*"%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>CultureSquare</title>
<!-- 부트스트랩 -->
<script type="text/javascript" src="https://code.jquery.com/jquery-2.2.4.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
<!-- 아이콘 -->
<script defer src="https://use.fontawesome.com/releases/v5.0.8/js/solid.js" integrity="sha384-+Ga2s7YBbhOD6nie0DzrZpJes+b2K1xkpKxTFFcx59QmVPaSA8c7pycsNaFwUK6l" crossorigin="anonymous"></script>
<script defer src="https://use.fontawesome.com/releases/v5.0.8/js/fontawesome.js" integrity="sha384-7ox8Q2yzO/uWircfojVuCQOZl+ZZBg2D2J5nkpLqzH1HY0C1dHlTKIbpRz/LG23c" crossorigin="anonymous"></script>
<script src="https://kit.fontawesome.com/175b2de93b.js" crossorigin="anonymous"></script>
<!-- resources css파일 -->
<link rel="stylesheet" href="/resources/css/css.css" />
<link href="carousel.css" rel="stylesheet">

<script type="text/javascript">

$(document).ready(function() {
	
	
	
	$('#rememberCheck').click(function(){
		if($("input:checkbox[id='rememberCheck']").is(":checked") == true){
//			console.log("ㅊ크박스 체크");
			$('#userid1').val("${cookie.rememberUser.value }");
		}
		else{		
//			console.log("ㅊ크박스 체크 해제");
			$('#userid1').val("");
		}
	})
	
	
	// 아이디 / 비밀번호 찾기
	$("#findInfo").click(function(){
		
		$("#findModal").modal({backdrop: 'static', keyboard:false});
		
	})
	
	
	$("#loginBtn").click(function(){
//		console.log("안들어와?");
		var userid = $('#userid1').val();
		var userpw = $('#userpw1').val();
		if ($('#rememberCheck').is(":checked")){			
			var rememberUser = $('input:checkbox[id="rememberCheck"]').val();
		} else {
			var rememberUser = "off"
		}
		
		console.log(userid);
		console.log(userpw);
		console.log(rememberUser);
		console.log($('#rememberUser').val());
	
		if(userid == ""){
			$(".content").text('아이디를 입력해주세요.');
			$("#loginModal").modal({backdrop: 'static', keyboard: false});
		}
		
		if(userpw == ""){
			$(".content").text('비밀번호를 입력해주세요.');
			$("#loginModal").modal({backdrop: 'static', keyboard: false});
		}
		
		$.ajax({
			
			type:"post",
			url:"/login",
			data: {"userid" : userid, "userpw" : userpw, "rememberUser" : rememberUser},
			success : function(res){
				// ModelAndView - result
				
				if(res.result == 1){ // 로그인 성공
					location.href="/main/main";
				}
				
				if(res.result == 2){ // 아이디 틀림
					$(".content").text('해당하는 사용자가 없습니다.');
					$("#loginModal").modal({backdrop: 'static', keyboard: false});
					$('#userid1').val('');
					$('#userpw1').val('');
				}
				
				if(res.result == 3){ // 비밀번호 틀림
					$(".content").text('비밀번호가 일치하지 않습니다.');
					$("#loginModal").modal({backdrop: 'static', keyboard: false});
					$('#userid1').val('');
					$('#userpw1').val('');
				}
				
				if(res.result == 4){ // 메일인증 안한 사용자
					$(".content").text('가입하신 아이디(이메일)에서 인증확인을 하셔야 서비스 이용 가능하십니다.');
					$("#loginModal").modal({backdrop: 'static', keyboard: false});
					$('#userid1').val('');
					$('#userpw1').val('');
				}
				
			}
		})
	})
})
</script>

<style type="text/css">

.culture { 
   width: 300px;
   height:250px;
}
/* 로고위치 */
.center {
    place-content: center;
    padding-top: 0px;
    padding-bottom: 0px;
}
/* 목록들 사이 패딩 */
.nav-item {
	padding-left: 20px;
    padding-right: 20px;
}
/* 상단 아이콘 패딩 */
.iconpadding {
	padding-left:200px;
    padding-right: 200px;
}
/* 상단 아이콘 위치 */
.right{
	place-content: flex-end;
}
.rpadding {
    padding-right: 50px;
}

.center {
	text-align: center;
}
.navbar-expand-md {
	padding-left: 40px;
}
h5 {
	margin-top: 10px;
}
</style>

</head>
<body>

<!-- header --> 
<div class="wrap">

<nav class="navbar navbar-expand-md navbar-dark fixed-top bg-dark">
  <a class="navbar-brand" href="/main/main">CultureSquare</a>
  <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarCollapse" aria-controls="navbarCollapse" aria-expanded="false" aria-label="Toggle navigation">
    <span class="navbar-toggler-icon"></span>
  </button>
  
	<div class="collapse navbar-collapse" id="navbarCollapse">
	    <ul class="navbar-nav mr-auto">
	      <li class="nav-item">
	        <a class="nav-link" href="/board/noticelist">공지사항<span class="sr-only">(current)</span></a>
	      </li>
	      <li class="nav-item">
	        <a class="nav-link" href="/board/freelist">자유 게시판</a>
	      </li>
					<%
						Date date = new Date();
						SimpleDateFormat simpleDate = new SimpleDateFormat("yyyy-MM-dd");
						String strdate = simpleDate.format(date);
					%>
					<%
						Calendar cal = Calendar.getInstance();
					%>

					<li class="nav-item">
	        <a class="nav-link" href="/artboard/list?bo_table=calendar&cal_year=<%= cal.get(Calendar.YEAR)%>&cal_month=<%= cal.get(Calendar.MONTH)+1%>">CALENDAL </a>
	      </li>
	      <li class="nav-item">
	        <a class="nav-link" href="/prboard/prlist">PR</a>
	      </li>
	      <li class="nav-item">
	        <a class="nav-link" href="/board/faqlist">FAQ</a>
	      </li>
	    </ul>
	<!-- 우측 상단 아이콘 -->
	<div class="btn-group rpadding">
		<!-- 상단 날씨 아이콘 -->  
		<a href="#">
		   <button type="button" class="btn btn-secondary " >
		      <span class="fas fa-cloud" ></span>
		   </button>
		</a>&nbsp;&nbsp;
		<!-- 상단 알림 아이콘 -->  
		<a href="#">
		   <button type="button" class="btn btn-secondary ">
		      <span class="fas fa-bell" ></span>
		   </button>
		</a>&nbsp;&nbsp;
		<!-- 상단 로그인 아이콘 -->  
		<button type="button" class="btn btn-secondary dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
		   <span class="fas fa-user" ></span>
		</button>
		<!-- 로그인  드롭다운-->
		<!-- 로그인 상태 -->
	    <c:if test="${login}">
	       <div class="dropdown-menu center">
	         <h5>${usernick}님 할라븅~!</h5>
	    	 <div class="dropdown-divider"></div>
				<input id="mypage" class="btn btn" onclick="location.href='/mypage/main'" value="마이페이지">
				<input id="logout" class="btn btn-danger" onclick="location.href='/logout'" value="로그아웃">
	       </div>
	    </c:if>
	    
	    <!-- 로그아웃 상태 -->
	    <c:if test="${not login}">
	       <div class="dropdown-menu ">
	       
	          <form class="px-4 py-3" action="/login" method=post>
	             <div class="form-group">0
	                <label for="exampleDropdownFormEmail1">Email address</label> 
	                <input
	                   type="email" class="form-control"
	                   id="userid1" placeholder="email@example.com" name="userid" >
	             </div>
	             <div class="form-group">
	                <label for="exampleDropdownFormPassword1">Password</label> <input
	                   type="password" class="form-control"
	                   id="userpw1" placeholder="Password" name=userpw>
	             </div>
	             <div class="form-group">
	                <div class="form-check">
	                   <input type="checkbox" class="form-check-input" name="rememberUser"
	                      id="rememberCheck" > <label class="form-check-label"
	                      for="rememberCheck"> Remember me </label>
	                </div>
	             </div>
	             <button type="button" id="loginBtn" class="btn btn-primary">로그인</button>
	             <div class="find">
	                <a href="#" id="findInfo">아이디/비밀번호 찾기</a>
	             </div>
	             <div class="join">
	                <a href="/user/joinForm" id="join">회원가입</a>
	             </div>
	          </form>
	          <div class="dropdown-divider"></div>
	          <!-- 구글 로그인 화면으로 이동 시키는 URL -->
	          <!-- 구글 로그인 화면에서 ID, PW를 올바르게 입력하면 oauth2callback 메소드 실행 요청-->
	          <div id="google_id_login" style="text-align:center">
	             <a href="${google_url}">
	                <img width="220" src="/resources/img/google.png"/>
	             </a>
	          </div>
	          <!-- 네이버 로그인 창으로 이동 -->
	          <div id="naver_id_login" style="text-align: center">
	             <a href="${naver_url}"> <img width="223"
	                src="/resources/img/naver.png" /></a>
	          </div>
	          <!-- 카카오 로그인 창으로 이동 -->
	          <div id="kakao_id_login" style="text-align: center">
	             <a href="${kakao_url}"><img width="223"
	                src="/resources/img/kakao.png" /></a>
	          </div>
	       </div>
	    </c:if>
	</div>
	</div>
</nav>


<!-- 메인이미지 -->
<nav class="navbar navbar-dark bg-dark center">
   <div class="cropping">
      <a href="/main/main"><img class="culture" src="/resources/logo/culturesquareLogo.png" ></a>
   </div>
</nav>

<!-- 로그인 모달 -->
<div class="modal fade" id="loginModal">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content">

      <!-- Modal Header -->
      <div class="modal-header">
        <h4 class="modal-title">알림</h4>
      </div>

      <!-- Modal body -->
      <div class="modal-body content">
      </div>

      <!-- Modal footer -->
      <div class="modal-footer">
        <button class="btn btn-info" data-dismiss="modal">확인</button>
      </div>

    </div>
  </div>
</div>

<!-- 아이디/비밀번호 찾기 모달 -->
<div class="modal fade" id="findModal">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content">

      <!-- Modal Header -->
      <div class="modal-header">
        <h4 class="modal-title">아이디/비밀번호 찾기</h4>
      </div>

      <!-- Modal body -->
      <div class="modal-body content">
      </div>

      <!-- Modal footer -->
      <div class="modal-footer">
        <button class="btn btn-info" data-dismiss="modal">확인</button>
      </div>

    </div>
  </div>
</div>


