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
			<a href="<c:url value='/hills/guide/etiquette.do'/>" class="">골프에티켓</a>					
			<a href="<c:url value='/hills/guide/localRule.do'/>" class="on">로컬룰</a>
		</div>
		
		<div class="subTitle">
			<span class="title">로컬룰</span>
			<a class="r_title" href="http://www.kgagolf.or.kr/GolfRule/GolfRule.aspx" target="_blank"><img src="<c:url value='/images/hills/commonDot.png'/>" alt=""> 대한골프협회 개정룰</a>
		</div>
		<div class="subLine"></div>
		
		<ul class="etiquetteText">
			<li class="commonDot guideTitle"> OB와 수리지 표시</li>
			<li class="etiquetteContent">
			· 아웃 오브 바운드(O.B)는 백색발뚝, 워터해저드는 황색말뚝, 병행워터해저드는 적색말뚝으로 표시하고, 수리지(G.U.R)는 녹색선 또는 적색, 백색 깃발로 표시합니다.
			</li>
		</ul>
		<br>
		<ul class="etiquetteText">
			<li class="commonDot guideTitle"> 장애물 구분</li>
			<li class="etiquetteContent">
			· 화단, 나무 보호를 위한 자주, 고무매트, 카트도로, 배수구, 볼 세척기 등 인공 시설물은 장애물입니다.
			</li>
		</ul>
		<br>
		<ul class="etiquetteText">
			<li class="commonDot guideTitle"> 볼이 다른 홀로 들어간 경우</li>
			<li class="etiquetteContent">
			· 아웃 오브 바운드(O.B) 경계선을 넘어 다른 홀에 들어간 볼은 코스안에 있더라도 O.B입니다.
			</li>
		</ul>
		<br>
		<ul class="etiquetteText">
			<li class="commonDot guideTitle"> 볼이 화단내에 들어간 경우</li>
			<li class="etiquetteContent">
			· 볼이 코스내의 화단에 들어갔을 경우에는, 화초류의 보호를 위하여, 홀에 가깝지 않게 1클럽 이내에 드롭 하여야 합니다.
			</li>
		</ul>
		<br>
		<ul class="etiquetteText">
			<li class="commonDot guideTitle"> 야간나이트 경기시</li>
			<li class="etiquetteContent">
			· 라이트 경기시 OB는 1벌타로 처리하며, 병행워터해저드는 무벌 드롭 입니다.
			</li>
		</ul>
		<br>
		<ul class="etiquetteText">
			<li class="commonDot guideTitle"> 기타사항</li>
			<li class="etiquetteContent">
			· 상기 이외 사항은 대한골프협회 규칙을 적용합니다.
			</li>
		</ul>
		

	</div><!-- contents End -->
</div>

<jsp:include page="../include/footer-quick.jsp" flush="true" />
<jsp:include page="../include/footer.jsp" flush="true" />