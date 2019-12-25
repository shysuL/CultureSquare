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

/* tr td:not(:nth-child(2)){ */
/* 	text-color:#1a3a5a; */
	
/* } */


tr td:not(:first-child), tr th:not(:first-child) {
	border-left: 1px solid white;
}

.src{
	text-align: center;
}

</style>

<script type="text/javascript">

$(document).ready(function(){
    //최상단 체크박스 클릭
    $("#checkAll").click(function(){
        //클릭되었으면
//         console.log($("#checkAll").prop("checked"));
        if($("#checkAll").prop("checked")){
            //input태그의 name이 chk인 태그들을 찾아서 checked옵션을 true로 정의
            $("input[name=checkRow]").prop("checked",true);
            //클릭이 안되있으면
        }else{
            //input태그의 name이 chk인 태그들을 찾아서 checked옵션을 false로 정의
            $("input[name=checkRow]").prop("checked",false);
        }
    });
});

</script>

<%-- <c:forEach items="${boardlist }" var="list"> --%>
<%-- ${list.board_no } ${list.title } ${list.content } ${list.writer_id } ${list.writer_nick } --%>
<%-- ${list.hit } ${list.write_date }<br> --%>
<%-- </c:forEach> --%>
<div class="container">
<form action="/list/delete" method="get">
<table class="table table-border table-hover table-condesed table-stripe">
<tr style="color: #1a3a5a" class= "info">
	<th><input type="checkbox" id="checkAll" /></th>
	<th style="width: 10%">글번호</th>
	<th style="width: 50%">제목</th>
	<th style="width: 15%">아이디</th>
	<th style="width: 15%">닉네임</th>
	<th style="width: 10%">조회수</th>
	<th style="width: 15%">작성일</th>
</tr>

<c:forEach items = "${boardlist }" var = "list">
	<tr>
	<td><input type="checkbox" name="checkRow" value="${list.boardno }"/></td>
		<td style="color: #1a3a5a">${list.boardno }</td>
		<td style="color: #1a3a5a"><a href="/board/view?board_no=${list.boardno }">${list.title }</a></td>
<%-- 		<td style="color: #1a3a5a">${list.content }</td> --%>
		<td style="color: #1a3a5a">${list.userid }</td>
<%-- 		<td style="color: #1a3a5a">${list.usernick }</td> --%>
<%-- 		<td style="color: #1a3a5a">${list.views }</td> --%>
		<td style="color: #1a3a5a">${list.writtendate }</td>
	</tr>
</c:forEach>
</table>

<c:if test="${login }">
<div style="text-align: right;">
<a href="/board/write"><button type="button" class="btn btn-primary btn-sm">글쓰기</button></a>
<button class="btn btn-primary btn-sm">삭제</button>
</div>
</c:if>
</form>
<div class="src">
	<form action="/board/list" method="get">
	<input name="search" type="text" placeholder = "검색어 입력">
	<button>검색</button>
	</form>
</div>


<jsp:include page = "/WEB-INF/views/layout/paging.jsp" />


</div><!-- .container -->
 
<jsp:include page="/WEB-INF/views/layout/footer.jsp"/>  


</body>
</html>