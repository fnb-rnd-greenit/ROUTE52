<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta name="viewport" content="user-scalable=yes, initial-scale=0.3, maximum-scale=1.0, minimum-scale=0.1, width=device-width" />
<meta name="format-detection" content="telephone=no, address=no, email=no"/>
<meta name="title" content="서원밸리">
<meta name="author" content="서원밸리">
<meta name="Keywords" content="서원밸리, 대보, ">
<meta name="description" content="서원밸리, 대보, ">
<meta name="copyright" content="All Contents Copyright©seowonHills">
<meta property="og:type" content="mobile">
<meta property="og:title" content="서원밸리, 대보">
<meta property="og:description" content="서원밸리, 대보">
<meta property="og:url" content="">
<title>서원밸리</title>
<link rel="icon" href="<c:url value='/images/valley/favicon.ico?v=2'/>">
<link rel="shortcut icon" href="<c:url value='/images/valley/favicon.ico'/>">
<link rel="stylesheet" type="text/css" href="<c:url value='/css/valley/import.css'/>">
<script type="text/javascript" src="<c:url value='/js/globals.js'/>"></script>
<script type='text/javascript' src="<c:url value='/js/valley/jquery.js'/>"></script>
<script type="text/javascript" src="<c:url value='/js/valley/common.js'/>"></script> 
<script type="text/javascript" src="<c:url value='/js/jquery.preloaders.js'/>"></script>  
<script type="text/javascript" src="<c:url value='/js/tools.js'/>"></script>  
<script type="text/javascript">
	function actionLogout() {
		var sUrl = "<c:url value='/valley/member/actionLogout.do'/>";
		
		mAjax(sUrl, null, function(data){
			if(data.resultCode == "0000") {
				alert("로그아웃 되었습니다.");
				location.reload();				
			} else {
				alert(data.resultMessage);
			}
		})
	}
	
	function locationMyZone() {
		var sUrl = "<c:url value='/valley/reservation/reservationCheck.do'/>";
		
		location.href = sUrl;
	}
	
	$(document).ready(function() { 
		initWeather();
		
		var bUri = window.location.pathname.split("/");
		var exception = bUri[bUri.length - 1];
		
		for(i=0; i<exceptionViewList.length; i++) {
			if(exception == exceptionViewList[i]){
				return;
			}
		}
		
		var imsiYn = "${sessionScope.msMember.imsiYn}";
		var agreeYn = "${sessionScope.msMember.agreeYn}";
		
		if(agreeYn != "" && agreeYn == "N") {
        	alert("이용약관 동의 후 이용 부탁드립니다.");
    		location.href = "<c:url value='/valley/member/agree.do'/>";		
    		return;
		}
		
		if(imsiYn != "" && imsiYn == "Y") {
        	alert("아이디 변경 후 이용 부탁드립니다.");
    		location.href = "<c:url value='/valley/member/memModify.do'/>";		
    		return;			
		}
		
		var mainCodiv = "${sessionScope.msMember.msMainCoDiv}";
		
		if(mainCodiv != "" && mainCodiv == "65") {
			var logoutUrl = "<c:url value='/common/changeAccout.do'/>";
			var logoutParams = String.format("coDiv={0}", "61");
			
			mAjax(logoutUrl, logoutParams, function(data){
				if(data.resultCode == "0000") {
					alert("밸리계정으로 변경되었습니다.");
				} else {
					alert("밸리에서 사용할 수 없는 계정입니다.");
				}
				location.reload();
			});	
			
			return;
		}
	});
	
	function initWeather() {
		var sUrl = "<c:url value='/common/getWeather.do'/>";
		
		mAjax2(sUrl, null, function(data) {
			if(data.resultCode == "0000") {
				var temp = data.rows.temp;
				var wfKor = data.rows.wfKor;
				var wfEn = data.rows.wfEn;
				 
				var img = "<c:url value='/images/valley/wt_b.png'/>";
				
				$("#txtWeather").html(String.format("{0}˚ {1}", temp, wfKor)); 
				
				if(wfEn == "Clear") {
					img = "<c:url value='/images/valley/wt_s.png'/>";
				} else if(wfEn == "Partly Cloudy") {
					img = "<c:url value='/images/valley/wt_pc.png'/>";
				} else if(wfEn == "Mostly Cloudy") {
					img = "<c:url value='/images/valley/wt_mc.png'/>";
				} else if(wfEn == "Cloudy") {
					img = "<c:url value='/images/valley/wt_c.png'/>";
				} else if(wfEn == "Rain") {
					img = "<c:url value='/images/valley/wt_r.png'/>";
				} else if(wfEn == "Snow/Rain") {
					img = "<c:url value='/images/valley/wt_ras.png'/>";
				} else if(wfEn == "Snow") {
					img = "<c:url value='/images/valley/wt_sn.png'/>";
				}
				
				$("#imgWeather").attr("src", img);
			}
		});
	}
