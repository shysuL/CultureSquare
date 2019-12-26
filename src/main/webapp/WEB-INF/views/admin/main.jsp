<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
<jsp:include page="/WEB-INF/views/admin/layout/header.jsp" />

<!-- 관리자페이지 네비게이션 바 -->
<ul class="nav nav-tabs justify-content-center" id="myTab" role="tablist">
	<li class="nav-item">
		<a class="nav-link active" id="home-tab" data-toggle="tab" href="#home" role="tab" aria-controls="home"
			aria-selected="true">&emsp;&emsp;Home&emsp;&emsp;</a>
	</li>
	<li class="nav-item">
		<a class="nav-link" id="artboard-tab" data-toggle="tab" href="#artboard" role="tab" aria-controls="artboard"
			aria-selected="false">&emsp;&emsp;ArtInformation Board&emsp;&emsp;</a>
	</li>
	<li class="nav-item">
		<a class="nav-link" id="prboard-tab" data-toggle="tab" href="#prboard" role="tab" aria-controls="prboard"
			aria-selected="false">&emsp;&emsp;PR Board&emsp;&emsp;</a>
	</li>
	<li class="nav-item">
		<a class="nav-link" id="freeboard-tab" data-toggle="tab" href="#freeboard" role="tab" aria-controls="freeboard"
			aria-selected="false">&emsp;&emsp;Free Board&emsp;&emsp;</a>
	</li>
	<li class="nav-item">
		<a class="nav-link" id="faqboard-tab" data-toggle="tab" href="#faqboard" role="tab" aria-controls="faqboard"
			aria-selected="false">&emsp;&emsp;FAQ Board&emsp;&emsp;</a>
	</li>
	<li class="nav-item">
		<a class="nav-link" id="noticeboard-tab" data-toggle="tab" href="#noticeboard" role="tab" aria-controls="noticeboard"
			aria-selected="false">&emsp;&emsp;Notice Board&emsp;&emsp;</a>
	</li>
	<li class="nav-item">
		<a class="nav-link" id="user-tab" data-toggle="tab" href="#user" role="tab" aria-controls="user"
			aria-selected="false">&emsp;&emsp;User&emsp;&emsp;</a>
	</li>
</ul>

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
	<div class="tab-pane fade" id="artboard" role="tabpanel" aria-labelledby="artboard-tab">
		<div class="container" style="margin-top: 50px;">
			<div class="innercon2">
				<div class="src" style="text-align: right;">
					<form action="/mgr/complist" method="get">
					<input type="text" name="search" id="search"/>
					<button id="btnSearch" class="btn btn-secondary" style="text-align: right;">검색</button>
					</form>
				</div>
				<br>
				<form action="" method="get">
					<table class="table table-hover">
						<thead>
						<tr class = "info"  >
							<th style="width: 5%"><input type="checkbox" id="checkAll"/></th>
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
					<button class="btn btn-secondary">삭제</button>
				</form>
			</div>
		</div> <!-- container -->
	</div>
	
	<!-- pr게시판 -->
	<div class="tab-pane fade" id="prboard" role="tabpanel" aria-labelledby="prboard-tab">
		<div class="container" style="margin-top: 50px;">
			<div class="innercon2">
				<div class="src" style="text-align: right;">
					<form action="/mgr/complist" method="get">
					<input type="text" name="search" id="search"/>
					<button id="btnSearch" class="btn btn-secondary" style="text-align: right;">검색</button>
					</form>
				</div>
				<br>
				<form action="" method="get">
					<table class="table table-hover">
						<thead>
						<tr class = "info"  >
							<th style="width: 5%"><input type="checkbox" id="checkAll"/></th>
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
					<button class="btn btn-secondary">삭제</button>
				</form>
			</div>
		</div> <!-- container -->
	</div>
	
	<!-- 자유게시판 -->
	<div class="tab-pane fade" id="freeboard" role="tabpanel" aria-labelledby="freeboard-tab">
		<div class="container" style="margin-top: 50px;">
			<div class="innercon2">
				<div class="src" style="text-align: right;">
					<form action="/mgr/complist" method="get">
					<input type="text" name="search" id="search"/>
					<button id="btnSearch" class="btn btn-secondary" style="text-align: right;">검색</button>
					</form>
				</div>
				<br>
				<form action="" method="get">
					<table class="table table-hover">
						<thead>
						<tr class = "info"  >
							<th style="width: 5%"><input type="checkbox" id="checkAll"/></th>
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
					<button class="btn btn-secondary">삭제</button>
				</form>
			</div>
		</div> <!-- container -->
	</div>
	
	<!-- FAQ 게시판 -->
	<div class="tab-pane fade" id="faqboard" role="tabpanel" aria-labelledby="faqboard-tab">
		<div class="container" style="margin-top: 50px;">
			<div class="innercon2">
				<div class="src" style="text-align: right;">
					<form action="/mgr/complist" method="get">
					<input type="text" name="search" id="search"/>
					<button id="btnSearch" class="btn btn-secondary" style="text-align: right;">검색</button>
					</form>
				</div>
				<br>
				<form action="" method="get">
					<table class="table table-hover">
						<thead>
						<tr class = "info"  >
							<th style="width: 5%"><input type="checkbox" id="checkAll"/></th>
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
					<button class="btn btn-secondary">삭제</button>
				</form>
			</div>
		</div> <!-- container -->
	</div>
	
	<!-- 공지사항 -->
	<div class="tab-pane fade" id="noticeboard" role="tabpanel" aria-labelledby="noticeboard-tab">
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
						<tr class = "info"  >
							<th style="width: 5%"><input type="checkbox" id="checkAll"/></th>
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
					<button class="btn btn-secondary">삭제</button>
				</form>
			</div>
		</div> <!-- container -->
	</div>
	
	<!-- user리스트 -->
	<div class="tab-pane fade" id="user" role="tabpanel" aria-labelledby="user-tab">
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
						<tr class = "info">
							<th style="width: 5%"><input type="checkbox" id="checkAll"/></th>
							<th style="width: 10%">사용자 번호</th>
							<th style="width: 50%">사용자 이름</th>					
							<th style="width: 15%">닉네임</th>
							<th style="width: 20%">회원구분</th>
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
					<button class="btn btn-secondary">삭제</button>
				</form>
			</div>
		</div> <!-- container -->	
	</div>
	
</div>



