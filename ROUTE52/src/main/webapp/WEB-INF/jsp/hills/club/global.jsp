<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="../include/header.jsp" />
<jsp:include page="../include/subTop.jsp" />

<div class="lnbBox">
	<div class="lnb">
		<img src="<c:url value='/images/hills/ico-home.png'/>" alt="">
		<p>서원힐스  &nbsp;&nbsp;&nbsp; ＞ <span>서원알리기</span></p>
	</div>
</div>

<div id="wrap">
	<div class="contents">
		<div class="myzoneTabList5">
			<a href="<c:url value='/hills/club/intro.do'/>" class="">인사말</a>
			<a href="<c:url value='/hills/club/cibi.do'/>" class="">CI/BI소개</a>
			<a href="<c:url value='/hills/club/history.do'/>" class="">연혁</a>
			<a href="<c:url value='/hills/club/gloabl.do'/>" class="on">글로벌멤버쉽</a>
			<a href="<c:url value='/hills/club/s_greenConcert.do'/>" class="">서원알리기</a>
			
		</div>
		
		<div class="subTitle">
			<span class="title">서원알리기</span>
		</div>
		<div class="subLine"></div>

		
	</div><!-- contents End -->
</div>

<jsp:include page="../include/footer-quick.jsp" flush="true" />
<jsp:include page="../include/footer.jsp" flush="true" />