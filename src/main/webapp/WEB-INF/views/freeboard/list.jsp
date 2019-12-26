<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>  
<jsp:include page="/WEB-INF/views/layout/header.jsp"/>   

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

#freeIntroduceContent{
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
    padding-left: 200px;
    padding-right: 200px;
">
<h1></h1>
<hr>
<!-- 	<div style="background-color: #252525;"> -->
         <h2>자유게시판</h2>
<!--     </div> -->
<div style="background-color: #343a40;height: 50px;">
<i class="fas fa-list" style= "color: #ffff;margin-left: 20px;"></i>
<i class="far fa-user" style= "color: #ffff;margin-left: 435px;"></i>
<i class="fas fa-eye" style= "color: #ffff;margin-left: 90px;"></i>
<i class="far fa-clock" style= "color: #ffff;margin-left: 70px;"></i>
</div>

<!-- <form action="/list/delete" method="get"> -->
<table class="table table-border table-hover table-condesed table-stripe" style="color: #343a40;">
<!-- <tr style="color: #1a3a5a" class= "info"> -->
<!-- 	<th><input type="checkbox" id="checkAll" /></th> -->
<!-- 	<th style="width: 10%">글번호</th> -->
<!-- 	<th style="width: 55%">제목</th> -->
<!-- 	<th style="width: 15%">아이디</th> -->
<!-- 	<th style="width: 10%">닉네임</th> -->
<!-- 	<th style="width: 10%">조회수</th> -->
<!-- 	<th style="width: 15%">작성일</th> -->
<!-- </tr> -->

<c:forEach items = "${boardlist }" var = "list">
	<tr>
<%-- 	<td><input type="checkbox" name="checkRow" value="${list.boardno }"/></td> --%>
		<td style="color: #1a3a5a; width: 5%;">${list.boardno }</td>
		<td style="color: #1a3a5a; width: 50%;"><a href="/freeboard/view?boardno=${list.boardno }">${list.title }</a></td>
<%-- 		<td style="color: #1a3a5a">${list.content }</td> --%>
<%-- 		<td style="color: #1a3a5a">${list.userid }</td> --%>
		<td style="color: #1a3a5a; width: 20%;">${list.usernick }</td>
		<td style="color: #1a3a5a; width: 10%;">${list.views }</td>
		<td style="color: #1a3a5a; width: 15%;">${list.writtendate }</td>
	</tr>
</c:forEach>

</table>
<div id="side">
	<div class="list-group" id="freeIntroduceTitle">
  <a class="list-group-item" id="freeIntroduceContent">
	자유게시판 소개
  </a>
  <a href="#" class="list-group-item">Dapibus ac facilisis in</a>
</div>
</div>


<%-- <c:if test="${login }"> --%>
<div style="text-align: right;">
<a href="/freeboard/write"><button class="btn btn-default btn-sm" style="float: right; background-color: #343a40; color: white;">글쓰기</button></a>
<!-- <button class="btn btn-default btn-sm" style="float: right; background-color: #494b4d; color: white;">삭제</button> -->
</div>
<%-- </c:if> --%>
<!-- </form> -->



<jsp:include page = "/WEB-INF/views/layout/freepaging.jsp" />

<div class="src">
	<form action="/freeboard/list" method="get">
	<input name="search" type="text" placeholder = "검색어 입력">
	<button>검색</button>
	</form>
</div>

</div><!-- .container -->
 
<jsp:include page="/WEB-INF/views/layout/footer.jsp"/>  


</body>
</html>