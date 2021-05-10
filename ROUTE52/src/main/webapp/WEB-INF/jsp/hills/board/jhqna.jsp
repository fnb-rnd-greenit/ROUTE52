<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="../include/header.jsp" />
<jsp:include page="../include/subTop.jsp" />

<div class="lnbBox">
	<div class="lnb">
		<img src="<c:url value='/images/hills/ico-home.png'/>" alt="">
		<p>제휴안내 &nbsp;&nbsp;&nbsp; ＞ <span>제휴안내</span></p>
	</div>
</div>

<div id="wrap">
	<div class="contents">
		<div class="myzoneTabList5">
			<a href="<c:url value='/hills/board/jhqna.do'/>" class="on">제휴안내</a>
			<a href="<c:url value='/hills/board/list.do?bbsType=51'/>">전체보기</a>
			<a href="<c:url value='/hills/board/list.do?bbsType=52'/>">골프용품(의류)</a>
			<a href="<c:url value='/hills/board/list.do?bbsType=53'/>">호텔/레저/외식</a>
			<a href="<c:url value='/hills/board/list.do?bbsType=54'/>">기타</a>
		</div>
		<div class="subTitle subBottom">
			<span class="title">제휴안내</span>
		</div>
		<div style="text-align:center;">
			<img src="<c:url value='/images/hills/hjhqna.jpg'/>" alt="">
		</div>
	</div>
</div>

<jsp:include page="../include/footer-quick.jsp" flush="true" />
<jsp:include page="../include/footer.jsp" flush="true" />