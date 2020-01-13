<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<script type="text/javascript">
	$(document).ready(function() {
		$("a[class='page-link']").on("click", function() {
			$.ajax({
				type:"post",
				url: $(this).attr("href"),
				data: {
					"category" : 4,
				},
				datatype: "html",
				success : function(res){
					console.log(res);
					$("#faqboard").html(res);
				},
				error: function(e){
				console.log(e);
				}
			});
			
			return false;
		});
	});
</script>

<div class="container" style="margin-top: 50px;">
	<div class="innercon2">
	<h3 style="text-align: center;">FAQ</h3>
		<div class="src" style="text-align: right;">
		<form action="" method="get">
			<input type="text" name="search" id="search"/>
			<button id="btnSearch" class="btn btn-secondary" style="text-align: right;">검색</button>
		</form>
	</div>
	<br>
	<form action="" method="get">
		<table class="table table-hover">
			<thead>
				<tr class="info"  style="text-align: center; background-color: #4b5055;color: #fff;">
<!-- 					<th style="width: 5%"><input type="checkbox" id="checkAll"/></th> -->
					<th style="width: 10%">글번호</th>
					<th style="width: 50%">제목</th>					
					<th style="width: 15%">작성자</th>
					<th style="width: 20%">작성일</th>
				</tr>
			</thead>
			
			<tbody>
<%-- 					<c:forEach items="${list }" var="comp"> --%>
<!-- 					<tr> -->
<%-- 						<td><input type="checkbox" name="checkRow" value="${comp.comp_no  }"/></td> --%>
<%-- 						<td>${comp.comp_no }</td> --%>
<%-- 						<td><a href="/mgr/compview?comp_no=${comp.comp_no}">${comp.comp_title }</a></td> --%>
<%-- 						<td>${comp.userno }</td> --%>
<%-- 						<td>${comp.comp_date }</td> --%>
<!-- 					</tr> -->
<%-- 					</c:forEach> --%>
			</tbody>
				
			</table>
		</form>
	</div>
</div> <!-- container -->