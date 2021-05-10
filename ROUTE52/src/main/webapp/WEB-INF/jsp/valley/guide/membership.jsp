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
		<img src="<c:url value='/images/valley/ico-home.png'/>" alt="">
		<p>이용안내 &nbsp;&nbsp;&nbsp; ＞ <span>회원권안내</span></p>
	</div>
</div>

<div id="wrap">
	<div class="contents">
		<div class="myzoneTabList4">
			<a href="<c:url value='/valley/guide/useGuide.do'/>" class="on">이용안내</a>
			<a href="<c:url value='/valley/guide/charge.do'/>" class="">이용요금</a>
			<%-- <a href="<c:url value='/valley/guide/membership.do'/>" class="">회원권안내</a> --%>
			<a href="<c:url value='/valley/guide/etiquette.do'/>" class="">골프에티켓</a>
			<a href="<c:url value='/valley/guide/localRule.do'/>" class="">로컬룰</a>			
		</div>
		
		<div class="subTitle">
			<span class="title">회원권안내</span>
		</div>
		<div class="subLine"></div>
		
		<div class="memGuideTitle">회원권안내</div>
		<div class="memGuideTurnBox">
			<ul class="memGuideTurn">
				<li class="turnImg"><img src="<c:url value='/images/valley/memTurn01.png'/>" alt=""></li>
				<li class="turnTxt"><span class="bold">01.</span>입회신청</li>
			</ul>
			<div class="memGuideArrow"><img src="<c:url value='/images/valley/memGuideArrow.png'/>" alt=""></div>
			<ul class="memGuideTurn">
				<li class="turnImg"><img src="<c:url value='/images/valley/memTurn02.png'/>" alt=""></li>
				<li class="turnTxt"><span class="bold">02.</span>서류심사</li>
			</ul>
			<div class="memGuideArrow"><img src="<c:url value='/images/valley/memGuideArrow.png'/>" alt=""></div>
			<ul class="memGuideTurn">
				<li class="turnImg"><img src="<c:url value='/images/valley/memTurn03.png'/>" alt=""></li>
				<li class="turnTxt"><span class="bold">03.</span>입회예정자 공고</li>
			</ul>
			<div class="memGuideArrow"><img src="<c:url value='/images/valley/memGuideArrow.png'/>" alt=""></div>
			<ul class="memGuideTurn">
				<li class="turnImg"><img src="<c:url value='/images/valley/memTurn04.png'/>" alt=""></li>
				<li class="turnTxt"><span class="bold">04.</span>클럽 사전설명회 참석</li>
			</ul>
			<div class="memGuideArrow"><img src="<c:url value='/images/valley/memGuideArrow.png'/>" alt=""></div>
			<ul class="memGuideTurn">
				<li class="turnImg"><img src="<c:url value='/images/valley/memTurn05.png'/>" alt=""></li>
				<li class="turnTxt"><span class="bold">05.</span>운영위원회 심사</li>
			</ul>
			<div class="memGuideArrow"><img src="<c:url value='/images/valley/memGuideArrow.png'/>" alt=""></div>
			<ul class="memGuideTurn">
				<li class="turnImg"><img src="<c:url value='/images/valley/memTurn06.png'/>" alt=""></li>
				<li class="turnTxt"><span class="bold">06.</span>명의개서료 수납</li>
			</ul>
			<div class="memGuideArrow"><img src="<c:url value='/images/valley/memGuideArrow.png'/>" alt=""></div>
			<ul class="memGuideTurn">
				<li class="turnImg"><img src="<c:url value='/images/valley/memTurn07.png'/>" alt=""></li>
				<li class="turnTxt"><span class="bold">07.</span>회원자격 취득</li>
			</ul>
		</div>

		<ul class="useGuideText">
			<li class="commonDot guideTitle"> 회원변경 관련 서식받기</li>
			<li class="memFormAcceptBox">
				<div class="memFormAccept">
					<ul class="fileBtnList">
						<li><a href="https://kr.object.ncloudstorage.com/contents/seowon-member/%EC%A0%95%ED%9A%8C%EC%9B%90%EB%B3%80%EA%B2%BD%EC%8B%A0%EC%B2%AD.hwp" class="fileList list01"><span>· 정회원 변경신청 </span><img src="<c:url value='/images/valley/hw_icon.gif'/>" alt=""></a></li>
						<li><a href="https://kr.object.ncloudstorage.com/contents/seowon-member/%EC%A4%80%ED%9A%8C%EC%9B%90%EB%93%B1%EB%A1%9D%28%EB%B3%80%EA%B2%BD%29.hwp" class="fileList list02"><span>· 준회원 등록(변경)</span><img src="<c:url value='/images/valley/hw_icon.gif'/>" alt=""></a></li>
					</ul>
					<ul class="fileBtnList">
						<li><a href="https://kr.object.ncloudstorage.com/contents/seowon-member/%EC%83%81%ED%98%B8%EB%B3%80%EA%B2%BD%EC%8B%A0%EC%B2%AD.hwp" class="fileList list03"><span>· 상호 변경신청 </span><img src="<c:url value='/images/valley/hw_icon.gif'/>" alt=""></a></li>
						<li><a href="https://kr.object.ncloudstorage.com/contents/seowon-member/%EA%B8%B0%EB%AA%85%ED%9A%8C%EC%9B%90%EB%93%B1%EB%A1%9D%28%EB%B3%80%EA%B2%BD%29.hwp" class="fileList list04"><span>· 기명회원등록(변경) </span><img src="<c:url value='/images/valley/hw_icon.gif'/>" alt=""></a></li>
					</ul>
				</div>
				<div class="memFormAccept">
					<ul class="fileBtnList">
						<li><a href="https://kr.object.ncloudstorage.com/contents/seowon-member/%ED%9A%8C%EC%9B%90%EA%B6%8C%EC%96%91%EC%88%98%EB%8F%84%EC%8B%A0%EC%B2%AD.hwp" class="fileList list01"><span>· 회원권 양수도 신청 </span><img src="<c:url value='/images/valley/hw_icon.gif'/>" alt=""></a></li>
						<li><a href="https://kr.object.ncloudstorage.com/contents/seowon-member/%ED%9A%8C%EC%9B%90%EC%A6%9D%EB%B6%84%EC%8B%A4%EA%B0%81%EC%84%9C.hwp" class="fileList list02"><span>· 회원증 분실각서 </span><img src="<c:url value='/images/valley/hw_icon.gif'/>" alt=""></a></li>
					</ul>
					<ul class="fileBtnList">
						<li><a href="https://kr.object.ncloudstorage.com/contents/seowon-member/%ED%9A%8C%EC%B9%99.hwp" class="fileList list03"><span>· 회칙</span><img src="<c:url value='/images/valley/hw_icon.gif'/>" alt=""></a></li>
						<li><a href="https://kr.object.ncloudstorage.com/contents/seowon-member/%EC%97%B0%ED%9A%8C%EC%9B%90%EC%95%BD%EA%B4%80.hwp" class="fileList list04"><span>· 연회원약관</span><img src="<c:url value='/images/valley/hw_icon.gif'/>" alt=""></a></li>
					</ul>
				</div>
			</li>
		</ul>
		
	</div><!-- contents End -->
</div>

<jsp:include page="../include/footer-quick.jsp" flush="true" />
<jsp:include page="../include/footer.jsp" flush="true" />