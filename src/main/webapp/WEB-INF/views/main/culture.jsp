<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>



<style type="text/css">
.float-container {
	width: 270px;
	height: 480px;
	border: 1px solid #ccc;
	float: left;
	text-aligin: center;
}
.float-container img{
	
	margin: 5px;
	padding: 5px;
	width: 250px;
	height: 350px;
}

</style>

<c:forEach items="${list }" var="list">
<div class="float-container">

${list.cul }
</div>
</c:forEach>
