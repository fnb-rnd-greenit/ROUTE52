<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="../include/header.jsp" />
<jsp:include page="../include/subTop.jsp" />

<div class="lnbBox">
	<div class="lnb">
		<img src="<c:url value='/images/hills/ico-home.png'/>" alt="">
		<p>고객센터 &nbsp;&nbsp;&nbsp; ＞ <span>날씨정보</span></p>
	</div>
</div>

<div id="wrap">
	<div class="contents">
		<div class="subTitle">
			<span class="title">날씨정보</span>
		</div>
		<div class="subLine"></div>
		<!-- 데이타 시작 -->
		<iframe src="https://hosting.kweather.co.kr/seowonvalley/index.html" name="weather" width="700px" marginwidth="0" height="1500px" marginheight="0" scrolling="no" frameborder="0"></iframe>
		<!-- 데이타 종료 -->
	</div>
</div>

<jsp:include page="../include/footer-quick.jsp" flush="true" />
<jsp:include page="../include/footer.jsp" flush="true" />