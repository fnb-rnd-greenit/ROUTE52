<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="../include/header.jsp" />

<link rel="stylesheet" type="text/css" href="<c:url value='/css/m_hills/content.css'/>">

<div id="wrap">
	<div class="mainTitle">
		<img src="<c:url value='/images/m_hills/titleDot.png'/>" alt=""> 2019 서원힐스 BIG2 아마추어대회 <img src="<c:url value='/images/m_hills/titleDot.png'/>" alt="">
	</div>
	<div class="contents">
		<div class="b2f_movie">
			<div class="b2f_box">
				<img src="<c:url value='/images/m_hills/b2f_1_01.jpg'/>">
			</div>
			<div class="b2f_btn">
				<ul>
					<li><a href="#b2f1"><img src="<c:url value='/images/m_hills/b2f_1_02.jpg'/>"></a></li>
					<li><a href="#b2f2"><img src="<c:url value='/images/m_hills/b2f_1_03.jpg'/>"></a></li>
				</ul>
			</div>
			<div class="b2f_box1" id="b2f1">
				<ul>
					<li><img src="<c:url value='/images/m_hills/b2f_2.jpg'/>"></li>
				</ul>
				<div class="movie">
					<h2>제 3회 대보·서원힐스 여성아마추어 챔피언십 영상 하이라이트 보기</h2>
					<video muted="true" loop="loop" id="" controls="controls">
						<source src="/video/hills/b2f_191014.webm" type="video/webm">
						<source src="/video/hills/b2f_191014.mp4" type="video/mp4"> 
					</video>				
				</div>
			</div>
			<div class="b2f_box2" id="b2f2">
				<!--<ul>
					<li><img src="images/b2f_3_01.jpg"></li>
					<li>
						
					</li>
					<li><img src="images/b2f_3_02.jpg"></li>
				</ul>-->
				<img src="<c:url value='/images/m_hills/b2f_3.jpg'/>">
			</div>
		</div>
	</div><!-- contents End -->

<jsp:include page="../include/footer.jsp" flush="true" />
</div>   

</body>
</html>