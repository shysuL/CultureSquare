<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
    <%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*"%>

<jsp:include page="/WEB-INF/views/layout/header.jsp" />  
<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>

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
	    		html += '<textarea style="height: auto; width: 100%; margin-left:15px; resize: none;" id="rreText'+replyno+'" name="editContent" id="editContent" class="form-control" style= "resize:none;">';
	    		html += '</textarea>';
	    		html += '<button id="rreaddBtn'+replyno+'" onClick="addReReply('+replyno +','+boardno +')" >등록</button>';
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
<script type="text/javascript">
$(document).ready(function() {
	
	var money;
	
	//로그인 안했을 경우 후원하기 버튼 누르면 모달
	$("#noLoginDonationbtn").click(function() {
		$("#artNotLoginModal .content").text('로그인 후 후원이 가능합니다.');
		$("#artNotLoginModal").modal({backdrop: 'static', keyboard: false});
		return false;
	});
	
	//로그인 후 후원하기버튼 클릭 시 모달
	$("#donationbtn").click(function() {
		var msg = '후원하실 금액을 선택하세요.';
		msg += '<div class="custom-control custom-radio">'
  		msg +=    '<input type="radio" class="custom-control-input" id="1000won" name="donprice" value="1000">';
  		msg +=     '<label class="custom-control-label" for="1000won">1000원</label>';
  		msg +=   '</div>';
  		msg +=   '<div class="custom-control custom-radio">';
  		msg +=      '<input type="radio" class="custom-control-input" id="5000won" name="donprice" value="5000">';
  		msg +=     '<label class="custom-control-label" for="5000won">5000원</label>';
  		msg +=   '</div>';
  		msg +=   '<div class="custom-control custom-radio">';
  		msg +=     '<input type="radio" class="custom-control-input" id="10000won" name="donprice" value="10000">';
  		msg +=      '<label class="custom-control-label" for="10000won">10000원</label>';
  		msg +=  '</div>';
  		msg +=  '<div class="custom-control custom-radio">';
  		msg +=      '<input type="radio" class="custom-control-input" id="etc" name="donprice" value="">';
  		msg +=      '<label class="custom-control-label" for="etc">기타</label>';
  		msg +=     '<input id = "etcinput" name = "etcinput"  class="form-control"  disabled="disabled"/>';
  		msg +=  '</div>';
  		
  		$("#donationModal .content").html(msg);
		$("#donationModal").modal({backdrop: 'static', keyboard: false});
	});
	
	//후원 모달에서 후원하기 눌렀을때
	$("#donation").click(function() {
		
		var donChecked = $("input[name=donprice]:checked").val();
		var inputCost = $('#etcinput').val();
		
		//숫자 정규식
		var regexp = /^[0-9]*$/
		
		//화면에 나온 금액 입력
		if(donChecked == '1000' || donChecked == '5000' || donChecked == '10000'){
			
			// 라디오 초기화
			$('input[name="donprice"]').removeAttr('checked');
			console.log(donChecked + "입니다.");
			
		    	 var IMP = window.IMP; // 생략가능
		         IMP.init('imp31677120'); // 'iamport' 대신 부여받은 "가맹점 식별코드"를 사용
		         var msg;
		         
		         IMP.request_pay({
//		              pg: 'inicis', // version 1.1.0부터 지원.
		             pg: 'kakaopay', // version 1.1.0부터 지원.
		             /* 
		                 'kakao':카카오페이, 
		                 html5_inicis':이니시스(웹표준결제)
		                     'nice':나이스페이
		                     'jtnet':제이티넷
		                     'uplus':LG유플러스
		                     'danal':다날
		                     'payco':페이코
		                     'syrup':시럽페이
		                     'paypal':페이팔
		                 */
		             pay_method: 'card',
		             /* 
		                 'samsung':삼성페이, 
		                 'card':신용카드, 
		                 'trans':실시간계좌이체,
		                 'vbank':가상계좌,
		                 'phone':휴대폰소액결제 
		             */
		             merchant_uid: 'merchant_' + new Date().getTime(),
		             /* 
		              */
		             name: '주문명: 카카오결제테스트',
		             //결제창에서 보여질 이름
		             amount: donChecked, 
		             
		             //가격 
		             buyer_email: 'iamport@siot.do',
		             buyer_name: '구매자이름',
		             buyer_tel: '010-1234-5678',
		             buyer_addr: '서울특별시 강남구 삼성동',
		             buyer_postcode: '123-456',
		             m_redirect_url: 'https://www.yourdomain.com/payments/complete'
		             /*  
		                 모바일 결제시,
		                 결제가 끝나고 랜딩되는 URL을 지정 
		                 (카카오페이, 페이코, 다날의 경우는 필요없음. PC와 마찬가지로 callback함수로 결과가 떨어짐) 
		                 */
		         }, function (rsp) {
		             console.log(rsp);
		             if (rsp.success) {
		            	 
		            	 money = rsp.paid_amount;
		            	 
		                 var msg = '결제가 완료되었습니다.';
		                 msg +='<br>';
		                 msg += '고유ID : ' + rsp.imp_uid;
		                 msg +='<br>';
		                 msg += '상점 거래ID : ' + rsp.merchant_uid;
		                 msg +='<br>';
		        		 msg += '후원자 : ${usernick}'
		        		 msg +='<br>';
		        		 msg += '후원받는 사람 : ${writer.usernick}'
			        	 msg +='<br>';
		                 msg += '결제 금액 : ' + rsp.paid_amount +"원";
		                 msg +='<br>';
		                 
		                 $(".content").html(msg);
				         $("#donationSuccess").modal({backdrop: 'static', keyboard: false});
		             } else {
		                 var msg = '결제에 실패하였습니다.';
		                 msg +='<br>';
		                 msg += '에러내용 : ' + rsp.error_msg;
		                 $("#donationFail .content").html(msg);
				         $("#donationFail").modal({backdrop: 'static', keyboard: false});
		             }
		         })
			
			
		}
		//기타 금액 입력
		else{
			//빈칸 입력
			if(inputCost ==""){
				//후원 에러 모달 호출
				$("#donationErrorModal .content").html("빈칸은 입력할 수 없습니다.");
				$("#donationErrorModal").modal({backdrop: 'static', keyboard: false});
			}
			
			//숫자가 아닌 경우
			else if(!regexp.test(inputCost)){
				//숫자 입력하라는 모달 호출
				$("#donationNumberModal .content").html("숫자만 입력 가능합니다.");
				$("#donationNumberModal").modal({backdrop: 'static', keyboard: false});
			}
			
			// 숫자 입력 결제 시스템 호출
			else{
			    	 var IMP = window.IMP; // 생략가능
			         IMP.init('imp31677120'); // 'iamport' 대신 부여받은 "가맹점 식별코드"를 사용
			         var msg;
			         
			         IMP.request_pay({
//			              pg: 'inicis', // version 1.1.0부터 지원.
			             pg: 'kakaopay', // version 1.1.0부터 지원.
			             /* 
			                 'kakao':카카오페이, 
			                 html5_inicis':이니시스(웹표준결제)
			                     'nice':나이스페이
			                     'jtnet':제이티넷
			                     'uplus':LG유플러스
			                     'danal':다날
			                     'payco':페이코
			                     'syrup':시럽페이
			                     'paypal':페이팔
			                 */
			             pay_method: 'card',
			             /* 
			                 'samsung':삼성페이, 
			                 'card':신용카드, 
			                 'trans':실시간계좌이체,
			                 'vbank':가상계좌,
			                 'phone':휴대폰소액결제 
			             */
			             merchant_uid: 'merchant_' + new Date().getTime(),
			             /* 
			              */
			             name: '주문명: 카카오결제테스트',
			             //결제창에서 보여질 이름
			             amount: inputCost, 
			             
			             //가격 
			             buyer_email: 'iamport@siot.do',
			             buyer_name: '구매자이름',
			             buyer_tel: '010-1234-5678',
			             buyer_addr: '서울특별시 강남구 삼성동',
			             buyer_postcode: '123-456',
			             m_redirect_url: 'https://www.yourdomain.com/payments/complete'
			             /*  
			                 모바일 결제시,
			                 결제가 끝나고 랜딩되는 URL을 지정 
			                 (카카오페이, 페이코, 다날의 경우는 필요없음. PC와 마찬가지로 callback함수로 결과가 떨어짐) 
			                 */
			         }, function (rsp) {
			             console.log(rsp);
			             if (rsp.success) {
			            	 
			            	 money = rsp.paid_amount;
			            	 
			                 var msg = '결제가 완료되었습니다.';
			                 msg +='<br>';
			                 msg += '고유ID : ' + rsp.imp_uid;
			                 msg +='<br>';
			                 msg += '상점 거래ID : ' + rsp.merchant_uid;
			                 msg +='<br>';
			        		 msg += '후원자 : ${usernick}'
			        		 msg +='<br>';
			        		 msg += '후원받는 사람 : ${writer.usernick}'
				        	 msg +='<br>';
			                 msg += '결제 금액 : ' + rsp.paid_amount +"원";
			                 msg +='<br>';
			                 $("#donationSuccess .content").html(msg);
					         $("#donationSuccess").modal({backdrop: 'static', keyboard: false});
			             } else {
			                 var msg = '결제에 실패하였습니다.';
			                 msg +='<br>';
			                 msg += '에러내용 : ' + rsp.error_msg;
			                 
			                 $("#donationFail .content").html(msg);
					         $("#donationFail").modal({backdrop: 'static', keyboard: false});
			             }
			         })
			}
			
			// 값 초기화
			$('#etcinput').val("");
			$('input[name="donprice"]').removeAttr('checked');
			console.log("요긴 기타 버튼 : " +  inputCost);
		}
			
	});
	   $("#donationModal").on("click","input:radio[name=donprice]", function(){
		   var donChecked = $(this).val();
// 		   var donChecked = $("input[name=donprice]:checked").val();
			console.log(donChecked);
			if(donChecked == '1000'){
				$('#donationModal #etcinput').val("");
				$("#donationModal #etcinput").attr("disabled", true);
			}else if(donChecked == '5000'){
				$('#donationModal #etcinput').val("");
				$("#donationModal #etcinput").attr("disabled", true);
			}else if(donChecked == '10000'){
				$('#donationModal #etcinput').val("");
				$("#donationModal #etcinput").attr("disabled", true);
			}else{
				console.log(1)
				$("#donationModal #etcinput").attr("disabled", false);
			}
	   })
	   
	   //후원 하고 확인 버튼 눌렀을때 DB에 저장
	   $("#donationSuccessModalBtn").click(function() {

		 //후원 처리 컨트롤러로 이동
		 location.href="/artboard/donation?donprice="+money+"&usernick=${usernick}&boardno=${ view.boardno}";
		   
		   console.log("후원자 : ${usernick}");
		   console.log("금액 : " + money);
		   console.log("게시글 번호 : ${ view.boardno}" );
	   })
});
</script>


