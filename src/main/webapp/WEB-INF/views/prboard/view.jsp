<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<jsp:include page="../layout/header.jsp" />

<script type="text/javascript">

//지울 댓글 번호
var dreplyno;

//지울 답글 번호
var drereplyno;

//한번에 여러개 수정 못하게 하는 체크 변후
var modifyCnt = 0;

//답글 눌렀는지 판별여부 위한 배열
var checkReReply = new Array(); //배열 선언

//댓글 삭제 클릭 -> 진짜로 삭제 할거냐는 모달 호출
function deleteReply(replyno){
	$("#prReplyDeleteModal").modal({backdrop: 'static', keyboard: false});
	console.log("댓글 삭제 번호당: " + replyno);
	dreplyno = replyno;
}

//답글 삭제 클릭 -> 진짜로 삭제 할거냐는 모달 호출
function deleteReReply(replyno){
	checkReReply[replyno] = 'undefined';
	console.log(checkReReply[replyno] + "답글 입니다.");
}



// 댓글 수정 버튼 클릭시, 기존댓글에서 커서 맨 뒤로 이동시키기 위한 메서드 추가
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

//답글 처리 메서드
function getReReply(replyno, len){
	console.log("답글 테스트 번호: " + replyno);
	
	
	
	//기존 div 제거
	$('#RereplyBox' + replyno).remove();
		
	    $.ajax({
	        type:'POST',
	        url : "/prboard/ReReplyList",
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
	        	if(checkReReply[replyno] == undefined || checkReReply[replyno]=='undefined'){
	        		
	    		html += '<div class = "RereplyBox" id="RereplyBox' + replyno + '">';
	    		html += '<strong class="text-gray-dark">' + '답글의 댓글 번호 : ' + replyno + '</strong>';
	    		html += '<title>Placeholder</title>';
	    		html += '<rect width="100%" height="100%" fill="#007bff"></rect>';
	    		html += '<p class="media-body pb-3 mb-0 small lh-125 border-bottom horder-gray">';
	    		html += '<span class="d-block">';
	    	      if(res.reReplyList.length > 0){
	    	      	
	    	      	for(i=0; i<res.reReplyList.length; i++){
	    	      		  html += "<div class='reReplyBox" + res.reReplyList[i].replyno+ "'id='reReplyBox"+res.reReplyList[i].replyno+"'>";
	    	              html += "<img style='margin-right: 5px;margin-left: 5px;margin-top: -60px;' src='/resources/img/replyarrow.png' />"
	    	              html += "<div style=' display: inline-block;'>"
	    	              html += "<h6 style='padding-top: 10px; padding-left: 15px;' ><strong style='margin-left: -15px;'><strong>"+res.reReplyList[i].usernick+"</strong></h6>";
	    	              html += "</strong>" + res.reReplyList[i].recontents + "&nbsp;<small>(" + res.reReplyList[i].replydate + ")</small>";
	    	              
	    	              //답글 번호 삭제
	    	              html += "<h1 style='display:none;'>" + res.reReplyList[i].replyno + "</h1>";
	    	              html += "</div>";
						 
						//자기가 작성한 답글만 수정 삭제 출력
						  if(res.reReplyList[i].usernick == "${usernick}") {
		    	              html += "<div><button class='reReplyDelete btn-danger'onClick=deleteReReply(" + res.reReplyList[i].replyno + ")>삭제</button>";
		    	              html+= "<button class='reReplyModify btn-info'>수정</button>";
		    	              html +="</div>";
						  }
		    	              

	    	              html +="</div>";
	    	          }
	    	      	
	    	          
	    	      } else {
	    	          
	    	          html += "<div>";
	    	          html += "<h6><strong>등록된 답글이 없습니다.</strong></h6>";
	    	          html += "</div>";
	    	          
	    	      }
	    		html += '<span style="padding-left: 7px; font-size: 9pt">';
	    		html += '</span>';
	    		html += '</span>';	
	    		html += '<div style="position: relative; min-height: 90px;">';
	    		html += '<textarea name="editContent" id="editContent" class="form-control" style= "resize:none;">';
	    		html += '</textarea>';
	    		html += '<button style="margin-top: 5px; position: absolute; right: 0;">등록</button>';
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


/*
 * 댓글 등록하기(Ajax)
 */
function fn_comment(boardno){
    
	//입력한 댓글 내용 저장
	var recontents = $('#reply').val();
	
	//빈칸 입력한 경우
	if(recontents==""){
		$("#prReplyErrorModal").modal({backdrop: 'static', keyboard: false});
	}
	
	//제대로 입력한 경우
	else{
		$.ajax({
			type : "POST",
			url : "/prboard/addComment",
			data : {
				//게시판 번호, 댓글 내용 넘겨줌
				boardno : boardno,
				recontents : recontents
			},
			dataType : "json",
			success : function(res) {
				
				// 로그인 후 댓글 작성일때 처리 - 댓글 리스트 보여줌
	            if(res.insert)
	            {
	            	console.log("로그인 상태");
	                getCommentList();
	                $("#reply").val("");
	            }
	            
				//로그아웃 상태에서 댓글 작성 처리 - 모달 호출
	            else{
	            	$("#reply").val("");
	            	$("#prReplyLoginModal").modal({backdrop: 'static', keyboard: false});
	            }
			},
			error : function() {
				console.log("실패");
			}
		});
	}
}
 
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
			url : "/prboard/modifyComment",
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
 
/**
 * 댓글 불러오기(Ajax)
 */
function getCommentList(){
	
	//댓글 수정에서 취소 눌렀을때 고려해서 카운트 초기화
	modifyCnt = 0;
	console.log('${viewBoard.boardno }');
	
    $.ajax({
        type:'POST',
        url : "/prboard/commentList",
        data : {
			//게시판 번호
			boardno : '${viewBoard.boardno }',
		},
        dataType : "json",
        success : function(res){
            
        	console.log("리스트 : ");
        	console.log(res.reList);
        	
            var cCnt = res.reList.length;
            var html = "";
            if(res.reList.length > 0){
            	
            	for(i=0; i<res.reList.length; i++){
                    html += "<div class='commentBox' id='commentBox"+res.reList[i].replyno+"'>";
                    html += "<h6><strong>"+res.reList[i].usernick+"</strong></h6>";
                    html += res.reList[i].recontents + "&nbsp;<small>(" + res.reList[i].replydate + ")</small>";
                    html+= "<br><button style='height:25px; margin-right:5px' onClick=getReReply(" + res.reList[i].replyno + ",\'"+res.reList.length +"\')>답글</button>"
                    html += "<strong>"+res.reList[i].replyCnt+"</strong>"
                    
                    //댓글 번호 삭제
                    html += "<h1 style='display:none;'>" + res.reList[i].replyno + "</h1>";
                    
                    //자기가 작성한 댓글만 수정 삭제 출력
                    if(res.reList[i].usernick == "${usernick}") {
//                     	html += "<div class='btnBox'>"
                    	html += "<button style = 'float:right;' class ='btn-danger' onClick=deleteReply(" + res.reList[i].replyno + ")>삭제</button>&nbsp";
                    	//.replace 메서드로 빈칸 에러 해결 => 정규식 / /gi 이 모든 빈칸을 뜻함
                    	html += "<button style = 'float:right; margin-right: 10px;' class = 'btn-info' onClick=modifyReply(" + res.reList[i].replyno + ",\'"+res.reList[i].recontents.replace(/ /gi, "&nbsp;") +"\')>수정</button>&nbsp";
//                     	html += "</div>";
                    	
                    }
                    html += "</div>";
                }
                
            } else {
                
                html += "<div>";
                html += "<h6><strong>등록된 댓글이 없습니다.</strong></h6>";
                html += "</div>";
                
            }
            
            $("#cCnt").html(cCnt);
            $("#commentList").html(html);
            
        },
        error:function(request,status,error){
            
       }
        
    });
}
 
</script>



<script type="text/javascript">

	$(document).ready(function() {
		
		recheckAction();
		
		//목록버튼 동작
		$("#btnList").click(function() {
			$(location).attr("href", "/prboard/prlist");
		});
		
		//수정버튼 동작
		$("#btnUpdate").click(function() {
			$(location).attr("href", "/prboard/modify?boardno=${viewBoard.boardno }");
		});

		//삭제버튼 동작
		$("#btnDelete").click(function() {
			$("#prdeleteModal").modal({backdrop: 'static', keyboard: false});
		});
		
		//삭제모달 확인 버튼 눌렀을때
		$("#prDeleteCheckBtn").click(function() {
			$(location).attr("href", "/prboard/delete?boardno=${viewBoard.boardno }");
		});

		//추천버튼 동작
		$("#recommendtd").on("click", "#recommend", function() {
//	 		$(location).attr("href", "/board/recommend?boardno=${viewBoard.boardno }");
			console.log("추천버튼 눌림");
			recommendAction();
		});
		
		//댓글 삭제모달에서 확인 버튼 클릭 - 댓글 삭제 동작 Ajax 처리
		$("#prReplyDeleteModalBtn").click(function() {
			console.log(dreplyno + "입니다.");
			
			$.ajax({
				type : "POST",
				url : "/prboard/deleteComment",
				data : {
					//댓글번호 넘겨줌
					replyno : dreplyno,
				},
				dataType : "json",
				success : function(res) {

					console.log("삭제 요청 성공");
		           	getCommentList();
		            
				},
				error : function() {
					console.log("실패");
				}
			});
			
		});
		
	})
	
	function recommendAction() {
		$.ajax({
			type : "get",
			url : "/prboard/recommend",
			data : {
				boardno : '${viewBoard.boardno }'
			},
			dataType : "html",
			success : function(data) {
				console.log("성공")
				console.log(data)

				$("#recommendtd").html(data)
			},
			error : function() {
				$("#prLikeLoginModal").modal({backdrop: 'static', keyboard: false});
			}
		});
	}
	
	function recheckAction() {
		$.ajax({
			type : "get",
			url : "/prboard/recheck",
			data : {
				boardno : '${viewBoard.boardno }'
			},
			dataType : "html",
			success : function(data) {
				console.log("성공")
				console.log(data)

				$("#recommendtd").html(data)
			},
			error : function() {
				console.log("실패연 하이하이");
			}
		});
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


#btnList{
	background-color:#343a40;
}

#fileTitle{
	padding-bottom: 20px;
}
#fileContent{
	background-color:#343a40; 
	color:white;
}
.commentBox {
	position: relative;
	padding: 5px;
}
.btnBox {
	position: absolute;
	right: 5px;
	bottom: 5px;
}
/*  .commentBox:first-child {  */
/*  	border-top: 1px solid #ccc; */
/*  }  */
.commentBox {
	border-bottom: 1px solid #ccc;
}

.reReplyBox{
	border-bottom: 1px solid #ccc;
	border-top: 1px solid #ccc;
}



/*RereplyBox라는 이름을 id가 포함하는 div 태그*/
div[id*=RereplyBox]{
	border-top: 1px solid;
    border-bottom: 1px solid;
	margin-top: 15px;
    margin-bottom: 10px;
    background-color: rgb(240,240,240);
}

div[class*=reReplyBox]{
	position: relative;
	border-bottom: 1px solid #ccc;
    border-top: 1px solid #ccc;
}

.reReplyDelete{
	position: absolute;
	bottom: 0;
    right: 0;
}

.reReplyModify{
	  position: absolute;
	  bottom: 0;
	  right: 55px;
}

.RereplyBox {
	min-height: 200px;
}

</style>

<div class="container">

	<h3 id ="h3title">게시글 보기</h3>

	<div>
			<table class="table table-bordered">
				<tr>
					<td class="info" id ="Title">게시글 번호</td>
					<td colspan="4" id="Content">${viewBoard.boardno}</td>
				</tr>
				<tr>
					<td class="info" id ="Title">닉네임</td>
					<td colspan="4" id="Content">${viewBoard.usernick}</td>
				</tr>
				<tr>
					<td class="info" id="Title">유형</td>
					<td colspan="4" id="Content">${viewBoard.prname}</td>
				</tr>
				<tr>
					<td class="info" id="Title">제목</td>
					<td colspan="4" id="Content">${viewBoard.title}</td>
				</tr>
				<tr>
					<td class="info" id ="Title">조회수</td><td id="Content">${viewBoard.views }</td>
					<td class="info" id = "Title">좋아요 수</td><td id="recommendtd"></td>
				</tr>
				<tr>
					<td class="info" id = "Title">작성일</td><td colspan="3" id="Content">${viewBoard.writtendate }</td>
				</tr>
				<tr>
					<td colspan="4" class="info" id = "Title">내용</td>
				</tr>
				<tr>
				<td colspan="4" id="Content">
					
				<!-- 이미지 파일인 경우 내용에서 보여줌 -->
					<c:forEach items="${fileList }" var="fileList">
						<c:set var="image" value="${fileList.storedname}" />
						<c:if test="${fn:contains(image, '.jpg')}">
							<img src="/upload/${fn:trim(image)}" style="width: 1080px; padding-bottom: 50px;">
						</c:if>
						<c:if test="${fn:contains(image, '.png')}">
							<img src="/upload/${fn:trim(image)}" style="width: 1080px; padding-bottom: 50px;">
						</c:if>
						<c:if test="${fn:contains(image, '.JPG')}">
							<img src="/upload/${fn:trim(image)}" style="width: 1080px; padding-bottom: 50px;">
						</c:if>
						<c:if test="${fn:contains(image, '.PNG')}">
							<img src="/upload/${fn:trim(image)}" style="width: 1080px; padding-bottom: 50px;">
						</c:if>
					</c:forEach>
					<!-- 내용 보여줌 -->
						${viewBoard.content }
					</td>
				</tr>
			</table>
			<div class="list-group" id="fileTitle">
				  <a class="list-group-item" id="fileContent">
				   첨부파일
				  </a>
				<c:forEach items="${fileList }" var="fileList">
 					<a href="/prboard/download?fileno=${fileList.fileno}" class="list-group-item">${fileList.originname}</a>					
				</c:forEach>
			</div>
	</div>	
	
        <div>
            <div>
                <span><strong>Comments</strong></span> <span id="cCnt"></span>
            </div>
            <div>
                <table class="table">                    
                    <tr>
                        <td style="border-top: none;">
                            <textarea style="margin-left: -15px;width: 1110px" rows="3" cols="30" id="reply" name="reply" placeholder="댓글을 입력하세요"></textarea>
                            <br>
                            <div style="text-align: right;">
                                <a style="color:white" onClick="fn_comment('${viewBoard.boardno }')" class="btn pull-right btn-success">등록</a>
                            </div>
                        </td>
                    </tr>
                </table>
            </div>
        </div>
</div>


<!-- 삭제 여부 확인 모달-->
<div class="modal fade" id="prdeleteModal">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content">

      <!-- Modal Header -->
      <div class="modal-header">
        <h4 class="modal-title">PR 게시글 삭제</h4>
        <button id="inputPwX" type="button" class="close" data-dismiss="modal">&times;</button>
      </div>

      <!-- Modal body -->
      <div class="modal-body content">
     	 정말 게시글을 삭제하시겠습니까?
      </div>

      <!-- Modal footer -->
      <div class="modal-footer">
        <button type="submit" id="prDeleteCheckBtn"class="btn btn-danger" data-dismiss="modal">확인</button>
      </div>

    </div>
  </div>
</div>


<!-- 로그인 부탁 모달-->
<div class="modal fade" id="prLikeLoginModal">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content">

      <!-- Modal Header -->
      <div class="modal-header">
        <h4 class="modal-title">로그인 필요!</h4>
        <button id="prLikeLoginX" type="button" class="close" data-dismiss="modal">&times;</button>
      </div>

      <!-- Modal body -->
      <div class="modal-body content">
      	로그인 후 좋아요가 가능합니다.
      </div>

      <!-- Modal footer -->
      <div class="modal-footer">
        <button type="submit" id="prLikeLoginModalBtn"class="btn btn-danger" data-dismiss="modal">확인</button>
      </div>

    </div>
  </div>
</div>

<!-- 로그인 부탁 모달-->
<div class="modal fade" id="prReplyLoginModal">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content">

      <!-- Modal Header -->
      <div class="modal-header">
        <h4 class="modal-title">로그인 필요!</h4>
        <button id="prLikeLoginX" type="button" class="close" data-dismiss="modal">&times;</button>
      </div>

      <!-- Modal body -->
      <div class="modal-body content">
      	로그인 후 댓글 작성이 가능합니다.
      </div>

      <!-- Modal footer -->
      <div class="modal-footer">
        <button type="submit" id="prReplyLoginModalBtn"class="btn btn-danger" data-dismiss="modal">확인</button>
      </div>

    </div>
  </div>
</div>

<!-- 로그인 부탁 모달-->
<div class="modal fade" id="prReplyErrorModal">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content">

      <!-- Modal Header -->
      <div class="modal-header">
        <h4 class="modal-title">댓글 오류</h4>
        <button id="prLikeLoginX" type="button" class="close" data-dismiss="modal">&times;</button>
      </div>

      <!-- Modal body -->
      <div class="modal-body content">
      	내용을 입력해주세요!
      </div>

      <!-- Modal footer -->
      <div class="modal-footer">
        <button type="submit" id="prReplyErrorModalBtn"class="btn btn-danger" data-dismiss="modal">확인</button>
      </div>

    </div>
  </div>
</div>

<!-- 댓글 삭제 확인 모달-->
<div class="modal fade" id="prReplyDeleteModal">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content">

      <!-- Modal Header -->
      <div class="modal-header">
        <h4 class="modal-title">댓글 삭제</h4>
        <button id="prLikeLoginX" type="button" class="close" data-dismiss="modal">&times;</button>
      </div>

      <!-- Modal body -->
      <div class="modal-body content">
      	댓글을 삭제하시겠습니까?
      </div>

      <!-- Modal footer -->
      <div class="modal-footer">
        <button type="submit" id="prReplyDeleteModalBtn"class="btn btn-danger" data-dismiss="modal">확인</button>
      </div>

    </div>
  </div>
</div>

<!-- 댓글 수정 여러개 시도 에러  모달-->
<div class="modal fade" id="prModifyDupleModal">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content">

      <!-- Modal Header -->
      <div class="modal-header">
        <h4 class="modal-title">수정 오류</h4>
      </div>

      <!-- Modal body -->
      <div class="modal-body content">
      	기존 댓글 수정 작업을 완료해 주세요!
      </div>

      <!-- Modal footer -->
      <div class="modal-footer">
        <button type="submit" id="prModifyDupleModalBtn"class="btn btn-danger" data-dismiss="modal">확인</button>
      </div>

    </div>
  </div>
</div>
<!-- 컨테이너 -->

<div class="container">
<!--     <form id="commentListForm" name="commentListForm" method="post"> -->
        <div id="commentList">
        </div>
<!--     </form> -->
</div>
<div class="container" style ="margin-top: 15px;">
	<div class="text-center">	
		<button id="btnList" class="btn btn-primary">목록</button>
		<c:if test="${viewBoard.usernick eq usernick}">
			<button id="btnUpdate" class="btn btn-info">수정</button>
			<button id="btnDelete" class="btn btn-danger">삭제</button>
		</c:if>
	</div>
</div>

<jsp:include page="../layout/footer.jsp" />