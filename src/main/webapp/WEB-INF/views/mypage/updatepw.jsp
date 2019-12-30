<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

    
<script type="text/javascript">
//--- 비밀번호수정 모달 ---
$(document).ready(function() {
	
	//경고 모달 호출 메서드
	   function warningModal(content) {
	      $(".modal-contents").text(content);
	      $("#defaultModal").modal('show');
	      console.log("나는 경고모달창");
	   }
	
	$("#updateUserPw").click(function(){
// 		var userpw = $('#userpw').val();
		
		$("#updateUserPwModal").modal({backdrop: 'static', keyboard: false});
		
		$("#updatePw").click(function(){
			//현재 비밀번호 입력
			if($("#currentpw").val() == ""){
				warningModal('현재 비밀번호를 입력해주세요.')
				console.log("비밀번호 ${user.userpw}")
				$("#currentpw").focus();
				return false;
			}
			
			//현재 비밀번호 오류
			if($("currentpw").val() != "${user.userpw}"){
				warningModal('현재 비밀번호를 다시 입력해주세요.')
				$("#currentpw").focus();
				return false;
			}
			
			//변경할 비밀번호
			if($("#changepw").val() == ""){
				warningModal('변경할 비밀번호를 입력해주세요.')
				$("#changepw").focus();
				return false;
			}
			
			//변경할 비밀번호 다시 입력
			if("#changepw2".val() == ""){
				warningModal('변경할 비밀번호를 한 번 더 입력해주세요.')
				$("#changepw2").focus();
				return false;
			}
			
			// 변경할 비밀번호와 재확인이 같지 않을 때
			if(($("#currentpw").val()) == ($("#changepw").val())){
		    	warningModal('현재 비밀번호와 다르게 입력하세요');
		    	return false;
			}
	       	
			if(($("#changepw").val()) != ($("#changepw2").val())){
		    	warningModal('변경하실 비밀번호가 일치하지 않습니다');
		    	return false;
			}
			
			$("#updateForm").submit();
		})
	})
	
});
</script>

<!-- 비밀번호 수정 -->
			<br>
			<button type="button" class="btn btn-outline-dark" data-toggle="modal" id="updateUserPw" style="width: 84%; display: block; margin: 0 auto;">비밀번호 변경</button>
			
			<form action="/mypage/updatepw" method="post" id="updateForm">	
				<!-- 비밀번호 모달 -->
				<div class="modal fade" id="updateUserPwModal">
					<div class="modal-dialog modal-dialog-centered">
						<div class="modal-content">
	
							<!-- Modal Header -->
							<div class="modal-header">
								<h4 class="modal-title">비밀번호 변경</h4>
								<button id="inputPwX" type="button" class="close"
									data-dismiss="modal">&times;</button>
							</div>
	
							<!-- Modal body -->
							<div class="modal-body content" id="modalBody">
								<input type="hidden" value="${user.userno }" id="userno" name="userno"/>
								<input type="hidden" value="${user.userid }" id="userid" name="userid"/>
								
								현재 비밀번호 
								<input type="password" name="currentpw" id="currentpw" placeholder="현재 비밀번호 입력"/><br><br>
								변경할 비밀번호
								<input type="password" name="changepw" id="changepw" placeholder="변경할 비밀번호 입력"/><br><br>
								비밀번호 확인
								<input type="password" name="changepw2" id="changepw2" placeholder="변경할 비밀번호 재입력"/><br><br>
							</div>
	
							<!-- Modal footer -->
							<div class="modal-footer">
								<button type="submit" id="updatePw" class="btn btn-dark" data-dismiss="modal">변경하기</button>
								<button type="button" class="btn btn-danger" data-dismiss="modal">취소</button>
							</div>
	
						</div>
					</div>
				</div>
			</form>
			
			<!--모달창 -->
			<div class="modal fade" id="defaultModal">
				<div class="modal-dialog">
					<div class="modal-content ">
						<div class="modal-header panel-heading">
							<h4 class="modal-title">비밀번호 변경 알림</h4>
						</div>
						<div class="modal-body">
							<p class="modal-contents"></p>
						</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-dark" data-dismiss="modal">확인</button>
						</div>
					</div>
					<!-- /.modal-content -->
				</div>
				<!-- /.modal-dialog -->
			</div>
			<!-- /.modal -->
