<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta name="viewport" content="user-scalable=yes, initial-scale=0.3, maximum-scale=1.0, minimum-scale=0.1, width=device-width" />
<meta name="title" content="서원힐스">
<meta name="author" content="서원힐스">
<meta name="Keywords" content="서원힐스, 대보, ">
<meta name="description" content="서원힐스, 대보, ">
<meta name="copyright" content="All Contents Copyright©seowonHills">
<meta name="format-detection" content="telephone=no, address=no, email=no"/>
<meta property="og:type" content="mobile">
<meta property="og:title" content="서원힐스, 대보">
<meta property="og:description" content="서원힐스, 대보">
<meta property="og:url" content="">
<title>서원힐스</title>
<link rel="icon" href="<c:url value='/images/hills/favicon.ico?v=2'/>">
<link rel="shortcut icon" href="<c:url value='/images/hills/favicon.ico'/>">
<link rel="stylesheet" type="text/css" href="<c:url value='/css/hills/import.css'/>">
<link rel="stylesheet" type="text/css" href="<c:url value='/css/hills/content.css?v=1'/>">
<script src="//ajax.googleapis.com/ajax/libs/jquery/1.8.3/jquery.min.js"></script>
<script type="text/javascript" src="<c:url value='/js/globals.js'/>"></script>  
<script type="text/javascript" src="<c:url value='/js/tools.js'/>"></script> 
<script type="text/javascript" src="<c:url value='/js/jquery.preloaders.js'/>"></script>  
<script type="text/javascript">
	function initHeaderTab(idx) {
		$("#headerTab" + idx).addClass("on");
	}
</script>
</head>
<body>
	<div id="championTop">
		<div class="chTopBox">
			<div class="chtopBox_top">
				<a href="<c:url value='/hills/member/join02.do'/>">회원가입</a>				
				<a href="<c:url value='/hills/index.do'/>">서원힐스</a>
				<a href="<c:url value='/hills/member/login.do'/>">회원로그인</a>
			</div>
			<div class="chtopBox_con">
				<div class="chtopBox_conBox">
				<h1><a href="<c:url value='/hills/index.do'/>"><img src="<c:url value='/images/hills/champion/logo.jpg'/>"></a></h1>
				<ul>
					<li id="headerTab1" onclick="location.href = '<c:url value='/hills/champion/champion4.do'/>'">프로모션</li>
					<li id="headerTab2" onclick="location.href = '<c:url value='/hills/champion/trumpy4.do'/>'">시상내역</li>
					<li id="headerTab3" onclick="location.href = '<c:url value='/hills/champion/ladyPassport.do'/>'">리더보드</li>		
					<li id="headerTab4" onclick="location.href = '<c:url value='/hills/board/list.do?bbsType=46'/>'">대회스케치</li>
					<li id="headerTab5" onclick="location.href = '<c:url value='/hills/board/list.do?bbsType=45'/>'">공지사항</li>		
					<c:choose>
					    <c:when test="${sessionScope.msMember.msId eq '' || sessionScope.msMember.msId eq null}">
							<li id="headerTab6" onclick="initPopup(1)">참가신청</li>
					    </c:when>
					    <c:otherwise>
							<li id="headerTab6" onclick="initPopup(2)">참가신청</li>
					    </c:otherwise>
					</c:choose>	
				</ul>
				</div>
			</div>
		</div>
	</div>
<jsp:include page="../include/popup/champion_pop4.jsp" />