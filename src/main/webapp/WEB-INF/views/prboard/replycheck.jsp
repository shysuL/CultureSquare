<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<style type="text/css">
#replyLike{
	background-color:white;
	border: none;
}
</style>

<c:choose>
<c:when test="${result eq 0 }">
<button id ="replyLike" class ="replyLike" name = "${replyno }"><img src="/resources/img/replyNo.png" /></button>
</c:when>
<c:when test="${result ne 0  }">
<button id ="replyLike" class = "replyLike" name = "${replyno }"><img src="/resources/img/replyYes.png" /></button>
</c:when>
</c:choose>

${replyRecommendCnt}