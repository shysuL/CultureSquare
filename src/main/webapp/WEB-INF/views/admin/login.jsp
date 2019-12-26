<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!-- jQuery 2.2.4 -->
<jsp:include page="/WEB-INF/views/admin/layout/header.jsp" />  

<script type="text/javascript">
<%-- 로그인 성공 또는 실패시 --%>
$(document).ready(function(){
	
	$("#adminloginbtn").click(function(){
		var adminid = $('#adminid').val();
		var adminpw = $('#adminpw').val();
		
        //아이디를 입력하지 않았을 때
        if(adminid == ""){
        	$(".content").text('아이디를 입력해주세요.');
			$("#pwAuthenticationModal").modal({backdrop: 'static', keyboard: false});
        	return false;
        }
        
        //비밀번호를 입력하지 않았을 때
        if(adminpw == ""){
        	$(".content").text('비밀번호를 입력해주세요.');
			$("#pwAuthenticationModal").modal({backdrop: 'static', keyboard: false});
        	return false;
        }
		
		$.ajax({
			type:"post",
			url:"/admin/login",
			data: {"adminid" : adminid, "adminpw" : adminpw},
			datatype: "json",
			success : function(res){
				console.log(res.adminIsLogin)
				if(res.adminIsLogin){
					location.href="/admin/main"
					return false;
				} else {
					console.log("떠라")
					$(".content").text('아이디나 비밀번호를 잘못 입력하셨습니다. 확인해주세요.');
					$("#pwAuthenticationModal").modal({backdrop: 'static', keyboard: false});
					return false;
				}
			}
				
		})
	})
	
	//아이디 입력 후 엔터 키 눌렀을 떄 로그인 버튼과 같은 동작하게 하기
	$('#adminid').keypress(function(event){
		if(event.which==13){
			$('#adminloginbtn').click();
			return false;
		}
	})
	
	//비밀번호 입력 후 엔터 키 눌렀을 떄 로그인 버튼과 같은 동작하게 하기
	$('#adminpw').keypress(function(event){
		if(event.which==13){
			$('#adminloginbtn').click();
			return false;
		}
	})
	
})


// 	$("#inputPwCheckBtn").click(function(){
// 		console.log("두번째 모달")
// 		$("#pwAuthenticationModal2").modal({backdrop: 'static', keyboard: false});
// 	})

</script>

<div class="container container-center" id="adminlogindiv">
	<br>
	<div style="border: 1px solid #ccc;">
		<h4 style="text-align:center; margin-top: 10px; margin-bottom: 10px;">관리자 로그인</h4>
	</div>
	<br>
	<div class="form-group">
	  <label for="adminid">ID</label>
	  <input type="text" class="form-control" id="adminid" name="adminid" aria-describedby="emailHelp" placeholder="Admin ID">
	</div>
	
	<div class="form-group">
	  <label for="adminpw">PASSWORD</label>
	  <input type="password" class="form-control" id="adminpw" name="adminpw" placeholder="Admin PassWord">
	</div>
	<br>
	<button type="submit" class="btn btn-secondary" id="adminloginbtn">LOGIN</button>
	<br><br>
	<div style="text-align: center;">
		<small>이곳은 "Culture Square"의 관리자 사이트입니다.<br>
		관리자를 제외한 다른 사용자는 접속할 수 없습니다.</small><br>
	</div>
</div>

<!-- 로그인 실패시 모달창 -->
<div class="modal fade" id="pwAuthenticationModal">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content">

      <!-- Modal Header -->
      <div class="modal-header">
        <h4 class="modal-title">로그인 실패</h4>
        <button id="inputPwX" type="button" class="close" data-dismiss="modal">&times;</button>
      </div>

      <!-- Modal body -->
      <div class="modal-body content">
      </div>

      <!-- Modal footer -->
      <div class="modal-footer">
        <button type="submit" id="inputPwCheckBtn"class="btn btn-info" data-dismiss="modal">확인</button>
      </div>

    </div>
  </div>
</div>

<!-- 두번째 모달 -->
<!-- <div class="modal fade" id="pwAuthenticationModal2"> -->
<!--   <div class="modal-dialog modal-dialog-centered"> -->
<!--     <div class="modal-content"> -->
      <!-- Modal Header -->
<!--       <div class="modal-header"> -->
<!--         <h4 class="modal-title">경고 메시지</h4> -->
<!--         <button id="inputPwX" type="button" class="close" data-dismiss="modal">&times;</button> -->
<!--       </div> -->
      <!-- Modal body -->
<!--       <div class="modal-body content"> -->
<!--            비밀번호를 입력해 주세요 -->
<!--       </div> -->
      <!-- Modal footer -->
<!--       <div class="modal-footer"> -->
<!--         <button type="submit" id="inputPwCheckBtn2"class="btn btn-danger" data-dismiss="modal">확인</button> -->
<!--       </div> -->
<!--     </div> -->
<!--   </div> -->
<!-- </div> -->
