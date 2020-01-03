<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>      
<jsp:include page="/WEB-INF/views/layout/header.jsp"/> 

<script type="text/javascript">
$(document).ready(function() {
	
	recheckAction();
	
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
	
	//추천버튼 동작
	$("#recommendtd").on("click", "#recommend", function() {
// 		$(location).attr("href", "/board/recommend?boardno=${viewBoard.boardno }");
		console.log("추천버튼 눌림");
		recommendAction();
	});

});

function recommendAction() {
	$.ajax({
		type : "get",
		url : "/board/recommend",
		data : {
			boardno : '${board.boardno }'
		},
		dataType : "html",
		success : function(data) {
			console.log("성공")
			console.log(data)

			$("#recommendtd").html(data)
		},
		error : function() {
			$("#freeLikeLoginModal").modal({backdrop: 'static', keyboard: false});
		}
	});
}

function recheckAction() {
	$.ajax({
		type : "get",
		url : "/board/recheck",
		data : {
			boardno : '${board.boardno }'
		},
		dataType : "html",
		success : function(data) {
			console.log("성공")
			console.log(data)

			$("#recommendtd").html(data)
		},
		error : function() {
			console.log("실패연 하이하이");
		}
	});
}

//댓글 슬라이드토글
$(document).ready(function(){
	$('#writereply').click(function() {
		$('#replyinputbody').slideToggle("fast");
	});
});

//대댓글 슬라이드토글
$(document).ready(function(){
	$('#rereply').click(function() {
		$('#rereplybody').slideToggle("fast");
	});
});
$(document).ready(function() {
	// 댓글 입력
	$("#btnCommInsert").click(function() {

		if($('#recontents').val() == ''){
			$("#replyerror").modal({backdrop: 'static', keyboard: false});
		}else{
			
		
		
		$form = $("<form>").attr({
			action: "/freereply/insert",
			method: "post"
		}).append(
			$("<input>").attr({
				type:"hidden",
				name:"boardno",
				value:"${board.boardno }"
			})
		).append(
			$("<input>").attr({
				type:"hidden",
				name:"userno",
				value:"${LoginUser.userno }"
			})
		).append(
			$("<textarea>")
				.attr("name", "recontents")
				.css("display", "none")
				.text($("#recontents").val())
		);
		$(document.body).append($form);
		$form.submit();
		}
	});
});
	
//댓글 삭제
function deleteReply(replyno) {
	$.ajax({
		type: "post"
		, url: "/freereply/delete"
		, dataType: "json"
		, data: {
			replyno: replyno
		}
		, success: function(data){
			if(data.success) {
				console.log(replyno);
				$("[data-replyno='"+replyno+"']").remove();
				
			} else {
				alert("댓글 삭제 실패");
			}
		}
		, error: function() {
			console.log("error");
		}
	});
}

</script>

<style type="text/css">

#text{
	
}

#recommendtd{
	font-size: 18px;
}

</style>

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
			<td colspan="1" style="width: 45%; padding-top: 16px;"><i class="far fa-user" style="padding-right: 10px"></i>${board.usernick }</td>
			<td colspan="1" style="width: 25%; padding-top: 16px;"><i class="far fa-clock" style="padding-right: 10px"></i>${board.writtendate }</td>
<!-- 			<td class="info">추천수</td> -->
<!-- 			<td colspan="1" style="width: 15%">[ 1203 ]</td> -->
<!-- 			<td class="info">조회수</td> -->
			<td colspan="1" style="width: 15%; padding-top: 16px;"><i class="fas fa-eye" style="padding-right: 5px; width: 3.125em;"></i>${board.views }</td>
			<td colspan="1" style="width: 15%" id="recommendtd" ></td>
		</tr>
<!-- 		<tr><td class="info"  colspan="4">본문</td></tr> -->
	
		<tr><td colspan="4">${board.contents }</td></tr>

		<tr>
			<c:if test="${not empty file }">
			<td colspan="4"><a href="/board/download?fileno=${file.fileno }">${file.originname }</a></td>
			</c:if>
		</tr>
</table>

  <!-- 댓글 처리 -->
<div>

	
		<%-- 댓글입력 시 이동 위치 --%>
<!-- 비로그인상태 -->
<c:if test="${not login }">
<strong>로그인이 필요합니다</strong><br>
</c:if>

