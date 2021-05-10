<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="../include/header.jsp" />
<jsp:include page="../include/subTop.jsp" />

<script type="text/javascript">
	$(document).ready(function() { 
	    var offset = $(".myzoneTabList3").offset();
	    $('html, body').animate({scrollTop : offset.top}, 400);
	}); 
</script>


<div class="lnbBox">
	<div class="lnb">
		<img src="<c:url value='/images/hills/ico-home.png'/>" alt="">
		<p>예약서비스 &nbsp;&nbsp;&nbsp; ＞ <span>예약가이드</span></p>
	</div>
</div>

<div id="wrap">
	<div class="contents">
		
		<div class="myzoneTabList3">
			<a href="<c:url value='/hills/reservation/reservationGuide.do'/>" class="">웹 이용가이드</a>
			<a href="<c:url value='/hills/reservation/reservationGuide2.do'/>" class="on">모바일 이용가이드</a>
			<a href="<c:url value='/hills/reservation/reservationGuide3.do'/>" class="">어플 이용가이드</a>					
		</div>
		
		<div class="subTitle">
			<span class="title">실시간예약</span>
		</div>
		<div class="subLine"></div>
		
		<div>
		<img src="<c:url value='/images/hills/guide02.jpg'/>" alt="">		
		</div>

	</div><!-- contents End -->
</div>

<jsp:include page="../include/footer-quick.jsp" flush="true" />
<jsp:include page="../include/footer.jsp" flush="true" />