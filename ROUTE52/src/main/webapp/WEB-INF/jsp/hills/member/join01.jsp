<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="../include/header.jsp" />
<jsp:include page="../include/subTop.jsp" />

<div class="lnbBox">
	<div class="lnb">
		<img src="<c:url value='/images/hills/ico-home.png'/>" alt="">
		<p>Member &nbsp;&nbsp;&nbsp; ＞ <span>회원가입</span></p>
	</div>
</div>

<div id="wrap">
	<div class="contents">
		<div class="subTitle subBottom">
			<span class="title">회원가입</span>
			<span class="titleDes"></span>
		</div>
		<div class="subLine"></div>

		<div class="joinTitle">간편회원가입</div>
		<div class="joinGrayBg">
			<ul class="snsJoinBox">
				<a href="<c:url value='/hills/member/join02.do'/>"><img src="<c:url value='/images/hills/join_seowon.png'/>" alt=""></a>
				<a href=""><img src="<c:url value='/images/hills/join_naver.png'/>" alt=""></a>
				<a href=""><img src="<c:url value='/images/hills/join_kakao.png'/>" alt=""></a>
				<a href=""><img src="<c:url value='/images/hills/join_face.png'/>" alt=""></a>
				<a href=""><img src="<c:url value='/images/hills/join_google.png'/>" alt=""></a>
			</ul>
		</div>
	</div><!-- contents End -->
</div>

<jsp:include page="../include/footer.jsp" flush="true" />