<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="../include/header.jsp" />
<jsp:include page="../include/pop_coupon.jsp" />

<link rel="stylesheet" type="text/css" href="<c:url value='/css/m_hills/content.css'/>">

<div id="wrap">
	<div class="mainTitle">
		<img src="<c:url value='/images/m_hills/titleDot.png'/>" alt=""> MAP <img src="<c:url value='/images/m_hills/titleDot.png'/>" alt="">
	</div>
	<ul class="mapTabList3">			
			<li class=""><a href="<c:url value='/m_hills/map/map01.do'/>">네이버맵</a></li>
			<li class=""><a href="<c:url value='/m_hills/map/map02.do'/>">제1자유로 방면</a></li>
			<li class=""><a href="<c:url value='/m_hills/map/map03.do'/>">제2자유로</a></li>
			<li class=""><a href="<c:url value='/m_hills/map/map04.do'/>">서울 외곽순환도로 -<br>통일로IC 진출</a></li>
			<li class=""><a href="<c:url value='/m_hills/map/map05.do'/>">서울 외곽순환도로 -<br>송추IC 진출</a></li>
			<li class=""><a href="<c:url value='/m_hills/map/map06.do'/>">양주시청<br>사거리</a></li>
			<li class="on"><a href="<c:url value='/m_hills/map/map07.do'/>">구리-포천간 고속도로<br>(강동구,잠실,광진구)</a></li>
	</ul>

	<div class="contents">
		<div class="mapWrap">
			<div class="mapImg">
			<img src="<c:url value='/images/m_hills/map/map6.jpg'/>">
			</div>
			<div class="mapBox">
			<a class="mapbtn1" href="https://map.naver.com/?edid=20340126&sText=66%2B86529SUM%3D&elng=1d94082ce209e34b3acbbac37aaf6a7c&sdid=967986235&eslng=fe69b1889836c87b458399ea00fdb9ac&dtPathType=2&menu=route&lng=68e0fa143d95a627b75a6e9f93629909&mapMode=0&elat=3c912e7a5c55e0b03c32657b49ea87d4&pathType=0&eText=7ISc7JuQ7Z6Q7IqkQ0M%3D&slng=fa42f6aa3f48ac0a81ceb1635c7441da&eType=SITE_1&slat=9b526e196874e576c86c6a861431db38&sType=SITE_1&eslat=f0d19bc579ba9a93e19c854eee3c2e05&lat=64d6ad68493ad3f4f5cf961480258e9f&dlevel=6&enc=b64" target="_blank"><img src="<c:url value='/images/m_hills/map/arwBox.png'/>"> 빠른길 찾기</a>
			</div>
			<div class="mapText">
				<h2>&#8226; 구리-포천간 고속도로(강동구,잠실,광진구)</h2>
				<h3>1. 민락IC - 2. 민락교차로- 3. 광사교차로- 4.양주시청 사거리(법원리/백석/광적방향:360번)좌회전 - 5.막은골 삼거리(법원리/백석/광적)직진- 6.오산 삼거리(법원리/광전:360번)우회전 -7. 백석 삼거리(파주/광적:360번 직진) - 8. 가납사거리(파주/장흥:360번)좌회전 - 9. 대성빌라 사거리(파주/연곡리 2시방향도로: 360번)직진 - 10. 석천가든 앞 삼거리(파주/비암리:360번)직진- 11. 서원힐스 도착</h3>
			</div>				
		</div>
	</div>		
	<!-- contents End -->
    
<jsp:include page="../include/footer.jsp" flush="true" />
</div>   

</body>
</html>