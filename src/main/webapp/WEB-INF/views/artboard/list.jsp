<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
    <%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>
    
<%@ page import="java.util.*"%>
<%@ page import="java.text.*"%>

<jsp:include page="/WEB-INF/views/layout/header.jsp" />  

<script type="text/javascript">
$(document).ready(function(){
	
// 	$("#leftgo").click(function(){
// 		var cal_year = $('#cal_year').val();
// 		var cal_month = $('#cal_month').val();
		
// 		$.ajax({
// 			type:"get",
// 			url:"/artboard/list",
// 			data:{"cal_year" : cal_year, "cal_month" : cal_month},
// 			datatype : "json",
// 			success: function(res){
// 				console.log(cal_year)
// 				console.log(cal_month)
// // 				location.href="/artboard/list?bo_table=calendar&cal_year=&cal_month="
// 			}
// 		})
		
// 	})
	
})
</script>



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
	
});
</script>

<script type="text/javascript">
$(document).ready(function() {
   $(".fa-chevron-left").click(function() {
      $.ajax({
         type: "get"
         , url: "/artboard/list"
         , data: {yyyy : 2019, MM : 11 }
         , dataType: "html"
         , success: function(  ) {
        	 location.href="/artboard/list?bo_table=calendar&cal_year=${yyyy}&cal_month=${MM}";
            console.log("성공")
            console.log( res )
         }
         , error: function() {
            console.log("실패")
         }
      });
   })
});

</script>


<script type="text/javascript">
	var today = null;
	var year = null;
	var month = null;
	var firstDay = null;
	var lastDay = null;
	var $tdDay = null;
	var $tdSche = null;
	var jsonData = null;
	
	var clickDate = null;
	var clickScheduleno = null;
	
		
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
		getNewInfo();
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
		getNewInfo();
	}
	//정보갱신
	function getNewInfo() {
		for (var i = 0; i < 42; i++) {
			$tdDay.eq(i).text("");
			$tdSche.eq(i).text("");
		}
		dayCount = 0;
		firstDay = new Date(year, month - 1, 1);
		lastDay = new Date(year, month, 0);
		drawDays();
	}
	
	
	
	
	
</script>

<div class="container list-container">
<div class="h2"><h2> CALLENDAR </h2></div>
<hr>
<div class="row">
	
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
	
	<div class="b">
	<c:choose>
		<c:when test="${not login}">
		<div>
			<button id="notLoginWrite" class="btn btn-sm b-btn"
				style="background-color: #343a40; color: white;">글작성</button>
		</div>
		</c:when>
		<%--  예술인일 때 작성 가능한 조건 추가 필요 --%>
		<c:when test="${login}">
			<div>
			<a href="/artboard/write"><button id="LoginWrite"
					class="btn btn-sm b-btn"
					style="background-color: #343a40; color: white;">글작성</button></a>
			</div>
		</c:when>
	</c:choose>
	</div> 


<%
	Date date = new Date();
	SimpleDateFormat simpleDate = new SimpleDateFormat("yyyy-MM-dd");
	String strdate = simpleDate.format(date);
%>
<%
	Calendar cal = Calendar.getInstance();
%>


	
	<div id="list_table" class="width_660 box_shadow_3 text-center">
		<div class="list_cal_row_title relative">
			<div class="cal_header_div eng">
				<form method="get" action="/artboard/list">
					<input type="hidden" name="bo_table" value="calendar">
					<a href="/artboard/list?bo_table=calendar&cal_year=2019&cal_month=11">
<!-- 					<button id = "leftgo"> -->
					<i class="fa fa-chevron-left goto" ></i>
<!-- 					</button> -->
					</a>
					&nbsp;&nbsp;
					<input class="cal_header_year inputin" type="text" name="cal_year" id="cal_year" value="<%= cal.get(Calendar.YEAR)%>" maxlength="4" required="required"  data-hasqtip="23" oldtitle="년도" title="">&nbsp;/&nbsp;
					<input class="cal_header_month inputin" type="text" name="cal_month" id="cal_month" value="<%= cal.get(Calendar.MONTH) + 1%>" maxlength="2" required="required"  data-hasqtip="24" oldtitle="월" title="">&nbsp;
					<input class="btn inputbt" type="submit" value="이동" data-hasqtip="25" oldtitle="이동" title="">&nbsp;&nbsp;
					<a href="/artboard/list?bo_table=calendar&cal_year=2020&cal_month=01"><i class="fa fa-chevron-right goto" ></i></a>
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
			<div class="cal_yoil help han " style=" margin-top: 5px;">${i.performday }<span class="mobile_hide">요일</span></div>
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
				<form method="get" action="/artboard/list">
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
	  		<td><a href="#" ><input class="list-group-item active cate" type="submit" value="전체" /></a></td>
	  		<td><a href="#" ><input class="list-group-item cate" type="submit" value="공연" /></a></td>
	  		<td><a href="#" ><input class="list-group-item cate" type="submit" value="버스킹" /></a></td>
	  		<td><a href="#" ><input class="list-group-item cate" type="submit" value="연극" /></a></td>
	  		</tr>
	  		
	  		<tr>
	  		<td><a href="#" ><input class="list-group-item cate" type="submit" value="콘서트" /></a></td>
	  		<td><a href="#" ><input class="list-group-item cate" type="submit" value="축제" /></a></td>
	  		<td><a href="#" ><input class="list-group-item cate" type="submit" value="행사" /></a></td>
	  		<td><a href="#" ><input class="list-group-item cate" type="submit" value="기타" /></a></td>
	  		</tr>
	  		</table>


			</div>
		</div>
	</div>
</div>

<!-- 로그인 실패시 모달창 -->
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


	
</div> <!-- container -->


<jsp:include page="/WEB-INF/views/layout/footer.jsp" />