<!-- 로그인상태 -->
<c:if test="${login }">
<!-- 댓글 입력 -->
<div>
<div style="text-align: left; margin-bottom: 5px;">
		<a><button id="writereply" class="btn  bbc" type="button">댓글작성</button></a>
</div>

<div id = "replyinputheader">
	코멘트 남기기
</div>
<div  id = "replyinputbody" class="form-inline text-center col-9" style="display: none;">
	<div class="row">
	<div class="col-11">
	<input type="hidden"  id="userno" name="userno" value="${board.userno }" />
	<input type="hidden"  id="boardno" name="boardno" value="${ board.boardno}" />
<%-- 	<input type="text" size="10" class="form-control" id="replyWriter" name = "usernick" value="${LoginUser.usernick }" readonly="readonly"/> --%>
	<textarea rows="2" style="width: 626px;" class="form-control" id="recontents" name="recontents" ></textarea>
	</div>
	<div class="col-1">
	<button id="btnCommInsert" class="btn bbc" style="
    margin-left: 40px;">입력</button>
	</div>
	</div>
</div>	<!-- 댓글 입력 end -->
</div>

</c:if>

<br>


<c:forEach items="${replyList }" var="reply">

		<div class="container container-fluid" style="margin-bottom: 40px">
			<div id = "reply_head" class="col-xs-12 col-sm-6 col-md-8">
				<span>${reply.usernick }</span>
				<div id = "reply_date" class="col-md-4" style="font-size: 13px;">
					${reply.replydate}
				</div>
			</div>
		<div id = "view_recontents" class="col-xs-12 col-sm-6 col-md-8" >
			<div id = "recontents"  class="col-md-4" >
				${reply.recontents }
			</div>
				<c:if test="${login }">
				<br><br>
					<div id = "rereplyBtn" class="col-md-2"style="float:left" >
						<a ><button id="rereply" class="btn  bbc" type="button">답글</button></a>
					</div>
				</c:if>
				<c:if test="${LoginUser.userno eq reply.userno }">
					<div id = "deleteReplyBtn"  class="col-md-2"  >
					<button class="btn btn-default btn-xs" 
						onclick="deleteReply(${reply.replyno });">삭제</button>
					</div>
				</c:if>
					<div id = "rereplybody" class="form-inline text-center col-9" style = "display: none;">
						<textarea rows="2" cols="50" class="form-control" id="rerecontents" name="rerecontents" ></textarea>
						<button id="btnrereplyInsert" class="btn bbc">입력</button>
					</div>
		</div>
		<!-- 글내용 -->
		<!-- 버튼 -->
		
		</div>
	
</c:forEach>

</div>	<!-- 댓글 처리 end -->

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
      <c:choose>
      	<c:when test="${file.fileno eq null }">
      	<a href="/board/freedelete?boardno=${board.boardno }" class="btn btn-default" style="float: right; background-color: #343a40; color: white;" role="button">확인</a>
      	</c:when>
      	<c:otherwise>
        <a href="/board/freedelete?boardno=${board.boardno }&fileno=${file.fileno }" class="btn btn-default" style="float: right; background-color: #343a40; color: white;" role="button">확인</a>
      	</c:otherwise>
      </c:choose>
        <button type="submit" id="freeCancelBtn"class="btn btn-default" style="float: right; background-color: #343a40; color: white;" data-dismiss="modal" >취소</button>
      </div>

    </div>
  </div>
</div>

<!-- 로그인 부탁 모달-->
<div class="modal fade" id="freeLikeLoginModal">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content">

      <!-- Modal Header -->
      <div class="modal-header">
        <h4 class="modal-title">로그인 필요!</h4>
        <button id="freeLikeLoginX" type="button" class="close" data-dismiss="modal">&times;</button>
      </div>

      <!-- Modal body -->
      <div class="modal-body content">
      	로그인 후 좋아요가 가능합니다.
      </div>

      <!-- Modal footer -->
      <div class="modal-footer">
        <button type="submit" id="freeLikeLoginModalBtn"class="btn btn-danger" data-dismiss="modal">확인</button>
      </div>

    </div>
  </div>
</div>

</div>
<br>
<br>
<jsp:include page="/WEB-INF/views/layout/footer.jsp"/> 
