<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
<jsp:include page="/WEB-INF/views/admin/layout/header.jsp" />

<script type="text/javascript">
$(document).ready(function() {
	//자유게시판
	$("#freeboard-tab").on("click", function() {
		$.ajax({
			type:"post",
			url:"/admin/main",
			data: {
				"category" : 1,
			},
			datatype: "html",
			success : function(res){
				console.log(res);
				$("#freeboard").html(res);
			},
			error: function(e){
			console.log(e);
			}
		});
	});
	
	//pr게시판
	$("#prboard-tab").on("click", function() {
		$.ajax({
			type:"post",
			url:"/admin/main",
			data: {
				"category" : 2,
			},
			datatype: "html",
			success : function(res){
				console.log(res);
				$("#prboard").html(res);
			},
			error: function(e){
			console.log(e);
			}
		});
	});
	
	//pf게시판
	$("#artboard-tab").on("click", function() {
		$.ajax({
			type:"post",
			url:"/admin/main",
			data: {
				"category" : 3,
			},
			datatype: "html",
			success : function(res){
				console.log(res);
				$("#artboard").html(res);
			},
			error: function(e){
			console.log(e);
			}
		});
	});

	//공지사항
	$("#noticeboard-tab").on("click", function() {
		$.ajax({
			type:"post",
			url:"/admin/main",
			data: {
				"category" : 5,
			},
			datatype: "html",
			success : function(res){
				console.log(res);
				$("#noticeboard").html(res);
			},
			error: function(e){
			console.log(e);
			}
		});
	});
	
	//사용자목록
	$("#user-tab").on("click", function() {
		$.ajax({
			type:"post",
			url:"/admin/main",
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
	});
});

</script>

<div class="tab-content" id="myTabContent">
	<!-- 메인 -->
	<div class="tab-pane fade show active" id="home" role="tabpanel" aria-labelledby="home-tab">
		<div class="container container-center" style="text-align: center; width:500px; height: 200px; 
				border: 1px solid #ccc; margin-top: 100px;">
			<c:if test="${adminLogin }"> 
				<br><br><h5>관리자 ${adminid }님, 반갑습니다 :-)</h5><br>
				<button onclick="location.href='/admin/logout';" class="btn btn-secondary">Logout</button>
				<br>
			</c:if>
		</div>
	</div>
	
	<!-- 예술정보게시판 -->
	<div class="tab-pane fade" id="artboard" role="tabpanel" aria-labelledby="artboard-tab" style="margin-bottom: 100px;">

	</div>
	
	<!-- pr게시판 -->
	<div class="tab-pane fade" id="prboard" role="tabpanel" aria-labelledby="prboard-tab" style="margin-bottom: 100px;">
	
	</div>
	
	<!-- 자유게시판 -->
	<div class="tab-pane fade" id="freeboard" role="tabpanel" aria-labelledby="freeboard-tab" style="margin-bottom: 100px;">
	
	</div>
	
	<!-- 공지사항 -->
	<div class="tab-pane fade" id="noticeboard" role="tabpanel" aria-labelledby="noticeboard-tab" style="margin-bottom: 100px;">
		
	</div>
	
	<!-- user리스트 -->
	<div class="tab-pane fade" id="user" role="tabpanel" aria-labelledby="user-tab" style="margin-bottom: 100px;">
	
	</div>
	
</div>



