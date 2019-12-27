<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
    <%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>
    
<%@ page import="java.util.Calendar"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.text.DecimalFormat"%>
<%@ page import="java.text.SimpleDateFormat"%>

<jsp:include page="/WEB-INF/views/layout/header.jsp" />  

<script type="text/javascript">
$(document).ready(function() {
	
	//글쓰기 버튼 누르면 이동
	$("#btnWrite").click(function() {
		location.href= "/artboard/write";
	});
	
});
</script>


<div class="container list-container">
<div class="h2"><h2> CALLENDAR </h2></div>
<hr>
<div class="row">

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
	
	<div class="b">
	<button id="btnWrite" class="btnwritee" >글작성</button>
	</div>
	
	<div id="list_table" class="width_660 box_shadow_3 text-center">
		<div class="list_cal_row_title relative">
			<div class="cal_header_div eng">
				<form method="get" action="/g2/bbs/board.php">
					<input type="hidden" name="bo_table" value="calendar">
					<a href="/g2/bbs/board.php?bo_table=calendar&amp;cal_year=2019&amp;cal_month=12&amp;cal_year=2019&amp;cal_month=11"><i class="fa fa-chevron-left goto" ></i></a>&nbsp;&nbsp;
					<input class="cal_header_year inputin" type="text" name="cal_year" value="2019" maxlength="4" required="required"  data-hasqtip="23" oldtitle="년도" title="">&nbsp;/&nbsp;
					<input class="cal_header_month inputin" type="text" name="cal_month" value="12" maxlength="2" required="required"  data-hasqtip="24" oldtitle="월" title="">&nbsp;
					<input class="btn inputbt" type="submit" value="이동" data-hasqtip="25" oldtitle="이동" title="">&nbsp;&nbsp;
					<a href="/g2/bbs/board.php?bo_table=calendar&amp;cal_year=2019&amp;cal_month=12&amp;cal_year=2020&amp;cal_month=1"><i class="fa fa-chevron-right goto" ></i></a>
				</form>
			</div>
		</div>
	</div>

	<c:forEach items="${list }" var="i">
	<div class = "list">
	
		<div class="perdate cal_col0 relative float_left center theme_key2" data-hasqtip="31" oldtitle="아직 출시 전인 제품입니다." title="" aria-describedby="qtip-31">
			<c:set var = "string1" value = "${i.performdate }"/>
	   	 	<c:set var = "length" value = "${fn:length(string1)}"/>
	    	<c:set var = "pdate" value = "${fn:substring(string1, length -2, length)}" />
			
			
			
			<div class="cal_date eng bold help" style="font-size: 25px">${pdate }</div>
			<div class="cal_yoil help han " style=" margin-top: 5px;"><span class="mobile_hide">요일</span></div>
		</div>
		
		
		
		<div class="media float_right">
			<div class="media-left media-middle">
				<a href="#">
				<img class="media-object" src="/resources/logo/mainlogo.png" alt="..." style="width: 80px; height: 80px;">
				</a>
			</div>
			<div class="media-body">
				<span class="media-heading"><a href="/artboard/view?boardno=${i.boardno}">${i.title }</a></span>
				<br><br>
				<span id = "category_name">${i.performname}</span>
			</div>
	  
		</div>
	</div>
	</c:forEach>


	<div id="list_table" class="width_660 box_shadow_3 text-center">
		<div class="list_cal_row_title relative">
			<div class="cal_header_div eng">
				<form method="get" action="/g2/bbs/board.php">
					<input type="hidden" name="bo_table" value="calendar">
					<a href="/g2/bbs/board.php?bo_table=calendar&amp;cal_year=2019&amp;cal_month=12&amp;cal_year=2019&amp;cal_month=11"><i class="fa fa-chevron-left goto" ></i></a>&nbsp;&nbsp;
					<input class="cal_header_year inputin" type="text" name="cal_year" value="2019" maxlength="4" required="required"  data-hasqtip="23" oldtitle="년도" title="">&nbsp;/&nbsp;
					<input class="cal_header_month inputin" type="text" name="cal_month" value="12" maxlength="2" required="required"  data-hasqtip="24" oldtitle="월" title="">&nbsp;
					<input class="btn inputbt" type="submit" value="이동" data-hasqtip="25" oldtitle="이동" title="">&nbsp;&nbsp;
					<a href="/g2/bbs/board.php?bo_table=calendar&amp;cal_year=2019&amp;cal_month=12&amp;cal_year=2020&amp;cal_month=1"><i class="fa fa-chevron-right goto" ></i></a>
				</form>
			</div>
		</div>
	</div>
	</div>
	
	<div class="col-3">
	<div id="side">
		<div class="list-group" id="pfIntroduceTitle">
  		<a class="list-group-item" id="pfIntroduceContent">
  		 CALENDAR 소개
  		</a>
  		<a href="#" class="list-group-item" style="font-size: 12px">
 		 버스킹, 연극, 공연, 전시 등의<br>
 		  일정을 포스팅하는 공간입니다.
 		  </a>
		</div>
	</div>	
	</div>
</div>
	
</div> <!-- container -->


<jsp:include page="/WEB-INF/views/layout/footer.jsp" />

