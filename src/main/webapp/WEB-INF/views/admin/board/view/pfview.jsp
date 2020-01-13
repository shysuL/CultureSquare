<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>

<jsp:include page="/WEB-INF/views/admin/layout/etcheader.jsp" />
<link rel="stylesheet" href="/resources/css/css.css" />
<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>

<script type="text/javascript">
$(document).ready(function(){
	
	//삭제버튼 동작
	$("#btnDelete").click(function() {
		$("#pfdeleteModal").modal({backdrop: 'static', keyboard: false});
	});	
	//삭제모달 확인 버튼 눌렀을때
	$("#pfDeleteCheckBtn").click(function() {
		$(location).attr("href", "/admin/board/view/pfview/delete?boardno=${viewpf.boardno }");
	});})


</script>

<script type="text/javascript">

//지울 댓글 번호
var dreplyno;

//선택된 댓글 번호
var selectReply;

//한번에 여러개 수정 못하게 하는 체크 변후
var modifyCnt = 0;

////한번에 여러개 수정 못하게 하는 체크 변후 - 답글
var reModifyCnt = 0;

//답글 눌렀는지 판별여부 위한 배열
var checkReReply = new Array(); //배열 선언

//답글 갯수 출력 위한 배열
var rReCnt = new Array();

//댓글 길이 전역 변수
var replyListLen = 0;

//댓글 번호 배열
var replyarray = new Array();

//현재 보여진 댓글 수
var currentCnt = 0;

// 댓글 더보기 눌렀는지 여부 판단
var newFirst = true;

//댓글 슬라이드토글
$(document).ready(function(){
	
	recheckAction();
	$('#writereply').click(function() {
		$('#replyinputbody').slideToggle("fast");
	});
});

//댓글 삭제 클릭 -> 진짜로 삭제 할거냐는 모달 호출
function deleteReply(replyno){
	$("#pfReplyDeleteModal").modal({backdrop: 'static', keyboard: false});
	console.log("댓글 삭제 번호당: " + replyno);
	dreplyno = replyno;
}

//답글 삭제 클릭 -> 진짜로 삭제 할거냐는 모달 호출
function deleteReReply(replyno){
	$("#pfReReplyDeleteModal").modal({backdrop: 'static', keyboard: false});
	console.log(checkReReply[replyno] + "답글 입니다.");
	dreplyno = replyno;
}

$(document).ready(function() {
	
	
	// 댓글 입력
	$("#btnCommInsert").click(function() {

		if($('#recontents').val() == ''){
			$("#replyerror").modal({backdrop: 'static', keyboard: false});
		}else{
			
		
		
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
		}
	});
});


//2
// 대댓글 등록하기

 function addReReply(replyno, boardno){
	    
		console.log("답글 등록 테스트 -> 댓글 번호는? " + replyno);
		//입력한 답글 내용 저장
		var rrecontents = $('#rreText'+replyno).val();
		console.log("입력한 내용은?" + rrecontents);
		
		//빈칸 입력한 경우
		if(rrecontents==""){
			$("#prReReplyErrorModal").modal({backdrop: 'static', keyboard: false});
		}
		
		//제대로 입력한 경우
		else{
			$.ajax({
				type : "POST",
				url : "/artboard/addReReply",
				data : {
					//게시판 번호, 부모 댓글 번호, 답글 내용 넘겨줌
					boardno : boardno,
					replyno : replyno,
					recontents : rrecontents
				},
				dataType : "json",
				success : function(res) {
					
					// 로그인 후 답글 작성일때 처리 - 답글 리스트 보여줌
		            if(res.insert)
		            {
		            	console.log("로그인 상태");
		            	checkReReply[replyno] = 'undefined';
						getReReply(replyno);
		            	$('#rreText'+replyno).val("");
		            }
		            
					//로그아웃 상태에서 답글 작성 처리 - 모달 호출
		            else{
		            	$('#rreText'+replyno).val("");
		            	$("#prReReplyErrorModal").modal({backdrop: 'static', keyboard: false});
		            }
				},
				error : function() {
					console.log("실패");
				}
			});
		}
	}


