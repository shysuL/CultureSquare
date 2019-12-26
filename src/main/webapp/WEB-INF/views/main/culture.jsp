<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>



<c:forEach items="${list }" var="list">

<div>

${list.cul }

</div>



</c:forEach>
