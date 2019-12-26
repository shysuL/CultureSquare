<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<jsp:include page="/WEB-INF/views/layout/header.jsp" />

<script type="text/javascript">
$(document).ready(function() {
	
// 	//로그인 했을 경우 글쓰기 버튼 누르면 이동
// 	$("#LoginWrite").click(function() {
// // 		location.href="/prboard/write";
// 		console.log("오건 로그인 했을때");
// 		return false;
// 	});
	
// 	//로그인 안했을 경우 글쓰기 버튼 누르면 모달
// 	$("#notLoginWrite").click(function() {
// 		$(".content").text('로그인 후 게시글 작성이 가능합니다.');
// 		$("#prNotLoginModal").modal({backdrop: 'static', keyboard: false});
// 		return false;
// 	});
	
});
</script>

<style type="text/css">
#carouselExampleFade img {
	width: 800px;
	height: 400px;
}
</style>
<br><br>
<h3>하이</h3>
<div class="container">

 <!-- 스마트 에디터2 라이브러리 -->
<script type="text/javascript" src="/resources/se2/js/service/HuskyEZCreator.js" charset="utf-8"></script>
<script type="text/javascript" src="https://code.jquery.com/jquery-2.2.4.min.js" charset="utf-8"></script>
<script type="text/javascript">
$(document).ready(function(){
	

	    // 라디오버튼 클릭시 이벤트 발생
	    $("input:radio[name=chk]").click(function(){
	 
	    	var secretChecked = $("input[name=chk]:checked").val();
	    	
// 	    	console.log("라디오 체크 : " + secretChecked);
	    	
	    	$.ajax({
	            type : "get",
	            url : "/inquiry/secret",
	            data : {
	            	secretChecked : secretChecked
	            },
	            dataType : "html",
	            success : function(data) {
// 	               console.log("성공")
// 	               console.log(data)

	               $("#showpw").html(data)
	            },
	            error : function() {
// 	               console.log("실패");
	            }
	         });
	    });
	
		

});


</script>  

<script type="text/javascript">
function submitContents(elClickedObj) {
    // 에디터의 내용을 textarea에 적용
    oEditors.getById["content"].exec("UPDATE_CONTENTS_FIELD", []);

    try {
        elClickedObj.form.submit();
    } catch(e) {}
}


$(document).ready(function(){
   $("#btnWrite1").click(function(){
// 	   console.log(13123);
      submitContents($("#btnWrite1"));
      $("form").submit();
   })
   $("#btnCancel").click(function(){
      history.go(-1);
   })
   
   
   //경고 모달 호출 메서드
	function warningModal(content) {
	
	   $(".modal-contents").text(content);
		$("#defaultModal").modal('show');
	}
      
	
   
   
});
</script>
 <style type="text/css">
 #content {
 	width: 95%; 	
 }
 

 .container {
 	margin-bottom: 30px;
 }
 
 .modal-backdrop {
   z-index: 1;
}
 
</style>
<div class="container">

<div style="margin: 0 auto; margin-top: 70px;">
<form action="/inquiry/write"  method="post" enctype="multipart/form-data">
<div style="background: lightgray; border: 1px solid lightgray; padding: 10px; width: 80%; margin: 0 auto; text-align: center;">
문의사항
</div>
<table class="table" style=" width: 80%; margin: 0 auto; margin-top: 10px; ">
	<tr style="background-color: lightgray;">
		<th style="text-align: center;">
		<select name="inquiryType" style="margin: 0 auto; padding: 3px;">
			<option>건의사항</option>
			<option>등급문의</option>
			<option>오류문의</option>
		</select>
		<input type="text" id="title" name="title" placeholder="제목을 입력하세요." style="width: 80%;">
		</th>
		</tr>
		<tr  style="background-color: lightgray;">
		<th><input type="file" id="file" name="file"></th>
		</tr>
	<tr>
		<td style="background-color: white; text-align: center;">
			<textarea cols="70%" rows="20%" style="resize: none;"  id="content" name="content" placeholder="내용을 입력하세요.">
			</textarea>
		</td>
	</tr>
	
</table>
<div style="float: right;">
<input type="radio"  name="chk" value="0">비공개
<input type="radio"  name="chk" value="1" checked="checked">전체공개
<div id = "showpw" style="float: inherit">
</div>
</div>
</form>
</div>	

<br>
<hr>

<button class="btn btn-md b-btn" type="button" style="background-color: #4ea1d3; color: white;" onclick="location.href='/inquiry/list';">목록</button>
<button class="btn btn-md b-btn" id="btnWrite" style="background-color: #4ea1d3; color: white; float: right;" data-toggle="modal" data-target="#myModal">작성</button>


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
  
  
</div> <!-- 컨테이너 end -->
<jsp:include page="/WEB-INF/views/layout/footer.jsp" />

