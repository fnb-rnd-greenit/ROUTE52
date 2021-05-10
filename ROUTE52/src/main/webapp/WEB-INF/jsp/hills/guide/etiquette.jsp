<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="../include/header.jsp" />
<jsp:include page="../include/subTop.jsp" />

<script type="text/javascript">
	
	$(document).ready(function() { 
	    var offset = $(".myzoneTabList5").offset();
	    $('html, body').animate({scrollTop : offset.top}, 400);
	});

</script>

<div class="lnbBox">
	<div class="lnb">
		<img src="<c:url value='/images/hills/ico-home.png'/>" alt="">
		<p>이용안내 &nbsp;&nbsp;&nbsp; ＞ <span>이용안내</span></p>
	</div>
</div>

<!-- 
1. 화면 이동 - <a href="<c:url value='/hills/cource/sample.do'/>" class=""></a>
2. 이미지 - <img src="<c:url value='/images/hills/quickIcon01.png'/>">
-->

<div id="wrap">
	<div class="contents">
		<div class="myzoneTabList4">
			<a href="<c:url value='/hills/guide/useGuide.do'/>" class="">이용안내</a>
			<!-- <a href="javascript:alert('준비중입니다.');" class="">예약가이드</a> -->
			<%-- <a href="<c:url value='/hills/guide/reserGuide.do'/>" class="">예약가이드</a> --%>
			<a href="<c:url value='/hills/guide/charge.do'/>" class="">이용요금</a>
			<a href="<c:url value='/hills/guide/etiquette.do'/>" class="on">골프에티켓</a>					
			<a href="<c:url value='/hills/guide/localRule.do'/>" class="">로컬룰</a>
		</div>
		
		<div class="subTitle">
			<span class="title">골프에티켓</span>
		</div>
		<div class="subLine"></div>
		
		<ul class="etiquetteText">
			<li class="commonDot guideTitle"> 골프에티켓</li>
			<li class="etiquetteContent">
			· 골프는 상대방을 배려할 줄 아는 작은 매너에서부터 시작되므로 질서와 에티켓을 지켜 주시기 바랍니다. <br>
			· 골퍼는 기본 복장을 준수하여 주시기 바랍니다.<br>
			· 경기 집중력을 위해 휴대폰은 진동으로 설정하여 상대 골퍼에게 방해되는 일이 없도록 하여 주시기 바랍니다.<br>
			· 늑장 플레이로 경기 시간을 지연하는 행위를 삼가하여 주시기 바랍니다.<br>
			· 뒷팀을 패스하거나, 잔디를 훼손하는 행위를 삼가하여 주시기 바랍니다.<br>
			· 잦은 연습스윙으로 잔디를 훼손하거나, 클럽으로 잔디를 찍는 행위, 클럽을 내던지는 행위를 삼가하여 주시기 바랍니다.<br>
			· 고객 상호간 진한 애정표현이나 캐디에게 성희롱 언어사용 및 신체 접촉 행위를 삼가하여 주시기 바랍니다.<br>
			· 코스내 금연이오니 지정 흡연 장소를 이용하여 주시기 바랍니다.<br>
			· 티잉그라운드는 잔디보호 및 안전사고 예방을 위하여 티샷하시는 고객만 올라가 주시기 바랍니다.<br>
			· 골프장에는 외부 음식물을 반입할 수 없습니다.<br>
			· 음주, 방뇨, 고성방가 등을 삼가하여 주시기 바랍니다.<br>
			· 그린 위에서는 스파크를 끌거나, 상처를 내는 일이 없도록 하여 주시기 바랍니다.<br>
			· 벙커샷 후에는 반드시 고무래로 벙커를 정리해 주시기 바랍니다.<br>
			· 그린 보호를 위하여 반드시 고무징 골프화를 착용하시기 바랍니다.<br>
			<span class="red">· 스윙으로 생긴 잔디 뗏장은 반드시 디봇 위치에 되돌려 놓고 발로 힘있게 눌러 주십시오.</span><br>
			</li>
		</ul>
		

	</div><!-- contents End -->
</div>

<jsp:include page="../include/footer-quick.jsp" flush="true" />
<jsp:include page="../include/footer.jsp" flush="true" />