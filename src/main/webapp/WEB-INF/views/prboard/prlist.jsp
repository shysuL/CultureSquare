<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>


<c:forEach var="i" items="${paging.search2 }">
<c:if test="${i.key=='searchType' }">
   <c:set var="searchType" value="${i.value }"/>
</c:if>
<c:if test="${i.key=='keyword' }">
   <c:set var="keyword" value="${i.value }"/>
</c:if>
</c:forEach>
<c:set var="query" value="&searchType=${searchType}&keyword=${keyword }"/>


<jsp:include page="/WEB-INF/views/layout/header.jsp" />

<script type="text/javascript">
$(document).ready(function() {
	
	//로그인 했을 경우 글쓰기 버튼 누르면 하루 쓴 게시글 검사
	$("#LoginWrite").click(function() {
		
		$.ajax({
			type:"post",
			url:"/prboard/checkWriteDate",
			datatype: "json",
			success : function(res){
				console.log(res.time)
				//1분 지났거나 안썼을 경우
				if(res.time){
					//글 쓰기 폼으로 이동
					location.href="/prboard/write";
					return false;
				} else {
					$(".content").text('하루에 1개의 게시글 작성이 가능합니다.');
					$("#prcntOverModal").modal({backdrop: 'static', keyboard: false});
					return false;
				}
			}
		})
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
    padding-top: 120px;
    padding-bottom: 50px;
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
	right: -355px;
}

</style>
<br><br>

<div class="container" style="position: relative">
<!-- Page Heading -->
  <h1 class="my-4">Page Heading
    <small>Secondary Text</small>
  </h1>

<form action="/prboard/prlist" method="get">
<div style="margin: 1%">
<select name="searchType">
	<option value="title">제목</option>
	<option value="usernick">닉네임</option>
	<option value="prname">게시판 유형</option>
</select>
<input type="text" id="search" name="search">
<button>검색</button>
</div>
</form>

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
<c:forEach items="${list }" var="prboard">
	<div class="col-lg-3 col-md-4 col-sm-6 mb-4">
      <div class="card h-100">
        <a href="#"><img class="card-img-top" src="http://placehold.it/700x400" alt=""></a>
        <div class="card-body">
        	 <p class="card-text">${prboard.prname }</p>
          <h4 class="card-title">
            <a href="#">${prboard.title }</a>
          </h4>
          <p class="card-text">${prboard.usernick}</p>
        </div>
      </div>
    </div>
</c:forEach>
 </div> <!-- row -->

  <ul class="pagination justify-content-center">
  <jsp:include page="/WEB-INF/views/layout/prpaging.jsp" />
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

<!-- pr 게시글 횟수 초과 -->
<div class="modal fade" id="prcntOverModal">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content">

      <!-- Modal Header -->
      <div class="modal-header">
        <h4 class="modal-title">PR 게시글 작성 불가!</h4>
        <button id="inputPwX" type="button" class="close" data-dismiss="modal">&times;</button>
      </div>

      <!-- Modal body -->
      <div class="modal-body content">
      </div>

      <!-- Modal footer -->
      <div class="modal-footer">
        <button type="submit" id="prCntOverCheckBtn"class="btn btn-info" data-dismiss="modal">확인</button>
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

