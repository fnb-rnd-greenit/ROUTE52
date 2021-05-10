<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="../include/header.jsp" />
<jsp:include page="../include/subTop.jsp" />

<script type="text/javascript">
	$(document).ready(function() { 
	    var offset = $(".myzoneTabList6").offset();
	    $('html, body').animate({scrollTop : offset.top}, 400);
	});
</script>

<div class="lnbBox">
	<div class="lnb">
		<img src="<c:url value='/images/hills/ico-home.png'/>" alt="">
		<p>(연)단체안내 &nbsp;&nbsp;&nbsp; ＞ <span>대관안내</span></p>
	</div>
</div>

<div id="wrap">
	<div class="contents">
		<div class="myzoneTabList5">
			<!-- <a href="javascript:alert('준비중입니다.');" class="">MY연단체</a> -->
			<%-- <a href="<c:url value='/hills/team/myTeam.do'/>" class="">MY연단체</a> --%>
			<a href="<c:url value='/hills/team/yearTeam.do'/>" class="">연단체안내</a>	
			<a href="<c:url value='/hills/team/yearRequest.do'/>" class="">연단체신청</a>	
			<%-- <a href="<c:url value='/hills/team/groupRequest.do'/>" class="">공지사항/조편성기입하기</a> --%>
			<a href="<c:url value='/hills/team/generalTeam.do'/>" class="">일반단체안내</a>
			<a href="<c:url value='/hills/team/generalRequest.do'/>" class="">일반단체신청</a>
			<a href="<c:url value='/hills/team/lease.do'/>" class="on">대관안내</a>
			<%-- <a href="<c:url value=''/>" class="">연단체공지사항</a> --%>
		</div>
		
		<div class="subTitle">
			<span class="title">대관안내</span>
		</div>
		<div class="subLine"></div>
		
		<div class="teamGuideBox">
			<div class="commonDot guideTitle"> 대관 종류</div>
			<div class="teamBox">			
				·  Happy Life를 만드는 복합문화공간 <a href="https://blog.naver.com/seowonatrium/220446394230" target="_blank" class="leaseLink">보러 가기 </a>
			</div>
		</div>
		<div class="teamGuideBox">
			<div class="commonDot guideTitle"> 대관 신청 및 예약안내 </div>
			<img src="<c:url value='/images/hills/img_art.jpg'/>" alt=""> 
		</div>
		
	</div><!-- contents End -->
</div>

<jsp:include page="../include/footer-quick.jsp" flush="true" />
<jsp:include page="../include/footer.jsp" flush="true" />