<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
    <%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>
<jsp:include page="/WEB-INF/views/layout/header.jsp" />  

<style type="text/css">
#view_head{
	background-color: #343a40;
	border: 1px solid black;
	max-width: 95%;
	height: 45px;
	text-align: center;
	color: white;
	padding: 6px;
}
#writer_head{
	background-color: #343a40;
	border: 1px solid black;
	max-width: 95%;
	height: 45px;
	text-align: center;
	color: white;
	padding: 6px;
}
.con_left{
	width: 68%;
	border: 1px solid black;
	float: left;
}
.con_right{
	width: 32%;
	border: 1px solid black;
	float: right;
}
#view_writer{
	border: 1px solid black;
	max-width: 95%;
    height: 35px;
	padding: 6px;

}
#view_content{
	border: 1px solid black;
	max-width: 95%;
	height: auto;
}
#writer_nick{
	width:30%;
	float: left;
}

#viewcount{
	width: 20%;
	float:right;
}
#write_date{
	width: 30%;
	float:right;
}

#view_buttonarea{
	max-width: 95%;
	text-align: right;
}
#writer_title{
	background-color: #343a40;
	color : white;
}
#writer_photo{
    width: 100px;
    height: 100px;
	float:left;
}
#profileImg{
	width:98px;
	height:98px;
	display: block;
	margin: 0 auto;
}

#writer_info{
    width: 150px;
    height: 100px;
	float:right;
	padding: 10px;
	text-align: center;
}
#side{
	position:absolute;
	right: 20px;
    top: 384px;
}
</style>

<h1> CALLENDAR </h1>
<hr>

<h2>VIEWVIEW</h2>

<div class="container container-fluid" style="margin-bottom: 600px">
<div id = "view_head" class="col-xs-12 col-sm-6 col-md-8">
<span style="">${view.title }</span>
</div>
<div id = "view_writer" class="col-xs-12 col-sm-6 col-md-8" >
	<div id = "writer_nick" class="col-md-4">
	${writer.usernick }
	</div>
	<div id = "write_date"  class="col-md-4">
	${view.writtendate }
		<div id = "viewcount">
		${view.views }
		</div>
	</div>


</div>


<div id = view_content class="col-xs-12 col-sm-6 col-md-8">
${view.contents }<br>
<br><br><br><br><br><br><br><br><br><br><br><br><br>
</div>


<div id = "view_buttonarea" class="btn col-md-4" role="group">
	<button type = "button" class="btn btn-default" style="background-color: #343a40 !important; color: white !important;">후원하기</button>
	<button type = "button" class="btn btn-default" style="background-color: #343a40 !important; color: white !important;">추천</button>
</div>
<div>&nbsp;</div><br>

<!-- 댓글 처리 -->
<div>

<hr>

<!-- 비로그인상태 -->
<c:if test="${not login }">
<strong>로그인이 필요합니다</strong><br>
</c:if>

<!-- 로그인상태 -->
<c:if test="${login }">
<!-- 댓글 입력 -->
${LoginUser.userno }
<div class="form-inline text-center">
	<input type="hidden"  id="userno" name="userno" value="${LoginUser.userno }" />
	<input type="hidden"  id="boardno" name="boardno" value="${ view.boardno}" />
	<input type="text" size="10" class="form-control" id="replyWriter" name = "usernick" value="${LoginUser.usernick }" readonly="readonly"/>
	<textarea rows="2" cols="60" class="form-control" id="recontents" name="recontents"></textarea>
	<button id="btnCommInsert" class="btn">입력</button>
</div>	<!-- 댓글 입력 end -->
</c:if>

<!-- 댓글 리스트 -->
<table class="table table-striped table-hover table-condensed">
<thead>
<tr>
	<th style="width: 5%;">번호</th>
	<th style="width: 10%;">작성자</th>
	<th style="width: 50%;">댓글</th>
	<th style="width: 20%;">작성일</th>
	<th style="width: 5%;"></th>
</tr>
</thead>
<tbody id="commentBody">
<c:forEach items="${replyList }" var="reply">
<tr data-commentno="${reply.replyno }">
	<td>${reply.rnum }</td>
	<td>${reply.userno }</td><!-- 닉네임으로 해도 좋음 -->
	<td>${reply.recontents }</td>
	<td>${reply.replydate}</td>
	<td>
		<c:if test="${sessionScope.userno eq reply.userno }">
		<button class="btn btn-default btn-xs"
			onclick="deleteComment(${reply.replyno });">삭제</button>
		</c:if>
	</td>
	
</tr>
</c:forEach>
</tbody>
</table>	<!-- 댓글 리스트 end -->

</div>	<!-- 댓글 처리 end -->



<ul id = "side" class="list-group">
  <li id = "writer_title" class="list-group-item">
	작성자 프로필
	</li>
  <li class="list-group-item">
  <div id = "writer_photo">
	<img id="profileImg" src="/resources/img/userdefaultprofile.png" class="img-responsive img-circle"
							alt="Responsive image">
</div>
  <div id = "writer_info">${writer.usernick } 
  <br>
  		<div> <button class="btn btn-default" style="background-color: #343a40 !important; color: white !important; margin-top: 15px;">
  		팔로우</button></div>
   </div>
   </li>
</ul>











<br><br>
</div> <!-- div_container -->

<jsp:include page="/WEB-INF/views/layout/footer.jsp" />


<script type="text/javascript">
$(document).ready(function() {
	// 댓글 입력
	$("#btnCommInsert").click(function() {
		// 게시글 번호.... ${viewBoard.boardno }
	//		console.log($("#commentWriter").val());
	//		console.log($("#commentContent").val());
		
		$form = $("<form>").attr({
			action: "/reply/insert",
			method: "post"
		}).append(
			$("<input>").attr({
				type:"hidden",
				name:"boardno",
				value:"${view.boardno }"
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
		
	});
	
});

// //댓글 삭제
// function deleteComment(commentNo) {
// 	$.ajax({
// 		type: "post"
// 		, url: "/comment/delete"
// 		, dataType: "json"
// 		, data: {
// 			commentNo: commentNo
// 		}
// 		, success: function(data){
// 			if(data.success) {
				
// 				$("[data-commentno='"+commentNo+"']").remove();
				
// 			} else {
// 				alert("댓글 삭제 실패");
// 			}
// 		}
// 		, error: function() {
// 			console.log("error");
// 		}
// 	});
// }
</script>