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
			<li class="on"><a href="<c:url value='/m_valley/map/map02.do'/>">제1자유로 방면</a></li>
			<li class=""><a href="<c:url value='/m_valley/map/map03.do'/>">제2자유로</a></li>
			<li class=""><a href="<c:url value='/m_valley/map/map04.do'/>">서울 외곽순환도로 -<br>통일로IC 진출</a></li>
			<li class=""><a href="<c:url value='/m_valley/map/map05.do'/>">서울 외곽순환도로 -<br>송추IC 진출</a></li>
			<li class=""><a href="<c:url value='/m_valley/map/map06.do'/>">양주시청<br>사거리</a></li>
			<li class=""><a href="<c:url value='/m_valley/map/map07.do'/>">구리-포천간 고속도로<br>
				(강동구,잠실,광진구)</a></li>
	</ul>

	<div class="contents">
		<div class="mapWrap">
			<div class="mapImg">
			<img src="<c:url value='/images/m_valley/map/map1.jpg'/>">
			</div>
			<div class="mapBox">
			<a class="mapbtn1" href="https://map.naver.com/?sText=66y467CcSUM%3D&dtPathType=2&lng=fe39cb5d610379616a7e9c4e766224bb&mapMode=0&eText=7ISc7JuQ67C466as7Luo7Yq466as7YG065%2B9&eType=SITE&sType=SITE&lat=cc28d00f37e34698e5b456142f884f50&dlevel=7&enc=b64&edid=11613479&elng=64fe6dc44ee80f86355471cfbeffc9f3&sdid=19309684&menu=route&eelat=b5f90b82bf48800877b746e0b2b2bf02&elat=43c90128d5b316adf8d17d3d895f0b73&pathType=0&slng=5acebb2642a94ecb8bf0f2890e531f13&eelng=dbe50211e2983da6161e6b5dfc279c7f&slat=ab95262e575b69add3cb2c7c3ba416a6" target="_blank"><img src="<c:url value='/images/m_valley/map/arwBox.png'/>"> 빠른길찾기</a>
			</div>
			<div class="mapText">
				<h2>&#8226; 제1자유로 방면</h2>
				<h3>1. 문발 IC진출(광탄/교하지구: 56번 도로)- 2. 광탄 IC - 3.방축교차로 우회전- 4.방축2교차로 직진(광적,양주방향) - 5. 서원밸리컨트리클럽 도착</h3>
			</div>
				
		</div>
	</div>		
	<!-- contents End -->
    
<jsp:include page="../include/footer.jsp" flush="true" />
</div>   

</body>
</html>