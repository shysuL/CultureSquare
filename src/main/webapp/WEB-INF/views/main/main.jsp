<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<jsp:include page="/WEB-INF/views/layout/header.jsp" />   
    <!-- Favicons -->
<link rel="apple-touch-icon" href="/docs/4.4/assets/img/favicons/apple-touch-icon.png" sizes="180x180">
<link rel="icon" href="/docs/4.4/assets/img/favicons/favicon-32x32.png" sizes="32x32" type="image/png">
<link rel="icon" href="/docs/4.4/assets/img/favicons/favicon-16x16.png" sizes="16x16" type="image/png">
<link rel="manifest" href="/docs/4.4/assets/img/favicons/manifest.json">
<link rel="mask-icon" href="/docs/4.4/assets/img/favicons/safari-pinned-tab.svg" color="#563d7c">
<link rel="icon" href="/docs/4.4/assets/img/favicons/favicon.ico">
<meta name="msapplication-config" content="/docs/4.4/assets/img/favicons/browserconfig.xml">
<meta name="theme-color" content="#563d7c">
<!-- 크롤링 불러오기 ajax -->
<script type="text/javascript">
	$(document).ready(function() {
		
		// 메일인증요구 확인버튼 누를시
		$("#mailCheckOkBtn").click(function(){
			location.href="/logout";
		})
		// 회원가입 후 첫 메일인증요구 모달 띄우기
		if ('${emailcheck}' == 'N'){
			$("#mailCheckModal").modal({backdrop: 'static', keyboard: false});
		} else if('${login}'== true && '${emailcheck}' == 'N' ) {
			$("#mailCheckModal").modal({backdrop: 'static', keyboard: false});
		} else {}
			

		
		//닉넴 중복 검사하는 모달에서 X버튼 눌렀을 때
		$("#SocialMainX").click(function(){
			$("#notifyModal").modal({backdrop: 'static', keyboard: false});
		})
		
		//닉넴 중복 검사하는 모달에서 확인 버튼 눌렀을 때
		$("#SocialMainBtn").click(function(){
			location.href="/socialinsert?socialType=${socialType}&usernick="+$('#socialInput').val()+"&username=${username}";
		})
		
		//중복체크 하지 않을경우 알림 메시지 모달에서 취소버튼 클릭
		$("#notifyCancelBtn").click(function(){
			$("#SocialMainModal").modal({backdrop: 'static', keyboard: false});;
		})
		
		//중복체크 하지 않을경우 알림 메시지 모달에서 확인버튼 클릭
		$("#notifyOkBtn").click(function(){
			location.href="/logout";
		})
		
		//체크박스 눌렀을때 기존 닉네임 사용, 해제시  사라짐
		$("#usesocialnick").change(function(){
			if($("#usesocialnick").is(":checked")){
				$('input[name=usernick]').attr('value','');
				$('input[name=usernick]').attr('value','${socialnick }');
			}else{
			   $('input[name=usernick]').attr('value','');
			 }
		});
		
		//로그인 상태
		if('${login}'){
			
			//소셜 로그인인 경우만  모달 출력
			if('${socialType}' == 'Google' || '${socialType}' == 'Naver' || '${socialType}' == 'Kakao'){
				console.log('${socialDouble}' + " 트루잖아");
				// DB에 회원정보 있을 경우
				if('${socialDouble}'=='true'){
					console.log("DB에 이미 정보 있지");
				}
				// 없을 경우
				else{
					$("#SocialMainModal").modal({backdrop: 'static', keyboard: false});
					
					//중복 체크 버튼을 눌렀을때 
					 $("#SocialCheckBtn").click(function(){
						 
						 var usernick = $('#socialInput').val();
						//닉네임 정규식
						var nickJ = /^[0-9a-zA-Z가-힣]{2,12}$/;
						
							$.ajax({
								url : "/user/nickCheck",
								type : 'post',
								data: {"usernick" : usernick},
								datatype:"json",
								success : function(res){
									console.log(res.nickCheck + "수정");
									if(res.nickCheck == 1){
										$('#nick_check').text('중복된 닉네임입니다')
										$('#nick_check').css('color', 'red')
										$("#SocialMainBtn").attr("disabled", true);
									} else {
										if(nickJ.test(usernick)){
											$('#nick_check').text('사용가능한 닉네임입니다')
											$('#nick_check').css('color','green')
											$("#SocialMainBtn").attr("disabled", false);
										} else if (usernick == ''){
											$('#nick_check').text('닉네임을 입력해주세요')
											$('#nick_check').css('color','red')
											$("#SocialMainBtn").attr("disabled", true);
										}else {
											$('#nick_check').text('올바른 닉네임 형식이 아닙니다')
											$('#nick_check').css('color', 'red')
											$("#SocialMainBtn").attr("disabled", true);
										}
									}
								}
							})
					 })
				}
			}
		}
		else{
			console.log("로그아웃 상태");
		}
		//크롤링
		$.ajax({
			type : "get",
			url : "/main/culture",
			data : {},
			dataType : "html",
			success : function(data) {
				console.log("success")
// 				console.log(data)
				$("#culture").html(data);
				// 링크 바꾸기
				$(".list_title").on("click", "a" , function() {
					window.location.href = "https://search.naver.com/search.naver" + $(this).attr("href");
					return false;
				});
				$(".list_thumb").on("click", "a" , function() {
					window.location.href = "https://search.naver.com/search.naver" + $(this).attr("href");
					return false;
				});
				$(".list_cate").on("click", "a", function() {
					window.location.href = "https://search.naver.com/search.naver" + $(this).attr("href");
					return false;
				});
// 					$("#culture").click(function(){
// 					location.href="https://search.naver.com/search.naver?sm=tab_hty.top&where=nexearch&query=%EA%B3%B5%EC%97%B0&oquery=%EC%B9%B4%EC%B9%B4%EC%98%A4%EB%B0%B0%EA%B7%B8+%EC%8B%9C%EA%B0%84&tqi=UlI4PdprvhGss75of9Nssssss1R-031480";
// 				});
				
				$(".period").on("click", "span", function() {
					
				})
			},
			error : function() {
				console.log("error")
			}
		});
	});
