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



#freeIntroduceContent{
	background-color:#343a40; 
	color:white;
}

#freeRankContent{
	background-color:#343a40; 
	color:white;
} 

tr td:not(:first-child), tr th:not(:first-child) {
	border-left: 1px solid white;
}

.src{
	text-align: center;
	width: 670px;
}

.far{
    line-height: 3;	
}

.tit { 
color: #343a40;
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

<div class="container" >
<hr>
<h2>자유게시판</h2>

<div class="row">
<!-- 게시판 리스트 -->
<div class="col-8">

<div style="background-color: #343a40; height: 50px;">
	<i class="fas fa-list" style= "color: #ffff;margin-left: 18px;" title="게시글 번호"></i>
	<i class="far fa-user" style= "color: #ffff;margin-left: 435px;" title="작성자 닉네임"></i>
	<a href="board/freelist" title="조회수, 클릭하시면 조회수 순으로 정렬"><i class="fas fa-eye" style= "color: #ffff;margin-left: 86px;"></i></a>
	<a href="board/freelist" title="게시글 작성 시간, 클릭하시면 시간 순으로 정렬"><i class="far fa-clock" style= "color: #ffff;margin-left: 70px;"></i></a>
</div>

<table class="table table-border table-hover table-condesed table-stripe" style="color: #343a40;">


<c:forEach items = "${boardlist }" var = "list">
	<tr>
<%-- 	<td><input type="checkbox" name="checkRow" value="${list.boardno }"/></td> --%>
		<td style="color: #1a3a5a; width: 5%;">${list.boardno }</td>
		<td style="color: #1a3a5a; width: 50%;"><a class="tit" href="/board/freeview?boardno=${list.boardno }">${list.title }</a></td>
		<td style="color: #1a3a5a; width: 20%;">${list.usernick }</td>
		<td style="color: #1a3a5a; width: 10%;">${list.views }</td>
		<td style="color: #1a3a5a; width: 15%;">${list.writtendate }</td>
	</tr>
</c:forEach>

</table>

<span> 
	<c:choose>
		<c:when test="${not login}">
			<button id="notLoginWrite" class="btn btn-sm b-btn"
				style="float: right; background-color: #343a40; color: white;">글작성</button>
		</c:when>
		<c:when test="${login}">
			<a href="/board/freewrite"><button id="LoginWrite"
					class="btn btn-sm b-btn"
					style="float: right; background-color: #343a40; color: white;">글작성</button></a>
		</c:when>
	</c:choose>
</span>

<jsp:include page = "/WEB-INF/views/layout/freepaging.jsp" />

<div class="src" >
	<form action="/board/freelist" method="get">
	<select name="searchcategory" style="
    height: 30px;">
	<option value="title">제목</option>
	<option value="usernick">닉네임</option>
<!-- 	<option value="prname">게시판 유형</option> -->
</select>
	<input id=search name="searchtarget" type="text" placeholder = "검색어 입력">
	<button>검색</button>
	</form>
</div>



</div>

<!-- 사이드 리스트 -->
<div class="col-4">

	<div class="list-group" id="freeIntroduceTitle">
	  <a class="list-group-item" id="freeIntroduceContent">자유게시판 소개</a>
	  <a class="list-group-item tit">모든 주제에 대해 여러사람들과 자유롭게 이용하는 게시판</a>
	</div>
	<br><br><br><br><br><br><br><br><br><br>
	
	<div class="list-group" id="freeRankTitle">
	  <a class="list-group-item" id="freeRankContent">자유게시판 최다 조회글</a>
	<c:forEach items = "${viewslist }" var = "views" varStatus="status">
	  <a href="/board/freeview?boardno=${views.boardno }" class="list-group-item tit">(${status.count}) ${views.title }</a>
	  </c:forEach>
	 </div>

</div>
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
