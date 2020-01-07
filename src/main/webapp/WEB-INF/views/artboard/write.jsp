<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
    <%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>
<jsp:include page="/WEB-INF/views/layout/header.jsp" />  



<script type="text/javascript" src="/resources/ckeditor/ckeditor.js"></script>
<script>
    window.onload = function(){
       ck = CKEDITOR.replace("contents");
    };
</script>

<script type="text/javascript">
var g_count =1;
$(document).ready(function() {

	$("#btnWrite").click(function() {

		console.log("작성작성");


		
		
		//form submit
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
<script>
    var editorConfig = {
        filebrowserUploadUrl : "/resources/ckeditor/imgUpload", //이미지 업로드
    };

    CKEDITOR.on('dialogDefinition', function( ev ){
        var dialogName = ev.data.name;
        var dialogDefinition = ev.data.definition;

        switch (dialogName) {
            case 'image': //Image Properties dialog
            //dialogDefinition.removeContents('info');
            dialogDefinition.removeContents('Link');
            dialogDefinition.removeContents('advanced');
            break;
        }
    });
 window.onload = function(){
      ck = CKEDITOR.replace("editor", editorConfig);
 };
</script>

<style type="text/css">
#contents {
	width: 95%;
}
#write_head{
	background-color: #343a40;
	border: 1px solid black;
	max-width: 100%;
	height: 45px;
	text-align: center;
	color: white;
	padding: 6px;
}

#contentsarea{
	width: 100%px;
	height:600px;
	border: 1px solid black;
}
#fileup{
	width: 800px;
	height:auto;
	border: 1px solid black;
}
</style>



<div class="container container-fluid" style="margin-bottom: 300px">
<br>
<h1>WRITE</h1>
<hr>

<div class="row">
	<div class="col-9">
		<div id = "write_head" class="col-xs-12 col-sm-6 col-md-8">
			<span>필수 입력 사항</span>
		</div>
		<form action="/artboard/write" method="post" enctype="multipart/form-data">
		<br>
			<div>
				<label for="title"><b> 제목 </b></label><br>
				<input id="title" name="title" type="text" size="100%"  placeholder=" 제목을 입력하세요."/>
			</div>
			<br>
			<div>
				<label for="performdate"> <b>일시 </b></label><br>
				<input id="performdate" name="performdate" type="text" size="25%"  placeholder=" 입력 양식 : 20201221"/>
			</div>
			<br>
			<div>
				<label for="performname"> <b>게시물 카테고리 </b></label><br>
			</div>
		
			<div id = "performradio"> 
				<span class="radio">
			  		<label>
			   			<input type="radio" name="performname"  value="버스킹" checked>버스킹
			 		</label>
				</span>&nbsp;
				<span class="radio">
					<label>
						<input type="radio" name="performname"  value="전시회">전시회
					</label>
				</span>&nbsp;
				<span class="radio">
					<label>
						<input type="radio" name="performname"  value="연극">연극
					</label>
				</span>&nbsp;
				<span class="radio">
					<label>
						<input type="radio" name="performname"  value="뮤지컬">뮤지컬
					</label>
				</span>&nbsp;
				<span class="radio">
					<label>
						<input type="radio" name="performname"  value="행사">행사
					</label>
				</span>&nbsp;
				<span class="radio">
					<label>
						<input type="radio" name="performname"  value="축제">축제
					</label>
				</span>
		
			</div>
			<br>
			<label for="contents"> <b>상세내용 </b></label><br>
		
			<div id = "contentsarea">
				<textarea id="contents" name="contents"></textarea>
				<script type="text/javascript">
					 CKEDITOR.replace('contents', {height: 400,toolbar: 'Full'})
				</script>
			</div>
			<br>
			<div id="fileDiv" style="text-align: right;">
				<p>
					<input type="file" name="file_0" /><button type="button" id="delete" name = "delete" class="btn btn-danger">삭제하기</button>
				</p> 
			</div>
		
			<input type="hidden" id = "userno" name = "userno" value = "${userno.userno }"/>
		</form>
	</div>

	<div class="col-3">
		<div class="list-group" >
	 		<a class="list-group-item" id="pfIntroduceContent">CALENDAR 글쓰기안내</a>
	 		<a class="list-group-item tit" style="font-size: 14px">
	 			타 사이트의 게시물을 옮겨오실 경우 저작권 보호를 위해 내용을 그대로 붙여넣지 마시고 내용 요약 및 원문링크(또는 출처)를 삽입해 주세요.</a>
	 		<a class="list-group-item tit" style="font-size: 14px">	
	 			CultureSquare는 이미지 개별 첨부 이미지 당 5MB 이하 총 10MB 이미지까지 업로드 가능합니다. 다만 글을 읽으시는 분들께서 페이지 로딩에 지장을 받지 않도록 가급적 이미지 갯수는 적절히 조절해 주세요.</a>
		</div>
	</div>
</div>
	
	<div class="row">
	<div class="col-9">
		<div style="text-align: right;">
			<button type="button" id="add" class="btn btn-info">파일 추가하기</button>
			<button type="button" id="btnWrite" class="btn bbc" >작성완료</button>
			<button type="button" id="btnCancel" class="btn bbc">작성취소</button>
		</div>
	</div>
	</div>





</div> <!-- div_container -->

<jsp:include page="/WEB-INF/views/layout/footer.jsp" />

