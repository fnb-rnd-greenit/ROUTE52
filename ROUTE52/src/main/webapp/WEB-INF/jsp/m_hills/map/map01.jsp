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
			<li class="on"><a href="<c:url value='/m_hills/map/map01.do'/>">네이버맵</a></li>
			<li class=""><a href="<c:url value='/m_hills/map/map02.do'/>">제1자유로 방면</a></li>
			<li class=""><a href="<c:url value='/m_hills/map/map03.do'/>">제2자유로</a></li>
			<li class=""><a href="<c:url value='/m_hills/map/map04.do'/>">서울 외곽순환도로 -<br>통일로IC 진출</a></li>
			<li class=""><a href="<c:url value='/m_hills/map/map05.do'/>">서울 외곽순환도로 -<br>송추IC 진출</a></li>
			<li class=""><a href="<c:url value='/m_hills/map/map06.do'/>">양주시청<br>사거리</a></li>
			<li class=""><a href="<c:url value='/m_hills/map/map07.do'/>">구리-포천간 고속도로<br>
				(강동구,잠실,광진구)</a></li>
	</ul>

	<div class="contents">
		<div class="mapWrap">
			<div class="mapImg">
			<img src="<c:url value='/images/m_hills/map/map.jpg'/>">
			</div>
			<div class="mapBox">
			<a class="mapbtn1" href="https://map.naver.com/index.nhn?__pinOnly=false&query=&searchCoord=&menu=location&tab=1&lng=c9602ad019902d6ff4059b2132ea0339&__fromRestorer=true&mapMode=0&mpx=371eac5c858f9c107f515985010e2c443778ee121bd5d23c72192cf4d10cd9dad7047a987887382e824d389ff689658f&pinId=20340126&rpanel=n-f&pinType=site&lat=13818e0d75f516a204f2204efc57a217&dlevel=8&enc=b64" target="_blank"><img src="<c:url value='/images/m_hills/map/arwBox.png'/>"> 네이버지도보기</a>
			</div>
				
		</div>
	</div>		
	<!-- contents End -->
    
<jsp:include page="../include/footer.jsp" flush="true" />
</div>   

</body>
</html>