<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<jsp:include page="/WEB-INF/views/admin/layout/etcheader.jsp" />

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
	$("#freeCancelBtn").click(function() {
		// 스마트에디터 내용 <textarea>에 적용
		submitContents( $("#btnWrite"));
		// form submit
		$("form").submit();
	});
	
	//취소버튼 동작
	$("#btnCancel").click(function() {
		history.go(-1);
	});
	
	//수정버튼 동작
	$("#btnUpdate").click(function() {
		$("#freedeleteModal").modal({backdrop: 'static', keyboard: false});
	});
});
</script>

<style type="text/css">
#content {
	width: 95%;	
}

#noticeContent{
	background-color:#343a40; 
	color:white;
}

.tit { 
color: #343a40;
}
</style>

<div class="container container-center" style="margin-bottom: 50px; margin-top: 40px; padding-bottom: 30px; border: 1px solid #dee2e6;">
	<h3 style="text-align: center; margin-top: 30px;">NOTICE UPDATE</h3>
	<div class="row" style="margin-top: 60px;">
		<div class="col-8">
			<form action="" method="post" enctype="multipart/form-data">
				<table class="table table-bordered">
					<tr>
						<td class="info" colspan="2" style="background-color:#343a40; color:white;">공지사항 제목</td>
					</tr>
					<tr>
						<td colspan="2" style="text-align: center;"><input type="text" name="title" style="width: 95%" value="${notice.title }" /></td>
					</tr>
					<tr>
						<td class="info" colspan="2" style="background-color:#343a40; color:white;">공지사항 내용</td>
					</tr>
					<tr style="height: 450px;">
						<td colspan="2"><textarea id="content" name="contents">${notice.contents }</textarea></td>
					</tr>
					<tr>
						<td style="background-color:#343a40; color:white;">기존 첨부파일</td>
					</tr>
					<tr>
						<td>${fileinfo.originname }</td>
					</tr>
					<tr>
						<td><input type="file" name="file" id="file"></td>
					</tr>
				</table>

			</form>
		</div>
		<div class="col-4">
			<div class="list-group" id="noticeContent" style="height: 67px;">
				<p class="list-group-item" id="noticeContent">공지사항 안내</p> 
				<p class="list-group-item tit" style="color: black;">
					관리자가 본 사이트의 사용자들을 위한 공지사항을 작성하는 곳입니다. 사용자들의 편리한 사용을 위해 참고하시길 바랍니다.
					타 사이트의 게시물을 옮겨오실 경우에는 저작권 보호를
					위해 내용을 그대로 붙여넣지 마시고 내용 요약 및 원문링크(또는 출처)를 삽입해 주세요.</p>
			</div>

		</div>
	</div>

	<div class="text-center">
		<button type="button" id="btnUpdate" class="btn btn-dark">수정</button>
		<button type="button" id="btnCancel" class="btn btn-secondary">취소</button>
	</div>
</div>

<!-- 게시글 삭제 모달창 -->
<div class="modal fade" id="freedeleteModal">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content">

      <!-- Modal Header -->
      <div class="modal-header">
        <h4 class="modal-title">게시글 수정</h4>
        <button id="inputPwX" type="button" class="close" data-dismiss="modal">&times;</button>
      </div>

      <!-- Modal body -->
      <div class="modal-body content">
      	공지사항 수정을 완료 하시겠습니까?
      </div>

      <!-- Modal footer -->
      <div class="modal-footer">
        <button type="submit" id="freeCancelBtn"class="btn btn-secondary">확인</button>
      </div>

    </div>
  </div>
</div>

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