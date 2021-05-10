<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="../include/header.jsp" />
<jsp:include page="../include/subTop.jsp" />

<script type="text/javascript">
	
	$(document).ready(function() { 
	    var offset = $(".myzoneTabList5").offset();
	    $('html, body').animate({scrollTop : offset.top}, 400);
	});

</script>

<div class="lnbBox">
	<div class="lnb">
		<img src="<c:url value='/images/hills/ico-home.png'/>" alt="">
		<p>서원힐스 &nbsp;&nbsp;&nbsp; ＞ <span>CI/BI소개</span></p>
	</div>
</div>

<div id="wrap">
	<div class="contents">
		<div class="myzoneTabList4">
			<a href="<c:url value='/hills/club/intro.do'/>" class="">인사말</a>
			<a href="<c:url value='/hills/club/cibi.do'/>" class="on">CI/BI소개</a>
			<a href="<c:url value='/hills/club/history.do'/>" class="">연혁</a>
			<!-- <a href="javascript:alert('준비중입니다.');" class="">글로벌멤버쉽</a> -->
			<%-- <a href="<c:url value='/hills/club/gloabl.do'/>" class="">글로벌멤버쉽</a> --%>
			<a href="<c:url value='/hills/club/s_greenConcert.do'/>" class="">서원알리기</a>	
		</div>
		
		<div class="subTitle">
			<span class="title">CI/BI소개</span>
		</div>
		<div class="subLine"></div>
		
		<div class="introTextBox">
			<div class="introLogoBox">
				<img src="<c:url value='/images/hills/introLogo.png'/>" alt="">
			</div>
			<div class="introLogoText">
				<div class="miniText">자연과 하나되는 여유와 즐거움</div>
				<div class="introTitleText cibiTitleText">
					<span class="bold">Seowon Valley Country Club</span>은<br>
					<span class="textDeco bold">고향의 '정'</span> 입니다.
				</div>
				<p class="cibiText">서원밸리CC를 가득 둘러싼 참나무들의 잎모양을 영문알파벳 S로 형상화하여 자연환경의 <br>
				고급스러움을 표현하였으며 배경색인 진녹색 컬러는 자연과 한몸이 된 친환경 골프장의 <br>
				이미지를 시각화한 것입니다.</p>
			</div>
		</div>

		<div class="cibiTitle">서원밸리컨트리클럽</div>
		<div class="logoDownBox">
			<ul class="downList">
				<li class="logoImg"><img src="<c:url value='/images/hills/ccImg01.png'/>" alt=""></li>
				<li class="downBtn"><a href="https://kr.object.ncloudstorage.com/contents/seowon-etc/logo01.ai">한글로고 DOWNLOAD</a></li>
			</ul>
			<ul class="downList">
				<li class="logoImg"><img src="<c:url value='/images/hills/ccImg02.png'/>" alt=""></li>
				<li class="downBtn"><a href="https://kr.object.ncloudstorage.com/contents/seowon-etc/logo02.ai">영문로고 DOWNLOAD</a></li>
			</ul>
			<ul class="downList">
				<li class="logoImg"><img src="<c:url value='/images/hills/ccImg03.png'/>" alt=""></li>
				<li class="downBtn"><a href="https://kr.object.ncloudstorage.com/contents/seowon-etc/logo03.ai">워터마크 DOWNLOAD</a></li>
			</ul>
		</div>
		<ul class="colorInfoBox">
			<li class="colorBox1">■</li>
			<li class="colorInfo">CMYK : C 90%  M 42%  Y 57%  K 23% <br>RGB : R 0   G 101   B 99</li>
			<li class="colorBox2">■</li>
			<li class="colorInfo">CMYK : C 70%  M 67%  Y 64%  K 74%<br>RGB : R 35   G 31   B 32</li>
		</ul>

		<div class="cibiTitle">서원밸리(회원제)</div>
		<div class="logoDownBox">
			<ul class="downList">
				<li class="logoImg"><img src="<c:url value='/images/hills/ccImg04.png'/>" alt=""></li>
				<li class="downBtn"><a href="https://kr.object.ncloudstorage.com/contents/seowon-etc/logo04.ai">한글로고 DOWNLOAD</a></li>
			</ul>
			<ul class="downList">
				<li class="logoImg"><img src="<c:url value='/images/hills/ccImg05.png'/>" alt=""></li>
				<li class="downBtn"><a href="https://kr.object.ncloudstorage.com/contents/seowon-etc/logo05.ai">영문로고 DOWNLOAD</a></li>
			</ul>
			<ul class="downList">
				<li class="logoImg"><img src="<c:url value='/images/hills/ccImg06.png'/>" alt=""></li>
				<li class="downBtn"><a href="https://kr.object.ncloudstorage.com/contents/seowon-etc/logo06.ai">워터마크 DOWNLOAD</a></li>
			</ul>
		</div>
		<ul class="colorInfoBox">
			<li class="colorBox1">■</li>
			<li class="colorInfo">CMYK : C 90%  M 42%  Y 57%  K 23% <br>RGB : R 0   G 101   B 99</li>
			<li class="colorBox2">■</li>
			<li class="colorInfo">CMYK : C 70%  M 67%  Y 64%  K 74% <br>RGB : R 35   G 31   B 32</li>
		</ul>

		<div class="cibiTitle">서원힐스</div>
		<div class="logoDownBox">
			<ul class="downList">
				<li class="logoImg"><img src="<c:url value='/images/hills/ccImg07.png'/>" alt=""></li>
				<li class="downBtn"><a href="https://kr.object.ncloudstorage.com/contents/seowon-etc/logo07.ai">한글로고 DOWNLOAD</a></li>
			</ul>
			<ul class="downList">
				<li class="logoImg"><img src="<c:url value='/images/hills/ccImg08.png'/>" alt=""></li>
				<li class="downBtn"><a href="https://kr.object.ncloudstorage.com/contents/seowon-etc/logo08.ai">영문로고 DOWNLOAD</a></li>
			</ul>
			<ul class="downList">
				<li class="logoImg"><img src="<c:url value='/images/hills/ccImg09.png'/>" alt=""></li>
				<li class="downBtn"><a href="https://kr.object.ncloudstorage.com/contents/seowon-etc/logo09.ai">워터마크 DOWNLOAD</a></li>
			</ul>
		</div>
		<ul class="colorInfoBox">
			<li class="colorBox3">■</li>
			<li class="colorInfo">CMYK : C 90%  M 42%  Y 57%  K 23% <br>RGB : R 0   G 101   B 99</li>
			<li class="colorBox2">■</li>
			<li class="colorInfo">CMYK : C 70%  M 67%  Y 64%  K 74% <br>RGB : R 35   G 31   B 32</li>
		</ul>

		
	</div><!-- contents End -->
</div>

<jsp:include page="../include/footer-quick.jsp" flush="true" />
<jsp:include page="../include/footer.jsp" flush="true" />