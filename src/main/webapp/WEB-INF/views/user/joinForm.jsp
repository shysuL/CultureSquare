<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!-- Header -->
<jsp:include page="/WEB-INF/views/layout/header.jsp"/>

<style type="text/css">

.container{
	margin-top: 5%;
}

</style>

<div class="container">
   
   <div class="innercon1" style="width: 40%;">
   
      <div style="background-color: #252525;">
         <h2 style="color: #FFFFFF;">회원가입</h2>
      </div>
      
      <div>
         <form action="/user/joinProc" class="was-validated" method=post>
           
           <div class="form-group">
             <label for="userid">아이디</label>
             <input type="text" class="form-control" id="userid" placeholder="이메일 입력" name="userid" required>
             <div class="valid-feedback">Valid.</div>
             <div class="invalid-feedback">Please fill out this field.</div>
           </div>
           
           <div class="form-group">
             <label for="userpw">비밀번호</label>
             <input type="password" class="form-control" id="userpw" placeholder="비밀번호 입력" name="userpw" required>
             <div class="valid-feedback">Valid.</div>
             <div class="invalid-feedback">Please fill out this field.</div>
           </div>

           <div class="form-group">
             <label for="userpw">비밀번호</label>
             <input type="password" class="form-control" id="userpw2" placeholder="비밀번호 재입력" name="userpw2" required>
             <div class="valid-feedback">Valid.</div>
             <div class="invalid-feedback">Please fill out this field.</div>
           </div>
           
           <div class="form-group">
             <label for="username">이름</label>
             <input type="text" class="form-control" id="username" placeholder="이름 입력" name="username" required>
             <div class="valid-feedback">Valid.</div>
             <div class="invalid-feedback">Please fill out this field.</div>
           </div>

           <div class="form-group">
             <label for="usernick">닉네임</label>
             <input type="text" class="form-control" id="usernick" placeholder="닉네임 입력" name="usernick" required>
             <div class="valid-feedback">Valid.</div>
             <div class="invalid-feedback">Please fill out this field.</div>
           </div>
           
           <div class="form-group">
             <label for="userphone">전화번호</label>
             <input type="tel" class="form-control" id="userphone" placeholder="핸드폰 번호 입력" name="userphone" required>
             <div class="valid-feedback">Valid.</div>
             <div class="invalid-feedback">Please fill out this field.</div>
           </div>
           
           <div class="form-group">
             <label for="userbirth">생년월일</label>
             <input type="text" class="form-control" id="userbirth" placeholder="생년월일 입력" name="userbirth" required>
             <div class="valid-feedback">Valid.</div>
             <div class="invalid-feedback">Please fill out this field.</div>
           </div>
           
           
           <div class="form-group">
           		성별
	            <div class="custom-control custom-radio">
	               <input type="radio" class="custom-control-input" id="customradiom" name="usergender" value="남자">
	               <label class="custom-control-label" for="customradiom">남자</label>
	            </div>
	            <div class="custom-control custom-radio">
	               <input type="radio" class="custom-control-input" id="customradiow" name="usergender" value="여자">
	               <label class="custom-control-label" for="customradiow">여자</label>
	            </div>
           </div> 
           
           <div class="form-group">
           		관심분야
           		<div class="custom-control custom-check">
	               <input type="checkbox" class="custom-control-input" id="busking" name="interest" value="버스킹">
	               <label class="custom-control-label" for="busking">버스킹</label>
	            </div>
	            <div class="custom-control custom-check">
	               <input type="checkbox" class="custom-control-input" id="perform" name="interest" value="공연/예술">
	               <label class="custom-control-label" for="perform">공연/예술</label>
	            </div>
	            <div class="custom-control custom-check">
	               <input type="checkbox" class="custom-control-input" id="etc" name="interest" value="기타">
	               <label class="custom-control-label" for="etc">기타</label>
	            </div>           		
           </div>
           
           <div class="form-group">
           		회원구분
	            <div class="custom-control custom-radio">
	               <input type="radio" class="custom-control-input" id="usualuser" name="usertype" value="0">
	               <label class="custom-control-label" for="usualuser">일반 사용자</label>
	            </div>
	            <div class="custom-control custom-radio">
	               <input type="radio" class="custom-control-input" id="perfomencer" name="usertype" value="1">
	               <label class="custom-control-label" for="perfomencer">예술인</label>
	            </div>
           </div> 
                           
           <div class="form-group form-check">
             <label class="form-check-label">
               <input class="form-check-input" type="checkbox" name="remember" required> 이용약관 및 개인정보처리방침에 동의
               <div class="valid-feedback">동의하셨습니다.</div>
               <div class="invalid-feedback">동의하시면 체크버튼을 눌러주세요</div>
             </label>
           </div>
           
           <button type="submit" class="btn btn-primary">가입</button>
         </form>
      </div>

   </div> <!-- innercon1 -->
</div> <!-- container -->



<!-- footer -->
<jsp:include page="/WEB-INF/views/layout/footer.jsp"/>