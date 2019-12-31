<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>      
<jsp:include page="/WEB-INF/views/layout/header.jsp"/> 

<script type="text/javascript">
$(document).ready(function() {
	//목록버튼 동작
	$("#btnList").click(function() {
		$(location).attr("href", "/board/freelist");
	});
		
	$("#deleteWrite").click(function() {
		$(".content").text('삭제 하시겠습니까?') 
		$("#deleteWriteModal").modal({
			backdrop : 'static',
			keyboard : false			
		});
		
		return false;
	});

});

</script>

<div class="container" style="
    padding-left: 200px;
    padding-right: 200px;
">

<h1></h1>
<hr>
<h2>자유게시판</h2>

<div class="container">
	<table class="table table-bordered">
		<tr>
<!-- 			<td class="info">제목</td> -->
			<td style="background-color: #343a40; color: #fff;" colspan="4">${board.title }</td>
		</tr>
	
		<tr>
			<!-- <td class="info">닉네임</td> -->
			<td colspan="2" style="width: 60%"><i class="far fa-user" style="padding-right: 10px"></i>${board.usernick }</td>
			<td colspan="1" style="width: 25%"><i class="far fa-clock" style="padding-right: 10px"></i>${board.writtendate }</td>
<!-- 			<td class="info">추천수</td> -->
<!-- 			<td colspan="1" style="width: 15%">[ 1203 ]</td> -->
<!-- 			<td class="info">조회수</td> -->
			<td colspan="1" style="width: 15%"><i class="fas fa-eye" style="padding-right: 5px; width: 3.125em;"></i>${board.views }</td>
		</tr>
<!-- 		<tr><td class="info"  colspan="4">본문</td></tr> -->
	
		<tr><td colspan="4">${board.contents }</td></tr>

		<tr>
			<td class="info" colspan="1">첨부파일</td><td colspan="3"><a href="/board/download?fileno=${file.fileno }">${file.originname }</a></td>
		</tr>
</table>
	<div class="text-center" >
		<button id="btnList" class="btn btn-default" style="float: left; background-color: #343a40; color: white;">목록</button>
		<c:if test="${usernick eq board.usernick}"> 
		<a id="deleteWrite" class="btn btn-default" style="float: right; background-color: #343a40; color: white;" role="button">삭제</a>
		<a class="btn btn-default" style="float: right; background-color: #343a40; color: white; white;margin-right: 1px;" href="/board/freemodifiy?boardno=${board.boardno }" role="button">수정</a>
		</c:if>
	</div>	
</div>
<!-- 게시글 삭제 모달창 -->
<div class="modal fade" id="deleteWriteModal">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content">

      <!-- Modal Header -->
      <div class="modal-header">
        <h4 class="modal-title">게시글 삭제</h4>
        <button id="inputPwX" type="button" class="close" data-dismiss="modal">&times;</button>
      </div>

      <!-- Modal body -->
      <div class="modal-body content">
      </div>

      <!-- Modal footer -->
      <div class="modal-footer">
        <a href="/board/freedelete?boardno=${board.boardno }&fileno=${file.fileno }" class="btn btn-default" style="float: right; background-color: #343a40; color: white;" role="button">확인</a>
        <button type="submit" id="freeCancelBtn"class="btn btn-default" style="float: right; background-color: #343a40; color: white;" data-dismiss="modal" >취소</button>
      </div>

    </div>
  </div>
</div>
</div>
<br>
<br>
<jsp:include page="/WEB-INF/views/layout/footer.jsp"/> 
