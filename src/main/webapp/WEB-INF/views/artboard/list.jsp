<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
    <%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>
    
<%@ page import="java.util.*"%>
<%@ page import="java.text.*"%>

<jsp:include page="/WEB-INF/views/layout/header.jsp" />  


<script type="text/javascript">
$(document).ready(function() {
	
	//로그인 했을 경우 글쓰기 버튼 누르면 이동
	$("#LoginWrite").click(function() {
		location.href="/artboard/write";
		return false;
	});
	
	//로그인 안했을 경우 글쓰기 버튼 누르면 모달
	$("#notLoginWrite").click(function() {
		$(".content").text('로그인 후 게시글 작성이 가능합니다.');
		$("#pfNotLoginModal").modal({backdrop: 'static', keyboard: false});
		return false;
	});

	//로그인 회원이 예술인이거나 소셜로그인인 경우 글쓰기 버튼 누르면 모달
	$("#notArtistWrite").click(function() {
		$(".content").text('예술인 회원만 게시글 작성이 가능합니다.');
		$("#pfNotArtistModal").modal({backdrop: 'static', keyboard: false});
		return false;
	});
	
});
</script>

<%
	Date date = new Date();
	SimpleDateFormat simpleDate = new SimpleDateFormat("yyyy-MM-dd");
	String strdate = simpleDate.format(date);
%>
<%
	Calendar cal = Calendar.getInstance();
%>

<script type="text/javascript">
	var today = null;
	var year = null;
	var month = null;
<%-- 	<%= cal.get(Calendar.YEAR)%> --%>
<%-- 	<%= cal.get(Calendar.MONTH) +1 %>	 --%>
	// =============================================== 날짜 포맷 함수 ===============================================
	
	
	//calendar 월 이동
	function movePrevMonth() {
		month--;
		if (month <= 0) {
			month = 12;
			year--;
		}
		if (month < 10) {
			month = String("0" + month);
		}
		location.href="/artboard/list?bo_table=calendar&cal_year="+year+"&cal_month="+month;
	}
	function moveNextMonth() {
		month++;
		if (month > 12) {
			month = 1;
			year++;
		}
		if (month < 10) {
			month = String("0" + month);
		}
		location.href="/artboard/list?bo_table=calendar&cal_year="+year+"&cal_month="+month;
	}
	//날짜 초기화
	function initDate() {
		dayCount = 0;
		today = new Date();
// 		year = today.getFullYear();
// 		month = today.getMonth() + 1;
		year = "${nowYear}";
		month = "${nowMonth}";
		if (month < 10) {
			month = "0" + month;
		}
	}
	
	
$(document).ready(function(){
	initDate();
	$("#movePrevMonth").on("click", function() {
		movePrevMonth();
	});
	$("#moveNextMonth").on("click", function() {
		moveNextMonth();
	});
	
});	


</script>




<style type="text/css">
#views_img{
    max-width: 4%;
	float:right;
	margin-right: 6px;
}
#views{
	float: right;
	margin-right: 6px;
}
#like_img{
    max-width: 4%;
    float: right;
	margin-right: 6px;
}
#likes{
    max-width: 4%;
    float: right;
	margin-right: 6px;
}
#reply_img{
    max-width: 4%;
    float: right;
	margin-right: 6px;
}
#replies{
    max-width: 4%;
    float: right;
	margin-right: 6px;
}

#top {
    position: fixed;
    right: 5%;
    bottom: 50px;
    z-index: 999;
    font-size: 20px;
    text-decoration: none;
}
</style>

