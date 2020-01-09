<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<c:forEach var="i" items="${paging.search2 }">
<c:if test="${i.key=='searchType' }">
   <c:set var="searchType" value="${i.value }"/>
</c:if>
<c:if test="${i.key=='search' }">
   <c:set var="search" value="${i.value }"/>
</c:if>
</c:forEach>
<c:set var="query" value="&searchType=${searchType}&search=${search }"/>


<div class="paging">
   <ul class="pagination justify-content-center" >
   <!-- 처음으로 가기 -->
   <c:if test="${paging.curPage ne 1 }">
   <li class="page-item"><a class="page-link" href="/prboard/prmorelist?curPage=1${query }">처음</a></li>
   </c:if>
   
   <!-- 이전 페이징리스트로 가기 -->
   <c:if test="${paging.endPage > paging.pageCount }">
<%--    <c:if test="${paging.startPage ne paging.pageCount}"> --%>
   <li class="page-item"><a class="page-link" href="/prboard/prmorelist?curPage=${paging.startPage-paging.pageCount }${query }">&laquo;</a></li>
   </c:if>
   
   <!-- 이전 페이지로 가기 -->
   <c:if test="${paging.curPage ne 1 }">
   <li class="page-item"><a class="page-link" href="/prboard/prmorelist?curPage=${paging.curPage-1 }${query }">&lt;</a></li>
   </c:if>
   
   <!-- 페이징 리스트 -->
      <c:forEach begin="${paging.startPage }" end="${paging.endPage }"
         var="i"> 
         <c:choose>
             <c:when test="${paging.curPage eq i }">      
               <li class="page-item active"><a class="page-link " href="/prboard/prmorelist?curPage=${i }${query }">${i }</a></li>
            </c:when>
            <c:otherwise>
               <li class="page-item"><a class="page-link" href="/prboard/prmorelist?curPage=${i }${query }">${i }</a></li>
            </c:otherwise>
         </c:choose>
      </c:forEach>
   <!-- 다음 페이지로 가기 -->
   <c:if test="${paging.curPage ne paging.totalPage }">
   <li class="page-item"><a class="page-link" href="/prboard/prmorelist?curPage=${paging.curPage+1 }${query }">&gt;</a></li>
   </c:if>
      <!-- 다음 페이징리스트로 가기 -->
<%--    <c:if test="${paging.endPage > 10 }"> --%>
   <c:if test="${paging.endPage ne paging.totalPage}">
   <li class="page-item"><a class="page-link" href="/prboard/prmorelist?curPage=${paging.startPage + paging.pageCount }${query }">&raquo;</a></li>
   </c:if>
<%--    <c:if test="${paging.endPage eq paging.totalPage}"> --%>
<!--    <li class="disabled"><a>&raquo;</a></li> -->
<%--    </c:if> --%>

   <!-- 끝 페이지로 가기 -->
      <c:if test="${paging.curPage ne paging.totalPage}">
   <li class="page-item"><a class="page-link" href="/prboard/prmorelist?curPage=${paging.totalPage }${query }">끝</a></li>
   </c:if>
   </ul>
</div>