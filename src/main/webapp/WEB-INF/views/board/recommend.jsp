<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<style type="text/css">
#recommend{
	background-color:white;
	border: none;
}
</style>
${recommendCnt}
<c:choose>
<c:when test="${result eq 1 }">
<button id ="recommend"><img src="/resources/img/nolike.png" style="width: 20px;" /></button>
</c:when>
<c:when test="${result ne 1  }">
<button id ="recommend"><img src="/resources/img/likeheart.png" style="width: 20px;" /></button>
</c:when>
</c:choose>