/**
 * 초기 페이지 로딩시 좋아요 불러오기
 */
// $(function(){
    
// 	recheckAction();
    
// });
/**
 * 초기 페이지 로딩시 댓글 불러오기
 */
$(function(){
    
    getCommentList();
    
});
/**
 * 댓글 수정 처리 (Ajax)
 */
 function modifyReplyAjax(replyno){
	
	//수정한 댓글 내용
	 var updateReContents = $('#editContent').val();
	
	console.log("댓글수정하ㅗㄱ 버튼 클릭 : " + replyno);
	console.log("댓글수정내용: " + updateReContents);
	
	//빈칸 입력한 경우
	if(updateReContents==""){
		$("#prReplyErrorModal").modal({backdrop: 'static', keyboard: false});
	}
	//내용 입력한 경우
	else{
		$.ajax({
			type : "POST",
			url : "/artboard/modifyComment",
			data : {
				//댓글 번호, 수정 댓글 내용 넘겨줌
				replyno : replyno,
				recontents : updateReContents
			},
			dataType : "json",
			success : function(res) {
	            getCommentList();
			},
			error : function() {
				console.log("실패");
			}
		});
	}
}

//댓글 수정 버튼 클릭시, 기존댓글에서 커서 맨 뒤로 이동시키기 위한 메서드 추가
 $.fn.setCursorPosition = function( pos )
 {
     this.each( function( index, elem ) {
         if( elem.setSelectionRange ) {
             elem.setSelectionRange(pos, pos);
         } else if( elem.createTextRange ) {
             var range = elem.createTextRange();
             range.collapse(true);
             range.moveEnd('character', pos);
             range.moveStart('character', pos);
             range.select();
         }
     });
     
     return this;
 };

//댓글 수정 클릭
//댓글 번호, 댓글 내용 매개변수로 받음
function modifyReply(replyno,recontents){
	
	modifyCnt++;
	
	//하나만 수정 시도 할 경우
	if(modifyCnt == 1){
		console.log("댓글 수정 번호당: " + replyno);
		console.log("댓글 내용이당 : " + recontents);
		console.log("수정하고 있는 갯수당 : " + modifyCnt);
		
		var html = "";
	
		html += '<div id="commentBox' + replyno + '">';
		html += '<title>Placeholder</title>';
		html += '<rect width="100%" height="100%" fill="#007bff"></rect>';
		html += '<p class="media-body pb-3 mb-0 small lh-125 border-bottom horder-gray">';
		html += '<span class="d-block">';
		html += '<strong class="text-gray-dark">' + replyno + '</strong>';
		html += '<span style="padding-left: 7px; font-size: 9pt">';
		html += '<a href="javascript:void(0)" onClick="modifyReplyAjax('+replyno +')" style="padding-right:5px">수정<a>';
		html += '<a href="javascript:void(0)" onClick="getCommentList()" style="color:red;">취소<a>';
		html += '</span>';
		html += '</span>';		
		html += '<textarea name="editContent" id="editContent" class="form-control">';
		html += recontents;
		html += '</textarea>';
		html += '</p>';
		html += '</div>';
	
		//수정 가능하도록 textarea로 기존 댓글창을 치환
		$('#commentBox' + replyno).replaceWith(html);

		//수정 textarea에 문자열 맨뒤로 포커스
		$('#commentBox' + replyno + ' #editContent').focus().setCursorPosition(recontents.length);
	}
	//여러개 수정 시도
	else{
		$("#prModifyDupleModal").modal({backdrop: 'static', keyboard: false});
	}
	
}

