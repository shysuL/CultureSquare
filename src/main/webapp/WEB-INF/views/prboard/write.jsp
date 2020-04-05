  <%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<jsp:include page="../layout/header.jsp" />

<!-- 스마트 에디터2 라이브러리 -->
<script type="text/javascript"
	src="/resources/se2/js/service/HuskyEZCreator.js" charset="utf-8"></script>

<script type="text/javascript">
	// <form>이 submit되면
	// 스마트 에디터 내용을 <textarea>반영해주는 함수
	
	function submitContents(elClickedObj) {
		// 에디터의 내용이 textarea에 적용된다.
		oEditors.getById["content"].exec("UPDATE_CONTENTS_FIELD", []);
		try {
			elClickedObj.form.submit(); // <form> submit 수행
		} catch (e) {
		}
	}
</script>

<script type="text/javascript">
	var g_count =1;
	$(document).ready(function() {
		
		//작성버튼 동작
		$("#btnWrite").click(function() {
			// 스마트에디터의 내용을 <textarea>에 적용
			submitContents($("#btnWrite"));
			
		      if($("#title").val() == ""){
		          $("#freeWriteErrorModal").modal({backdrop: 'static', keyboard: false});
		       }
		       else if($("#content").val() == "<p><br></p>") {
		          $("#freeWriteErrorModalC").modal({backdrop: 'static', keyboard: false});
		       }
		       else{
				// form submit
				$("form").submit();
		       }
		});
		//취소버튼 동작
		$("#btnCancel").click(function() {
			history.go(-1);
		});
		
		$("a[name='delete']").on("click",function(e){
			e.preventDefault();
			fn_fileDelete($(this));
		})
		$("#add").on("click",function(e){
			e.preventDefault();
			fn_fileAdd();
		})
		
	});
	
	function fn_fileDelete(obj){
		obj.parent().remove();
	}
	function fn_fileAdd(){
		var str = "<p><input type='file' name='file_"+(g_count++)+"'/><button type='button' id='delete' name = 'delete'class='btn btn-danger'>삭제하기</button></p> ";
		$("#fileDiv").append(str);
		
		$("button[name='delete']").on("click",function(e){
			e.preventDefault();
			fn_fileDelete($(this));			
		})
	}
	
</script>

<style type="text/css">
#content {
	width: 95%;
}
#h3title {
	text-align: center;
	padding: 20px;
}
#contentTitle {
}
#prType{
	height: 35px;
}
}
</style>

<div class="container">

	<h3 id ="h3title">게시글 쓰기</h3>

	<div>
		<form action="/prboard/writeProc" method="post" enctype="multipart/form-data">
			<table class="table table-bordered">
				<tr>
					<td class="info" id ="nicknameTitle">닉네임</td>
					<td id="nicknameShow">${usernick}</td>
				</tr>
				<tr>
					<td class="info" id="typeTitle">유형</td>
					<td><select name="prname" id="prname"
						style="margin: 0 auto; padding: 3px; height: 30px;">
							<option value="앨범 홍보">앨범 홍보</option>
							<option value="공연 홍보">공연 홍보</option>
							<option value="전시회 홍보">전시회 홍보</option>
							<option value="기타">기타</option>
					</select></td>
				</tr>
				<tr>
					<td class="info" id="titleTitle">제목</td>
					<td><input id = "title" type="text" name="title" style="width: 100%" /></td>
				</tr>
				<tr>
					<td class="info" colspan="2" id="contentTitle">내용</td>
				</tr>
				<tr>
					<td colspan="2"><textarea id="content" name="content"></textarea></td>
				</tr>
			</table>

		<div id="fileDiv">
			<p>
				<input type="file" name="file_0"/>
				<button type="button" id="delete" name = "delete"class="btn btn-danger">삭제하기</button>
			</p> 
		</div>
		</form>
	</div>	
	
	<div class="text-center">
		<button type="button" id="add" class="btn btn-info">파일 추가하기</button>
		<button type="button" id="btnWrite" class="btn btn-info">작성</button>
		<button type="button" id="btnCancel" class="btn btn-danger">취소</button>
	</div>
	
	
<div class="modal fade" id="freeWriteErrorModal">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content">

      <!-- Modal Header -->
     <div class="modal-header">
        <h4 class="modal-title">PR 게시글 작성 불가!</h4>
        <button id="freeWriteErrorModalX" type="button" class="close" data-dismiss="modal">&times;</button>
      </div>

      <!-- Modal body -->
      <div class="modal-body content">
      	제목을 입력해 주세요!
      </div>

      <!-- Modal footer -->
      <div class="modal-footer">
        <button type="submit" id="freeWriteErrorBtn"class="btn btn-danger" data-dismiss="modal">확인</button>
      </div>

    </div>
  </div>
</div>

<div class="modal fade" id="freeWriteErrorModalC">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content">

      <!-- Modal Header -->
     <div class="modal-header">
        <h4 class="modal-title">PR 게시글 작성 불가!</h4>
        <button id="freeWriteErrorModalCX" type="button" class="close" data-dismiss="modal">&times;</button>
      </div>

      <!-- Modal body -->
      <div class="modal-body content">
      	내용을 입력해 주세요!
      </div>

      <!-- Modal footer -->
      <div class="modal-footer">
        <button type="submit" id="freeWriteErrorCBtn"class="btn btn-danger" data-dismiss="modal">확인</button>
      </div>

    </div>
  </div>
</div>
	
</div>
<!-- 컨테이너 -->

<jsp:include page="../layout/footer.jsp" />


<!-- 스마트 에디터 적용 코드 -->
<!-- <textarea>태그에 스마트 에디터의 스킨을 입히는 코드 -->
<script type="text/javascript">
	var oEditors = [];
	nhn.husky.EZCreator.createInIFrame({
		oAppRef : oEditors,
		elPlaceHolder : "content", // 에디터가 적용되는 <textarea>의 id
		sSkinURI : "/resources/se2/SmartEditor2Skin.html", // 에디터 스킨
		fCreator : "createSEditor2"
	});
</script>
