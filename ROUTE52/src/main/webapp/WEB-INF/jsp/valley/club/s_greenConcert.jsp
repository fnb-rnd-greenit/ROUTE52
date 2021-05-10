<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="../include/header.jsp" />
<jsp:include page="../include/subTop.jsp" />

<div class="lnbBox">
	<div class="lnb">
		<img src="<c:url value='/images/valley/ico-home.png'/>" alt="">
		<p>서원밸리 &nbsp;&nbsp;&nbsp; ＞ <span>서원알리기</span></p>
	</div>
</div>

<div id="wrap">
	<div class="contents">
		<div class="myzoneTabList5">
			<a href="<c:url value='/valley/club/s_greenConcert.do'/>" class="on">그린콘서트</a>	
			<a href="<c:url value='/valley/club/s_greenTable.do'/>" class="">그린테이블</a>	
			<a href="<c:url value='/valley/club/s_essay.do'/>" class="">서원ESSAY</a>	
			<a href="<c:url value='/valley/club/s_top10.do'/>" class="">TOP10 코스</a>	
			<a href="<c:url value='/valley/club/s_marketing.do'/>" class="">홍보동영상</a>				
		</div>
		
		<div class="subTitle">
			<span class="title">그린콘서트</span>
		</div>
		<div class="subLine"></div>
		
		<div class="midTitleText">Happy Together in Seowon Valley Green Concert</div>
		<ul class="dashedBox" style="width: 835px;">
			<li class="grayTitle bold">5월 마지막 주 토요일 서원밸리와 함께 하는 자선 그린콘서트</li>
			<li class="greenTitle bold">Green Concert</li>
			<!-- <li class="concertDate">18회 그린콘서트 행사일 : 2020년 5월 30일</li> -->
			<li class="concertDate" style="font-size: 14px;line-height: 18px; width:730px;">“5월 30일 그린콘서트를 기대하고 계신 여러분들께 양해의 말씀드립니다.”</li>
			<li class="concertCont bold">제18회 서원밸리 자선 그린콘서트는 코로나19 위기 극복에 동참하기 위해 깊은 고민 끝에 취소를 결정했습니다. 이 점 매우 송구하게 생각합니다. 하루 빨리 일상으로 돌아가 신록의 계절 5월에 서원밸리 잔디 위에서 온 가족이 즐겁게 뛰어 노시는 모습을 다시 보게 되길 기원합니다.</li>
			<li class="concertDate" style="font-size:16px;">2021년 5월 29일 더 알차게 준비해 찾아뵙겠습니다.</li>
		</ul>
		
		<div class="concertTitle bold"><span class="concertDot">●</span>그린 콘서트 개요</div>
		<ul class="concertEx">
			<li class="concertCont">서원밸리 그린콘서트는 기업이윤을 사회에 환원하는 기업문화를 조성하고 골프장을 일반 시민들과 함께하는
			문화공간으로 <br> 만들어 골프의 대중화를 선도하며 회원들의 후원과 행사를 통해 마련된 기금을 주변의 어려운 이웃에게 지원하여 나눔의 가치를 실현하는 사회공헌 행사입니다.</li>			 
			<li><a href="<c:url value='http://www.greenconcert.co.kr'/>" target="_blank" class="concertLink">콘서트 홈페이지</a></li>
			<li><a href="javascript:opentoggle('open')" class="concertLink link2">문화체육관광부<br>장관 표창 수상</a></li>
		</ul>
		<div class="concertVideo">
			<iframe width="1200" height="500" src="https://www.youtube.com/embed/qWpr8S0lcMw" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
		</div>
		
		<p id="open_content" style="display:none; text-align:center;"><img src="<c:url value='/images/valley/award.png'/>" width="" alt="표창장" /></p>
		<script>
			function opentoggle(e){$("#" + e + "_content").slideToggle(250)}				
		</script>

		<div class="concertTitle bold"><span class="concertDot">●</span>그린 콘서트 자선기금 및 관람객참여 현황</div>
		<div class="graphImg"><img src="<c:url value='/images/valley/graph.png'/>" alt=""></div>
		 
		<div class="concertTitle bold"><span class="concertDot">●</span>그린 콘서트 년도별 사진갤러리</div>

		<div class="concertGalleryBox">
			<div class="concertGallery" onclick="popOpen(17)">
				<div class="concertGalleryImg on"><img src="<c:url value='/images/valley/greenConImg17.png'/>" alt=""></div>
				<div class="concertGalleryTitle on">17회 그린콘서트(2019년)</div>
			</div>
			<div class="concertGallery" onclick="popOpen(16)">
				<div class="concertGalleryImg"><img src="<c:url value='/images/valley/greenConImg16.png'/>" alt=""></div>
				<div class="concertGalleryTitle">16회 그린콘서트(2018년)</div>
			</div>
			<div class="concertGallery" onclick="popOpen(15)">
				<div class="concertGalleryImg"><img src="<c:url value='/images/valley/greenConImg15.png'/>" alt=""></div>
				<div class="concertGalleryTitle">15회 그린콘서트(2017년)</div>
			</div>
			<div class="concertGallery" onclick="popOpen(14)">
				<div class="concertGalleryImg"><img src="<c:url value='/images/valley/greenConImg14.png'/>" alt=""></div>
				<div class="concertGalleryTitle">14회 그린콘서트(2016년)</div>
			</div>			
		</div>
		<div class="concertGalleryBox">
			<div class="concertGallery" onclick="popOpen(13)">
				<div class="concertGalleryImg"><img src="<c:url value='/images/valley/greenConImg13.png'/>" alt=""></div>
				<div class="concertGalleryTitle">13회 그린콘서트(2015년)</div>
			</div>
			<div class="concertGallery" onclick="popOpen(12)">
				<div class="concertGalleryImg"><img src="<c:url value='/images/valley/greenConImg12.png'/>" alt=""></div>
				<div class="concertGalleryTitle">12회 그린콘서트(2014년)</div>
			</div>
			<div class="concertGallery" onclick="popOpen(11)">
				<div class="concertGalleryImg"><img src="<c:url value='/images/valley/greenConImg11.png'/>" alt=""></div>
				<div class="concertGalleryTitle">11회 그린콘서트(2013년)</div>
			</div>
			<div class="concertGallery" onclick="popOpen(10)">
				<div class="concertGalleryImg"><img src="<c:url value='/images/valley/greenConImg10.png'/>" alt=""></div>
				<div class="concertGalleryTitle">10회 그린콘서트(2012년)</div>
			</div>			
		</div>
		<div class="concertGalleryBox">
			<div class="concertGallery" onclick="popOpen(9)">
				<div class="concertGalleryImg"><img src="<c:url value='/images/valley/greenConImg9.png'/>" alt=""></div>
				<div class="concertGalleryTitle">9회 그린콘서트(2011년)</div>
			</div>
			<div class="concertGallery" onclick="popOpen(8)">
				<div class="concertGalleryImg"><img src="<c:url value='/images/valley/greenConImg8.png'/>" alt=""></div>
				<div class="concertGalleryTitle">8회 그린콘서트(2010년)</div>
			</div>
			<div class="concertGallery" onclick="popOpen(7)">
				<div class="concertGalleryImg"><img src="<c:url value='/images/valley/greenConImg7.png'/>" alt=""></div>
				<div class="concertGalleryTitle">7회 그린콘서트(2009년)</div>
			</div>
			<div class="concertGallery" onclick="popOpen(6)">
				<div class="concertGalleryImg"><img src="<c:url value='/images/valley/greenConImg6.png'/>" alt=""></div>
				<div class="concertGalleryTitle">6회 그린콘서트(2008년)</div>
			</div>
		</div>
		<div class="concertGalleryBox">
			<div class="concertGallery" onclick="popOpen(5)">
				<div class="concertGalleryImg"><img src="<c:url value='/images/valley/greenConImg5.png'/>" alt=""></div>
				<div class="concertGalleryTitle">5회 그린콘서트(2007년)</div>
			</div>
			<div class="concertGallery" onclick="popOpen(4)">
				<div class="concertGalleryImg"><img src="<c:url value='/images/valley/greenConImg4.png'/>" alt=""></div>
				<div class="concertGalleryTitle">4회 그린콘서트(2006년)</div>
			</div>
			<div class="concertGallery" onclick="popOpen(3)">
				<div class="concertGalleryImg"><img src="<c:url value='/images/valley/greenConImg3.png'/>" alt=""></div>
				<div class="concertGalleryTitle">3회 그린콘서트(2005년)</div>
			</div>
			<div class="concertGallery" onclick="popOpen(2)">
				<div class="concertGalleryImg"><img src="<c:url value='/images/valley/greenConImg2.png'/>" alt=""></div>
				<div class="concertGalleryTitle">2회 그린콘서트(2004년)</div>
			</div>
		</div>
		<div class="concertGalleryBox">
			<div class="concertGallery" onclick="popOpen(1)">
				<div class="concertGalleryImg"><img src="<c:url value='/images/valley/greenConImg1.png'/>" alt=""></div>
				<div class="concertGalleryTitle">1회 그린콘서트(2000년)</div>
			</div>
		</div>
		
	</div><!-- contents End -->
</div>

<jsp:include page="../include/footer-quick.jsp" flush="true" />
<jsp:include page="../include/footer.jsp" flush="true" />