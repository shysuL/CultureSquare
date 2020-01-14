<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>  
<jsp:include page="/WEB-INF/views/layout/header.jsp"/>   

<div class="container">

<div class="h2"><h2> FQA </h2></div>
<hr>

<div class="accordion" id="accordionExample">
  <div class="card">
    <div class="card-header" id="headingOne">
      <h2 class="mb-0">
        <button class="btn btn-link" type="button" data-toggle="collapse" data-target="#collapseOne" aria-expanded="true" aria-controls="collapseOne">
		CALENDAL 페이지에서 글쓰기가 되지 않아요.
        </button>
      </h2>
    </div>
    <div id="collapseOne" class="collapse show" aria-labelledby="headingOne" data-parent="#accordionExample">
      <div class="card-body">
		CALENDAL 페이지는 예술활동을 하시는 분들만 글쓰기 기능이 가능합니다.<br> 
		회원 가입 후 마이페이지에서 예술인 신청을 해주세요.<br>
		예술활동을 하시는 회원님이 아니시면 작성글 보기 기능만 이용 가능합니다. 
      </div>
    </div>
  </div>
  
  
  <div class="card">
    <div class="card-header" id="headingTwo">
      <h2 class="mb-0">
        <button class="btn btn-link collapsed" type="button" data-toggle="collapse" data-target="#collapseTwo" aria-expanded="false" aria-controls="collapseTwo">
		CALENDAL 페이지에서 대표 이미지 사진은 어떻게 올리나요? 
        </button>
      </h2>
    </div>
    <div id="collapseTwo" class="collapse" aria-labelledby="headingTwo" data-parent="#accordionExample">
      <div class="card-body">
		글쓰기 버튼을 누르신 후 아래부분에 파일 첨부버튼이 있습니다.<br>
		여러가지 파일이 업로드 가능하며, 그 중 첫번째 파일이 이미지 사진이면 대표 사진으로 자동 설정됩니다.<br>
		*주의* 폭력적이거나 음란한 파일 업로드는 법적으로 조취하고 있으니 주의해 주시기 바랍니다.
      </div>
    </div>
  </div>
  
  
  <div class="card">
    <div class="card-header" id="headingThree">
      <h2 class="mb-0">
        <button class="btn btn-link collapsed" type="button" data-toggle="collapse" data-target="#collapseThree" aria-expanded="false" aria-controls="collapseThree">
		CALENDAL 공연 자료가 많아 원하는 공연을 찾기가 힘들어요.
        </button>
      </h2>
    </div>
    <div id="collapseThree" class="collapse" aria-labelledby="headingThree" data-parent="#accordionExample">
      <div class="card-body">
		페이지 우측에 카테고리별 보기에서 버스킹, 전시회, 콘서트 등 원하시는 공연을 클릭하시면 해당 공연 자료를 한눈에 보실 수 있습니다. 
      </div>
    </div>
  </div>


  <div class="card">
    <div class="card-header" id="headingFour">
      <h2 class="mb-0">
        <button class="btn btn-link collapsed" type="button" data-toggle="collapse" data-target="#collapseFour" aria-expanded="false" aria-controls="collapseFour">
		PR 게시판은 어떻게 사용하나요?
        </button>
      </h2>
    </div>
    <div id="collapseFour" class="collapse" aria-labelledby="headingFour" data-parent="#accordionExample">
      <div class="card-body">
		예술활동을 하시는 회원님이 아니어도, 예술인 승인을 받지 않아도 글쓰기가 가능합니다.<br>
		자신이 활동하거나 홍보하고 싶은 예술인의 앨범, 공연, 전시회 등을 홍보할 수 있습니다.  
      </div>
    </div>
  </div>


  <div class="card">
    <div class="card-header" id="headingFive">
      <h2 class="mb-0">
        <button class="btn btn-link collapsed" type="button" data-toggle="collapse" data-target="#collapseFive" aria-expanded="false" aria-controls="collapseFive">
		예술인 신청을 하고 싶은데 어디에서 해야하나요?
        </button>
      </h2>
    </div>
    <div id="collapseFive" class="collapse" aria-labelledby="headingFive" data-parent="#accordionExample">
      <div class="card-body">
		예술인 신청은 회원 가입 후 우측 상단에 있는 사람 모양의 아이콘을 클릭 하신 후 마이페이지에 들어가셔서
		예술인 신청을 클릭하시면 됩니다. <br>
		그 외에 개인정보 수정, 프로필 사진 변경, 회원 탈퇴 등이 가능합니다.
      </div>
    </div>
  </div>
</div>


</div><!-- .container -->
 
<jsp:include page="/WEB-INF/views/layout/footer.jsp"/>  


</body>
</html>