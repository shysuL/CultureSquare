<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<style type="text/css">
#follow{
	background-color:white;
	border: none;
}
</style>

${followCnt}
<c:choose>
<c:when test="${result eq 0 }">
<button id ="follow"><img src="/resources/img/nolike.png" /></button>
</c:when>
<c:when test="${result ne 0  }">
<button id ="follow"><img src="/resources/img/likeheart.png" /></button>
</c:when>
</c:choose>