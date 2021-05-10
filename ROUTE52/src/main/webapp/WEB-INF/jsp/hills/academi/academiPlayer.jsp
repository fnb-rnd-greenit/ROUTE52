<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="../include/header.jsp" />
<jsp:include page="../include/subTop.jsp" />
<jsp:include page="popup/pop_player.jsp" />

<!-- FlexSlider -->
<script src="<c:url value='/js/hills/jquery.flexslider.js'/>"></script>
<script type="text/javascript">
	$(document).ready(function() { 
	    var offset = $(".fareTabList").offset();
	    $('html, body').animate({scrollTop : offset.top}, 400);
	});
</script>
<div class="lnbBox">
		<div class="lnb">
			<img src="<c:url value='/images/hills/ico-home.png'/>" alt="">
			<p>아카데미 &nbsp;&nbsp;&nbsp; ＞ <span>선수단 소개</span></p>
		</div>
	</div>

<div id="wrap">
	<div class="contents">
		<div class="fareTabList">
			<a href="<c:url value='/hills/academi/rangeFare.do'/>" class="">드라이빙레인지</a>
			<a href="<c:url value='/hills/academi/academi.do'/>" class="on">아카데미</a>
		</div>
		
		<div class="fareCenterTab">
			<a href="<c:url value='/hills/academi/academiFare.do'/>" class="">아카데미 요금안내</a>
			<span>|</span>
			<a href="<c:url value='/hills/academi/academi.do'/>" class="">입점 아카데미</a>
			<span>|</span>
			<a href="<c:url value='/hills/academi/academiPlayer.do'/>" class="on">선수단 소개</a>
			<span>|</span>
			<a href="<c:url value='/hills/board/list.do?bbsType=33'/>" class="">아카데미 대회성적</a>
		</div>
		
		<div class="subTitle">
			<span class="title">선수단 소개</span>
		</div>
		<div class="subLine"></div>
		
		<div class="acaWrap">
			<div class="acaBox1">
				<p><img src="<c:url value='/images/hills/aca/p1.jpg'/>" alt=""></p>
				<h2>KPGA 최민철 프로</h2>
				<a href='javascript:void(0);' onclick="javascript:aca_popupOpen(1)">MORE</a>
			</div>
			<div class="acaBox1">
				<p><img src="<c:url value='/images/hills/aca/p2.jpg'/>" alt=""></p>
				<h2>KPGA 이상엽 프로</h2>
				<a href='javascript:void(0);' onclick="javascript:aca_popupOpen(2)">MORE</a>
			</div>
			<div class="acaBox1">
				<p><img src="<c:url value='/images/hills/aca/p3.jpg'/>" alt=""></p>
				<h2>KLPGA 박소연 프로</h2>
				<a href='javascript:void(0);' onclick="javascript:aca_popupOpen(3)">MORE</a>
			</div>
			<div class="acaBox1">
				<p><img src="<c:url value='/images/hills/aca/p4.jpg'/>" alt=""></p>
				<h2>KLPGA 임은빈 프로</h2>
				<a href='javascript:void(0);' onclick="javascript:aca_popupOpen(4)">MORE</a>
			</div>
			
			<hr>
			
			<div class="acaBox1">
				<p><img src="<c:url value='/images/hills/aca/p5.jpg'/>" alt=""></p>
				<h2>피승현 선수</h2>
				<a href='javascript:void(0);' onclick="javascript:aca_popupOpen(5)">MORE</a>
			</div>
			<div class="acaBox1">
				<p><img src="<c:url value='/images/hills/aca/p6.jpg'/>" alt=""></p>
				<h2>유현준 선수</h2>
				<a href='javascript:void(0);' onclick="javascript:aca_popupOpen(6)">MORE</a>
			</div>
		</div>
	</div>
	
	
	<!-- contents End -->
</div>

<jsp:include page="../include/footer-quick.jsp" flush="true" />
<jsp:include page="../include/footer.jsp" flush="true" />