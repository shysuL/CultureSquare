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
					"category" : 6,
				},
				datatype: "html",
				success : function(res){
					console.log(res);
					$("#user").html(res);
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
					<tr class = "info" style="text-align: center;">
						<th style="width: 5%"><input type="checkbox" id="checkAll"/></th>
						<th style="width: 10%">사용자 번호</th>
						<th style="width: 10%">타입</th>
						<th style="width: 15%">이름</th>
						<th style="width: 15%">아이디</th>
						<th style="width: 15%">전화번호</th>					
						<th style="width: 10%">승인여부</th>
						<th style="width: 10%">구독자수</th>
						<th style="width: 10%">소셜로그인</th>
					</tr>
				</thead>
				
				<tbody>
					<c:forEach items="${userlist }" var="userlist">
						<tr onclick="location.href='/admin/user?userno=${userlist.userno }';" style="text-align: center;">
							<td><input type="checkbox" name="checkRow" value="${userlist.userno  }"/></td>
							<td>${userlist.userno }</td>
							<td>${userlist.usertype }</td>
							<td>${userlist.username }</td>
							<td>${userlist.userid }</td>
							<td>${userlist.userphone }</td>
							<td>${userlist.permit }</td>
							<td>${userlist.follow }</td>
							<td>${userlist.sociallogin }</td>
						</tr>
					</c:forEach>
				</tbody>
				
			</table>
			<button class="btn btn-secondary">삭제</button>
		</form>
	</div>
	
	<jsp:include page = "/WEB-INF/views/admin/layout/userpaging.jsp" />
	
</div> <!-- container -->	