<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="../include/header.jsp" />
<jsp:include page="../include/pop_coupon.jsp" />

<link rel="stylesheet" type="text/css" href="<c:url value='/css/m_valley/content.css'/>">

<div id="wrap">
	<div class="mainTitle">
		<img src="<c:url value='/images/m_valley/titleDot.png'/>" alt=""> MAP <img src="<c:url value='/images/m_valley/titleDot.png'/>" alt="">
	</div>
	<ul class="mapTabList3">			
			<li class=""><a href="<c:url value='/m_valley/map/map01.do'/>">네이버맵</a></li>
			<li class=""><a href="<c:url value='/m_valley/map/map02.do'/>">제1자유로 방면</a></li>
			<li class=""><a href="<c:url value='/m_valley/map/map03.do'/>">제2자유로</a></li>
			<li class="on"><a href="<c:url value='/m_valley/map/map04.do'/>">서울 외곽순환도로 -<br>통일로IC 진출</a></li>
			<li class=""><a href="<c:url value='/m_valley/map/map05.do'/>">서울 외곽순환도로 -<br>송추IC 진출</a></li>
			<li class=""><a href="<c:url value='/m_valley/map/map06.do'/>">양주시청<br>사거리</a></li>
			<li class=""><a href="<c:url value='/m_valley/map/map07.do'/>">구리-포천간 고속도로<br>(강동구,잠실,광진구)</a></li>
	</ul>

	<div class="contents">
		<div class="mapWrap">
			<div class="mapImg">
			<img src="<c:url value='/images/m_valley/map/map3.jpg'/>">
			</div>
			<div class="mapBox">
			<a class="mapbtn1" href="https://map.naver.com/?sText=7Ya17J2866GcSUM%3D&dtPathType=2&lng=3439d3649d8872c322d68beecca2266b&mapMode=0&eText=7ISc7JuQ67C466as7Luo7Yq466as7YG065%2B9&eType=SITE&sType=SITE&lat=427ba54f9343fb042bfee916860fdcc9&dlevel=7&enc=b64&edid=11613479&elng=937a0ebb5a2abd167814d083cfb914c9&sdid=19039403&eslng=15057a114a94bd61f062f647bf034172&menu=route&eelat=b5f90b82bf48800877b746e0b2b2bf02&elat=b212d2f9bf916d84b2d2598a85191e5d&pathType=0&slng=30a715543bc7172d1d5929884e67755f&eelng=dbe50211e2983da6161e6b5dfc279c7f&slat=aa6c02d57be854e71f5baeb2e2927508&eslat=802aaf772ac6921a856c01a40af0c985" target="_blank"><img src="<c:url value='/images/m_valley/map/arwBox.png'/>"> 네이버 지도보기</a>
			</div>
			<div class="mapText">
				<h2>&#8226; 서울 외곽순환도로-통일로IC 진출</h2>
				<h3>1. 대자사거리(의정부/고양동:39번)우회전- 2. 고양동 신삼거리(푸른마을,GS주유소 삼거리에서 광탄 보광사)좌회전-3. 농원가든 삼거리(광탄/보광사/국군벽제병원)우회전 - 4. 벽제 삼거리(광탄/용미리묘지)좌회전- 5. 혜음령터널 직진- 6. 발랑리, 마장리방면 우회전- 7. 창만 사거리 직진-8.서원밸리컨트리클럽 도착</h3>
			</div>
				
		</div>
	</div>		
	<!-- contents End -->
    
<jsp:include page="../include/footer.jsp" flush="true" />
</div>   

</body>
</html>