//답글 수정 클릭 처리 메서드
function modifyReReply(replyno,recontents){
	
	console.log("답글 번호 : " + replyno);
	console.log("답글 내용 : " + recontents);
	
	reModifyCnt++;

	//하나만 수정 시도 할 경우
	if(reModifyCnt == 1){
		console.log("수정하고 있는 갯수당 : " + reModifyCnt);
		
	
		var html = "";
		html += '<div id="reReplyBox' + replyno + '">';
		html += '<title>Placeholder</title>';
		html += '<rect width="100%" height="100%" fill="#007bff"></rect>';
		html += '<p class="media-body pb-3 mb-0 small lh-125 border-bottom horder-gray">';
		html += '<span class="d-block">';
		html += '<strong class="text-gray-dark">' + replyno + '</strong>';
		html += '<span style="padding-left: 7px; font-size: 9pt">';
		html += '<a href="javascript:void(0)" onClick="modifyReReplyAjax('+replyno +')" style="padding-right:5px">수정<a>';
		html += '<a href="javascript:void(0)" onClick="getReReply('+selectReply+');" style="color:red;">취소<a>';
		
		//이전 답글리스트로 돌아가도록
		checkReReply[selectReply] = 'undefined';
		
		html += '</span>';
		html += '</span>';		
		html += '<textarea style ="resize:none; height: auto; width: 100%;" name="editReContent" id="editReContent" class="form-control">';
		html += recontents;
		html += '</textarea>';
		html += '</p>';
		html += '</div>';
	
		//수정 가능하도록 textarea로 기존 댓글창을 치환
		$('#reReplyBox' + replyno).replaceWith(html);
		
		//수정 textarea에 문자열 맨뒤로 포커스
		$('#reReplyBox' + replyno + ' #editReContent').focus().setCursorPosition(recontents.length);
	}
	//여러개 수정 시도
	else{
		$("#prModifyDupleModal").modal({backdrop: 'static', keyboard: false});
	}
	
}
/**
 * 답글 수정 처리 (Ajax)
 */
 function modifyReReplyAjax(replyno){
	
	//수정한 답글 내용
	 var updateReContents = $('#editReContent').val();
	
	console.log("답글 수정 내용 : " + updateReContents);
	console.log("수정할 답글 번호 : " + replyno);
	
	//빈칸 입력한 경우
	if(updateReContents==""){
		$("#prReplyErrorModal").modal({backdrop: 'static', keyboard: false});
	}
	//내용 입력한 경우
	else{
		$.ajax({
			type : "POST",
			url : "/artboard/modifyComment",
			data : {
				//댓글 번호, 수정 댓글 내용 넘겨줌
				replyno : replyno,
				recontents : updateReContents
			},
			dataType : "json",
			success : function(res) {
				checkReReply[selectReply] = 'undefined';
				getReReply(selectReply);
			},
			error : function() {
				console.log("실패");
			}
		});
	}
} 

