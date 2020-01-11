<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<jsp:include page="/WEB-INF/views/admin/layout/etcheader.jsp" />
<link rel="stylesheet" href="/resources/css/css.css" />

<style type="text/css">
.info {
	background-color:#4b5055; 
	color: #fff;
}

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
	
	//초기화
	currentCnt = 0;
	
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
            		
            		//5개 까지만 댓글 보여줌
            		if(i < 5){
            			currentCnt++;
            			 html += "<div class='commentBox' id='commentBox"+res.reList[i].replyno+"'>";
                   		
            		}
            		
            		//5개 이후 댓글은 숨김
            		else{
            			 html += "<div class='commentBox' style = 'display:none' id='commentBox"+res.reList[i].replyno+"'>";
            		}
            		
        			//댓글 보기 버튼 출력
        			replyshow = "";
        			replyshow += "<div id ='replyShowDiv' style='border: 1px solid; padding: 10px; margin:auto; width:30%' class='text-center'>";
        			replyshow += "<button class = 'showReply' style ='background-color:white; border: none;'>";
        			replyshow += "댓글 보기";
        			replyshow += "<img style ='width:23px; padding-left:5px;' src='/resources/img/showReply.png' />";
        			replyshow += "</button>";
        			replyshow += "</div>";
                    
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
            
        },
        error:function(request,status,error){
            
       }
    });
}

/**
 * 좋아요순(Best) 댓글 불러오기(Ajax)
 */
function getBestCommentList(){
	
	//초기화
	currentCnt = 0;
	
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
            		
            		//5개 까지만 댓글 보여줌
            		if(i < 5){
            			currentCnt++;
            			 html += "<div class='commentBox' id='commentBox"+res.reList[i].replyno+"'>";
                   		
            		}
            		
            		//5개 이후 댓글은 숨김
            		else{
            			 html += "<div class='commentBox' style = 'display:none' id='commentBox"+res.reList[i].replyno+"'>";
            		}
            		
        			//댓글 보기 버튼 출력
        			replyshow = "";
        			replyshow += "<div id ='replyShowDiv' style='border: 1px solid; padding: 10px; margin:auto; width:30%' class='text-center'>";
        			replyshow += "<button class = 'showReply' style ='background-color:white; border: none;'>";
        			replyshow += "댓글 보기";
        			replyshow += "<img style ='width:23px; padding-left:5px;' src='/resources/img/showReply.png' />";
        			replyshow += "</button>";
        			replyshow += "</div>";
            		
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
            
        },
        error:function(request,status,error){
            
       }
    });
}
 
</script>

<div class="container">

	<h3 id ="h3title">PR 게시판</h3>

	<div>
			<table class="table table-bordered">
				<tr>
					<td class="info" id ="Title">게시글 번호</td>
					<td colspan="4" id="Content">${viewpr.boardno}</td>
<!-- 				</tr> -->
<!-- 				<tr> -->
					<td class="info" id ="Title">작성자</td>
					<td colspan="4" id="Content">${viewpr.usernick}</td>
				</tr>
				<tr>
					<td class="info" id="Title">유형</td>
					<td colspan="4" id="Content">${viewpr.prname}</td>
<!-- 				</tr> -->
<!-- 				<tr> -->
					<td class="info" id="Title">제목</td>
					<td colspan="4" id="Content">${viewpr.title}</td>
				</tr>
				<tr>
					<td class="info" id ="Title">조회수</td>
					<td colspan="4"id="Content">${viewpr.views }</td>
<!-- 				</tr> -->
<!-- 				<tr> -->
					<td class="info" id = "Title">작성일</td>
					<td colspan="4" id="Content">${viewpr.writtendate }</td>
				</tr>
				<tr>
					<td colspan="12" class="info" id = "Title">내용</td>
				</tr>
				<tr>
				<td colspan="12" id="Content" style="height: 500px;">
					
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
						${viewpr.content }
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

<div class="container">
	<div id ="replyComment">
	    <span><strong>Comments</strong></span> <span id="cCnt"></span>
	</div>
	<br>
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


<div class="container" style ="margin-top: 15px; margin-bottom: 50px;">
	<div class="text-center">	
		<button id="btnDelete" class="btn btn-danger">삭제</button>
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
