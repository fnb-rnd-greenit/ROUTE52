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
<style>
.movie{ width: 1200px; text-align: center; display: block; margin: 0  0 50px 0; padding: 0; background-color: #000;}
.movie video{ margin: 0; padding: 0; width: 100%;}
</style>

<div class="lnbBox">
	<div class="lnb">
		<img src="<c:url value='/images/hills/ico-home.png'/>" alt="">
		<p>서원힐스 &nbsp;&nbsp;&nbsp; ＞ <span>서원알리기</span></p>
	</div>
</div>

<div id="wrap">
	<div class="contents">
		<div class="myzoneTabList5">
			<a href="<c:url value='/hills/club/s_greenConcert.do'/>" class="">그린콘서트</a>	
			<a href="<c:url value='/hills/club/s_greenTable.do'/>" class="">그린테이블</a>	
			<a href="<c:url value='/hills/club/s_essay.do'/>" class="">서원ESSAY</a>	
			<a href="<c:url value='/hills/club/s_top10.do'/>" class="">TOP10 코스</a>	
			<a href="<c:url value='/hills/club/s_marketing.do'/>" class="on">홍보동영상</a>				
		</div>
		
		<div class="subTitle">
			<span class="title">홍보동영상</span>
		</div>
		<div class="subLine"></div>
		
		<div class="marketingBox">
			<div class="marketingTitle">명품으로 거듭나는 서원밸리컨트리클럽을 영상으로 소개합니다.</div>
			<p class="marketingText">서원힐스는 국제대회 유치가 가능한 7,367야드 전장(18홀 기준)과 단일홀 국내 최장의 640야드 장거리홀, 비거리 300야드의 드라이빙레인지, 꿈나무 육성을 위한 주니어 아카데미,<br> 
			 우기에 빗물을 담아 저장하는 지하 4미터, 담수용량 3만톤의 코퍼댐, 국내 유일 147미터 길이의 코스내 무지개 터널 등 전국 최고 수준의 골프장으로 여러분 곁에 다가서고 있습니다.</p>
		</div>
		<h1 style="font-size:20px; padding:10px 0 5px;">&bull; 레이델 폴리코사놀 도네이션 스킨스 게임</h1>
		<div class="movie">
			<video muted="true" loop="loop" id="bgvid" controls="controls" autoplay="autoplay">
				<source src="/images/intro/skins.mp4" type="video/mp4">  
				<source src="/images/intro/skins.webm" type="video/webm">				
			</video>
		</div>
		
		<div style="float:left; width:580px; margin-right:10px;">
			<h1 style="font-size:20px; padding:10px 0 5px;">&bull; 제4회 서원·클럽디 레이디스 골프 챔피언십 With 대보</h1>	
			<div class="movie" style="width:580px;">
				<video muted="true" loop="loop" id="bgvid" controls="controls" autoplay="autoplay">
					<source src="/images/intro/ladyday.mp4" type="video/mp4">  
					<source src="/images/intro/ladyday.webm" type="video/webm">				
				</video>
			</div>
		</div>
		
		<div style="float:left; width:600px;">
			<h1 style="font-size:20px; padding:10px 0 5px">&bull; 서원밸리컨트리클럽 홍보영상</h1>
			<div class="marketingVideo" style="width:600px;">			
				<iframe width="600" height="325" src="https://www.youtube.com/embed/dFwUG1I7ekY" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
			</div>
		</div>
	</div><!-- contents End -->
</div>

<jsp:include page="../include/footer-quick.jsp" flush="true" />
<jsp:include page="../include/footer.jsp" flush="true" />