//답글 리스트 출력 메서드
function getReReply(replyno){
	console.log("답글 테스트 번호: " + replyno);
	var boardno = '${view.boardno}';
	
	if($('#rreaddBtn22').click)
	console.log('$(#rreaddBtn22)');
	//답글 수정에서 취소 눌렀을때 고려해서 카운트 초기화
	reModifyCnt = 0;
	
	//기존 div 제거
	$('#RereplyBox' + replyno).remove();
	
	    $.ajax({
	        type:'POST',
	        url : "/artboard/ReReplyList",
	        data : {
				//댓글 번호
				replyno : replyno,
			},
	        dataType : "json",
	        success : function(res){
	    		var html = "";
	            var cCnt = res.reReplyList.length;
	            var html = "";
	            
	        	//답글 버튼을 처음 누른다면 답글 리스트 출력하도록
	        	if(
	        			checkReReply[replyno] == undefined || checkReReply[replyno]=='undefined'
	        			){
	        	
	        	//전역 변수에 값 저장
	        	selectReply = replyno;
	        		
	    		html += '<div class = "RereplyBox  col-11" id="RereplyBox' + replyno + '">';
	    		html += '<strong class="text-gray-dark">' + '답글의 댓글 번호 : ' + replyno + '</strong>';
	    		html += '<title>Placeholder</title>';
	    		html += '<rect width="100%" height="100%" fill="#007bff"></rect>';
	    		html += '<p class="media-body pb-3 mb-0 small lh-125 border-bottom horder-gray">';
	    		html += '<span class="d-block">';
	    	      if(res.reReplyList.length > 0){
	    	      	
	    	      	for(i=0; i<res.reReplyList.length; i++){
	    	      		rReCnt[i] = res.reReplyList[i].replyCnt;
	    	      		  html += "<div class='reReplyBox" + res.reReplyList[i].replyno+ "'id='reReplyBox"+res.reReplyList[i].replyno+"'>";
	    	              html += "<div style=' display: inline-block;'>"
	    	              html += "<div id = 'rereply_head' style = 'width: 680px !important;'>";
	    	              html += "<span><h5>" + res.reReplyList[i].usernick + "</h5></span>"
// 	    	              html += "<h6 style='padding-top: 10px; padding-left: 15px;' ><strong style='margin-left: -15px;'><strong>"+res.reReplyList[i].usernick+"</strong></h6>";
// 	    	              html += "</strong>";
	    	              html += "<div id = 'reply_date'  style='font-size: 13px;'>" + res.reReplyList[i].replydate + "</div></div>";
// 	    	              html += res.reReplyList[i].recontents ;
		                    html += "<div class='col-12' style = 'padding: 0px;'>";
		                    html += "<div id = 'view_rerecontents' >";
		                    html += "<div id = 'recontents' class='col-12'>" + res.reReplyList[i].recontents + "</div>";
		                    html += "</div>";
		                    html += "</div>";
	    	              
	    	              //답글 번호 삭제
	    	              html += "<h1 style='display:none;'>" + res.reReplyList[i].replyno + "</h1>";
	    	              html += "</div>";
						 
						//자기가 작성한 답글만 수정 삭제 출력
						  if(res.reReplyList[i].usernick == "${usernick}") {
		    	              html += "<div><a style = 'color: red; cursor: pointer;'class='reReplyDelete' onClick=deleteReReply(" + res.reReplyList[i].replyno + ")>삭제</a>";
		    	          	//.replace 메서드로 빈칸 에러 해결 => 정규식 / /gi 이 모든 빈칸을 뜻함
		    	              html+= "<a style = 'color: #007bff; cursor: pointer;' class='reReplyModify' onClick=modifyReReply(" + res.reReplyList[i].replyno + ",\'"+res.reReplyList[i].recontents.replace(/ /gi, "&nbsp;") +"\')>수정</a>";
		    	              html +="</div>";
						  }
		    	              
	    	              html +="</div>";
	    	              
	    	              $('#rCnt' + replyno).html(rReCnt[i]);
	    	          }
	    	      	
	    	          
	    	      } else {
	    	    	  html += "<div>";
	    	          html += "<h6><strong>등록된 답글이 없습니다.</strong></h6>";
	    	          html += "</div>";
	    	          $('#rCnt' + replyno).html(0);
	    	          
	    	      }
	    		html += '<span style="padding-left: 7px; font-size: 9pt">';
	    		html += '</span>';
	    		html += '</span>';	
	    		html += '<div style="position: relative; min-height: 90px;">';
	    		html += '<textarea style="height: auto; width: 100%; margin-left:2px; resize: none;" id="rreText'+replyno+'" name="editContent" id="editContent" class="form-control" style= "resize:none;">';
	    		html += '</textarea>';
	    		html += '<button class ="btn btn-secondary" id="rreaddBtn'+replyno+'" onClick="addReReply('+replyno +','+boardno +')" >등록</button>';
	    		html += '</div>';
	    		html += '</p>';
	    		html += '</div>';
	    		
	    		$('#commentBox' + replyno).append(html);

	    		//twice 상태면 답글 버튼을 한번 누른 상태
	    		checkReReply[replyno] = 'twice';
	    	}
			
			//답글 버튼을 두번째 누르는 상황 => 답글이 닫히도록 => remove();
			else{
				checkReReply[replyno] = 'undefined';
				$('#RereplyBox' + replyno).remove();
			}
	        	
	        },
	        error:function(request,status,error){
	            console.log("실패");
	       }
	    });
}


