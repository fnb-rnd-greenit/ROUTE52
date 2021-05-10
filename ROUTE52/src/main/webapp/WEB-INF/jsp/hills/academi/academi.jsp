<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="../include/header.jsp" />
<jsp:include page="../include/subTop.jsp" />
<jsp:include page="popup/pop_aca.jsp" />

<!-- FlexSlider -->
<script src="<c:url value='/js/hills/jquery.flexslider.js'/>"></script>
<script type="text/javascript">
	$(document).ready(function() { 
	    var offset = $(".fareTabList").offset();
	    $('html, body').animate({scrollTop : offset.top}, 400);
	});
</script>
<div class="lnbBox">
		<div class="lnb">
			<img src="<c:url value='/images/hills/ico-home.png'/>" alt="">
			<p>아카데미 &nbsp;&nbsp;&nbsp; ＞ <span>입점아카데미</span></p>
		</div>
	</div>

<div id="wrap">
	<div class="contents">
		<div class="fareTabList">
			<a href="<c:url value='/hills/academi/rangeFare.do'/>" class="">드라이빙레인지</a>
			<a href="<c:url value='/hills/academi/academi.do'/>" class="on">아카데미</a>
		</div>
		
		<div class="fareCenterTab">
			<a href="<c:url value='/hills/academi/academiFare.do'/>" class="">아카데미 요금안내</a>
			<span>|</span>
			<a href="<c:url value='/hills/academi/academi.do'/>" class="on">입점 아카데미</a>
			<span>|</span>
			<a href="<c:url value='/hills/academi/academiPlayer.do'/>" class="">선수단 소개</a>
			<span>|</span>
			<a href="<c:url value='/hills/board/list.do?bbsType=33'/>" class="">아카데미 대회성적</a>
		</div>
		
		<div class="subTitle">
			<span class="title">입점 아카데미</span>
		</div>
		<div class="subLine"></div>
		
		<div class="acaWrap">
			<div class="acaBox">
				<p><img src="<c:url value='/images/hills/aca/bn1.jpg'/>" alt=""></p>
				<h2>NBK 아카데미</h2>
				<h3>원장 : 나병관<br>문의전화 : 010-4786-7047</h3>
				<a href='javascript:void(0);' onclick="javascript:aca_popupOpen(1)">MORE</a>
			</div>
			<div class="acaBox">
				<p><img src="<c:url value='/images/hills/aca/bn2.jpg'/>" alt=""></p>
				<h2>KS 아카데미</h2>
				<h3>원장 : 김광담<br>문의전화 : 010-4652-0808</h3>
				<a href='javascript:void(0);' onclick="javascript:aca_popupOpen(2)">MORE</a>
			</div>
			<div class="acaBox">
				<p><img src="<c:url value='/images/hills/aca/bn3.jpg'/>" alt=""></p>
				<h2>PJ 아카데미</h2>
				<h3>원장 : 이정희<br>문의전화 : 010-9479-1234</h3>
				<a href='javascript:void(0);' onclick="javascript:aca_popupOpen(3)">MORE</a>
			</div>
			<div class="acaBox">
				<p><img src="<c:url value='/images/hills/aca/bn4.jpg'/>" alt=""></p>
				<h2>JS 아카데미</h2>
				<h3>원장 : 정해심<br>문의전화 : 010-3734-4800</h3>
				<a href='javascript:void(0);' onclick="javascript:aca_popupOpen(4)">MORE</a>
			</div>
			
			<hr>
			
			<div class="acaBox">
				<p><img src="<c:url value='/images/hills/aca/bn5.jpg'/>" alt=""></p>
				<h2>T.F 아카데미</h2>
				<h3>원장 : 이종현<br>문의전화 : 010-2664-0785</h3>
				<a href='javascript:void(0);' onclick="javascript:aca_popupOpen(5)">MORE</a>
			</div>
			<div class="acaBox">
				<p><img src="<c:url value='/images/hills/aca/bn6.jpg'/>" alt=""></p>
				<h2>T.P 아카데미</h2>
				<h3>원장 : 성호준<br>문의전화 : 010-3851-0019</h3>
				<a href='javascript:void(0);' onclick="javascript:aca_popupOpen(6)">MORE</a>
			</div>
			<div class="acaBox">
				<p><img src="<c:url value='/images/hills/aca/bn8.jpg'/>" alt=""></p>
				<h2>KGTC 아카데미</h2>
				<h3>원장 : 최천호<br>문의전화 : 010-6391-1005</h3>
				<a href='javascript:void(0);' onclick="javascript:aca_popupOpen(7)">MORE</a>
			</div>
			<div class="acaBox">
				<p><img src="<c:url value='/images/hills/aca/bn9.jpg'/>" alt=""></p>
				<h2>BY 아카데미</h2>
				<h3>원장 : 유은석<br>문의전화 : 010-3230-6226</h3>
				<a href='javascript:void(0);' onclick="javascript:aca_popupOpen(8)">MORE</a>
			</div>
			
			<hr>
			
			<div class="acaBox">
				<p><img src="<c:url value='/images/hills/aca/bn10.jpg'/>" alt=""></p>
				<h2>d&b 아카데미</h2>
				<h3>원장 : 이단<br>문의전화 : 010-9145-8738</h3>
				<a href='javascript:void(0);' onclick="javascript:aca_popupOpen(9)">MORE</a>
			</div>			
		</div>
	</div>
	
	
	<!-- contents End -->
</div>

<jsp:include page="../include/footer-quick.jsp" flush="true" />
<jsp:include page="../include/footer.jsp" flush="true" />