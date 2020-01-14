<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<title>Culture Square Admin</title>

<script type="text/javascript" src="https://code.jquery.com/jquery-2.2.4.min.js"></script>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>

<style type="text/css">

#adminlogindiv {
	width: 350px;
	margin-top: 40px;
}

#adminloginbtn {
	padding-left: 135px;
	padding-right: 138px;
}

.cropping {
    max-height: 180px;
    overflow: hidden;
    display: block;
    margin: 0 auto;
}

a {
	font: menu;
    color: #000000;;
    text-decoration: none;
    background-color: transparent;
}

.nav-tabs .nav-link.active {
    color: #949faa;
    background-color: #fff;
    border-color: #dee2e6 #dee2e6 #fff;
}

/* 웹폰트 적용 */
@font-face { 
	font-family: 'KHNPHU'; 
	src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_one@1.0/KHNPHU.woff') format('woff'); 
	font-weight: normal; 
	font-style: normal; 
}

.adminbody {
	font-family:'KHNPHU';
}

#top {
    position: fixed;
    right: 5%;
    bottom: 50px;
    z-index: 999;
    font-size: 20px;
    text-decoration: none;
    width: 100px;
    text-align: center;
    padding-top: 10px;
    padding-bottom: 10px;
    border: 1px solid #ccc;
}

</style>

</head>
<body class="adminbody">
	
	<a id="top" href="https://desk.channel.io/#/channels/18967/user_chats" target="_blank">고객상담</a>
<!-- 메인이미지 -->
<nav class="navbar navbar-dark bg-dark center">
	<div class="cropping">
		<img class="culture" src="/resources/logo/culturesquareLogo.png" style="height:200px;">
	</div>
</nav>

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
		<a class="nav-link" id="noticeboard-tab" data-toggle="tab" href="#noticeboard" role="tab" aria-controls="noticeboard"
			aria-selected="false">&emsp;&emsp;Notice Board&emsp;&emsp;</a>
	</li>
	<li class="nav-item">
		<a class="nav-link" id="user-tab" data-toggle="tab" href="#user" role="tab" aria-controls="user"
			aria-selected="false">&emsp;&emsp;User&emsp;&emsp;</a>
	</li>
</ul>

<div class="wrap">