</script>
  
<style type="text/css">

#carouselExampleFade img {
	width: 800px;
	height: 400px;
}

</style>
<br><br>


<div class="container">


	<!-- 캐러셀영역 -->
	<div id="carouselExampleFade" class="carousel slide carousel-fade" data-ride="carousel">
	  <div class="carousel-inner">
	    <div class="carousel-item active">
	      <img src="/resources/slider/main1.jpg" class="d-block w-100" alt="...">
	    </div>
	    <div class="carousel-item">
	      <img src="/resources/slider/main2.jpg" class="d-block w-100" alt="...">
	    </div>
	    <div class="carousel-item">
	      <img src="/resources/slider/main3.jpg" class="d-block w-100" alt="...">
	    </div>
	    <div class="carousel-item">
	      <img src="/resources/slider/main4.jpg" class="d-block w-100" alt="...">
	    </div>
	    <div class="carousel-item">
	      <img src="/resources/slider/main5.jpg" class="d-block w-100" alt="...">
	    </div>
	    <div class="carousel-item">
	      <img src="/resources/slider/main6.jpg" class="d-block w-100" alt="...">
	    </div>
	    <div class="carousel-item">
	      <img src="/resources/slider/main7.jpg" class="d-block w-100" alt="...">
	    </div>
	  </div>
	  <a class="carousel-control-prev" href="#carouselExampleFade" role="button" data-slide="prev">
	    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
	    <span class="sr-only">Previous</span>
	  </a>
	  <a class="carousel-control-next" href="#carouselExampleFade" role="button" data-slide="next">
	    <span class="carousel-control-next-icon" aria-hidden="true"></span>
	    <span class="sr-only">Next</span>
	  </a>
	</div>

	
	<!-- 캐러셀영역 END -->




	<div class="container">
	<hr class="featurette-divider">
	<!-- 크롤링  -->
	<div id="culture"></div>
    <!-- 크롤링 END -->
    
	<div style="clear: both; margin: 10px 0; height: 10px;"></div>
	<hr>
	</div>
	
 
 

	
	   
    
