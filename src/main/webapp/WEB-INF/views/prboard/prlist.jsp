<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<jsp:include page="/WEB-INF/views/layout/header.jsp" />

<script type="text/javascript">
$(document).ready(function() {
	
	//로그인 했을 경우 글쓰기 버튼 누르면 이동
	$("#LoginWrite").click(function() {
		location.href="/prboard/write";
		return false;
	});
	
	//로그인 안했을 경우 글쓰기 버튼 누르면 모달
	$("#notLoginWrite").click(function() {
		$(".content").text('로그인 후 게시글 작성이 가능합니다.');
		$("#prNotLoginModal").modal({backdrop: 'static', keyboard: false});
		return false;
	});
	
});
</script>

<style type="text/css">
#carouselExampleFade img {
	width: 800px;
	height: 400px;
}

#prIntroduceTitle{
	width: 340px;
    padding-top: 400px;
    padding-bottom: 50px;
}
}

#prRankTitle{
	width: 340px;
}

#prIntroduceContent{
	background-color:#343a40; 
	color:white;
}

#prRankContent{
	background-color:#343a40; 
	color:white;
}

#side{
	position:absolute;
	top: 0;
	right: -340px;
}


</style>
<br><br>

<div class="container" style="position: relative">
<!-- Page Heading -->
  <h1 class="my-4">Page Heading
    <small>Secondary Text</small>
  </h1>

<!-- <form action="/manager/counselormanage" method="get"> -->
<div style="margin: 1%">
<select name="searchType">
	<option value="albumPR">앨범 홍보</option>
	<option value="showPR">공연 홍보</option>
	<option value="exhibitionPR">전시회 홍보</option>
</select>
<input type="text" id="search" name="search">
<button>검색</button>
</div>
<!-- </form> -->

<div style="margin-top:20px; margin-bottom: 20px;">
<span >
		<a href="#"> <img src="/resources/img/time.png" /></a>
		<a href="#"> <img src="/resources/img/view.png" style="padding-left: 10px;"/></a>
		<a href="#"> <img src="/resources/img/like.png" style="padding-left: 10px;"/></a>
</span>
<span>
		<c:choose>
			<c:when test="${not login}">
				<button id="notLoginWrite" class="btn btn-md b-btn" style="float: right; background-color: #494b4d; color: white;">글작성</button>
			</c:when>
			<c:when test="${login}">
				<button id="LoginWrite" class="btn btn-md b-btn" style="float: right; background-color: #494b4d; color: white;">글작성</button>
			</c:when>
		</c:choose>
		
