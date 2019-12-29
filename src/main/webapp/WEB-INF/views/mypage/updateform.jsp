<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<jsp:include page="/WEB-INF/views/layout/header.jsp" />    
    
<style type="text/css">
#updateform {
	margin-bottom: 3%; 
	margin-top: 3%; 
	margin-left: 30%;
	margin-right: 30%;
	border: 1px solid #ccc;
	padding-top: 2%;
	padding-bottom: 2%;
}

#updateform2 {
	width: 500px;
/* 	margin-left: 300px; */
/* 	margin-right: 300px; */
}
</style>

<div class="container container-center">
	<div class="container text-center">
		<h4 id="updateform">개인정보 수정</h4>
	</div>
	
	<form action="/mypage/updateform" method="post">
		<div class="container container-center" id="updateform2">
			이름 : ${username }<br>
			성별 : ${usergender }<br>
			생년월일 : ${userbirth }<br>
			아이디 : ${userid }<br>
			닉네임 : <input type="text" value="${usernick }"/><button>중복확인</button><br>
			전화번호 : <input type="text" value="${userphone }"/><br>
			관심분야 : <input type="text" value="${interest }"/><br>
			<button id="updatecancel" class="btn btn-danger" >수정 취소</button>
			<button type="submit" id="updatesuccess" class="btn btn-dark">수정 완료</button>
		
		</div>
	</form>


</div>
    
<jsp:include page="/WEB-INF/views/layout/footer.jsp" />    