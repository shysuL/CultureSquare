<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<jsp:include page="/WEB-INF/views/layout/header.jsp" />     
<style type="text/css">
#carouselExampleFade img {
	width: 800px;
	height: 400px;
}
</style>
<br><br>

<div class="container">

<c:choose>
	<c:when test="${not login}">
		<h1>로그아웃 상태</h1>
	</c:when>
	<c:when test="${login }">
		<h1>로그인 상태</h1>
		<h3>'${nickname}' 님 환영합니다!</h3>
	</c:when>
</c:choose>

<!-- 캐러셀영역 -->
<div id="carouselExampleFade" class="carousel slide carousel-fade" data-ride="carousel">
  <div class="carousel-inner">
    <div class="carousel-item active">
      <img src="/resources/slider/AIU.jpg" class="d-block w-100" alt="...">
    </div>
    <div class="carousel-item">
      <img src="/resources/slider/test.jpg" class="d-block w-100" alt="...">
    </div>
    <div class="carousel-item">
      <img src="/resources/slider/AIU3.jpg" class="d-block w-100" alt="...">
    </div>
    <div class="carousel-item">
      <img src="/resources/slider/test1.jpg" class="d-block w-100" alt="...">
    </div>
  </div>
  <a class="carousel-control-prev" href="#carouselExampleFade" role="button" data-slide="prev">
    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
    <span class="sr-only">Previous</span>
  </a>
  <a class="carousel-control-next" href="#carouselExampleFade" role="button" data-slide="next">
    <span class="carousel-control-next-icon" aria-hidden="true"></span>
    <span class="sr-only">Next</span>
  </a>
</div>
<!-- 캐러셀영역 END -->

<!-- 크롤링 영역 -->


<!-- 크롤링 영역 END -->
</div>


<jsp:include page="/WEB-INF/views/layout/footer.jsp" />

