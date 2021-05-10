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
		<p>서원힐스 &nbsp;&nbsp;&nbsp; ＞ <span>연혁</span></p>
	</div>
</div>

<div id="wrap">
	<div class="contents">
		<div class="myzoneTabList4">
			<a href="<c:url value='/hills/club/intro.do'/>" class="">인사말</a>
			<a href="<c:url value='/hills/club/cibi.do'/>" class="">CI/BI소개</a>
			<a href="<c:url value='/hills/club/history.do'/>" class="on">연혁</a>
			<!-- <a href="javascript:alert('준비중입니다.');" class="">글로벌멤버쉽</a> -->
			<%-- <a href="<c:url value='/hills/club/gloabl.do'/>" class="">글로벌멤버쉽</a> --%>
			<a href="<c:url value='/hills/club/s_greenConcert.do'/>" class="">서원알리기</a>	
			
		</div>
		
		<div class="subTitle">
			<span class="title">연혁</span>
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
					<span class="textDeco bold">'최고만을 추구'</span> 합니다.
				</div>
				<p class="cibiText">서원밸리CC는 언제나 고객님께 최고의 라운딩 환경을 만들어 드리기 위해 <br>
				최선의 노력을 다하고 있습니다. <br>
				고객이 만족하는 그날까지 저희 서원은 멈추지 않습니다.</p>
			</div>
		</div>

		<ul class="historyTab">
			<li class="on" id="history1"><a href="javascript:historyTab(1);">2020~2016</a></li>
			<li class="" id="history2"><a href="javascript:historyTab(2);">2015~2011</a></li>
			<li class="" id="history3"><a href="javascript:historyTab(3);">2010~2006</a></li>
			<li class="" id="history4"><a href="javascript:historyTab(4);">2005~2000</a></li>
		</ul>

		<div class="history1" style="display:block">
			<img src="<c:url value='/images/hills/history01.png'/>" alt="">
		</div>
		<div class="history2" style="display:none">
			<img src="<c:url value='/images/hills/history02.png'/>" alt="">
		</div>
		<div class="history3" style="display:none">
			<img src="<c:url value='/images/hills/history03.png'/>" alt="">
		</div>
		<div class="history4" style="display:none">
			<img src="<c:url value='/images/hills/history04.png'/>" alt="">
		</div>


		
	</div><!-- contents End -->
</div>

<jsp:include page="../include/footer-quick.jsp" flush="true" />
<jsp:include page="../include/footer.jsp" flush="true" />