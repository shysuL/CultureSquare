<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
    <%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>
<jsp:include page="/WEB-INF/views/layout/header.jsp" />  

<script type="text/javascript">
$(document).ready(function() {
	
	//글쓰기 버튼 누르면 이동
	$("#btnWrite").click(function() {
		location.href= "/artboard/write";
	});
	
});
</script>


<style type="text/css">
.cal_header_div{
	background-color: #343a40;
    height: 50px;
}

.list{
	width: 800px;
	height: 100px;
	margin: 5px auto;

	padding: 8px;
	border: 1px solid #bcbcbc;
}

.perdate{
	width: 90px;
    height: 85px;
	float: left;
	text-align: center;
	border: 1px solid #bcbcbc;
	padding: unset;
}
.media{
	width : 70%;
	height : auto;
	float: right;
	border: 0px solid #bcbcbc;
}

#side{
	position:absolute;
    right: 30px;
    top: 384px;
}
#pfIntroduceTitle{
    background-color: #343a40;
    color: white;

}
#pfIntroduceContent{
    background-color: #343a40;
    color: white;

}

#category_name{
    border: 1px solid #e5e5e5;
    background: #f8f8f8;
    padding: 4px 7px;
    border-radius: 15px;
    font-size: 12px;
    letter-spacing: -1px;
}


</style>



<h1> CALLENDAR </h1>
<hr>

<div class="container list-container">

<div id = top_banner style="width: 800px;">
	<div id = "banner" style="border : 1px solid #bcbcbc; width: 70%; height: 60px;  margin-bottom: 15px;" >배너</div>
	
	<button id="btnWrite" class="btn btn-primary" >글작성</button>
</div>
<div id="list_table" class="width_660 box_shadow_3 text-center">

		<div class="list_cal_row_title theme_box2 relative">
		<div class="cal_header_div eng">
				<input type="hidden" name="bo_table" value="calendar">
				<a href="/g2/bbs/board.php?bo_table=calendar&amp;cal_year=2019&amp;cal_month=12&amp;cal_year=2019&amp;cal_month=11"><i class="fa fa-chevron-left" style="font-size: 18px; margin-bottom: 1px;"></i></a>&nbsp;&nbsp;
				<input class="cal_header_year theme_box2" type="text" name="cal_year" value="2019" maxlength="4" required="required" style="border: 1px solid rgba(255, 255, 255, 0.2);" data-hasqtip="23" oldtitle="년도" title="">&nbsp;/&nbsp;
				<input class="cal_header_month theme_box2" type="text" name="cal_month" value="12" maxlength="2" required="required" style="border: 1px solid rgba(255, 255, 255, 0.2);" data-hasqtip="24" oldtitle="월" title="">&nbsp;
				<input class="btn_input2" type="submit" value="이동" data-hasqtip="25" oldtitle="이동" title="">&nbsp;&nbsp;
				<a href="/g2/bbs/board.php?bo_table=calendar&amp;cal_year=2019&amp;cal_month=12&amp;cal_year=2020&amp;cal_month=1"><i class="fa fa-chevron-right" style="font-size: 18px; margin-bottom: 1px;"></i></a>
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
		<div class="cal_yoil help han " style=" margin-top: 5px;">O<span class="mobile_hide">요일</span></div>
</div>
		
		
		
<div class="media float_right">
  <div class="media-left media-middle">
    <a href="#">
      <img class="media-object" src="..." alt="...">
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



<div class="list_cal_row_title theme_box2 relative text-center">
		<div class="cal_header_div eng">
			<form method="get" action="/g2/bbs/board.php">
				<input type="hidden" name="bo_table" value="calendar">
				<a href="/g2/bbs/board.php?bo_table=calendar&amp;cal_year=2019&amp;cal_month=12&amp;cal_year=2019&amp;cal_month=11"><i class="fa fa-chevron-left" style="font-size: 18px; margin-bottom: 1px;"></i></a>&nbsp;&nbsp;
				<input class="cal_header_year theme_box2" type="text" name="cal_year" value="2019" maxlength="4" required="required" style="border: 1px solid rgba(255, 255, 255, 0.2);" data-hasqtip="127" oldtitle="년도" title="">&nbsp;/&nbsp;
				<input class="cal_header_month theme_box2" type="text" name="cal_month" value="12" maxlength="2" required="required" style="border: 1px solid rgba(255, 255, 255, 0.2);" data-hasqtip="128" oldtitle="월" title="">&nbsp;
				<input class="btn_input2" type="submit" value="이동" data-hasqtip="129" oldtitle="이동" title="">&nbsp;&nbsp;
				<a href="/g2/bbs/board.php?bo_table=calendar&amp;cal_year=2019&amp;cal_month=12&amp;cal_year=2020&amp;cal_month=1"><i class="fa fa-chevron-right" style="font-size: 18px; margin-bottom: 1px;"></i></a>
			</form>
		</div>
	</div>

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
</div> <!-- container -->


<jsp:include page="/WEB-INF/views/layout/footer.jsp" />