<div class="container list-container">
<div class="h2"><h2> CALENDAR </h2></div>
<hr>
<div class="row">

	<a id="top" href="#">승리싫어하는 사람 눌러</a>
	
	<!-- 공연 게시판 -->
	<!-- 캐러셀영역 -->
	<div class="col-9">
	<div id="carouselExampleFade" class="carousel slide carousel-fade" data-ride="carousel">
	  <div class="carousel-inner">
	    <div class="carousel-item active">
	      <a href="https://www.iei.or.kr/question/event.kh"><img src="/resources/img/banner.png" class="d-block w-100" alt="..."></a>
	    </div>
	    <div class="carousel-item">
	      <a href="https://www.youtube.com/watch?v=I9BPyqvdDYc"><img src="/resources/img/banner2.jpg" class="d-block w-100" alt="..."></a>
	    </div>
	    <div class="carousel-item">
	      <a href="http://www.joongboo.com/news/articleView.html?idxno=363373120"><img src="/resources/img/banner3.jpg" class="d-block w-100" alt="..."></a>
	    </div>
	    <div class="carousel-item">
	      <a href="https://www.ggcf.or.kr/pages/festival/view.asp?MU_IDX=36&Cul_Idx=21510"><img src="/resources/img/banner4.jpg" class="d-block w-100" alt="..."></a>
	    </div>
	    <div class="carousel-item">
	      <a href="http://mticket.interpark.com/Goods/GoodsInfo/info?GoodsCode=19018269&app_tapbar_state=fix"><img src="/resources/img/banner5.jpg" class="d-block w-100" alt="..."></a>
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
	
	<!-- 상단 글작성 버튼 -->
	<div class="b">
	<c:choose>
		<c:when test="${not login}">
		<div>
			<button id="notLoginWrite" class="btn bbc">글작성</button>
		</div>
		</c:when>
		<%--  예술인일 때 작성 가능한 조건 추가 필요 --%>
	 <c:otherwise> 
     <c:choose> 
			<c:when test = "${LoginUser.usertype ne 1}">
			<div>
			<button id="notArtistWrite" class="btn bbc">글작성</button>
			</div>
			</c:when>
			<c:otherwise>
			<div>
			<a href="/artboard/write">
			<button id="LoginWrite"class="btn bbc">글작성</button>
			</a>
			</div>
			</c:otherwise>
		</c:choose>
		</c:otherwise>
	</c:choose>
	</div> 


	<!-- 월 이동 -->
	<div id="list_table" class="width_660 box_shadow_3 text-center">
		<div class="list_cal_row_title relative">
			<div class="cal_header_div eng">
				<form method="get" action="/artboard/list">
					<input type="hidden" name="bo_table" value="calendar">
					<a href="#" id="movePrevMonth">
						<span id="prevMonth" class="cal_tit">
					<i class="fa fa-chevron-left goto" ></i>
					</span>
					</a>
					&nbsp;&nbsp;
					<input class="cal_header_year inputin" type="text" name="cal_year" id="cal_year" value="${nowYear }" maxlength="4" required="required"  data-hasqtip="23" oldtitle="년도" title="">&nbsp;/&nbsp;
					<input class="cal_header_month inputin" type="text" name="cal_month" id="cal_month" value="${nowMonth }" maxlength="2" required="required"  data-hasqtip="24" oldtitle="월" title="">&nbsp;
					<input class="btn inputbt" type="submit" value="이동" data-hasqtip="25" oldtitle="이동" title="">&nbsp;&nbsp;
					<a href="#" id="moveNextMonth">
					<span id="nextMonth" class="cal_tit">
					<i class="fa fa-chevron-right goto" >
					</i>
					</span>
					</a>
				</form>
			</div>
		</div>
	</div>
	
	<div id="cal_tab" class="cal"></div>

	<c:forEach items="${list }" var="i">
	<div class = "list">
		<!-- 공연 날짜 표기 -->
		<div class="perdate cal_col0 relative float_left center theme_key2" data-hasqtip="31" oldtitle="아직 출시 전인 제품입니다." title="" aria-describedby="qtip-31">
			<c:set var = "string1" value = "${i.performdate }"/>
	   	 	<c:set var = "length" value = "${fn:length(string1)}"/>
	    	<c:set var = "pdate" value = "${fn:substring(string1, length -2, length)}" />
			<div class="cal_date eng bold help" style="font-size: 25px; margin-top: 8px;">${pdate }</div>
			<div class="cal_yoil help han " style=" margin-top: 5px;">${i.performday }<span class="mobile_hide">요일</span></div>
		</div>
		<!-- 리스트 사진, 제목 -->
		<div class="media float_right">
			<div class="media-left media-middle">
				<a href="/artboard/view?boardno=${i.boardno }">
				<img class="media-object" onerror="this.src='/resources/img/NoImage.gif';" src="/pfImage/${i.boardno }" style="width: 80px; height: 80px;">
				</a>
			</div>
			<div class="media-body">
				<c:choose>
					<c:when test="${i.userno == 0 }">
						<span class="media-heading"><a href="/artboard/view?boardno=${i.boardno}"
						style = "font-size: 23px; color: #343A40;">[삭제된 게시물 ] ${i.title }</a></span>
					</c:when>
					<c:otherwise>
						<span class="media-heading"><a href="/artboard/view?boardno=${i.boardno}"
						style = "font-size: 23px; color: #343A40;">${i.title }</a></span>
					</c:otherwise>
				</c:choose>
				<br><br>
				<span id = "category_name" style = "color: #343A40;">${i.performname}</span>
				
				<span id = "views">${i.views }</span>
				<span id = "views_img"><img src="/resources/img/view.png" class="d-block w-100" alt="..."> </span>

				<span id = "replies"> ${i.replyCnt } </span>
				<span id = "reply_img"><img src="/resources/img/note.png" class="d-block w-100" alt="..."></span>

				<span id = "likes"> ${i.blike } </span>
				<span id = "like_img"><img src="/resources/img/like.png" class="d-block w-100" alt="..."></span> 
				
				
			</div>
	  
		</div>
	</div>
	</c:forEach>




	
	</div>
	
	<!-- 사이트 게시판 -->
	<div class="col-3">
		<div>
			<div class="list-group" >
	  		<a class="list-group-item" id="pfIntroduceContent">CALENDAR 소개</a>
	  		<a class="list-group-item tit" style="font-size: 14px">
	  			버스킹, 연극, 공연, 전시 등의<br>
	 		  	일정을 포스팅하는 공간입니다.</a>
			</div>
		</div>
		<br>
		<div>
			<div>
		  		<table class="list-group">
		  		<tr>
		  		<th colspan="4"><a class="list-group-item" id="pfIntroduceContent">카테고리 별 보기</a></th>
		  		</tr>
		  		
		  		<tr>
		  		<td><a href="/artboard/list?bo_table=calendar&cal_year=<%= cal.get(Calendar.YEAR)%>&cal_month=<%=(cal.get(Calendar.MONTH)+1< 10) ?"0"+(cal.get(Calendar.MONTH)+1) :cal.get(Calendar.MONTH)+1%>" ><input class="list-group-item action cate" type="submit" value="전체" /></a></td>
		  		<td><a href="/artboard/list?bo_table=calendar&cal_year=<%= cal.get(Calendar.YEAR)%>&cal_month=<%=(cal.get(Calendar.MONTH)+1< 10) ?"0"+(cal.get(Calendar.MONTH)+1) :cal.get(Calendar.MONTH)+1%>&performname=버스킹" ><input class="list-group-item cate" type="submit" value="버스킹" /></a></td>
		  		<td><a href="/artboard/list?bo_table=calendar&cal_year=<%= cal.get(Calendar.YEAR)%>&cal_month=<%=(cal.get(Calendar.MONTH)+1< 10) ?"0"+(cal.get(Calendar.MONTH)+1) :cal.get(Calendar.MONTH)+1%>&performname=전시회" ><input class="list-group-item cate" type="submit" value="전시회" /></a></td>
		  		<td><a href="/artboard/list?bo_table=calendar&cal_year=<%= cal.get(Calendar.YEAR)%>&cal_month=<%=(cal.get(Calendar.MONTH)+1< 10) ?"0"+(cal.get(Calendar.MONTH)+1) :cal.get(Calendar.MONTH)+1%>&performname=연극" ><input class="list-group-item cate" type="submit" value="연극" /></a></td>
		  		</tr>
		  		
		  		<tr>
		  		<td><a href="/artboard/list?bo_table=calendar&cal_year=<%= cal.get(Calendar.YEAR)%>&cal_month=<%=(cal.get(Calendar.MONTH)+1< 10) ?"0"+(cal.get(Calendar.MONTH)+1) :cal.get(Calendar.MONTH)+1%>&performname=콘서트" ><input class="list-group-item cate" type="submit" value="콘서트" /></a></td>
		  		<td><a href="/artboard/list?bo_table=calendar&cal_year=<%= cal.get(Calendar.YEAR)%>&cal_month=<%=(cal.get(Calendar.MONTH)+1< 10) ?"0"+(cal.get(Calendar.MONTH)+1) :cal.get(Calendar.MONTH)+1%>&performname=뮤지컬" ><input class="list-group-item cate" type="submit" value="뮤지컬" /></a></td>
		  		<td><a href="/artboard/list?bo_table=calendar&cal_year=<%= cal.get(Calendar.YEAR)%>&cal_month=<%=(cal.get(Calendar.MONTH)+1< 10) ?"0"+(cal.get(Calendar.MONTH)+1) :cal.get(Calendar.MONTH)+1%>&performname=행사" ><input class="list-group-item cate" type="submit" value="행사" /></a></td>
		  		<td><a href="/artboard/list?bo_table=calendar&cal_year=<%= cal.get(Calendar.YEAR)%>&cal_month=<%=(cal.get(Calendar.MONTH)+1< 10) ?"0"+(cal.get(Calendar.MONTH)+1) :cal.get(Calendar.MONTH)+1%>&performname=축제" ><input class="list-group-item cate" type="submit" value="축제" /></a></td>
		  		</tr>
		  		</table>
			</div>
		</div>
		<br><br>
		<!-- 유투브 -->
		<div>
		<h5>한국 비보이 외국 길거리 공연</h5>
		<iframe  src="https://www.youtube.com/embed/pg3nlZx2gL8" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
		</div>
		<br>
		<div>
		<h5>[연극] 그남자 그여자</h5>
		<iframe  src="https://www.youtube.com/embed/2VgVekCEjPY" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
		</div>
		<br>
		<div>
		<h5>[뮤지컬] 웃는남자</h5>
		<iframe src="https://www.youtube.com/embed/WrFphwt29og" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
		</div>
		<br>
		<div>
		<h5>한국 댄스팀 퍼포먼스</h5>
		<iframe src="https://www.youtube.com/embed/GaJNVdJ_gBg" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
		</div>
		
	</div>
	
</div>

<!-- 비로그인 시 모달창 -->
<div class="modal fade" id="pfNotLoginModal">
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
        <button type="submit" id="pfLoginCheckBtn"class="btn btn-info" data-dismiss="modal">확인</button>
      </div>

    </div>
  </div>
</div>

<!-- 일반회원, 소셜회원 글작성 클릭 시 모달창 -->
<div class="modal fade" id="pfNotArtistModal">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content">

      <!-- Modal Header -->
      <div class="modal-header">
        <h4 class="modal-title">일반회원, 소셜로그인 회원</h4>
        <button id="inputPwX" type="button" class="close" data-dismiss="modal">&times;</button>
      </div>

      <!-- Modal body -->
      <div class="modal-body content">
      </div>

      <!-- Modal footer -->
      <div class="modal-footer">
        <button type="submit" id="pfLoginCheckBtn"class="btn btn-info" data-dismiss="modal">확인</button>
      </div>

    </div>
  </div>
</div>


	
</div> <!-- container -->


<jsp:include page="/WEB-INF/views/layout/footer.jsp" />






