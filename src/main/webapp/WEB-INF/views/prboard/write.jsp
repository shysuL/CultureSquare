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
			
			// form submit
			$("form").submit();
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

@font-face {
	font-family: 'yg-jalnan';
	src:
		url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_four@1.2/JalnanOTF00.woff')
		format('woff');
	font-weight: normal;
	font-style: normal;
}

@font-face {
	font-family: 'SDMiSaeng';
	src:
		url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_two@1.0/SDMiSaeng.woff')
		format('woff');
	font-weight: normal;
	font-style: normal;
}

#h3title {
	font-family: '잘난체 폰트', 'Jalnan', yg-jalnan;
	text-align: center;
	padding: 20px;
}

#nicknameTitle {
	font-family: '잘난체 폰트', 'Jalnan', yg-jalnan;
}

#titleTitle {
	font-family: '잘난체 폰트', 'Jalnan', yg-jalnan;
}

#typeTitle {

	font-family: '잘난체 폰트', 'Jalnan', yg-jalnan;
}

#contentTitle {
	font-family: '잘난체 폰트', 'Jalnan', yg-jalnan;
}

#nicknameShow{
	font-family: '잘난체 폰트', 'Jalnan', yg-jalnan;
}

#prType{
	font-family: '잘난체 폰트', 'Jalnan', yg-jalnan;
	height: 35px;
}

}
</style>

<div class="container">

	<h3 id ="h3title">게시글 쓰기</h3>

	<div>
		<form action="/board/write" method="post" enctype="multipart/form-data">
			<table class="table table-bordered">
				<tr>
					<td class="info" id ="nicknameTitle">닉네임</td>
					<td id="nicknameShow">${usernick}</td>
				</tr>
				<tr>
					<td class="info" id="typeTitle">유형</td>
					<td><select name="prType" id="prType"
						style="margin: 0 auto; padding: 3px;">
							<option value="1">앨범 홍보</option>
							<option value="2">공연 홍보</option>
							<option value="3">전시회 홍보</option>
							<option value="4">기타</option>
					</select></td>
				</tr>
				<tr>
					<td class="info" id="titleTitle">제목</td>
					<td><input type="text" name="title" style="width: 100%" /></td>
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