<script type="text/javascript">

	$(document).ready(function() {
		//추천버튼 동작
		$("#recommendtd").on("click", "#recommend", function() {
			//		$(location).attr("href", "/board/recommend?boardno=${viewBoard.boardno }");
			console.log("추천버튼 눌림");
			recommendAction();
		});
		//수정버튼 동작
		$("#btnUpdate").click(function() {
			console.log("수정버튼클릭");
			$(location).attr("href", "/artboard/modify?boardno=${view.boardno }");
		});

		//삭제버튼 동작
		$("#btnDelete").click(function() {
			$("#pfdeleteModal").modal({backdrop: 'static', keyboard: false});
		});	
		//삭제모달 확인 버튼 눌렀을때
		$("#pfDeleteCheckBtn").click(function() {
			$(location).attr("href", "/artboard/delete?boardno=${view.boardno }");
		});
		
		function recommendAction() {
			$.ajax({
				type : "get",
				url : "/artboard/recommend",
				data : {
					boardno : '${view.boardno }'
				},
				dataType : "html",
				success : function(data) {
					console.log("성공");
					console.log(data);

					$("#recommendtd").html(data)
				},
				error : function() {
					$("#pfLikeLoginModal").modal({backdrop: 'static', keyboard: false});
				}
			});
		}
		
		//댓글 삭제모달에서 확인 버튼 클릭 - 댓글 삭제 동작 Ajax 처리
		$("#pfReplyDeleteModalBtn").click(function() {
			console.log(dreplyno + "입니다.");
			
			$.ajax({
				type: "post"
				, url: "/reply/delete"
				, dataType: "json"
				, data: {
					replyno: dreplyno
				}
				, success: function(data){
						console.log("삭제 요청 성공");
						getCommentList();
					
				}
				, error: function() {
					console.log("error : 댓글삭제 실패");
				}
			});
			
		});
		
		//답글 삭제모달에서 확인 버튼 클릭 - 답글 삭제 동작 Ajax 처리
		$("#pfReReplyDeleteModalBtn").click(function() {
			
			$.ajax({
				type : "POST",
				url : "/artboard/deletereReply",
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
		
	});
		function recommendAction() {
			$.ajax({
				type : "get",
				url : "/artboard/recommend",
				data : {
					boardno : '${view.boardno }'
				},
				dataType : "html",
				success : function(data) {
					console.log("성공");
					console.log(data);

					$("#recommendtd").html(data)
				},
				error : function() {
					$("#pfLikeLoginModal").modal({backdrop: 'static', keyboard: false});
				}
			});
		}
		function recheckAction() {
			$.ajax({
				type : "get",
				url : "/artboard/recheck",
				data : {
					boardno : '${view.boardno }'
				},
				dataType : "html",
				success : function(data) {
					console.log("성공");
					console.log(data);

					$("#recommendtd").html(data)
				},
				error : function() {
					console.log("실패연 하이하이");
				}
			});
		}
			
			
</script>


<style type="text/css">
#view_recontents{
	background-color: #f7f7f7;
    max-width: 95%;
    height: 80px;
    padding: 6px;
}
#rereply_head{
	background-color: #6c757d;
    max-width: 95%;
    height: 45px;
    color: white;
    padding: 6px;
    font-size: 25px;
}
#view_rerecontents{
	background-color: #f7f7f7;
    max-width: 95%;
    height: 80px;
    padding: 6px;
	
}

</style>
<%
	Date date = new Date();
	SimpleDateFormat simpleDate = new SimpleDateFormat("yyyy-MM-dd");
	String strdate = simpleDate.format(date);
%>
<%
	Calendar cal = Calendar.getInstance();
%>
<div class="container list-container">

<div class="h2"><h2> CALENDAR </h2></div>
<hr>
<h3>VIEWVIEW</h3>
<br>
<div class="row">
	<div class="col-9">
		<div class="container container-fluid" style="margin-bottom: 50px">
			<div id = "view_head" class="col-xs-12 col-sm-6 col-md-8">
				<span>${view.title }</span>
			</div>
		<div id = "view_writer" class="col-xs-12 col-sm-6 col-md-8" >
			<div id = "writer_nick" class="col-md-4">
			${writer.usernick }
			</div>
			<div id="recommendtd">
			<div id = "write_date"  class="col-md-4">
			${view.writtendate }
			<div id = "viewcount">
			${view.views }
			</div>
			</div>
			</div>
		</div>
		<!-- 글내용 -->
		<div id = view_content class="col-xs-12 col-sm-6 col-md-8">
			<!-- 이미지 파일인 경우 내용에서 보여줌 -->
			<c:forEach items="${fileList }" var="fileList">
				<c:set var="image" value="${fileList.storedname}" />
				<c:if test="${fn:contains(image, '.jpg')}">
					<img src="/upload/${fn:trim(image)}" style="width: 100%; padding-bottom: 50px;">
				</c:if>
				<c:if test="${fn:contains(image, '.png')}">
					<img src="/upload/${fn:trim(image)}" style="width: 100%; padding-bottom: 50px;">
				</c:if>
				<c:if test="${fn:contains(image, '.JPG')}">
					<img src="/upload/${fn:trim(image)}" style="width: 100%; padding-bottom: 50px;">
				</c:if>
				<c:if test="${fn:contains(image, '.PNG')}">
					<img src="/upload/${fn:trim(image)}" style="width: 100%; padding-bottom: 50px;">
				</c:if>
			</c:forEach>
			<!-- 내용 보여줌 -->
			${view.contents }
			
			<hr>
			<div class="list-group" id="fileTitle">
				  <a class="list-group-item" id="fileContent">
				   첨부파일
				  </a>
				<c:forEach items="${fileList }" var="fileList">
 					<a href="/pfboard/download?fileno=${fileList.fileno}" class="list-group-item">${fileList.originname}</a>					
				</c:forEach>
			</div>
		</div>
		<!-- 버튼 -->
		<div id = "view_buttonarea" class="btn col-md-4" role="group">
		
		<c:if test="${writer.userno eq userno}">
			<button type = "button" id="btnUpdate" class="btn btn-info">수정</button>
			<button id="btnDelete" class="btn btn-danger">삭제</button>
		</c:if>
<!-- 		로그인 여부 처리 -->
		<c:choose>
			<c:when test="${not login}">
				<button type = "button" class="btn  bbc" id = "noLoginDonationbtn">후원하기</button>
			</c:when>
			<c:when test="${login}">
					<button type = "button" class="btn  bbc" id = "donationbtn">후원하기</button>
			</c:when>
		</c:choose>
			<button type = "button" class="btn  bbc" >추천</button>
			<a href="/artboard/list?bo_table=calendar&cal_year=<%= cal.get(Calendar.YEAR)%>&cal_month=<%=(cal.get(Calendar.MONTH)+1< 10) ?"0"+(cal.get(Calendar.MONTH)+1) :cal.get(Calendar.MONTH)+1%>">
			<button type = "button" class="btn  bbc" >목록</button>
			</a>
		</div>
		</div>



<!-- 댓글 처리 -->
<div >


	
		<%-- 댓글입력 시 이동 위치 --%>
<!-- 비로그인상태 -->
<c:if test="${not login }">
<strong>로그인이 필요합니다</strong><br>
</c:if>

<!-- 로그인상태 -->
<c:if test="${login }">
<!-- 댓글 입력 -->
<div>
	<div style="text-align: right; margin-right: 35px; margin-bottom: 5px;">
			<a><button id="writereply" class="btn  bbc" type="button">댓글작성</button></a>
			<c:if test="${userno eq writer.userno  }">
				<a style="float: right"
					href=""><button style="margin-left:2px;" class="btn bbc" type="button">수정하기</button></a>
				<a style="float: right"
					href=""
					onclick="warning();"><button style="margin-left:2px;"class="btn bbc" type="button">삭제하기</button></a>
			</c:if>
	</div>
	
	<div id = "replyinputheader">코멘트 남기기</div>
	
	<div  id = "replyinputbody" class="form-inline text-center col-9" style="display: none;">
		<div class="row">
			<div class="col-10">
				<input type="hidden"  id="userno" name="userno" value="${LoginUser.userno }" />
				<input type="hidden"  id="boardno" name="boardno" value="${ view.boardno}" />
				<%-- 	<input type="text" size="10" class="form-control" id="replyWriter" name = "usernick" value="${LoginUser.usernick }" readonly="readonly"/> --%>
				<textarea rows="2" cols="90" style="width:100%;" class="form-control" id="recontents" name="recontents" ></textarea>
			</div>
			<div class="col-2">
				<button id="btnCommInsert" class="btn bbc">입력</button>
			</div>
		</div>
	</div>	<!-- 댓글 입력 end -->
</div>

</c:if>

<br>
<!-- 댓글view -->
		<div  id="commentList" class='container' style='mawrgin-bottom: 40px'>              
		</div><!--  댓글 처리 end --> 


	</div>
</div>



<div class="col-3">
	<ul class="list-group" style="width: 300px;">
		<li id = "writer_title" class="list-group-item">작성자 프로필</li>
	<li class="list-group-item">
		<div id = "writer_photo">
		<img id="profileImg" src="/resources/img/userdefaultprofile.png" class="img-responsive img-circle"
							alt="Responsive image">
		</div>
  		<div id = "writer_info">${writer.usernick } 
  		<br>
	  		<div> 
	  		<button class="btn btn-default" style="background-color: #343a40 !important; 
	  				color: white !important; margin-top: 15px;">팔로우</button>
	  		</div>
  		</div>
   </li>
</ul>
</div>
</div>

<br><br>

<!-- 게시글 후원 모달창 -->
<div class="modal fade" id="donationModal">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content">

      <!-- Modal Header -->
      <div class="modal-header">
        <h4 class="modal-title">후원하기</h4>
        <button id="inputPwX" type="button" class="close" data-dismiss="modal">&times;</button>
      </div>

        <!-- Modal body -->
      <div class="modal-body content">
      </div>

      <!-- Modal footer -->
      <div class="modal-footer">
        <button type="button" id="donation" class="btn btn-info" data-dismiss="modal">후원하기</button>
      </div>

    </div>
  </div>
</div>


<!-- 로그인 실패시 모달창 -->
<div class="modal fade" id="artNotLoginModal">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content">

      <!-- Modal Header -->
      <div class="modal-header">
        <h4 class="modal-title">로그아웃 상태</h4>
        <button id="inputPwX" type="button" class="close" data-dismiss="modal">&times;</button>
      </div>

      <!-- Modal body -->
      <div class="modal-body content">
      </div>

      <!-- Modal footer -->
      <div class="modal-footer">
        <button type="submit" id="artLoginCheckBtn"class="btn btn-info" data-dismiss="modal">확인</button>
      </div>

    </div>
  </div>
</div>

<!-- 후원 에러 모달창 -->
<div class="modal fade" id="donationErrorModal">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content">

      <!-- Modal Header -->
      <div class="modal-header">
        <h4 class="modal-title">후원하기 오류!</h4>
        <button id="inputPwX" type="button" class="close" data-dismiss="modal">&times;</button>
      </div>

      <!-- Modal body -->
      <div class="modal-body content">
      </div>

      <!-- Modal footer -->
      <div class="modal-footer">
        <button type="submit" id="donationErrorBtn"class="btn btn-danger" data-dismiss="modal">확인</button>
      </div>

    </div>
  </div>
</div>

<!-- 후원 숫자 에러 모달창 -->
<div class="modal fade" id="donationNumberModal">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content">

      <!-- Modal Header -->
      <div class="modal-header">
        <h4 class="modal-title">후원하기 오류!</h4>
        <button id="inputPwX" type="button" class="close" data-dismiss="modal">&times;</button>
      </div>

      <!-- Modal body -->
      <div class="modal-body content">
      </div>

      <!-- Modal footer -->
      <div class="modal-footer">
        <button type="submit" id="donationNumberModalBtn"class="btn btn-danger" data-dismiss="modal">확인</button>
      </div>

    </div>
  </div>
</div>


<!-- 후원 성공 모달창 -->
<div class="modal fade" id="donationSuccess">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content">

      <!-- Modal Header -->
      <div class="modal-header">
        <h4 class="modal-title">후원완료!</h4>
      </div>

      <!-- Modal body -->
      <div class="modal-body content">
      </div>

      <!-- Modal footer -->
      <div class="modal-footer">
        <button type="submit" id="donationSuccessModalBtn"class="btn btn-info" data-dismiss="modal">확인</button>
      </div>

    </div>
  </div>
</div>

<!-- 후원 실패 모달창 -->
<div class="modal fade" id="donationFail">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content">

      <!-- Modal Header -->
      <div class="modal-header">
        <h4 class="modal-title">후원실패!</h4>
      </div>

      <!-- Modal body -->
      <div class="modal-body content">
      </div>

      <!-- Modal footer -->
      <div class="modal-footer">
        <button type="submit" id="donationFailModalBtn"class="btn btn-info" data-dismiss="modal">확인</button>
      </div>

    </div>
  </div>
</div>

</div> <!-- div_container -->




<!-- 댓글 입력이 비었을 때 모달 -->
<div class="modal fade" id="replyerror">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content">

      <!-- Modal Header -->
      <div class="modal-header">
        <h4 class="modal-title">알림</h4>
      </div>

      <!-- Modal body -->
      <div class="modal-body content">
      	 댓글 내용을 입력해주세요
      </div>

      <!-- Modal footer -->
      <div class="modal-footer">
        <button type="submit" id="btnCommInsert"class="btn btn-info" data-dismiss="modal">확인</button>
      </div>

    </div>
  </div>
</div>

<!-- 로그인 부탁 모달-->
<div class="modal fade" id="pfLikeLoginModal">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content">

      <!-- Modal Header -->
      <div class="modal-header">
        <h4 class="modal-title">로그인 필요!</h4>
        <button id="pfLikeLoginX" type="button" class="close" data-dismiss="modal">&times;</button>
      </div>

      <!-- Modal body -->
      <div class="modal-body content">
      	로그인 후 좋아요가 가능합니다.
      </div>

      <!-- Modal footer -->
      <div class="modal-footer">
        <button type="submit" id="pfLikeLoginModalBtn"class="btn btn-danger" data-dismiss="modal">확인</button>
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
<div class="modal fade" id="pfReplyDeleteModal">
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
        <button type="submit" id="pfReplyDeleteModalBtn"class="btn btn-danger" data-dismiss="modal">확인</button>
      </div>

    </div>
  </div>
</div>

<!-- 답글 삭제 확인 모달-->
<div class="modal fade" id="pfReReplyDeleteModal">
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
        <button type="submit" id="pfReReplyDeleteModalBtn"class="btn btn-danger" data-dismiss="modal">확인</button>
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
        <button type="submit" id="pfReplyDeleteModalBtn"class="btn btn-danger" data-dismiss="modal">확인</button>
      </div>

    </div>
  </div>
</div>


<jsp:include page="/WEB-INF/views/layout/footer.jsp" />


