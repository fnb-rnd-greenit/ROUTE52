<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="../include/header.jsp" />
<jsp:include page="../include/subTop.jsp" />

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
		<div class="myzoneTabList5">
			<a href="<c:url value='/hills/guide/useGuide.do'/>" class="">이용안내</a>
			<a href="<c:url value='/hills/guide/reserGuide.do'/>" class="on">예약가이드</a>
			<a href="<c:url value='/hills/guide/charge.do'/>" class="">이용요금</a>
			<a href="<c:url value='/hills/guide/etiquette.do'/>" class="">골프에티켓</a>					
			<a href="<c:url value='/hills/guide/localRule.do'/>" class="">로컬룰</a>
		</div>
		
		<div class="subTitle">
			<span class="title">예약가이드</span>
		</div>
		<div class="subLine"></div>

	</div><!-- contents End -->
</div>

<jsp:include page="../include/footer-quick.jsp" flush="true" />
<jsp:include page="../include/footer.jsp" flush="true" />