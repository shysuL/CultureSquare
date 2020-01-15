<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<jsp:include page="../layout/header.jsp" />

<!-- 스마트 에디터2 라이브러리 -->
<script type="text/javascript"
 src="/resources/se2/js/service/HuskyEZCreator.js" charset="utf-8"></script>

<script type="text/javascript">
//	<form>이 submit되면 
//	 스마트 에디터 내용을 <textarea> 반영해주는 함수

function submitContents(elClickedObj){
	// 에디터의 내용이 textarea에 적용된다.
	oEditors.getById["content"].exec("UPDATE_CONTENTS_FIELD", []);
	// 에디터의 내용에 대한 값 검증은 이곳에서
	// document.getElementById("ir1").value를 이용해서 처리한다.
	
	try{
		elClickedObj.form.submit(); // <form> submit 수행
	} catch(e){}
}

</script>

<script type="text/javascript">
$(document).ready(function() {
	
	//작성버튼 동작
	$("#btnWrite").click(function() {
		submitContents( $("#btnWrite"));
		
		if($("#title").val() == ""){
			$(".content").text("제목을 입력해주세요");
			$("#freeWriteErrorModal").modal({backdrop: 'static', keyboard: false});
		}
		else if($("#content").val() == "<p><br></p>") {
			$(".content").text("내용을 입력해주세요");
			$("#freeWriteErrorModal").modal({backdrop: 'static', keyboard: false});
		}
		else{
			
		// 스마트에디터 내용 <textarea>에 적용
		// form submit
		$("form").submit();
		}
	});
	
	//취소버튼 동작
	$("#btnCancel").click(function() {
		history.go(-1);
	});
});
</script>

<style type="text/css">
#content {
	width: 95%;	
}

#freeIntroduceContent{
	background-color:#343a40; 
	color:white;
}

.tit { 
color: #343a40;
}
</style>

<div class="container list-container">

<div class="h2"><h2> 자유게시판 </h2></div>
<hr>
<div class="row">
<div class="col-8">
<form action="/board/freewrite" method="post"
enctype="multipart/form-data">
<table class="table table-bordered">
<tr><td class="info" colspan="2">제목</td></tr>
<tr><td colspan="2"><input type="text" id="title" name="title" style="width:100%"/></td></tr>
<tr><td class="info" colspan="2">내용</td></tr>
<tr><td colspan="2"><textarea id="content" name="contents"></textarea></td></tr>
<tr><td><input type="file" name="file" id="file"></td></tr>
</table>

</form>
</div>
<div class="col-4">

	<div class="list-group" id="freeIntroduceTitle">
	  <a class="list-group-item" id="freeIntroduceContent">글쓰기 안내</a>
	  <a class="list-group-item tit"><i class="fas fa-exclamation-circle"></i> 타 사이트의 게시물을 옮겨오실 경우 저작권 보호를 위해 내용을 그대로 붙여넣지 마시고 내용 요약 및 원문링크(또는 출처)를 삽입해 주세요.</a>
	</div>

</div>
</div>

<div class="text-center">	
	<button type="button" id="btnWrite" class="btn btn-default" style="float: center; background-color: #494b4d; color: white;">작성</button>
	<button type="button" id="btnCancel" class="btn btn-default" style="float: center; background-color: #494b4d; color: white; margin-right: 380px;">취소</button>
</div>

<!-- 게시글 작성 오류 모달-->
<div class="modal fade" id="freeWriteErrorModal">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content">

      <!-- Modal Header -->
      <div class="modal-header">
        <h4 class="modal-title">글작성 오류</h4>
        <button id="freeLikeLoginX" type="button" class="close" data-dismiss="modal">&times;</button>
      </div>

      <!-- Modal body -->
      <div class="modal-body content">
      </div>

      <!-- Modal footer -->
      <div class="modal-footer">
        <button type="submit" id="freeWriteErrorModalBtn"class="btn btn-danger" data-dismiss="modal">확인</button>
      </div>

    </div>
  </div>
</div>

</div>
<br>


<jsp:include page="../layout/footer.jsp" />

<!-- 스마트 에디터 적용 코드 ( textarea 아래 작성 )-->
<!-- <textarea>태그에 스마트 에디터 스킨을 입히는 코드 -->
<script type="text/javascript">

var oEditors = [];
nhn.husky.EZCreator.createInIFrame({
 oAppRef: oEditors,
 elPlaceHolder: "content", // 에디터가 적용되는 <textarea>의 id
 sSkinURI: "/resources/se2/SmartEditor2Skin.html", // 에디터 스킨
 fCreator: "createSEditor2"
});

</script>
