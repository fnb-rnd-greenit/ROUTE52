<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="../include/header.jsp" />
<jsp:include page="../include/subTop.jsp" />

<script type="text/javascript">

	var selectedPage;
	
	$(document).ready(function() { 
	    var offset = $(".myzoneTabList5").offset();
	    $('html, body').animate({scrollTop : offset.top}, 400);
	});
	
	function onViewPdf(page) {
		var sUrl = "https://kr.object.ncloudstorage.com/contents/seowon-essay/{0}.pdf";
		
		if(selectedPage != null) {
			$("#" + selectedPage).removeClass("on");
		}
		
		selectedPage = page;
		
		$("#" + page).addClass("on");
		
		window.open(String.format(sUrl, page));
	}

</script>

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
			<a href="<c:url value='/hills/club/s_essay.do'/>" class="on">서원ESSAY</a>	
			<a href="<c:url value='/hills/club/s_top10.do'/>" class="">TOP10 코스</a>	
			<a href="<c:url value='/hills/club/s_marketing.do'/>" class="">홍보동영상</a>				
		</div>
		
		<div class="subTitle">
			<span class="title">서원ESSAY</span>
		</div>
		<div class="subLine"></div>
		
		<div class="essayTxtBox">
			<p class="essayMini">서원밸리가 만들어가는 풍요로운 삶의 길</p>
			<div class="essayTitleTxt">그 길을 담아가는 서원에세이</div>
			<p class="essayText">항상 열정적인 모습으로 임하는 서원인의 활기찬 모습과 생생한 현장 이야기들을 모아 계절별로 꾸미고 있습니다.</p>
		</div>

		<div class="essayTitleBox">
			<div class="img"><img src="<c:url value='/images/hills/essay.png'/>" alt=""></div>
			<ul class="essayTitle">
				<li class="title">&nbsp;.&nbsp;&nbsp;.&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;.&nbsp;&nbsp;.&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;.&nbsp;&nbsp;.</li>
				<li class="title">서원이의 열정과 정성이 담긴 서원에세이</li>
				<li class="text">그 생생한 현장 속에서 발전하는 서원의 모습을 지켜봐 주세요. <br>풍요로운 미래를 만즐어 가는 길에 서원밸리가 있습니다. </li>
			</ul>
		</div>

		<div class="essayListBox">
			<ul class="essayList">   
				<li class="essayBox" id="202001" onclick="onViewPdf('202001')">2020년 봄호</li>
				<li class="essayBox" id="201910" onclick="window.open('https://kr.object.ncloudstorage.com/contents/seowon-essay/%EC%84%9C%EC%9B%90%EC%97%90%EC%84%B8%EC%9D%B4%202019%20%EA%B0%80%EC%9D%84%ED%98%B8%28%ED%8E%BC%EC%B9%9C%EB%A9%B4%29.pdf')">2019년 가을호</li>
				<li class="essayBox" id="201907" onclick="window.open('https://kr.object.ncloudstorage.com/contents/seowon-essay/%EC%84%9C%EC%9B%90%EC%97%90%EC%84%B8%EC%9D%B4%202019%20%EC%97%AC%EB%A6%84%ED%98%B8%28%ED%8E%BC%EC%B9%9C%EB%A9%B4%29%29.pdf')">2019년 여름호</li>                 
				<li class="essayBox" id="201904" onclick="onViewPdf('201904')">2019년 04월 호</li>
				<li class="essayBox" id="201810" onclick="onViewPdf('201810')">2018년 10월 호</li>
				<li class="essayBox" id="201807" onclick="onViewPdf('201807')">2018년 7월 호</li>
				<li class="essayBox" id="201803" onclick="onViewPdf('201803')">2018년 3월 호</li>
				<li class="essayBox" id="201710" onclick="onViewPdf('201710')">2017년 10월 호</li>
				<li class="essayBox" id="201706" onclick="onViewPdf('201706')">2017년 6월 호</li>
				<li class="essayBox" id="201704" onclick="onViewPdf('201704')">2017년 4월 호</li>			
			</ul>
			<ul class="essayList">
				<li class="essayBox" id="201611" onclick="onViewPdf('201611')">2016년 11월 호</li>	
				<li class="essayBox" id="201604" onclick="onViewPdf('201604')">2016년 4월 호</li>
				<li class="essayBox" id="201506" onclick="onViewPdf('201506')">2015년 6월 호</li>
				<li class="essayBox" id="201503" onclick="onViewPdf('201503')">2015년 3월 호</li>
				<li class="essayBox" id="201412" onclick="onViewPdf('201412')">2014년 12월 호</li>
				<li class="essayBox" id="201407" onclick="onViewPdf('201407')">2014년 7월 호</li>
				<li class="essayBox" id="201404" onclick="onViewPdf('201404')">2014년 4월 호</li>
				<li class="essayBox" id="201310" onclick="onViewPdf('201310')">2013년 10월 호</li>
				<li class="essayBox" id="201306" onclick="onViewPdf('201306')">2013년 6월 호</li>
				<li class="essayBox" id="201207" onclick="onViewPdf('201207')">2012년 7월 호</li>
			</ul>
			<ul class="essayList"> 				
				<li class="essayBox" id="201107" onclick="onViewPdf('201107')">2011년 7월 호</li>
				<li class="essayBox" id="201103" onclick="onViewPdf('201103')">2011년 3월 호</li>
				<li class="essayBox" id="201011" onclick="onViewPdf('201011')">2010년 11월 호</li>     
				<li class="essayBox" id="201009" onclick="onViewPdf('201009')">2010년 9월 호</li>
				<li class="essayBox" id="201006" onclick="onViewPdf('201006')">2010년 6월 호</li>
				<li class="essayBox" id="201004" onclick="onViewPdf('201004')">2010년 4월 호</li>
				<li class="essayBox" id="201001" onclick="onViewPdf('201001')">2010년 1월 호</li>
				<li class="essayBox" id="200910" onclick="onViewPdf('200910')">2009년 10월 호</li>
				<li class="essayBox" id="200908" onclick="onViewPdf('200908')">2009년 8월 호</li>
				<li class="essayBox" id="200906" onclick="onViewPdf('200906')">2009년 6월 호</li>
			</ul> 
			<ul class="essayList">
				<li class="essayBox" id="200901" onclick="onViewPdf('200901')">2009년 1월 호</li>
				<li class="essayBox" id="200810" onclick="onViewPdf('200810')">2008년 10월 호</li>
				<li class="essayBox" id="200808" onclick="onViewPdf('200808')">2008년 8월 호</li>
				<li class="essayBox" id="200802" onclick="onViewPdf('200802')">2008년 2월 호</li>
			</ul>
		</div>
		<p class="esaayEtc">* 해당 호를 클릭하시면 해당 에세이를 보실수 있습니다.</p>
		
	</div><!-- contents End -->
</div>

<jsp:include page="../include/footer-quick.jsp" flush="true" />
<jsp:include page="../include/footer.jsp" flush="true" />