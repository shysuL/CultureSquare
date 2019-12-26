<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>CultureSquare</title>
<!-- 부트스트랩 -->
<script src="https://code.jquery.com/jquery-3.4.1.slim.min.js" integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n" crossorigin="anonymous"></script>
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

<style type="text/css">
.culture { 
   width: 250px;
   height:230px;
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
.logindrop{
   padding-left: 100px;
}
</style>

</head>
<body>

<!-- header --> 
<div class="wrap">


<nav class="navbar navbar-expand-md navbar-dark fixed-top bg-dark">
  <a class="navbar-brand" href="#">CultureSquare</a>
  <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarCollapse" aria-controls="navbarCollapse" aria-expanded="false" aria-label="Toggle navigation">
    <span class="navbar-toggler-icon"></span>
  </button>
  
	<div class="collapse navbar-collapse" id="navbarCollapse">
	    <ul class="navbar-nav mr-auto">
	      <li class="nav-item active">
	        <a class="nav-link" href="#">공지사항<span class="sr-only">(current)</span></a>
	      </li>
	      <li class="nav-item">
	        <a class="nav-link" href="#">자유 게시판</a>
	      </li>
	      <li class="nav-item">
	        <a class="nav-link" href="#">CALENDAL</a>
	      </li>
	      <li class="nav-item">
	        <a class="nav-link" href="#">PR</a>
	      </li>
	      <li class="nav-item">
	        <a class="nav-link" href="#">FAQ</a>
	      </li>
	    </ul>
	<!-- 우측 상단 아이콘 -->
	<div class="btn-group logindrop">
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
	       <div class="dropdown-menu ">
	         <div class="dropdown-divider"></div>
	           <h3>로그인 된 상태</h3>
	          <button id="logout" class="btn btn-danger" onclick="location.href='/logout'">로그아웃</button>
	        </div>
	    </c:if>
	    <!-- 로그아웃 상태 -->
	    <c:if test="${not login}">
	       <div class="dropdown-menu ">
	          <form class="px-4 py-3">
	             <div class="form-group">
	                <label for="exampleDropdownFormEmail1">Email address</label> <input
	                   type="email" class="form-control"
	                   id="exampleDropdownFormEmail1" placeholder="email@example.com">
	             </div>
	             <div class="form-group">
	                <label for="exampleDropdownFormPassword1">Password</label> <input
	                   type="password" class="form-control"
	                   id="exampleDropdownFormPassword1" placeholder="Password">
	             </div>
	             <div class="form-group">
	                <div class="form-check">
	                   <input type="checkbox" class="form-check-input"
	                      id="dropdownCheck"> <label class="form-check-label"
	                      for="dropdownCheck"> Remember me </label>
	                </div>
	             </div>
	             <button type="submit" id="login" class="btn btn-primary">로그인</button>
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