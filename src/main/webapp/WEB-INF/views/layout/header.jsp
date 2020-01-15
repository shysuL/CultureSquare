<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page import="java.util.Calendar"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.text.SimpleDateFormat"%>
    
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
		
	// 로그아웃 버튼 눌렀을 때
	$("#logout").click(function(){
		$(".content").text("로그아웃 하시겠습니까?");
		$("#logoutModal").modal({backdrop: 'static', keyboard: false});
		
	});
	
	// 로그아웃 모달에서 확인 누를떄
	$("#logoutBtnOk").click(function(){
		
		var socialType = '${socialType}';
		
		//구글 로그인일 경우
		if(socialType == 'Google'){
			var child = window.open('https://accounts.google.com/logout','popup', 'z-lock=yes',);
			
			setTimeout(function() {
				child.close();
				location.href="/logout";
				}, 1000); // 1000ms(3초)가 경과하면 이 함수가 실행됩니다.
		}
		else{
			location.href="/logout";
		}
		
	});
	
	
	// 비밀번호 찾기에서 확인 버튼 눌렀을 때
	$("#findPwOkBtn").click(function(){
		
		var userid = $("#pwFindByUserid").val();
		var username = $("#pwFindByUsername").val();
		
		console.log(userid);
		console.log(username);
		
		// 비밀번호 찾기 유효성 
		if ( $("#pwFindByUserid").val() == "" ){
			$(".content").text("이메일을 입력해주세요");
			$("#searchIdPw2").modal({backdrop: 'static', keyboard: false});
			$("#searchIdPwBtnOk2").click(function(){
				$("#pwFindByUserid").focus();
			})
		} else if ($("#pwFindByUsername").val() == ""){
			$(".content").text("이름을 입력해주세요");
			$("#searchIdPw2").modal({backdrop: 'static', keyboard: false});
			$("#searchIdPwBtnOk2").click(function(){
				$("#pwFindByUsername").focus();	
			})
			
		} else {
			
			$('#findPwOkBtn').attr("disabled", "true"); // 비밀번호 찾기 버튼 비활성화
			$('#findPwOkBtn').html('<span class="spinner-border spinner-border-sm"></span>'); // 비밀번호 찾기 버튼 비활성화
			$.ajax({
				type:"post",
				url:"/user/findPw",
				data: {"userid" : userid, "username" : username},					
				dataType: "json",
				success : function(res){
					$('#findPwOkBtn').html('확인'); // 비밀번호 찾기 버튼 비활성화
					console.log(res.result);
					$('#findPwOkBtn').attr('disabled', false); // 비밀번호 찾기 버튼 활성화
					if(res.result == 1 ){
// 						$('#findPwOkBtn').attr('disabled', true); // 비밀번호 찾기 버튼 비활성화
						$(".content").text("입력하신 메일로 임시비밀번호를 발급해드렸습니다.");
						$("#searchIdPw2").modal({backdrop: 'static', keyboard: false});
						$("#searchIdPwBtnOk2").click(function(){
							$("#pwFindByUserid").val("");
							$("#pwFindByUsername").val("");
							$('#findPwOkBtn').attr('disabled', false); // 비밀번호 찾기 버튼 활성화
						})
					} else {
						$(".content").text("존재하지 않는 사용자 입니다.");
						$("#searchIdPw2").modal({backdrop: 'static', keyboard: false});
					}
					
					
					
				}
			})
			
		}
		
		
	})
	
	// 아이디 찾기에서 확인 버튼 눌렀을 때
	$("#findIdOkBtn").click(function(){
		
		var username = $("#idFindByUsername").val();
		var userphone = $("#idFindByUserphone").val();
		
		// 아이디찾기 유효성
		if( $("#idFindByUsername").val() == ""){
			console.log(123);
			$(".content").text("이름을 입력해주세요");
			$("#searchIdPw").modal({backdrop: 'static', keyboard: false});
			$("#searchIdPwBtnOk").click(function(){
				$("#idFindByUsername").focus();
			})
		} else if ($("#idFindByUserphone").val() == ""){
			$(".content").text("핸드폰번호를 입력해주세요");
			$("#searchIdPw").modal({backdrop: 'static', keyboard: false});
			$("#searchIdPwBtnOk").click(function(){
				$("#idFindByUserphone").focus();	
			})
		}
			
		else {
						
			$.ajax({
				type:"post",
				url:"/user/findId",
				data: {"username" : username, "userphone" : userphone},
				dataType: "json",
				success : function(res){
					// ModelAndView - findId
	//				console.log("success");
					console.log(res)
					console.log(res.idList)
					
					if(res.idList == 0){
						
		 				$("#searchIdPw").modal({backdrop: 'static', keyboard: false});
		 				$(".content").text("해당하는 사용자가 존재하지 않습니다.");
						$("#idFindByUsername").val("");
		 				$("#idFindByUserphone").val("");
						$("#searchIdPwBtnOk").click(function(){
							$(".content").text("");
						})
										
					} else {
						
					
						var idList = res.idList		
						$(".content").text(""); // 유효성 검사 남아있는 (.content).text 지워 주기
						for (var i=0; i<idList.length; i++){
							
			 				$(".content").append("***" + idList[i].userid.substring(3,idList[i].length));
			 				$(".content").append("<br>");
			 				
						}
						
		 				$("#searchIdPw").modal({backdrop: 'static', keyboard: false});
						$("#idFindByUsername").val("");
		 				$("#idFindByUserphone").val("");
						$("#searchIdPwBtnOk").click(function(){
							$(".content").text("");
						})			
	 				
					}
	 				
				
				}
				,error: function(e) {
					console.log("error");
					console.log(e);
				}
			})
		
		}
		
		
	})
	
	
	
	
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
		console.log("ㅌㅁㅇ");
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
	
	//아이디 입력 후 엔터 키 눌렀을 떄 로그인 버튼과 같은 동작하게 하기
	$('#userid1').keypress(function(event){
		if(event.which==13){
			$('#loginBtn').click();
			return false;
		}
	})
	
	//아이디 입력 후 엔터 키 눌렀을 떄 로그인 버튼과 같은 동작하게 하기
	$('#userpw1').keypress(function(event){
		if(event.which==13){
			$('#loginBtn').click();
			return false;
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

<script type="text/javascript">
function weather(){
	var date ="";
	var temperature ="";
	var sky = "";
	var rain = "";
	$.ajax({
		type : "POST",
		url : "/main/showweather",
		success : function(res) {
			$(".weather").collapse('toggle'); 
			
			date += "<strong>현재 날짜 : </strong>"+res.weather.date+"<br><strong>측정 시간 : </strong>"+res.weather.time;
			$("#date").html(date);
			
			temperature += "<strong>현재 기온 : </strong>"+res.weather.humidity+"℃";
			$("#temperature").html(temperature);
			
			//하늘 상태
			//1 -> 맑음
			//2 -> 구름 조금
			//3 -> 구름 많음
			//4 -> 흐림
			
			if(res.weather.sky == 1){
				sky += "<strong>하늘 상태 :</strong> 맑음<br>"+"<img src='/resources/img/fine.png' style ='display: block; margin-left: auto; margin-right: auto;'/>"
				$("#sky").html(sky);
			}
			
			else if(res.weather.sky == 2){
				sky += "<strong>하늘 상태 :</strong> 구름 조금<br>"+"<img src='/resources/img/cloudsmall.png' style ='display: block; margin-left: auto; margin-right: auto;'/>"
				$("#sky").html(sky);
			}
			
			else if(res.weather.sky == 3){
				sky += "<strong>하늘 상태 :</strong> 구름 많음<br>"+"<img src='/resources/img/cloudmany.png' style ='display: block; margin-left: auto; margin-right: auto;'/>"
				$("#sky").html(sky);
			}
			else{
				sky += "<strong>하늘 상태 :</strong> 흐림<br>"+"<img src='/resources/img/bad.png' style ='display: block; margin-left: auto; margin-right: auto;'/>"
				$("#sky").html(sky);
			}
			
			//강수 상태
			//0-> 없음
			//1-> 비
			//2-> 비/눈
			//3-> 눈
			if(res.weather.rainCode == 0){
				rain += "<strong>강수 상태<small>("+res.weather.rainPercentage+"%)</small> :</strong> 없음";
				$("#rain").html(rain);
			}
			
			else if(res.weather.rainCode == 1){
				rain += "<strong>강수 상태<small>("+res.weather.rainPercentage+"%)</small> :</strong> 비<br>"+"<img src='/resources/img/rain.png' style ='display: block; margin-left: auto; margin-right: auto;'/>"
				$("#rain").html(rain);
			}
			
			else if(res.weather.rainCode == 2){
				rain += "<strong>강수 상태<small>("+res.weather.rainPercentage+"%)</small> :</strong> 비/눈<br>"+"<img src='/resources/img/rainsnow.png' style ='display: block; margin-left: auto; margin-right: auto;'/>"
				$("#rain").html(rain);
			}
			
			else{
				rain += "<strong>강수 상태<small>("+res.weather.rainPercentage+"%)</small> :</strong> 눈<br>"+"<img src='/resources/img/snow.png' style ='display: block; margin-left: auto; margin-right: auto;'/>"
				$("#rain").html(rain);
			}
		},
		error : function() {
			console.log("실패");
		}
	});
}
function alramread(){
	//로그인 상태
	if('${login}'){
		
		$.ajax({
			type : "POST",
			url : "/alram/getAlramList",
			data : {
				//사용자 닉네임 넘겨줌
				usernick : '${usernick}',
			},
			dataType : "json",
			success : function(res) {
				var html ="";
				$(".alram").collapse('toggle'); 
				
				if(res.alramList.length > 0){
					
					for(i=0; i<res.alramList.length; i++){
						html += "<div style ='cursor: pointer;' id = 'alram"+res.alramList[i].boardno+"' class='alram"+res.alramList[i].alramno+"' data-role='alram"+res.alramList[i].boardtype+"'>"
						
						if(res.alramList[i].alramcheck == 0){
							html += "<li id = 'alramshow' class='list-group-item' style ='background-color: #bef7ef;'>"
						}
						else{
							html += "<li id = 'alramshow' class='list-group-item'>"
						}
						
						html += "<strong>"+res.alramList[i].alramsender+"</strong>님이 "
						// alramtype == 1 -> 댓글
						if(res.alramList[i].alramtype == 1){
							html += "<br>회원님의  <strong>" + res.alramList[i].title +"</strong> 게시글에<br> ";
							html += "댓글을 남겼습니다.";
						}
						// alramtype == 2 -> 좋아요
						else if(res.alramList[i].alramtype == 2){
							html += "<br>회원님의  <strong>" + res.alramList[i].title +"</strong> 게시글에<br> ";
							html += "좋아요를 눌렀습니다.";
						}
						// alramtype == 3 -> 답글
						else if(res.alramList[i].alramtype == 3){
							html += "<br><strong>" + res.alramList[i].title +"</strong> 게시글에 있는<br>";
							html += "회원님의 댓글에  답글을 남겼습니다.";
						}
						
						// alramtype == 4 -> 후원
						else if (res.alramList[i].alramtype == 4){
							html += "<br>회원님의  <strong>" + res.alramList[i].title +"</strong> 게시글에<br> ";
							html +=  res.alramList[i].alramcontents + "원을 후원하였습니다.";
						}
						// 팔로우
						else{
							html += "<br>회원님을 팔로우하였습니다.";
						}
						html += "<br><small>"+res.alramList[i].alramtime+"</small>";
						html += "</li>";
						html += "</div>";
					}
				}
				else{
					html += "<div>"
					html += "<li id = 'alramshow' class='list-group-item'>"
					html += "<strong>알림 내용이 없습니다.</strong>"
					html += "</li>";
					html += "</div>";
				}
				$("#alramList").html(html);
			},
			error : function() {
				console.log("실패");
			}
		});
	}
	else{
		console.log("로그인 안댐");
	}
}
function getAlramCnt(usernick){
	$.ajax({
		type : "POST",
		url : "/alram/alarmcnt",
		data : {
			//사용자 닉네임 넘겨줌
			usernick : usernick,
		},
		dataType : "json",
		success : function(res) {
			if(res.alramCnt != 0){
				console.log("알람 갯수 : " + res.alramCnt);
				$("#alarmCnt").html(res.alramCnt);
			}
			else{
				console.log("알람 0개(다읽음): " + res.alramCnt);
				$("#alarmCnt").html("");
			}
		},
		error : function() {
			console.log("실패");
		}
	});
}
function getInfiniteAlram(usernick){
	setInterval(function() {
			getAlramCnt(usernick);
			
	}, 1000);
}
</script>

<script type="text/javascript">
		$(document).ready(function() {
			//로그인 상태
			if('${login}'){
				getInfiniteAlram('${usernick}');
			}
			
			// 알람 보기 버튼 클릭 처리
			$('#alramList').on("click", "#alramshow", function(){
				// 부모 div 아이디 얻기
				var parentId = $(this).closest('div').attr('id');
				//숫자만 추출
				var boardno = parentId.replace(/[^0-9]/g,'');
				
				// 부모 div 클래스 얻기
				var parentclass = $(this).closest('div').attr('class');
				//숫자만 추출
				var alramno = parentclass.replace(/[^0-9]/g,'');
				
				// 부모 div data-role얻기
				var parentType = $(this).closest('div').attr('data-role');
				boardtype = parentType.replace(/[^0-9]/g,'');
				
		 		$.ajax({
	 			type : "POST",
	 			url : "/alram/readalram",
	 			data : {
	 				//게시판 번호, 알람번호 넘겨줌
	 				boardno : boardno,
	 				alramno : alramno
	 			},
	 			dataType : "json",
	 			success : function(res) {
	 				
	 				// boardtype == 1 예술정보 게시판
	 				if(boardtype == 1){
	 					$(location).attr("href", "/artboard/view?boardno="+ boardno);
	 				}
	 				
	 				// boardtype == 2 PR 게시판
	 				else if(boardtype == 2){
	 					$(location).attr("href", "/prboard/view?boardno="+ boardno);
	 				}
	 				
	 				// 자유게시판
	 				else{
	 					$(location).attr("href", "/board/freeview?boardno="+ boardno);
	 				}
	 			},
	 			error : function() {
	 				console.log("실패");
	 			}
	 		});
		})
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
/* 날씨사이즈 */
.weather {
    margin-left: -100px;
    width: 220px;
}
.alram {
    margin-left: -212px;
    width: 356px;
    overflow: auto;
    height: 215px;
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
.loginwidth{
    padding-left: 20px;
}
/* 로고 애니메이션 */
img[class=culture]{min-height: 100%; max-width: 100%; }
.imgHoverEvent{width: 300px; height: 220px; margin-top: 10px; position: relative; overflow: hidden; display: inline-block;}
/* .imgHoverEvent .imgBox{width: 200px; height: 200px; text-align: center; background:url(http://gahyun.wooga.kr/portfolio/triple/resources/img/city00.jpg) no-repeat 50% 50%; background-size: auto 100%;} */
.imgHoverEvent .hoverBox{position: absolute; top:0; left: 0; width: 250px; height: 250px;}
.hoverBox p.p1{text-align:center; font-size:18px;}
.hoverBox p.p2{margin-top: 40px;}
.event3 .hoverBox{background: linear-gradient(to right, rgba(0,0,0,0) ,rgba(255,255,255,1)); width: 50px; height:400px; transform: rotateZ(30deg);top: -100px; left:-130px; transition: 0.4s; opacity: 0.5;}
.event3:hover .hoverBox{left: 400px; opacity: 1;}

#alarmCnt {
	height: 20px;
	min-width: 8px;
	line-height: 20px;
	padding: 1px 6px;
	margin-top: -7px;
	margin-left: -19px;
	z-index: 1;
	margin-right: 4px;
}
#top {
    position: fixed;
    right: 5%;
    bottom: 50px;
    z-index: 999;
    font-size: 20px;
    text-decoration: none;
}
#mypage{
	width: 195px;
    margin-bottom: 10px;
}

</style>

</head>
<body class="sitefont">

<!-- header --> 
<div class="wrap">
	<a id="top" href="#" style="width: 60px;"><img src="/resources/img/TOPbutton1.png" class="d-block w-100" alt="..."></a>
<nav class="navbar navbar-expand-md navbar-dark fixed-top bg-dark" >
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
	        <a class="nav-link" id="artboard" href="/artboard/list?bo_table=calendar&cal_year=<%= cal.get(Calendar.YEAR)%>&cal_month=<%=(cal.get(Calendar.MONTH)+1< 10) ?"0"+(cal.get(Calendar.MONTH)+1) :cal.get(Calendar.MONTH)+1%>">CALENDAR </a>
	      </li>
	      <li class="nav-item">
	        <a class="nav-link" id="prboard" href="/prboard/prlist">PR</a>
	      </li>
	      <li class="nav-item">
	        <a class="nav-link" id="faqboard" href="/faqboard/faqlist">FAQ</a>
	      </li>
	    </ul>
	    

    <div class="btn-group">
    
        <button class="btn btn-secondary dropdown-toggle" type="button" onclick="weather();">
		      <span class="fas fa-cloud" ></span>
		   </button>
   
    <div  class="dropdown-menu weather" aria-labelledby="dropdownMenuButton">
     <ul class="list-group">
  		<li id = "date" class="list-group-item"></li>
        <li id = "temperature"class="list-group-item"></li>
        <li id = "sky"class="list-group-item"></li>
        <li id="rain" class="list-group-item"></li>
      </ul>
	</div>
	</div>
&nbsp;&nbsp;&nbsp;&nbsp;
	<!-- 상단 알림 아이콘 -->  
<!-- 		   	<span  class="badge badge-pill badge-info" id = "alarmCnt"></span> -->
	<div class="btn-group" >

		<button class="btn btn-secondary dropdown-toggle" style="margin-right: 8px;" type="button" onclick="alramread();">
	        <span class="fas fa-bell" ></span>
	    </button>
			<span  class="badge badge-pill badge-info" id = "alarmCnt"></span>

		 <div class="dropdown-menu alram" aria-labelledby="dropdownMenuButton">
			<ul id = "alramList" class="list-group">
			</ul>
		 </div>
		
	</div>
	    
	
		<!-- 상단 로그인 아이콘 -->  
	<div class="btn-group rpadding loginwidth" style="margin-left: -12px;" >
	
		<button class="btn btn-secondary dropdown-toggle" type="button" id="dropdownMenuButton" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
		   <span class="fas fa-user"></span>
		</button>
		<!-- 로그인  드롭다운-->
		<!-- 로그인 상태 -->
	    <c:if test="${login}">
	       <div class="dropdown-menu center" style="margin-left: -115px;">
	         <h5>${usernick}님 반갑습니다 :)</h5>
	    	 <div class="dropdown-divider"></div>
	    	 <c:choose>
		    	 	<c:when test="${socialType eq 'Google'}">
		    	 		<button id="logout" class="btn btn-danger  logt" style="margin-right: 20px; margin-left:20px;">로그아웃</button>
		    	 	</c:when>
		    	 	<c:when test="${socialType eq 'Kakao'}">
		    	 		<button id="logout" class="btn btn-danger  logt" style="margin-right: 20px; margin-left:20px;">로그아웃</button>
		    	 	</c:when>
		    	 	<c:when test="${socialType eq 'Naver'}">
		    	 		<button id="logout" class="btn btn-danger  logt" style="margin-right: 20px; margin-left:20px;">로그아웃</button>
		    	 	</c:when>
		    	 	<c:otherwise>
		    	 		<input id="mypage" class="btn btn-light" onclick="location.href='/mypage/main'" value="마이페이지">
		    	 		<button id="logout" class="btn btn-danger  logt" >로그아웃</button>
		    	 	</c:otherwise>
	    	 	 </c:choose>
<!-- 				<button id="logout" class="btn btn-danger  logt" >로그아웃</button> -->
	       </div>
	    </c:if>
	    
	    <!-- 로그아웃 상태 -->
	    <c:if test="${not login}">
	       <div class="dropdown-menu " id="dpMenu" style="margin-left: -115px;">
	       
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
		                <img width="77%" height="55" style="margin-left: 30px; " src="/resources/img/g.jpg"/>
		             </a>
		          </div>
		          <!-- 네이버 로그인 창으로 이동 -->
		          <div id="naver_id_login" style="text-align: center;" class="col-4">
		             <a href="${naver_url}"> 
		             <img width="75%" height="55" src="/resources/img/n.jpg" /></a>
		          </div>
		          <!-- 카카오 로그인 창으로 이동 -->
		          <div id="kakao_id_login" style="text-align: center;" class="col-4">
		             <a href="${kakao_url}">
		             <img width="75%" height="55" style=" margin-left: -35px;" src="/resources/img/k.jpg" /></a>
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

      <!-- Modal Header1 -->
      <div class="modal-header1">
        <h4 class="modal-title" style="text-align: center;margin-top: 5%;">아이디 찾기</h4>
      </div>

      <!-- Modal body1 -->
      <div class="modal-body content1">
      
       <div class="form-group">
        <label for="idFindByUsername">이름</label>
        <input type="text" class="form-control" id="idFindByUsername" placeholder="이름 입력" name="idFindByUsername" required>
       </div>
       <div class="form-group">
        <label for="idFindByUserphone">휴대전화</label>
        <input type="tel" class="form-control" id="idFindByUserphone" placeholder="'-'없이 번호만 입력해주세요" name="idFindByUserphone" required>
      </div>
      
      <div class="modal-footer1">
        <button class="btn btn-dark"  id="findIdOkBtn">확인</button>
        <button class="btn btn-dark" data-dismiss="modal">취소</button>
      </div>
      
      </div>
      
      <!-- Modal Header2 -->
      <div class="modal-header2">
       		<h4 class="modal-title" style="text-align: center;">비밀번호 찾기</h4>
      </div>
       
      <!-- Modal body2 -->
      <div class="modal-body content2" style="padding-bottom: 0%;">
 
            <div class="form-group">
	             <label for="pwFindByUserid">이메일주소</label>
	             <input type="text" class="form-control" id="pwFindByUserid" placeholder="이메일을 입력해주세요" name="pwFindByUserid" required>
            </div>
            <div class="form-group">
	             <label for="pwFindByUsername">이름</label>
	             <input type="text" class="form-control" id="pwFindByUsername" placeholder="이름을 입력해주세요" name="pwFindByUsername" required>
            </div>

      
      </div>
     
      <!-- Modal footer2 -->
      <div class="modal-footer2">
        <button class="btn btn-dark" id="findPwOkBtn" style="margin-left: 3%; margin-bottom: 3%">확인</button>
        <button class="btn btn-dark" data-dismiss="modal" style="margin-bottom: 3%;">취소</button>
      </div>

    </div>
  </div>
</div>


<!-- 아이디 찾기 확인버튼 누르면 나오는 모달 -->
<div class="modal fade" id="searchIdPw">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content">

      <!-- Modal Header -->
      <div class="modal-header">
        <h4 class="modal-title">아이디 찾기</h4>
      </div>

      <!-- Modal body -->
      <div class="modal-body content">
      </div>

      <!-- Modal footer -->
      <div class="modal-footer">
        <button class="btn btn-dark" data-dismiss="modal" id=seachIdPwBtnOk>확인</button>
      </div>

    </div>
  </div>
</div>

<!-- 비밀번호찾기 버튼 누르면 나오는 모달 -->
<div class="modal fade" id="searchIdPw2">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content">

      <!-- Modal Header -->
      <div class="modal-header">
        <h4 class="modal-title">비밀번호 찾기</h4>
      </div>

      <!-- Modal body -->
      <div class="modal-body content">
      </div>

      <!-- Modal footer -->
      <div class="modal-footer">
        <button class="btn btn-dark" data-dismiss="modal" id=searchIdPwBtnOk2>확인</button>
      </div>
    </div>
  </div>
</div>

<!-- 로그아웃 버튼 누르면 나오는 모달 -->
<div class="modal fade" id="logoutModal">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content">

      <!-- Modal Header -->
      <div class="modal-header">
        <h4 class="modal-title">알림</h4>
      </div>

      <!-- Modal body -->
      <div class="modal-body content"></div>

      <!-- Modal footer -->
      <div class="modal-footer">
        <button class="btn btn-dark" data-dismiss="modal" id=logoutBtnOk>확인</button>
        <button class="btn btn-dark" data-dismiss="modal">취소</button>
      </div>
    </div>
  </div>
</div>