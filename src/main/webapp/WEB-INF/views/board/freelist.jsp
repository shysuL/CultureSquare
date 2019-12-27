<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>  
<jsp:include page="/WEB-INF/views/layout/header.jsp"/>   

<script type="text/javascript">
$(document).ready(function() {
	
	//로그인 했을 경우 글쓰기 버튼 누르면 이동
	$("#LoginWrite").click(function() {
		location.href="/board/freewrite";
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

table, th {
	text-align: center;
}

tr td:nth-child(2){
	text-align: left;
	
}

#freeIntroduceTitle{
	width: 340px;
    padding-top: 400px;
    padding-bottom: 50px;
}

#freeRankTitle{
	width: 340px;
    padding-top: 400px;
    padding-bottom: 50px;
}

#freeIntroduceContent{
	background-color:#343a40; 
	color:white;
}

#freeRankContent{
	background-color:#343a40; 
	color:white;
}

#side{
	position:absolute;
	top: 0;
	right: 50px;
}

/* tr td:not(:nth-child(2)){ */
/* 	text-color:#1a3a5a; */
	
/* } */


tr td:not(:first-child), tr th:not(:first-child) {
	border-left: 1px solid white;
}

.src{
	text-align: center;
}

.far{
    line-height: 3;	
}
</style>

<!-- <script type="text/javascript"> -->

<!-- // $(document).ready(function(){ -->
<!-- //     //최상단 체크박스 클릭 -->
<!-- //     $("#checkAll").click(function(){ -->
<!-- //         //클릭되었으면 -->
<!-- // //         console.log($("#checkAll").prop("checked")); -->
<!-- //         if($("#checkAll").prop("checked")){ -->
<!-- //             //input태그의 name이 chk인 태그들을 찾아서 checked옵션을 true로 정의 -->
<!-- //             $("input[name=checkRow]").prop("checked",true); -->
<!-- //             //클릭이 안되있으면 -->
<!-- //         }else{ -->
<!-- //             //input태그의 name이 chk인 태그들을 찾아서 checked옵션을 false로 정의 -->
<!-- //             $("input[name=checkRow]").prop("checked",false); -->
<!-- //         } -->
<!-- //     }); -->
<!-- // }); -->

<!-- </script> -->

<div class="container" style="
    position: relative;
    padding-left: 200px;
    padding-right: 200px;
    right: 150px;
">
<h1></h1>
<hr>

         <h2>자유게시판</h2>

<div style="background-color: #343a40;height: 50px;">
<i class="fas fa-list" style= "color: #ffff;margin-left: 20px;"></i>
<i class="far fa-user" style= "color: #ffff;margin-left: 435px;"></i>
<i class="fas fa-eye" style= "color: #ffff;margin-left: 90px;"></i>
<i class="far fa-clock" style= "color: #ffff;margin-left: 70px;"></i>
</div>

<!-- <form action="/list/delete" method="get"> -->
<table class="table table-border table-hover table-condesed table-stripe" style="color: #343a40;">


<c:forEach items = "${boardlist }" var = "list">
	<tr>
<%-- 	<td><input type="checkbox" name="checkRow" value="${list.boardno }"/></td> --%>
		<td style="color: #1a3a5a; width: 5%;">${list.boardno }</td>
		<td style="color: #1a3a5a; width: 50%;"><a href="/board/freeview?boardno=${list.boardno }">${list.title }</a></td>
		<td style="color: #1a3a5a; width: 20%;">${list.usernick }</td>
		<td style="color: #1a3a5a; width: 10%;">${list.views }</td>
		<td style="color: #1a3a5a; width: 15%;">${list.writtendate }</td>
	</tr>
</c:forEach>

</table>
<div id="side" style="
    left: 1000px;
    top: -320px;
    bottom: 0px;
    height: 100px;
">
	<div class="list-group" id="freeIntroduceTitle">
  <a class="list-group-item" id="freeIntroduceContent">
	자유게시판 소개
  </a>
  <a href="#" class="list-group-item">Dapibus ac facilisis in</a>
</div>

<div class="list-group" id="freeRankTitle">
  <a class="list-group-item" id="freeRankContent">
	자유게시판 순위
  </a>
  <a href="#" class="list-group-item">1등</a>
  <a href="#" class="list-group-item">2등</a>
  <a href="#" class="list-group-item">3등</a>
  <a href="#" class="list-group-item">4등</a>
  <a href="#" class="list-group-item">5등</a>
<!-- </div> -->
</div>
</div>

<span> 
	<c:choose>
		<c:when test="${not login}">
			<button id="notLoginWrite" class="btn btn-sm b-btn"
				style="float: right; background-color: #494b4d; color: white;">글작성</button>
		</c:when>
		<c:when test="${login}">
			<a href="/board/freewrite"><button id="LoginWrite"
					class="btn btn-sm b-btn"
					style="float: right; background-color: #494b4d; color: white;">글작성</button></a>
		</c:when>
	</c:choose>
</span>

<jsp:include page = "/WEB-INF/views/layout/freepaging.jsp" />

<div class="src">
	<form action="/board/freelist" method="get">
	<input name="search" type="text" placeholder = "검색어 입력">
	<button>검색</button>
	</form>
</div>

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

</div><!-- .container -->
 
<jsp:include page="/WEB-INF/views/layout/footer.jsp"/>  


</body>
</html>