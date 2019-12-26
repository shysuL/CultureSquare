<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
    <%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>
<jsp:include page="/WEB-INF/views/layout/header.jsp" />  

<style type="text/css">
#view_head{
	background-color: #343a40;
	border: 1px solid black;
	max-width: 95%;
	height: 45px;
	text-align: center;
	color: white;
	padding: 6px;
}
#writer_head{
	background-color: #343a40;
	border: 1px solid black;
	max-width: 95%;
	height: 45px;
	text-align: center;
	color: white;
	padding: 6px;
}
.con_left{
	width: 68%;
	border: 1px solid black;
	float: left;
}
.con_right{
	width: 32%;
	border: 1px solid black;
	float: right;
}
#view_writer{
	border: 1px solid black;
	max-width: 95%;
    height: 35px;
	padding: 6px;

}
#view_content{
	border: 1px solid black;
	max-width: 95%;
	height: auto;
}
#writer_nick{
	width:30%;
	float: left;
}

#viewcount{
	width: 20%;
	float:right;
}
#write_date{
	width: 30%;
	float:right;
}

#view_buttonarea{
	max-width: 95%;
	text-align: right;
}

#writer_photo{
	max-width: 35%;
    width: 60%;
    height: 100px;
	float:left;
	border: 1px solid black;
}

#writer_info{
	max-width: 65%;
	width: 40%;
	float:right;
	border: 1px solid black;
}
</style>

<h1> CALLENDAR </h1>
<hr>

<h2>VIEWVIEW</h2>

<div class="container container-fluid" style="margin-bottom: 600px">
<div class = "con_left">
<div id = "view_head" class="col-xs-12 col-sm-6 col-md-8">
<span style="">${view.title }</span>
</div>
<div id = "view_writer" class="col-xs-12 col-sm-6 col-md-8" >
	<div id = "writer_nick" class="col-md-4">
	${writer.usernick }
	</div>
	<div id = "write_date"  class="col-md-4">
	${view.writtendate }
		<div id = "viewcount">
		${view.views }
		</div>
	</div>


</div>


<div id = view_content class="col-xs-12 col-sm-6 col-md-8">
상세내용상세내용
${view.contents }<br>
<br><br><br><br><br><br><br><br><br><br><br><br><br>
</div>


<div id = "view_buttonarea" class="btn col-md-4" role="group">
	<button type = "button" class="btn btn-default" style="background-color: #343a40 !important; color: white !important;">후원하기</button>
	<button type = "button" class="btn btn-default" style="background-color: #343a40 !important; color: white !important;">추천</button>
</div>
<div>&nbsp;</div><br>








</div>
<div class = "con_right" style="height: auto;">

<div id = "writer_head" class="col-xs-12 col-sm-6 col-md-8">
<span>작성자프로필</span>
</div>
<div class="col-xs-12 col-sm-6 col-md-8" style="width:100%; ">
	<div id = "writer_photo">
	사진
	</div>
	<div id = "writer_info">
		<div> ${writer.usernick } </div>
		<br><br>
		<div><button type = "button" class="btn btn-default" style="background-color: #343a40 !important; color: white !important;">팔로우</button></div>
	</div>
</div>


<br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br>
</div>



<br><br>
</div> <!-- div_container -->

<jsp:include page="/WEB-INF/views/layout/footer.jsp" />