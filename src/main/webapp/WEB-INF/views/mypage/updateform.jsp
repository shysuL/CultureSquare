<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

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
			<input type="hidden" name = "userno" value="${getUser.userno }"/>
			이름 : ${getUser.username }<br>
			성별 : ${getUser.usergender }<br>
			생년월일 : ${getUser.userbirth }<br>
			아이디 : ${getUser.userid }<br>
			닉네임 : <input type="text" id="usernick" name = "usernick" value="${getUser.usernick }"/><button>중복확인</button><br>
			전화번호 : <input type="text" id="userphone" name = "userphone" value="${getUser.userphone }"/><br>
<%-- 			관심분야 : <input type="text" id="interest" name = "interest" value="${getUser.interest }"/><br> --%>
			<div class="form-group">
           		관심분야
           		<c:forEach items="${checkList}" var="check">
	           			<c:if test="${check == '버스킹'}">
	           		<div class="custom-control custom-check">
		                	<input type="checkbox" class="custom-control-input" id="busking" name="interest" value="버스킹" checked="checked">
		                <label class="custom-control-label" for="busking">버스킹</label>
		            </div>
		                </c:if>
        				<c:if test="${check == '공연/예술'}">
		            <div class="custom-control custom-check">
							<input type="checkbox" class="custom-control-input" id="perform" name="interest" value="공연/예술" checked="checked">
		                <label class="custom-control-label" for="perform">공연/예술</label>
		            </div>
	                </c:if>
           				<c:if test="${check == '기타'}">
		            <div class="custom-control custom-check">
		                <input type="checkbox" class="custom-control-input" id="etc" name="interest" value="기타">
		                <label class="custom-control-label" for="etc">기타</label>
		            </div>   
		                </c:if>
				</c:forEach>       		
			</div>
           
			<button id="updatecancel" class="btn btn-danger" >수정 취소</button>
			<button type="submit" id="updatesuccess" class="btn btn-dark">수정 완료</button>
		
		</div>
	</form>


</div>
    
<jsp:include page="/WEB-INF/views/layout/footer.jsp" />    