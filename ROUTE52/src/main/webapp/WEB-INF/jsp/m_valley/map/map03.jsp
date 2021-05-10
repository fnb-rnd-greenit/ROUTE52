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
			<li class="on"><a href="<c:url value='/m_valley/map/map03.do'/>">제2자유로</a></li>
			<li class=""><a href="<c:url value='/m_valley/map/map04.do'/>">서울 외곽순환도로 -<br>통일로IC 진출</a></li>
			<li class=""><a href="<c:url value='/m_valley/map/map05.do'/>">서울 외곽순환도로 -<br>송추IC 진출</a></li>
			<li class=""><a href="<c:url value='/m_valley/map/map06.do'/>">양주시청<br>사거리</a></li>
			<li class=""><a href="<c:url value='/m_valley/map/map07.do'/>">구리-포천간 고속도로<br>(강동구,잠실,광진구)</a></li>
	</ul>

	<div class="contents">
		<div class="mapWrap">
			<div class="mapImg">
			<img src="<c:url value='/images/m_valley/map/map2.jpg'/>">
			</div>
			<div class="mapBox">
			<a class="mapbtn1" href="https://map.naver.com/?edid=11613479&sText=7Iug7Y%2BJSUM%3D&elng=64fe6dc44ee80f86355471cfbeffc9f3&sdid=19416772&dtPathType=2&menu=route&lng=4f3daae47d9e4b540ec93d0154ac402a&eelat=b5f90b82bf48800877b746e0b2b2bf02&mapMode=0&elat=43c90128d5b316adf8d17d3d895f0b73&pathType=0&eText=7ISc7JuQ67C466as7Luo7Yq466as7YG065%2B9&slng=f1835cc8a95ef09e88f0a24c64a9399a&eelng=dbe50211e2983da6161e6b5dfc279c7f&eType=SITE&slat=1393894b6df4e7336bd05a30df5e1015&sType=SITE_1&lat=898a556ec75bf1c48e0b5d6b77106f46&dlevel=7&enc=b64" target="_blank"><img src="<c:url value='/images/m_valley/map/arwBox.png'/>"> 빠른길찾기</a>
			</div>
			<div class="mapText">
				<h2>&#8226; 제2자유로</h2>
				<h3>1. 신평IC - 2. 법곳IC 우회전 - 3. 산내교차로 우회전 - 4. 광탄IC 직진 - 5.방축교차로 우회전 - 6.방축2교차로 직진(광적,양주방향) - 7. 서원밸리컨트리클럽 도착</h3>
			</div>
				
		</div>
	</div>		
	<!-- contents End -->
    
<jsp:include page="../include/footer.jsp" flush="true" />
</div>   

</body>
</html>