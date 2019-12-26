<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
    <%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>
<jsp:include page="/WEB-INF/views/layout/header.jsp" />  

<script type="text/javascript">
$(document).ready(function() {
	
	//작성버튼 동작
	$("#btnWrite").click(function() {
		$("form").submit();
	});
	
	//취소버튼 동작
	$("#btnCancel").click(function() {
		history.go(-1);
	});
});


</script>


<div class="container container-fluid" style="margin-bottom: 600px">

<h1>WRITE</h1>
<hr>




<div class="text-center">	
	<button type="button" id="btnWrite" class="btn btn-info">작성</button>
	<button type="button" id="btnCancel" class="btn btn-danger">취소</button>
</div>



</div> <!-- div_container -->

<jsp:include page="/WEB-INF/views/layout/footer.jsp" />

