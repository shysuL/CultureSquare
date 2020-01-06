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

<script type="text/javascript">

$(document).ready(function() {
	
	
	if(${not empty cookie.rememberUser.value }){
		// 쿠키값이 있을때 // 쿠키값에 들어있는 아이디 가져오기 // 체크박스 선택 
//		console.log(1)
		$('#userid1').val("${cookie.rememberUser.value }");
		$("input:checkbox[id='rememberCheck']").prop("checked", true);
	} else {
		// 쿠키값이 없다면 // 체크박스 해제
//		console.log(2)
		$("input:checkbox[id='rememberCheck']").prop("checked", false); // 체크 해제
	}
	
	$('#rememberCheck').click(function(){
		if($("input:checkbox[id='rememberCheck']").is(":checked") == true){
	
			if(${not empty cookie.rememberUser.value }){
			console.log("체크 트루야");
			$('#userid1').val("${cookie.rememberUser.value }");				
			
			} else {
				$('#userid1').val();
			}
		} 
		
		else {		
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
	
		if( $('#userid1').val() == ""){
			console.log(1);
			$(".content").text('아이디를 입력해주세요.');
			$("#loginModal").modal({backdrop: 'static', keyboard: false});
			
		} else if($('#userpw1').val() == ""){
			console.log(2);
			$(".content").text('비밀번호를 입력해주세요.');
			$("#loginModal").modal({backdrop: 'static', keyboard: false});
		}
		else{
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
		}
	})
})

$(document).ready(function() {
	/**
	 *    헤더에 적용할 JS active
	 */
	
    var url = location.href;
    var arr = url.split("/");
    
    let identifier = arr[3];
    
    if (identifier == "noticeboard" || "board" || "artboard" || "prboard" || "faqboard") {
       // url이 메인이거나 구독이라면
       if (arr[3] == "noticeboard") {
	       $("#noticeboard").addClass("active");
	       
       } else if (arr[3] == "board") {
	       $("#board").addClass("active");
       
       } else if (arr[3] == "artboard") {
	       $("#artboard").addClass("active");
       
       } else if (arr[3] == "prboard") {
	       $("#prboard").addClass("active");
       
       } else if (arr[3] == "faqboard") {
	       $("#faqboard").addClass("active");
       
       } 
       
    } 
	    
});

</script>

<style type="text/css">

/* 웹폰트 적용 */
@font-face { 
   font-family: 'KHNPHU'; 
   src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_one@1.0/KHNPHU.woff') format('woff'); 
   font-weight: normal; 
   font-style: normal; 
}

.sitefont {
   font-family:'KHNPHU';
}

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

/* 로고 애니메이션 */
img{min-height: 100%; max-width: 100%; }
.imgHoverEvent{width: 300px; height: 220px; margin-top: 10px; position: relative; overflow: hidden; display: inline-block;}
/* .imgHoverEvent .imgBox{width: 200px; height: 200px; text-align: center; background:url(http://gahyun.wooga.kr/portfolio/triple/resources/img/city00.jpg) no-repeat 50% 50%; background-size: auto 100%;} */
.imgHoverEvent .hoverBox{position: absolute; top:0; left: 0; width: 250px; height: 250px;}
.hoverBox p.p1{text-align:center; font-size:18px;}
.hoverBox p.p2{margin-top: 40px;}
.event3 .hoverBox{background: linear-gradient(to right, rgba(0,0,0,0) ,rgba(255,255,255,1)); width: 50px; height:400px; transform: rotateZ(30deg);top: -100px; left:-130px; transition: 0.4s; opacity: 0.5;}
.event3:hover .hoverBox{left: 400px; opacity: 1;}
</style>

</head>
<body class="sitefont">

<!-- header --> 
<div class="wrap">

<nav class="navbar navbar-expand-md navbar-dark fixed-top bg-dark">
  <a class="navbar-brand" href="/main/main">CultureSquare</a>
  <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarCollapse" aria-controls="navbarCollapse" aria-expanded="false" aria-label="Toggle navigation">
    <span class="navbar-toggler-icon"></span>
  </button>
  
	<div class="collapse navbar-collapse" id="navbarCollapse">
	    <ul class="navbar-nav mr-auto">
	      <li class="nav-item ">
	        <a class="nav-link" id="noticeboard" href="/noticeboard/noticelist">공지사항<span class="sr-only">(current)</span></a>
	      </li>
	      <li class="nav-item">
	        <a class="nav-link" id="board" href="/board/freelist">자유 게시판</a>
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
<%-- 					<c:set var = "month" value= <%= cal.get(Calendar.MONTH)+1%> > --%>
					
					<%
// 						String cal_Month = "" + (cal.get(Calendar.MONTH)+1);
					
					%>
					
<%-- 					<c:if test = "${<%= cal.get(Calendar.MONTH)+1%> < 10 }"> --%>
	        <a class="nav-link" id="artboard" href="/artboard/list?bo_table=calendar&cal_year=<%= cal.get(Calendar.YEAR)%>&cal_month=<%=(cal.get(Calendar.MONTH)+1< 10) ?"0"+(cal.get(Calendar.MONTH)+1) :cal.get(Calendar.MONTH)+1%>">CALENDAL </a>
	      </li>
	      <li class="nav-item">
	        <a class="nav-link" id="prboard" href="/prboard/prlist">PR</a>
	      </li>
	      <li class="nav-item">
	        <a class="nav-link" id="faqboard" href="/faqboard/faqlist">FAQ</a>
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
		<button class="btn btn-secondary dropdown-toggle" type="button" id="dropdownMenuButton" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
		   <span class="fas fa-user" ></span>
		</button>
		<!-- 로그인  드롭다운-->
		<!-- 로그인 상태 -->
	    <c:if test="${login}">
	       <div class="dropdown-menu center">
	         <h5>${usernick}님 할라븅~!</h5>
	    	 <div class="dropdown-divider"></div>
				<input id="mypage" class="btn btn" onclick="location.href='/mypage/main'" value="마이페이지">
				<input id="logout" class="btn btn-danger  logt"  onclick="location.href='/logout'" value="로그아웃">
	       </div>
	    </c:if>
	    
	    <!-- 로그아웃 상태 -->
	    <c:if test="${not login}">
	       <div class="dropdown-menu " id="dpMenu">
	       
	          <form class="px-4 py-3" action="/login" method=post>
	             <div class="form-group">
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
	                      id="rememberCheck"> <label class="form-check-label"
	                      for="rememberCheck" > 아이디 저장 </label>
	                </div>
	             </div>
	             
	             <div>
	             <button type="button" id="loginBtn" class="btn btn-dark">로그인</button>
	             </div>
	             
	             <div class="find" style="margin-top: 10px;">
	                <a href="#" id="findInfo">아이디/비밀번호 찾기</a>
	             </div>
	           
	             <div class="join" style="margin-top: 5px;">
	                <a href="/user/joinForm" id="join">회원가입</a>
	             </div>
	          </form>
	          <div class="dropdown-divider"></div>
	          <!-- 구글 로그인 화면으로 이동 시키는 URL -->
	          <!-- 구글 로그인 화면에서 ID, PW를 올바르게 입력하면 oauth2callback 메소드 실행 요청-->
	          <div class="row">
		          <div id="google_id_login" style="text-align:center; " class="col-4">
		             <a href="${google_url}">
		                <img width="100%" height="50" style="margin-left: 10px; " src="/resources/img/g.jpg"/>
		             </a>
		          </div>
		          <!-- 네이버 로그인 창으로 이동 -->
		          <div id="naver_id_login" style="text-align: center;" class="col-4">
		             <a href="${naver_url}"> 
		             <img width="100%" height="50" src="/resources/img/n.jpg" /></a>
		          </div>
		          <!-- 카카오 로그인 창으로 이동 -->
		          <div id="kakao_id_login" style="text-align: center;" class="col-4">
		             <a href="${kakao_url}">
		             <img width="100%" height="50" style=" margin-left: -15px;" src="/resources/img/k.jpg" /></a>
		          </div>
		          
	          </div>
	       </div>
	    </c:if>
	</div>
	</div>
</nav>


<!-- 메인이미지 -->

          

<nav class="navbar navbar-dark bg-dark center">
   <div class="cropping">
	  <div class="imgHoverEvent event3">
    	  <div class="imgBox"> <a href="/main/main"><img class="culture" src="/resources/logo/culturesquareLogo.png" ></a></div>
  	 	  <div class="hoverBox">
  	 	  </div>
  	  </div>
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
        <button class="btn btn-dark" data-dismiss="modal">확인</button>
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
        <button class="btn btn-dark" data-dismiss="modal">확인</button>
      </div>

    </div>
  </div>
</div>