// 댓글 불러오기
function getCommentList(){
	
	// 댓글 수정에서 취소 눌렀을 때 고려해서 카운트 초기화
	modifyCnt = 0;
	console.log('${view.boardno}');
//     console.log("세션 : " + session.getAttribute("login"));
	console.log('${userno}');

	 $.ajax({
	        type:'POST',
	        url : "/artboard/commentList",
	        data : {
				//게시판 번호
				boardno : '${view.boardno }',
				userno : '${LoginUser.userno }'
			},
			dataType : "json",
	        success : function(res){
	        	console.log("리스트 : ");
	        	console.log(res.reList);
	        	
	            var cCnt = res.reList.length;
	            var html = "";
	            if(res.reList.length > 0){
	            	 
	            	for(i=0; i<res.reList.length; i++){
// 	                    html += "<div class='container' style='mawrgin-bottom: 40px'>";
	                    html += "<div class='row commentBox' id = 'commentBox"+res.reList[i].replyno+"'>";
	                    html += "<div id = 'reply_head' class = 'col-12' >";
	                    html += "<span>" + res.reList[i].usernick + "</span>"
	                    html += "<div id = 'reply_date' class='col-md-4' style='font-size: 13px;'>" + res.reList[i].replydate + "</div>";
	                    html += "</div>";
	                    
	                    html += "<div class='col-12' style = 'padding: 0px;'>";
	                    html += "<div id = 'view_recontents' >";
	                    html += "<div id = 'recontents' class='col-12'>" + res.reList[i].recontents + "</div>";
	                    html += "</div>";
	                    html += "</div>";
	                    
	                    html += "<div class='col-1.5'>";

	                    html += "<div id = 'rereplyBtn'>";
	                    html += "<a ><button id='rereply' class='btn bbc' type='button' onClick=getReReply(" + res.reList[i].replyno + ")>답글</button></a>";
// 	                    html += "<strong id='rCnt"+res.reList[i].replyno+"'>"+res.reList[i].replyCnt+"</strong>";
	                    html += "</div>";
	                    html += "</div>";
	                    
	                    if(res.reList[i].usernick == "${usernick}"){
	                    	html += "<div class='col-1.5'>";
	                    	html += "<div id = 'updateReplyBtn'>";
	                    	html += "<button class='btn bbc' onClick=modifyReply(" + res.reList[i].replyno + ",\'"+res.reList[i].recontents.replace(/ /gi, "&nbsp;") +"\')>수정</button>";
	                    	html += "</div></div>";
	                    	html += "<div class='col-1.5'>";
	                    	html += "<div id = 'deleteReplyBtn'>";
	                    	html += "<button class='btn bbc' onclick='deleteReply(" + res.reList[i].replyno + ");'>삭제</button>";
	                    	html += "</div></div>";
	                    }
                    	html += "</div><br>";
                    	
                    	
	            }
	        } else{
	        	html += "<div>";
                html += "<h6><strong>등록된 댓글이 없습니다.</strong></h6>";
                html += "</div>";
	        }
	            $("#cCnt").html(cCnt);
	            $("#commentList").html(html);
	            
	            
	       }  , 
	       error:function(request,status,error){
	       }
	});
}
</script>


<style type="text/css">
.info {
	background-color: #4b5055;
	color: #fff;
}
</style>
    
