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
		// 스마트에디터 내용 <textarea>에 적용
		submitContents( $("#btnWrite"));
		// form submit
		$("form").submit();
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
</style>

<div class="container">

<h1></h1>
<hr>
<h2>자유게시판</h2>

<div>
<form action="/freeboard/write" method="post"
enctype="multipart/form-data">
<table class="table table-bordered">
<tr><td class="info">닉네임</td><td>${user.usernick }</td></tr>
<tr><td class="info" colspan="2">제목</td></tr>
<tr><td colspan="2"><input type="text" name="title" style="width:100%"/></td></tr>
<tr><td class="info" colspan="2">내용</td></tr>
<tr><td colspan="2"><textarea id="content" name="content"></textarea></td></tr>
<tr><td class="info">첨부파일</td><td><input type="file" name="file" id="file"></td></tr>
</table>

</form>
</div>

<div class="text-center">	
	<button type="button" id="btnWrite" class="btn btn-default" style="float: right; background-color: #494b4d; color: white;">작성</button>
	<button type="button" id="btnCancel" class="btn btn-default" style="float: left; background-color: #494b4d; color: white;">취소</button>
</div>
</div>

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