</span>
</div>
  <div class="row">
    <div class="col-lg-3 col-md-4 col-sm-6 mb-4">
      <div class="card h-100">
        <a href="#"><img class="card-img-top" src="http://placehold.it/700x400" alt=""></a>
        <div class="card-body">
          <h4 class="card-title">
            <a href="#">Project One</a>
          </h4>
          <p class="card-text">Lorem ipsum dolor sit amet, consectetur adipisicing elit. Amet numquam aspernatur eum quasi sapiente nesciunt? Voluptatibus sit, repellat sequi itaque deserunt, dolores in, nesciunt, illum tempora ex quae? Nihil, dolorem!</p>
        </div>
      </div>
    </div>
    <div class="col-lg-3 col-md-4 col-sm-6 mb-4">
      <div class="card h-100">
        <a href="#"><img class="card-img-top" src="http://placehold.it/700x400" alt=""></a>
        <div class="card-body">
          <h4 class="card-title">
            <a href="#">Project Two</a>
          </h4>
          <p class="card-text">Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam viverra euismod odio, gravida pellentesque urna varius vitae.</p>
        </div>
      </div>
    </div>
    <div class="col-lg-3 col-md-4 col-sm-6 mb-4">
      <div class="card h-100">
        <a href="#"><img class="card-img-top" src="http://placehold.it/700x400" alt=""></a>
        <div class="card-body">
          <h4 class="card-title">
            <a href="#">Project Three</a>
          </h4>
          <p class="card-text">Lorem ipsum dolor sit amet, consectetur adipisicing elit. Quos quisquam, error quod sed cumque, odio distinctio velit nostrum temporibus necessitatibus et facere atque iure perspiciatis mollitia recusandae vero vel quam!</p>
        </div>
      </div>
    </div>
    <div class="col-lg-3 col-md-4 col-sm-6 mb-4">
      <div class="card h-100">
        <a href="#"><img class="card-img-top" src="http://placehold.it/700x400" alt=""></a>
        <div class="card-body">
          <h4 class="card-title">
            <a href="#">Project Four</a>
          </h4>
          <p class="card-text">Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam viverra euismod odio, gravida pellentesque urna varius vitae.</p>
        </div>
      </div>
    </div>
    <div class="col-lg-3 col-md-4 col-sm-6 mb-4">
      <div class="card h-100">
        <a href="#"><img class="card-img-top" src="http://placehold.it/700x400" alt=""></a>
        <div class="card-body">
          <h4 class="card-title">
            <a href="#">Project Five</a>
          </h4>
          <p class="card-text">Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam viverra euismod odio, gravida pellentesque urna varius vitae.</p>
        </div>
      </div>
    </div>
    <div class="col-lg-3 col-md-4 col-sm-6 mb-4">
      <div class="card h-100">
        <a href="#"><img class="card-img-top" src="http://placehold.it/700x400" alt=""></a>
        <div class="card-body">
          <h4 class="card-title">
            <a href="#">Project Six</a>
          </h4>
          <p class="card-text">Lorem ipsum dolor sit amet, consectetur adipisicing elit. Itaque earum nostrum suscipit ducimus nihil provident, perferendis rem illo, voluptate atque, sit eius in voluptates, nemo repellat fugiat excepturi! Nemo, esse.</p>
        </div>
      </div>
    </div>
    <div class="col-lg-3 col-md-4 col-sm-6 mb-4">
      <div class="card h-100">
        <a href="#"><img class="card-img-top" src="http://placehold.it/700x400" alt=""></a>
        <div class="card-body">
          <h4 class="card-title">
            <a href="#">Project Seven</a>
          </h4>
          <p class="card-text">Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam viverra euismod odio, gravida pellentesque urna varius vitae.</p>
        </div>
      </div>
    </div>
    <div class="col-lg-3 col-md-4 col-sm-6 mb-4">
      <div class="card h-100">
        <a href="#"><img class="card-img-top" src="http://placehold.it/700x400" alt=""></a>
        <div class="card-body">
          <h4 class="card-title">
            <a href="#">Project Eight</a>
          </h4>
          <p class="card-text">Lorem ipsum dolor sit amet, consectetur adipisicing elit. Eius adipisci dicta dignissimos neque animi ea, veritatis, provident hic consequatur ut esse! Commodi ea consequatur accusantium, beatae qui deserunt tenetur ipsa.</p>
        </div>
      </div>
    </div>
  </div>
  <!-- /.row -->
  <!-- Pagination -->
  <ul class="pagination justify-content-center">
    <li class="page-item">
      <a class="page-link" href="#" aria-label="Previous">
            <span aria-hidden="true">&laquo;</span>
            <span class="sr-only">Previous</span>
          </a>
    </li>
    <li class="page-item">
      <a class="page-link" href="#">1</a>
    </li>
    <li class="page-item">
      <a class="page-link" href="#">2</a>
    </li>
    <li class="page-item">
      <a class="page-link" href="#">3</a>
    </li>
    <li class="page-item">
      <a class="page-link" href="#" aria-label="Next">
            <span aria-hidden="true">&raquo;</span>
            <span class="sr-only">Next</span>
          </a>
    </li>
  </ul>

<!-- 로그인 실패시 모달창 -->
<div class="modal fade" id="prNotLoginModal">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content">

      <!-- Modal Header -->
      <div class="modal-header">
        <h4 class="modal-title">로그아웃 상태</h4>
        <button id="inputPwX" type="button" class="close" data-dismiss="modal">&times;</button>
      </div>

      <!-- Modal body -->
      <div class="modal-body content">
      </div>

      <!-- Modal footer -->
      <div class="modal-footer">
        <button type="submit" id="prLoginCheckBtn"class="btn btn-info" data-dismiss="modal">확인</button>
      </div>

    </div>
  </div>
</div>
<div id="side">
	<div class="list-group" id="prIntroduceTitle">
  <a class="list-group-item" id="prIntroduceContent">
   PR 소개
  </a>
  <a href="#" class="list-group-item">Dapibus ac facilisis in</a>
</div>
<div class="list-group" id="prRankTitle">
  <a class="list-group-item" id="prRankContent">
   PR 순위
  </a>
  <a href="#" class="list-group-item">1등</a>
  <a href="#" class="list-group-item">2등</a>
  <a href="#" class="list-group-item">3등</a>
  <a href="#" class="list-group-item">4등</a>
  <a href="#" class="list-group-item">5등</a>
<!-- </div> -->
</div>
</div>
</div> <!-- 컨테이너 end -->


<jsp:include page="/WEB-INF/views/layout/footer.jsp" />

