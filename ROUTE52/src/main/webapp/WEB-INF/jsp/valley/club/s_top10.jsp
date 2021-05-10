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
		<img src="<c:url value='/images/valley/ico-home.png'/>" alt="">
		<p>서원밸리 &nbsp;&nbsp;&nbsp; ＞ <span>서원알리기</span></p>
	</div>
</div>

<div id="wrap">
	<div class="contents">
		<div class="myzoneTabList5">
			<a href="<c:url value='/valley/club/s_greenConcert.do'/>" class="">그린콘서트</a>	
			<a href="<c:url value='/valley/club/s_greenTable.do'/>" class="">그린테이블</a>	
			<a href="<c:url value='/valley/club/s_essay.do'/>" class="">서원ESSAY</a>	
			<a href="<c:url value='/valley/club/s_top10.do'/>" class="on">TOP10 코스</a>	
			<a href="<c:url value='/valley/club/s_marketing.do'/>" class="">홍보동영상</a>				
		</div>
		
		<div class="subTitle">
			<span class="title">TOP10 코스</span>
		</div>
		<div class="subLine"></div>
		
		<div class="marketingBox">
			<div class="marketingMini">서원밸리는 항상 최고만을 추구합니다.</div>
			<div class="marketingTitle">국내 골프장을 대표하는 최고의 코스</div>
		</div>

		<div class="top10Img">
			<img src="<c:url value='/images/valley/top10.png'/>" alt="">
		</div>
		
	</div><!-- contents End -->
</div>

<jsp:include page="../include/footer-quick.jsp" flush="true" />
<jsp:include page="../include/footer.jsp" flush="true" />