</script>
</head>
<body>
<div id="header">
	<div class="tobBox">
		<div class="top">
			<a href="<c:url value='/valley/board/list.do?bbsType=1'/>">공지사항</a>
			<a href="<c:url value='/hills/champion/champion.do'/>">대회안내</a>
			<a href="<c:url value='/hills/academi/rangeFare.do'/>">드라이빙레인지</a>
			<a href="https://blog.naver.com/seowonatrium" target="_blank">서원아트리움</a>
			<a href="<c:url value='/hills/index.do'/>">서원힐스</a>
		</div>
	</div>
	<div class="headerBox">
		<div class="logoBox">
			<a href="<c:url value='/valley/index.do'/>"><img src="<c:url value='/images/valley/logo.png'/>" alt="서원힐스 로고"></a>
		</div>
		
		<c:if test="${empty sessionScope.msMember.msId}">
			<a href="<c:url value='/valley/member/login.do'/>" class="topLogin"> <img src="<c:url value='/images/valley/topLogin.png'/>" alt="로그인"><span>로그인 / 회원가입</span></a>
		</c:if>
		
		<a href="<c:url value='/valley/map/map.do'/>" class="topLocation"><img src="<c:url value='/images/valley/topLocation.png'/>" alt="오시는길"><span>오시는길</span></a>
			
		<div class="topWheather" onclick="location.href='<c:url value='/valley/contents/weather.do'/>'">
			<img src="<c:url value='/images/valley/wt_b.png'/>" id="imgWeather" alt="날씨">
			<span>오늘의 날씨 </span><span id="txtWeather"></span>
		</div>
				
		<c:if test="${!empty sessionScope.msMember.msId}">
			<a href="javascript:actionLogout()" class="topLogin" style="margin-right: 65px"> <img src="<c:url value='/images/valley/logout.png'/>" alt="로그아웃"><span>로그아웃</span></a>
			<a href="javascript:locationMyZone()" class="topLogin"> <img src="<c:url value='/images/valley/topLogin.png'/>" alt="마이존"><span>마이존</span></a>
		</c:if>
	</div>
	<div class="headerLine"></div>
	<div id="gnb">
		<div class="gnbBox">
			<a href="<c:url value='/valley/index.do'/>">서원밸리</a><span> l </span> 			
			<a href="<c:url value='/valley/guide/useGuide.do'/>">이용안내</a><span> l </span> 
			<a href="<c:url value='/valley/reservation/reservation.do'/>">실시간예약</a><span> l </span> 
			<a href="<c:url value='/valley/facil/facil01.do'/>">시설안내</a><span> l </span> 
			<a href="<c:url value='/valley/course/courseIntro.do'/>">코스안내</a><span> l </span> 
			<a href="<c:url value='/valley/board/list.do?bbsType=1'/>">정보안내</a><span> l </span> 
			<a href="javascript:void(0)">고객센터</a>
		</div>
	</div>
	
	<jsp:include page="../include/topmenu.jsp" flush="true" />
</div>