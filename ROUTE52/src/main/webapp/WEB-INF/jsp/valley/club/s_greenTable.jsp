<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="../include/header.jsp" />
<jsp:include page="../include/subTop.jsp" />
<script>

	jQuery(function() {
		var rolling_time = 3000;
		var effect_time = 1000;

		var $rolling_img = $(".rollingImg > img");
		$rolling_img.not(":first").hide();

		setInterval(rolling, rolling_time);

		function rolling() {
			$visible_img = $rolling_img.filter(":visible");
			$visible_img.fadeOut(effect_time);

			$next_img = $visible_img.next();
			if ($next_img.length === 0) {
				$next_img = $rolling_img.filter(":first");
			}
			$next_img.fadeIn(effect_time);
		}
	});
	
	$(document).ready(function() { 
	    var offset = $(".myzoneTabList5").offset();
	    $('html, body').animate({scrollTop : offset.top}, 400);
	});
</script>

<div class="lnbBox">
	<div class="lnb">
		<img src="<c:url value='/images/valley/ico-home.png'/>" alt="">
		<p>서원밸리 &nbsp;&nbsp;&nbsp; ＞ <span>서원알리기</span></p>
	</div>
</div>

<div id="wrap">
	<div class="contents">
		<div class="myzoneTabList5">
			<a href="<c:url value='/valley/club/s_greenConcert.do'/>" class="">그린콘서트</a>	
			<a href="<c:url value='/valley/club/s_greenTable.do'/>" class="on">그린테이블</a>	
			<a href="<c:url value='/valley/club/s_essay.do'/>" class="">서원ESSAY</a>	
			<a href="<c:url value='/valley/club/s_top10.do'/>" class="">TOP10 코스</a>	
			<a href="<c:url value='/valley/club/s_marketing.do'/>" class="">홍보동영상</a>				
		</div>
		
		<div class="subTitle">
			<span class="title">그린테이블</span>
		</div>
		<div class="subLine"></div>
		
		<div class="greenTableBox">
			<img src="<c:url value='/images/valley/greentable_01.png'/>" class="tableImg">
			<div class="tableImgBox">
				<div class="tableImg2">
					<img src="<c:url value='/images/valley/greentable_02.png'/>" alt="">			
				</div>
				<div class="rollingBox">
					<div class="rollingImg">
						<img src="<c:url value='/images/valley/greentable_03_1.png'/>">
						<img src="<c:url value='/images/valley/greentable_03_2.png'/>">
						<img src="<c:url value='/images/valley/greentable_03_3.png'/>">
						<img src="<c:url value='/images/valley/greentable_03_4.png'/>">
						<img src="<c:url value='/images/valley/greentable_03_5.png'/>">
						<img src="<c:url value='/images/valley/greentable_03_6.png'/>">								
					</div>
				</div>	
			</div>
			<img src="<c:url value='/images/valley/greentable_04.png'/>" class="tableImg">
		</div>
		
	</div><!-- contents End -->
</div>

<jsp:include page="../include/footer-quick.jsp" flush="true" />
<jsp:include page="../include/footer.jsp" flush="true" />