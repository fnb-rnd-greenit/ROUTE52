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
			<li class="on"><a href="<c:url value='/m_hills/map/map06.do'/>">양주시청<br>사거리</a></li>
			<li class=""><a href="<c:url value='/m_hills/map/map07.do'/>">구리-포천간 고속도로<br>(강동구,잠실,광진구)</a></li>
	</ul>

	<div class="contents">
		<div class="mapWrap">
			<div class="mapImg">
			<img src="<c:url value='/images/m_hills/map/map5.jpg'/>">
			</div>
			<div class="mapBox">
			<a class="mapbtn1" href="https://map.naver.com/?sText=7JaR7KO87Iuc7LKt7IKs6rGw66as&dtPathType=2&lng=777b045fd369f59439612d18439b8eee&mapMode=0&eText=7ISc7JuQ67C466as7Luo7Yq466as7YG065%2B9&eType=SITE&sType=SITE&lat=844a49f913c9570bcfa7b01486c95484&dlevel=8&enc=b64&edid=11613479&elng=64fe6dc44ee80f86355471cfbeffc9f3&sdid=18294339&menu=route&eelat=b5f90b82bf48800877b746e0b2b2bf02&elat=43c90128d5b316adf8d17d3d895f0b73&pathType=0&slng=dcffbd9edb1cf17fe6e65a6a7c00efdf&eelng=dbe50211e2983da6161e6b5dfc279c7f&slat=59b12a4fb50736b5a27cbefbed79d11c" target="_blank"><img src="<c:url value='/images/m_hills/map/arwBox.png'/>"> 빠른길찾기</a>
			</div>
			<div class="mapText">
				<h2>&#8226; 양주시청 사거리</h2>
				<h3>1.양주시청 사거리(법원리/백석/광적방향:360번)좌회전 - 2.막은골 삼거리(법원리/백석/광적)직진- 3.오산 삼거리(법원리/광전:360번)우회전 -4. 백석 삼거리(파주/광적:360번 직진) - 5. 가납사거리(파주/장흥:360번)좌회전 - 6. 대성빌라 사거리(파주/연곡리 2시방향도로: 360번)직진 - 7. 석천가든 앞 삼거리(파주/비암리:360번)직진-8.서원힐스 도착</h3>
			</div>
				
		</div>
	</div>		
	<!-- contents End -->
    
<jsp:include page="../include/footer.jsp" flush="true" />
</div>   

</body>
</html>