<div>
        <!-- Three columns of text below the carousel -->
    <div class="row">
  
      <div class="col-lg-4">
        <svg class="bd-placeholder-img rounded-circle" width="140" height="140" xmlns="http://www.w3.org/2000/svg" preserveAspectRatio="xMidYMid slice" focusable="false" role="img" aria-label="Placeholder: 140x140"><title>Placeholder</title><rect width="100%" height="100%" fill="#777"/><text x="50%" y="50%" fill="#777" dy=".3em">140x140</text></svg>
        <h2>Heading</h2>
        <p>Donec sed odio dui. Etiam porta sem malesuada magna mollis euismod. Nullam id dolor id nibh ultricies vehicula ut id elit. Morbi leo risus, porta ac consectetur ac, vestibulum at eros. Praesent commodo cursus magna.</p>
        <p><a class="btn btn-secondary" href="#" role="button">View details &raquo;</a></p>
      </div><!-- /.col-lg-4 -->
      <div class="col-lg-4">
        <svg class="bd-placeholder-img rounded-circle" width="140" height="140" xmlns="http://www.w3.org/2000/svg" preserveAspectRatio="xMidYMid slice" focusable="false" role="img" aria-label="Placeholder: 140x140"><title>Placeholder</title><rect width="100%" height="100%" fill="#777"/><text x="50%" y="50%" fill="#777" dy=".3em">140x140</text></svg>
        <h2>Heading</h2>
        <p>Duis mollis, est non commodo luctus, nisi erat porttitor ligula, eget lacinia odio sem nec elit. Cras mattis consectetur purus sit amet fermentum. Fusce dapibus, tellus ac cursus commodo, tortor mauris condimentum nibh.</p>
        <p><a class="btn btn-secondary" href="#" role="button">View details &raquo;</a></p>
      </div><!-- /.col-lg-4 -->
      <div class="col-lg-4">
        <svg class="bd-placeholder-img rounded-circle" width="140" height="140" xmlns="http://www.w3.org/2000/svg" preserveAspectRatio="xMidYMid slice" focusable="false" role="img" aria-label="Placeholder: 140x140"><title>Placeholder</title><rect width="100%" height="100%" fill="#777"/><text x="50%" y="50%" fill="#777" dy=".3em">140x140</text></svg>
        <h2>Heading</h2>
        <p>Donec sed odio dui. Cras justo odio, dapibus ac facilisis in, egestas eget quam. Vestibulum id ligula porta felis euismod semper. Fusce dapibus, tellus ac cursus commodo, tortor mauris condimentum nibh, ut fermentum massa justo sit amet risus.</p>
        <p><a class="btn btn-secondary" href="#" role="button">View details &raquo;</a></p>
      </div><!-- /.col-lg-4 -->
    </div><!-- /.row -->
    
    
    
	</div>
    <!-- /END THE FEATURETTES -->
    
<!-- 묻는 모달 -->
<div class="modal fade" id="notifyModal">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content">

      <!-- Modal Header -->
      <div class="modal-header">
        <h4 class="modal-title">알림</h4>
      </div>

      <!-- Modal body -->
      <div class="modal-body content">
      	닉네임 중복 검사를 하지 않으실 경우,<br>
      	 소셜 로그인 서비스를 이용할 수 없습니다. 
      	<br>
      	계속 하시겠습니까?
      </div>

      <!-- Modal footer -->
      <div class="modal-footer">
        <button type="submit" id="notifyOkBtn"class="btn btn-info" data-dismiss="modal">확인</button>
        <button type="submit" id="notifyCancelBtn"class="btn btn-danger" data-dismiss="modal">취소</button>
      </div>

    </div>
  </div>
</div>

<!-- 모달창 -->
<div class="modal fade" id="SocialMainModal">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content">

      <!-- Modal Header -->
      <div class="modal-header">
        <h4 class="modal-title" id ="nickalarm">닉네임 중복을 진행해 주세요</h4>
        <button id="SocialMainX" type="button" class="close" data-dismiss="modal">&times;</button>
      </div>

      <!-- Modal body -->
      <div class="modal-body content">
      
      <c:choose>
      	<c:when test="${socialType eq 'Google'}">
      		<img src="/resources/img/googleCircle.png" style="width:32px; height:32px;">
      	</c:when>
      	<c:when test="${socialType eq 'Naver'}">
      		<img src="/resources/img/naverCircle.png" style="width:32px; height:32px;">
      	</c:when>
      	<c:otherwise>
      		<img src="/resources/img/kakaoCircle.png" style="width:32px; height:32px;">
      	</c:otherwise>
      </c:choose>
      	 닉네임 : ${socialnick } <input type='checkbox' name='usesocialnick' id='usesocialnick' />
      	 <br>
      	사용할 닉네임 입력 : 
     	 <input type="text" name = "usernick"id="socialInput" value="">
     	 <div class="check_font" id="nick_check"></div>
      </div>

      <!-- Modal footer -->
      <div class="modal-footer">
        <button id="SocialCheckBtn"class="btn btn-info">중복체크</button>
        <button type="submit" id="SocialMainBtn"class="btn btn-info" data-dismiss="modal" disabled>확인</button>
      </div>

    </div>
  </div>
</div>


<!-- 회원가입 후 메일인증 모달 -->
<div class="modal fade" id="mailCheckModal">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content">

      <!-- Modal Header -->
      <div class="modal-header">
        <h4 class="modal-title">알림</h4>
      </div>

      <!-- Modal body -->
      <div class="modal-body content">
      	 ${usermailcheck.username}님의 가입하신 이메일(${usermailcheck.userid})에서<br> 
      	 인증완료 해주시면 서비스 이용 가능합니다.
      </div>

      <!-- Modal footer -->
      <div class="modal-footer">
        <button type="submit" id="mailCheckOkBtn"class="btn btn-info" data-dismiss="modal">확인</button>
      </div>

    </div>
  </div>
</div>

</div><!-- /.container -->


<jsp:include page="/WEB-INF/views/layout/footer.jsp" />

