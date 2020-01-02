<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
    <%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*"%>

<jsp:include page="/WEB-INF/views/layout/header.jsp" />  

<script type="text/javascript">
$(document).ready(function() {
	
	// 댓글 입력
	$("#btnCommInsert").click(function() {
		
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
//댓글 삭제
function deleteReply(replyno) {
	$.ajax({
		type: "post"
		, url: "/reply/delete"
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
<script type="text/javascript">
$(document).ready(function() {
	
	//후원하기버튼 클릭 시 모달
	$("#donationbtn").click(function() {
// 		$(".content").text('후원할 금액을 입력해 주세요');
		$("#donationModal").modal({backdrop: 'static', keyboard: false});
	});
	
	   $("input:radio[name=donprice]").click(function(){
		   var donChecked = $("input[name=donprice]:checked").val();
// 			console.log(donChecked);
			if(donChecked == '1000'){
				$('input[name=etcinput]').attr('value','');
				$("#etcinput").attr("disabled", true);
			}else if(donChecked == '5000'){
				$('input[name=etcinput]').attr('value','');
				$("#etcinput").attr("disabled", true);
			}else if(donChecked == '10000'){
				$('input[name=etcinput]').attr('value','');
				$("#etcinput").attr("disabled", true);
			}else
				$("#etcinput").attr("disabled", false);
	   })
});
</script>

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
	color: white;
	padding: 6px;
	font-size: 25px;
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

#reply_head{
	background-color: #343a40;
	border: 1px solid black;
	max-width: 95%;
	height: 45px;
	color: white;
	padding: 6px;
	font-size: 25px;
}

#reply_date{
	width: 20%;
	float:right;
}
#view_recontents{
	border: 1px solid black;
	max-width: 95%;
    height: 35px;
	padding: 6px;
}
#recontents{
	float: left;
}
#deleteReplyBtn{
	font-size: 12px; 
	float: right;
}
</style>
<%
	Date date = new Date();
	SimpleDateFormat simpleDate = new SimpleDateFormat("yyyy-MM-dd");
	String strdate = simpleDate.format(date);
%>
<%
	Calendar cal = Calendar.getInstance();
%>
<div class="container list-container">

<div class="h2"><h2> CALLENDAR </h2></div>
<hr>
<h3>VIEWVIEW</h3>
<br>
<div class="row">
	<div class="col-9">
		<div class="container container-fluid" style="margin-bottom: 600px">
			<div id = "view_head" class="col-xs-12 col-sm-6 col-md-8">
				<span>${view.title }</span>
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
		<!-- 글내용 -->
		<div id = view_content class="col-xs-12 col-sm-6 col-md-8">
			${view.contents }<br>
		<br><br><br><br><br>
		</div>
		<!-- 버튼 -->
		<div id = "view_buttonarea" class="btn col-md-4" role="group">
			<button type = "button" class="btn  bbc" id = "donationbtn">후원하기</button>
			<button type = "button" class="btn  bbc" >추천</button>
			<a href="/artboard/list?bo_table=calendar&cal_year=<%= cal.get(Calendar.YEAR)%>&cal_month=<%=(cal.get(Calendar.MONTH)+1< 10) ?"0"+(cal.get(Calendar.MONTH)+1) :cal.get(Calendar.MONTH)+1%>">
			<button type = "button" class="btn  bbc" >목록</button>
			</a>
		</div>
		</div>
	</div>


</div>



<!-- 댓글 처리 -->
<div>

<hr>
		<div id="commentbody"></div>
		<%-- 댓글입력 시 이동 위치 --%>
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
	<td>${reply.usernick }</td><!-- 닉네임으로 해도 좋음 -->
	<td>${reply.recontents }</td>
	<td>${reply.replydate}</td>
	<td>
		<c:if test="${LoginUser.userno eq reply.userno }">
		<button class="btn btn-default btn-xs" style="font-size: 12px;"
			onclick="deleteReply(${reply.replyno });">삭제</button>
		</c:if>
	</td>
	
</tr>
</c:forEach>
</tbody>
</table>	<!-- 댓글 리스트 end -->

<c:forEach items="${replyList }" var="reply">
<div class="col-9">
		<div class="container container-fluid" style="margin-bottom: 20px">
			<div id = "reply_head" class="col-xs-12 col-sm-6 col-md-8">
				<span>${reply.usernick }</span>
				<div id = "reply_date" class="col-md-4">
					${reply.replydate}
				</div>
			</div>
		<div id = "view_recontents" class="col-xs-12 col-sm-6 col-md-8" >
			<div id = "recontents"  class="col-md-4" >
				${reply.recontents }
			</div>
				<c:if test="${LoginUser.userno eq reply.userno }">
					<div id = "deleteReplyBtn"  class="col-md-2"  >
					<button class="btn btn-default btn-xs" 
						onclick="deleteReply(${reply.replyno });">삭제</button>
					</div>
				</c:if>
		</div>
		<!-- 글내용 -->
		<!-- 버튼 -->
		
		</div>
	</div>
</c:forEach>


</div>	<!-- 댓글 처리 end -->



<div class="col-3">
<ul class="list-group" style="width: 300px;">
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
</div>


<br><br>

<!-- 게시글 후원 모달창 -->
<div class="modal fade" id="donationModal">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content">

      <!-- Modal Header -->
      <div class="modal-header">
        <h4 class="modal-title">후원하기</h4>
        <button id="inputPwX" type="button" class="close" data-dismiss="modal">&times;</button>
      </div>

      <!-- Modal body -->
      <div class="modal-body content">
      	금액 
      		<div class="custom-control custom-radio">
	               <input type="radio" class="custom-control-input" id="1000won" name="donprice" value="1000">
	               <label class="custom-control-label" for="1000won">1000원</label>
	            </div>
	            <div class="custom-control custom-radio">
	               <input type="radio" class="custom-control-input" id="5000won" name="donprice" value="5000">
	               <label class="custom-control-label" for="5000won">5000원</label>
	            </div>
	            <div class="custom-control custom-radio">
	               <input type="radio" class="custom-control-input" id="10000won" name="donprice" value="10000">
	               <label class="custom-control-label" for="10000won">10000원</label>
	            </div>
	            <div class="custom-control custom-radio">
	               <input type="radio" class="custom-control-input" id="etc" name="donprice" value="">
	               <label class="custom-control-label" for="etc">기타</label>
	               <input id = "etcinput" name = "etcinput"  class="form-control"  disabled="disabled"/>
	            </div>
      </div>

      <!-- Modal footer -->
      <div class="modal-footer">
        <button type="button" id="donation" class="btn btn-info" data-dismiss="modal">후원하기</button>
      </div>

    </div>
  </div>
</div>



</div> <!-- div_container -->

<jsp:include page="/WEB-INF/views/layout/footer.jsp" />