<div class="h2" style="text-align: center;">
	<h2 style="margin-top: 40px; margin-bottom: 40px;"> CALENDAR </h2>
</div>
	<div class="row">
		<div class="container container-center">
			<div class="container container-fluid" style="margin-bottom: 50px">
				<table class="table table-bordered">
					<tr>
						<td class="info">제목</td>
						<td colspan="4" style="width: 45%; padding-top: 16px;">
							<c:if test="${writer.usernick == '관리자' }">
								[ 삭제된 게시물 ]
							</c:if>
							${viewpf.title }
						</td>
						<td class="info">작성자</td>
						<td colspan="4" style="width: 45%; padding-top: 16px;">
							${writer.usernick }
						</td>
					</tr>
					<tr>
						<td class="info">작성일</td>
						<td colspan="4" style="width: 25%; padding-top: 16px;">
							${viewpf.writtendate }
						</td>
						<td class="info">조회수</td>
						<td colspan="4" style="width: 15%; padding-top: 16px;">
						${viewpf.views }</td>
					</tr>
					
					<tr>
						<td class="info" colspan="12">본문</td>
					</tr>
					<tr>
						<td id="view_content" colspan="12" style="height: 500px; border: 1px solid #dee2e6;">
						<!-- 이미지 파일인 경우 내용에서 보여줌 -->
							<c:forEach items="${fileList }" var="fileList">
								<c:set var="image" value="${fileList.storedname}" />
								<c:if test="${fn:contains(image, '.jpg')}">
									<img src="/upload/${fn:trim(image)}"
										style="width: 300px; padding-bottom: 50px; margin-top: 20px;">
								</c:if>
								<c:if test="${fn:contains(image, '.png')}">
									<img src="/upload/${fn:trim(image)}"
										style="width: 300px; padding-bottom: 50px;">
								</c:if>
								<c:if test="${fn:contains(image, '.JPG')}">
									<img src="/upload/${fn:trim(image)}"
										style="width: 300px; padding-bottom: 50px;">
								</c:if>
								<c:if test="${fn:contains(image, '.PNG')}">
									<img src="/upload/${fn:trim(image)}"
										style="width: 300px; padding-bottom: 50px;">
								</c:if>
							</c:forEach>
							${viewpf.contents }
						</td>
					</tr>
			
					<tr>
						<td colspan="12" class="info" id="fileContent">첨부파일</td>
					</tr>
					<tr>
						<td colspan="12">
						<c:if test="${empty fileList }">
							 첨부파일이 없습니다.
						</c:if>
						<c:forEach items="${fileList }" var="fileList">
							<a href="/pfboard/download?fileno=${fileList.fileno}" class="list-group-item">${fileList.originname}</a>
						</c:forEach>
						</td>
					</tr>
				</table>

			<div style="text-align: center;">
				<a href="/admin/main"><button class="btn btn-secondary">메인</button></a>
				<button id="btnDelete" class="btn btn-secondary">삭제</button>
			</div>
			
			

			
		<!-- 댓글view -->
		<div  id="commentList" class='container' style='mawrgin-bottom: 40px'>              
	
		</div><!--  댓글 처리 end --> 		
			
		</div>
	</div>
</div>

<!-- 삭제 여부 확인 모달-->
<div class="modal fade" id="pfdeleteModal">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content">

      <!-- Modal Header -->
      <div class="modal-header">
        <h4 class="modal-title">PF 게시글 삭제</h4>
        <button id="inputPwX" type="button" class="close" data-dismiss="modal">&times;</button>
      </div>

      <!-- Modal body -->
      <div class="modal-body content">
     	 정말 게시글을 삭제하시겠습니까?
      </div>

      <!-- Modal footer -->
      <div class="modal-footer">
        <button type="submit" id="pfDeleteCheckBtn"class="btn btn-danger" data-dismiss="modal">확인</button>
      </div>

    </div>
  </div>
</div>