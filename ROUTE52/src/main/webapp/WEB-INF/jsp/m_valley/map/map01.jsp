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
			<li class="on"><a href="<c:url value='/m_valley/map/map01.do'/>">네이버맵</a></li>
			<li class=""><a href="<c:url value='/m_valley/map/map02.do'/>">제1자유로 방면</a></li>
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
			<img src="<c:url value='/images/m_valley/map/map.jpg'/>">
			</div>
			<div class="mapBox">
			<a class="mapbtn1" href="http://naver.me/GEQHM5fc" target="_blank"><img src="<c:url value='/images/m_valley/map/arwBox.png'/>"> 빠른길찾기</a>
			</div>
				
		</div>
	</div>		
	<!-- contents End -->
    
<jsp:include page="../include/footer.jsp" flush="true" />
</div>   

</body>
</html>