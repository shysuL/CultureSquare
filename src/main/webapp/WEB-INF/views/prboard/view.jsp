<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<jsp:include page="../layout/header.jsp" />

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

//댓글 삭제 클릭 -> 진짜로 삭제 할거냐는 모달 호출
function deleteReply(replyno){
	$("#prReplyDeleteModal").modal({backdrop: 'static', keyboard: false});
	console.log("댓글 삭제 번호당: " + replyno);
	dreplyno = replyno;
}

//답글 삭제 클릭 -> 진짜로 삭제 할거냐는 모달 호출
function deleteReReply(replyno){
	$("#prReReplyDeleteModal").modal({backdrop: 'static', keyboard: false});
	console.log(checkReReply[replyno] + "답글 입니다.");
	dreplyno = replyno;
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
		html += '<textarea style ="resize:none; height: auto; width: 1065px;" name="editReContent" id="editReContent" class="form-control">';
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

//답글 리스트 출력 메서드
function getReReply(replyno){
	console.log("답글 테스트 번호: " + replyno);
	var boardno = '${viewBoard.boardno}';

	//답글 수정에서 취소 눌렀을때 고려해서 카운트 초기화
	reModifyCnt = 0;
	
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
	        	
	        	//전역 변수에 값 저장
	        	selectReply = replyno;
	        		
	    		html += '<div class = "RereplyBox" id="RereplyBox' + replyno + '">';
	    		html += '<title>Placeholder</title>';
	    		html += '<rect width="100%" height="100%" fill="#007bff"></rect>';
	    		html += '<p class="media-body pb-3 mb-0 small lh-125 border-bottom horder-gray">';
	    		html += '<span class="d-block">';
	    	      if(res.reReplyList.length > 0){
	    	      	
	    	      	for(i=0; i<res.reReplyList.length; i++){
	    	      		rReCnt[i] = res.reReplyList[i].replyCnt;
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
	    		html += '<textarea style="height: auto; width: 1057px; margin-left:15px; resize: none;" id="rreText'+replyno+'" name="editContent" id="editContent" class="form-control" style= "resize:none;">';
	    		html += '</textarea>';
	    		html += '<button id="rreaddBtn'+replyno+'" onClick="addReReply('+replyno +','+boardno +')" style="margin-top: 5px; position: absolute; right: 28px;">등록</button>';
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
    
	//댓글 보기 버튼 있으면 지우기
	$('#replyShowDiv').hide();
	
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
 * 답글 등록하기
 */
 
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
				url : "/prboard/addReReply",
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
			url : "/prboard/modifyComment",
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

/**
 * 최신순 댓글 불러오기(Ajax)
 */
function getCommentList(){
	
	//초기화
	currentCnt = 0;
	
	//최신순, 답글순, Best댓글 버튼 색 지정
	$('#new').css('color', 'black');
	$('#reMost').css('color', '#ccc');
	$('#best').css('color', '#ccc');
	
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
            
            replyListLen = cCnt;
            
            if(res.reList.length > 0){
            	
            	for(i=0; i<res.reList.length; i++){

            		
            		//처음 댓글 좋아요 출력 메서드 호출
            		replycheckAction(res.reList[i].replyno);
            		
            		//5개 까지만 댓글 보여줌
            		if(i < 5){
            			currentCnt++;
            			 html += "<div class='commentBox' id='commentBox"+res.reList[i].replyno+"'>";
                   		
            		}
            		
            		//5개 이후 댓글은 숨김
            		else{
            			 html += "<div class='commentBox' style = 'display:none' id='commentBox"+res.reList[i].replyno+"'>";
            		}
            		
//             		html += "<div class='commentBox' style = 'display:none' id='commentBox"+res.reList[i].replyno+"'>";
            		
        			//댓글 보기 버튼 출력
        			replyshow = "";
        			replyshow += "<div id ='replyShowDiv' style='border: 1px solid; padding: 10px; margin:auto; width:30%' class='text-center'>";
        			replyshow += "<button class = 'showReply' style ='background-color:white; border: none;'>";
        			replyshow += "댓글 보기";
        			replyshow += "<img style ='width:23px; padding-left:5px;' src='/resources/img/showReply.png' />";
        			replyshow += "</button>";
        			replyshow += "</div>";
        			
            		
//             		html += "<div class='commentBox' id='commentBox"+res.reList[i].replyno+"'>";
            		
                    html += "<strong>"+res.reList[i].usernick+"</strong>";
                    html += "<span id ='replyRecommend"+res.reList[i].replyno+"'></span><br>";
                    html += res.reList[i].recontents + "&nbsp;<small>(" + res.reList[i].replydate + ")</small>";
                    
                    replyarray[i] = res.reList[i].replyno;
                    
                    html+= "<br><button style='height:25px; margin-right:5px; margin-top: 7px;' onClick=getReReply(" + res.reList[i].replyno + ")>답글</button>"
                    html += "<strong id='rCnt"+res.reList[i].replyno+"'>"+res.reList[i].replyCnt+"</strong>"
                    
                    //댓글 번호 삭제
                    html += "<h1 style='display:none;'>" + res.reList[i].replyno + "</h1>";
                    
                    //자기가 작성한 댓글만 수정 삭제 출력
                    if(res.reList[i].usernick == "${usernick}") {
                    	html += "<button style = 'float:right;' class ='btn-danger' onClick=deleteReply(" + res.reList[i].replyno + ")>삭제</button>&nbsp";
                    	//.replace 메서드로 빈칸 에러 해결 => 정규식 / /gi 이 모든 빈칸을 뜻함
                    	html += "<button style = 'float:right; margin-right: 10px;' class = 'btn-info' onClick=modifyReply(" + res.reList[i].replyno + ",\'"+res.reList[i].recontents.replace(/ /gi, "&nbsp;") +"\')>수정</button>&nbsp";
                    }
                    html += "</div>";
                }
            
        
        
		
		    if(res.reList.length <= 5){
		        html += '<span class="close" style = "margin-top: 7px;">';
				html += '<span class="blind">댓글보기 V</span>';
				html += '</span>';
            }
		    else{
		    	html += '<span class="more" style = "margin-top: 7px;">';
				html += '<span class="blind">댓글보기 V</span>';
				html += '</span>';
		    	
		    }
			html += "<div class ='moreCnt' id='moreCnt'>("+currentCnt+"/"+cCnt+")</div>";
			
            		
            } else {
                
                html += "<div>";
                html += "<h6><strong>등록된 댓글이 없습니다.</strong></h6>";
                html += "</div>";
                
            }
            
            $("#cCnt").html(cCnt);
            $("#commentList").html(html);
//   			$("#replyShow").html(replyshow );
            
        },
        error:function(request,status,error){
            
       }
        
    });
}

/**
 * 답글순 댓글 불러오기(Ajax)
 */
function getReMostCommentList(){
	//최신순, 답글순, Best댓글 버튼 색 지정
	$('#new').css('color', '#ccc');
	$('#reMost').css('color', 'black');
	$('#best').css('color', '#ccc');
	
	//댓글 수정에서 취소 눌렀을때 고려해서 카운트 초기화
	modifyCnt = 0;
	console.log('${viewBoard.boardno }');
	
    $.ajax({
        type:'POST',
        url : "/prboard/remostcommentList",
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

            		//처음 댓글 좋아요 출력 메서드 호출
            		replycheckAction(res.reList[i].replyno);
            		
                    html += "<div class='commentBox' id='commentBox"+res.reList[i].replyno+"'>";
                    html += "<strong>"+res.reList[i].usernick+"</strong>";
                    html += "<span id ='replyRecommend"+res.reList[i].replyno+"'></span><br>";
                    html += res.reList[i].recontents + "&nbsp;<small>(" + res.reList[i].replydate + ")</small>";
                    
                    replyarray[i] = res.reList[i].replyno;
                    
                    html+= "<br><button style='height:25px; margin-right:5px; margin-top: 7px;' onClick=getReReply(" + res.reList[i].replyno + ")>답글</button>"
                    html += "<strong id='rCnt"+res.reList[i].replyno+"'>"+res.reList[i].replyCnt+"</strong>"
                    
                    //댓글 번호 삭제
                    html += "<h1 style='display:none;'>" + res.reList[i].replyno + "</h1>";
                    
                    //자기가 작성한 댓글만 수정 삭제 출력
                    if(res.reList[i].usernick == "${usernick}") {
                    	html += "<button style = 'float:right;' class ='btn-danger' onClick=deleteReply(" + res.reList[i].replyno + ")>삭제</button>&nbsp";
                    	//.replace 메서드로 빈칸 에러 해결 => 정규식 / /gi 이 모든 빈칸을 뜻함
                    	html += "<button style = 'float:right; margin-right: 10px;' class = 'btn-info' onClick=modifyReply(" + res.reList[i].replyno + ",\'"+res.reList[i].recontents.replace(/ /gi, "&nbsp;") +"\')>수정</button>&nbsp";
                    	
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

/**
 * 좋아요순(Best) 댓글 불러오기(Ajax)
 */
function getBestCommentList(){
	//최신순, 답글순, Best댓글 버튼 색 지정
	$('#new').css('color', '#ccc');
	$('#reMost').css('color', '#ccc');
	$('#best').css('color', 'black');
	
	//댓글 수정에서 취소 눌렀을때 고려해서 카운트 초기화
	modifyCnt = 0;
	console.log('${viewBoard.boardno }');
	
    $.ajax({
        type:'POST',
        url : "/prboard/bestcommentList",
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

            		//처음 댓글 좋아요 출력 메서드 호출
            		replycheckAction(res.reList[i].replyno);
            		
                    html += "<div class='commentBox' id='commentBox"+res.reList[i].replyno+"'>";
                    html += "<strong>"+res.reList[i].usernick+"</strong>";
                    html += "<span id ='replyRecommend"+res.reList[i].replyno+"'></span><br>";
                    html += res.reList[i].recontents + "&nbsp;<small>(" + res.reList[i].replydate + ")</small>";
                    
                    replyarray[i] = res.reList[i].replyno;
                    
                    html+= "<br><button style='height:25px; margin-right:5px; margin-top: 7px;' onClick=getReReply(" + res.reList[i].replyno + ")>답글</button>"
                    html += "<strong id='rCnt"+res.reList[i].replyno+"'>"+res.reList[i].replyCnt+"</strong>"
                    
                    //댓글 번호 삭제
                    html += "<h1 style='display:none;'>" + res.reList[i].replyno + "</h1>";
                    
                    //자기가 작성한 댓글만 수정 삭제 출력
                    if(res.reList[i].usernick == "${usernick}") {
                    	html += "<button style = 'float:right;' class ='btn-danger' onClick=deleteReply(" + res.reList[i].replyno + ")>삭제</button>&nbsp";
                    	//.replace 메서드로 빈칸 에러 해결 => 정규식 / /gi 이 모든 빈칸을 뜻함
                    	html += "<button style = 'float:right; margin-right: 10px;' class = 'btn-info' onClick=modifyReply(" + res.reList[i].replyno + ",\'"+res.reList[i].recontents.replace(/ /gi, "&nbsp;") +"\')>수정</button>&nbsp";
                    	
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
		
		// 댓글 더보기 버튼 클릭시
		$('#commentList').on("click", ".more", function(){
			
			newFirst = false;
			
			// 5개씩 보여주기 위한 변수 초기화
			var endno = currentCnt + 5;
			
			//남은 댓글 아직 있으면 (현재 보여진 댓글 수가 전체 댓글보다 작으면)
			if(currentCnt <replyListLen){
				for(var i = currentCnt; i<endno; i++){
					currentCnt ++;
					
					//현재 보여진 댓글이 전체 댓글과 같거나 초과할 경우
					if(currentCnt >= replyListLen){
						//더보기 버튼 지우고 접기 버튼 추가
						$('.more').addClass('close').removeClass('more');
						currentCnt = replyListLen;
					}
					//보여준 댓글 갯수/ 전체 댓글 갯수 표시 및 다음 5개 댓글 보여줌			
					$('#moreCnt').html("("+currentCnt +"/" + replyListLen +")");
					$('#commentBox' + replyarray[i]).show(800);
				}
			}
		});

		// 접기 버튼 클릭
		$('#commentList').on("click", ".close", function(){
			
			// 보여준 댓글 갯수/ 전체댓글 갯수 지우기
			$('#moreCnt').hide();
			
			//접기 버튼 지우고 더보기 버튼 추가
			$('.close').addClass('more').removeClass('close');
			// 더보기 버튼 지우기
			$('.more').hide();
			
			
			//초기화
			currentCnt = 0;
			
			// 모든 댓글 숨기기
			for(var i = 0; i<replyListLen; i++){
				 $('#commentBox' + replyarray[i]).hide(800);
			}
			
			//댓글 보기 버튼 출력
			html = "";
			html += "<div id ='replyShowDiv' style='border: 1px solid; padding: 10px; margin:auto; width:30%' class='text-center'>";
			html += "<button class = 'showReply' style ='background-color:white; border: none;'>";
			html += "댓글 보기";
			html += "<img style ='width:23px; padding-left:5px;' src='/resources/img/showReply.png' />";
			html += "</button>";
			html += "</div>";
			
			$("#replyShow").html(html);
		});
		
		
		// 댓글 보기 버튼 클릭 - 댓글 5개 보여줌
		$('#replyShow').on("click", ".showReply", function(){

			showFirstReply();
		});
		
		recheckAction();
		
		//댓글 추천순 정렬
		$("#best").click(function() {
			
			//답글 눌렀는지 변수 초기화
	        for(var i=0; i<replyListLen; i++){
	        	checkReReply[replyarray[i]] = 'undefined';
	         }
			getBestCommentList();
		});
		
		//댓글 답글순 정렬
		$("#reMost").click(function() {
			
			//답글 눌렀는지 변수 초기화
	        for(var i=0; i<replyListLen; i++){
	        	checkReReply[replyarray[i]] = 'undefined';
	         }
			
			getReMostCommentList();
		});
		
		//댓글 최신순 정렬
		$("#new").click(function() {
			
			//현재 보여준 댓글 초기화
			currentCnt = 0;
			
			//답글 눌렀는지 변수 초기화
	        for(var i=0; i<replyListLen; i++){
	        	checkReReply[replyarray[i]] = 'undefined';
	         }
			
	        $('#replyShowDiv').hide();
			
			//댓글 더보기 안누르고 최신순 누를때
			if(newFirst){
				console.log("댓글 더보기 안누르고 최신순");
				getCommentList();
			}
			
			//댓글 더보기 누르고 최신순
			else{
				console.log("댓글 더보기 누르고 최신순");
				
				//보여진 댓글 갯수 표시 
				$('#moreCnt').show();
				// 더보기 버튼 추가
				$('.more').show();
				
				for(var i = 0; i<replyListLen; i++){
					 $('#commentBox' + replyarray[i]).hide();
				}
				
				for(var i = 0; i<5; i++){
					currentCnt ++;
					//보여준 댓글 갯수/ 전체 댓글 갯수 표시 및 다음 5개 댓글 보여줌			
					$('#moreCnt').html("("+currentCnt +"/" + replyListLen +")");
					$('#commentBox' + replyarray[i]).show(800);
				}
				
			}
		});
		
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
			console.log("추천버튼 눌림");
			recommendAction();
		});
		
		
		//댓글 추천버튼 동작 처리
		$('#commentList').on("click", ".commentBox #replyLike", function(){

			// 부모 div 아이디 얻기
			var parentId = $(this).closest('div').attr('id');
			//숫자만 추출
			var replyno = parentId.replace(/[^0-9]/g,'');
			
			replyrecommendAction(replyno);
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
		
		//답글 삭제모달에서 확인 버튼 클릭 - 답글 삭제 동작 Ajax 처리
		$("#prReReplyDeleteModalBtn").click(function() {
			
			$.ajax({
				type : "POST",
				url : "/prboard/deletereReply",
				data : {
					//댓글번호 넘겨줌
					replyno : dreplyno,
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
			
		});
		
	})
	
	function showFirstReply() {
		//초기화
		currentCnt = 0;
		
		//댓글 보기 버튼 숨기기
		$('#replyShowDiv').hide();
		
		//보여진 댓글 갯수 표시 
		$('#moreCnt').show();
		// 더보기 버튼 추가
		$('.more').show();
		
		//댓글 갯수가 5개보다 작으면
	    if(replyListLen <= 5){
			//더보기 버튼 지우고 접기 버튼 추가
			$('.more').addClass('close').removeClass('more');
			
			//댓글  보여주기
			for(var i = 0; i<replyListLen; i++){
				currentCnt ++;
				//보여준 댓글 갯수/ 전체 댓글 갯수 표시 및 다음 5개 댓글 보여줌			
				$('#moreCnt').html("("+currentCnt +"/" + replyListLen +")");
				$('#commentBox' + replyarray[i]).show(800);
			}
        }
	    else{
	    	$('.more').show();
			for(var i = 0; i<5; i++){
				currentCnt ++;
				//보여준 댓글 갯수/ 전체 댓글 갯수 표시 및 다음 5개 댓글 보여줌			
				$('#moreCnt').html("("+currentCnt +"/" + replyListLen +")");
				$('#commentBox' + replyarray[i]).show(800);
			}
	    }
		
	}
	
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
	
	//댓글 추천 동작
	function replyrecommendAction(replyno) {
		
		$.ajax({
			type : "get",
			url : "/prboard/replyrecommend",
			data : {
				replyno : replyno,
				boardno : '${viewBoard.boardno }'
			},
			dataType : "html",
			success : function(data) {
				console.log("성공")
				console.log(data)

				$('#replyRecommend'+replyno).html(data);
			},
			error : function() {
				$("#prReplyLikeLoginModal").modal({backdrop: 'static', keyboard: false});
			}
		});
	}
	
	// 처음에 게시글 추천 여부에 따른 이미지 출력
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
	
	// 처음 댓글 추천 여부에 따른 이미지 출력
	function replycheckAction(replyno) {
		
		console.log("267 | 261 | 260 : " + replyno);
		
		$.ajax({
			type : "get",
			url : "/prboard/replycheck",
			data : {
				replyno : replyno
			},
			dataType : "html",
			success : function(data) {
				console.log(data);

				$('#replyRecommend'+replyno).html(data);
			},
			error : function() {
				console.log("댓글 실패연 하이하이");
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
    right: 3px;
}

.reReplyModify{
	  position: absolute;
	  bottom: 0;
	  right: 45px;
}

.RereplyBox {
	min-height: 200px;
}

#replySort{
	padding-left: 3px;
    padding-bottom: 10px;
}

#new{
	 cursor: pointer;
}

#reMost{
	 padding: 20px;
	 cursor: pointer;
}

#best{
	 cursor: pointer;
}

span[class=more] {
  display:block; 
  width: 55px;
  height: 16px;
  background-image:url('https://s.pstatic.net/static/www/img/2017/sp_nav_v170523.png');
  background-position: 0px -78px;
}

span[class=blind] {
  position: absolute;
  overflow: hidden;
  clip: rect(0 0 0 0);
  margin: -1px;
  width: 1px;
  height: 1px;
}

.more:hover, .close:hover {
  cursor:pointer;
}

span[class=close] {
  display:block;
  background-image:url('https://s.pstatic.net/static/www/img/2017/sp_nav_v170523.png');
  width: 42px;
  height: 16px;
  background-position: -166px -78px;
}

.reply{
	display:none;
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
				  <c:choose>
					<c:when test="${!empty fileList}">
						<c:forEach items="${fileList }" var="fileList">
							<a href="/prboard/download?fileno=${fileList.fileno}" class="list-group-item">${fileList.originname}</a>
						</c:forEach>
	 				</c:when>	
	 				<c:otherwise>
	 					<strong style="padding: 5px;">첨부파일이 없습니다.</strong>
	 				</c:otherwise>
 				</c:choose>		
			</div>
	</div>	
</div> <!-- 컨테이너 -->


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
<div class="modal fade" id="prReplyLikeLoginModal">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content">

      <!-- Modal Header -->
      <div class="modal-header">
        <h4 class="modal-title">로그인 필요!</h4>
        <button id="prLikeLoginX" type="button" class="close" data-dismiss="modal">&times;</button>
      </div>

      <!-- Modal body -->
      <div class="modal-body content">
      	로그인 후 댓글 좋아요가 가능합니다.
      </div>

      <!-- Modal footer -->
      <div class="modal-footer">
        <button type="submit" id="prReplyLikeLoginModalBtn"class="btn btn-danger" data-dismiss="modal">확인</button>
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

<!-- 댓글 오류 모달-->
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

<!-- 답글 삭제 확인 모달-->
<div class="modal fade" id="prReReplyDeleteModal">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content">

      <!-- Modal Header -->
      <div class="modal-header">
        <h4 class="modal-title">답글 삭제</h4>
        <button id="prLikeLoginX" type="button" class="close" data-dismiss="modal">&times;</button>
      </div>

      <!-- Modal body -->
      <div class="modal-body content">
      	답글을 삭제하시겠습니까?
      </div>

      <!-- Modal footer -->
      <div class="modal-footer">
        <button type="submit" id="prReReplyDeleteModalBtn"class="btn btn-danger" data-dismiss="modal">확인</button>
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

<!-- 답글 오류 모달-->
<div class="modal fade" id="prReReplyErrorModal">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content">

      <!-- Modal Header -->
      <div class="modal-header">
        <h4 class="modal-title">답글 오류</h4>
        <button id="prLikeLoginX" type="button" class="close" data-dismiss="modal">&times;</button>
      </div>

      <!-- Modal body -->
      <div class="modal-body content">
      	내용을 입력해주세요!
      </div>

      <!-- Modal footer -->
      <div class="modal-footer">
        <button type="submit" id="prReReplyErrorModalBtn"class="btn btn-danger" data-dismiss="modal">확인</button>
      </div>

    </div>
  </div>
</div>
<!-- 컨테이너 -->

<div class="container">

            <div id ="replyComment">
                <span><strong>Comments</strong></span> <span id="cCnt"></span>
            </div>
<!--           <dib class = "reply">   -->
            <div id = "replyText">
                <table class="table">                    
                    <tr>
                        <td style="border-top: none;">
                            <textarea style="margin-left: -15px;width: 1110px; resize:none;" rows="3" cols="30" id="reply" name="reply" placeholder="댓글을 입력하세요"></textarea>
                            <br>
                            <div style="text-align: right;">
                                <a style="color:white" onClick="fn_comment('${viewBoard.boardno }')" class="btn pull-right btn-success">등록</a>
                            </div>
                        </td>
                    </tr>
                </table>
            </div>
            <div id = replySort>
	        	<a id = "new">최신순</a>
	        	<a id = "reMost">답글순</a>
		        <a id = "best">Best 댓글</a>
       		</div>
       		<div id = "replyShow">
       		</div>
       		

<!--     <form id="commentListForm" name="commentListForm" method="post"> -->
        <div id="commentList" class = "commentList">
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