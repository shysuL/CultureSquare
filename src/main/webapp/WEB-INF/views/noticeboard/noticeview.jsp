<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
     
<jsp:include page="/WEB-INF/views/layout/header.jsp"/> 
<style type="text/css">
#content {
	width: 95%;
}

#h3title {
	text-align: center;
	padding: 20px;
}


#btnList{
	background-color:#343a40;
}

#fileTitle{
	padding-bottom: 20px;
}
#fileContent{
	background-color:#343a40; 
	color:white;
}
.commentBox {
	position: relative;
	padding: 5px;
}
.btnBox {
	position: absolute;
	right: 5px;
	bottom: 5px;
}


</style>


<div class="container list-container">
<div class="h2"><h2> 공지사항 </h2></div>
<hr>
<div class="container">
	<table class="table table-bordered">
		<tr>

			<td style="background-color: #343a40; color: #fff;" colspan="4">${ntboard.title }</td>
		</tr>
	
		<tr>
			
			<td colspan="1" style="width: 45%; padding-top: 16px;"><i class="far fa-user" style="padding-right: 10px"></i>${ntboard.usernick }</td>
			<td colspan="1" style="width: 25%; padding-top: 16px;"><i class="far fa-clock" style="padding-right: 10px"></i>${ntboard.writtendate }</td>

			<td colspan="1" style="width: 15%; padding-top: 16px;"><i class="fas fa-eye" style="padding-right: 5px; width: 3.125em;"></i>${ntboard.views }</td>
			<td colspan="1" style="width: 15%; padding-top: 14px; padding-left: 28px;" id="recommendtd"  ></td>
		</tr>

	
		<tr>
			<td colspan="4" style="height: 500px;">${ntboard.contents }</td>
		</tr>


	</table>

	<div  style="text-align: right;">
		<a href="/noticeboard/noticelist"><button id="btnList" class="btn btn-default" style="background-color: #343a40; color: white; ">목록</button></a>
	</div>	
</div>
</div>



<jsp:include page="/WEB-INF/views/layout/footer.jsp"/> 

