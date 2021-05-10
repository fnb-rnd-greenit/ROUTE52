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
		<img src="<c:url value='/images/valley/ico-home.png'/>" alt="">
		<p>서원밸리 &nbsp;&nbsp;&nbsp; ＞ <span>인사말</span></p>
	</div>
</div>

<div id="wrap">
	<div class="contents">
		<div class="myzoneTabList4">
			<a href="<c:url value='/valley/club/intro.do'/>" class="on">인사말</a>
			<a href="<c:url value='/valley/club/cibi.do'/>" class="">CI/BI소개</a>
			<a href="<c:url value='/valley/club/history.do'/>" class="">연혁</a>
			<!-- <a href="javascript:alert('준비중입니다.');" class="">글로벌멤버쉽</a> -->
			<a href="<c:url value='/valley/club/s_greenConcert.do'/>" class="">서원알리기</a>
			<%-- <a href="<c:url value='/valley/club/gloabl.do'/>" class="">글로벌멤버쉽</a> --%>
			
		</div>
		
		<div class="subTitle">
			<span class="title">인사말</span>
		</div>
		<div class="subLine"></div>
		
		<div class="introTextBox">
			<div class="introTitle bold">Partnership</div>
			<div class="introTitleText">
				<span class="bold">Seowon Valley Country Club</span> 경영철학은 <br>
				<span class="textDeco bold">'함께하여 더 큰 가치'</span> 를 만들어내는 <br>
				것입니다.
			</div>

			<div class="introText">
				<p class="introMiniTitle bold">고향의 情이 느껴지는 서원밸리</p>
				<p class="introExplain">
					고향에온것 같은 편안함, 서원밸리가 추구하는 가치입니다. <br>
					보리수, 사과, 배 감 등 코스 내 가득한 과실수, 직접 재배하는 텃밭의 채소들, 직접 담가 5년 이상 <br>
					숙성시킨 된장, 간장, 고추장은 고향 같은 따뜻한 정을 선사합니다.
				</p>
				<p class="introMiniTitle bold">고품격, 회원제 서원밸리</p>
				<p class="introExplain">
					대한민국 TOP10 COURSE의 명대사가 된 서원밸리,영속적인 가치를 고객님과 함께 합니다.
				</p>

				<p class="introMiniTitle bold">FUN & JOY, 퍼블릭 서원힐스</p>
				<p class="introExplain">
					소비자가 뽑은 TOP10 COURSE에 선정 된 퍼블릭 서원힐스, 재미와 즐거움, 그리고 품격이 어우러진 <br>
					차별화된 서비스 퍼블릭의 새로운 지평을 열어 갑니다.
				</p>

				<p class="introMiniTitle bold">HAPPY LIFE, 문화코드 1번지</p>
				<p class="introExplain">
					골프여제 박인비가 결혼식을 올린 서원아트리움아름다운 자연 속의 야외 가든 웨딩과 돌잔치 등 <br>
					각종 연회 행사를 특별하게 연출랍니다.<br>
					골프장만이 가질 수 있는 아름다운 자연과 각종 문화행사의 노하우, 골프장 내 고품격 서비스<br>
					인프라를 바탕으로 복합문화공간을 만들어 갑니다.
				</p>

				<p class="introMiniTitle bold">GOLF LIFE, 알파에서 오메가까지</p>
				<p class="introExplain">
					300미터 길이, 90타석의 대규모 드라이빙 레인지, 벙커샷, 어프로치샷, 트러블샷 등 다양한 <br>
					샷을 훈련할 수 있는 숏게임연습장, 실전이 가능한 한국잔디 18홀과 양잔디 27홀의 코스,골프의 처음과 <br>
					끝을 서원밸리가 책임집니다.<br>
					서원아카데미에서 훈련하는 골프 꿈나무들은 서원밸리CC의 인프라와 차별화 된 우수아카데미 <br>
					프로그램으로 최상의 성과를 내고 있습니다.
				</p>

				<p class="introMiniTitle bold">사랑과 나눔, 멈출 수 없습니다</p>
				<p class="introExplain">
					누적관람객 40만명을 돌파한 자선 그린콘서트, 매년 5월 마지막 토요일, 서원밸리에서는 다양한 <br>
					국가의 관람객을 포함한 4만여명의 시민이 참여하는 축제의 한마당이 열립니다.<br>
					매년 6월 다문화가정 합동결혼식을 통해 결혼식의 꿈을 이뤄줍니다. <br>
					인근 초등학교 셔틀버스를 지원합니다.<br>
					매월 식음 매출에서 적립금을 모아 아프리카 기아 아동의급식을 지원합니다.<br>
					사랑과 나눔은 서원밸리 만이 아니라 회원과 고객, 그리고 지역주민이 함께 하기에 더욱 뜻 깊습니다.
				</p>
			</div>

			<ul class="signBox">
				<li><img src="<c:url value='/images/valley/introLogo.png'/>" style="width:200px" alt=""></li>
				<li>손끝에 정성과 혼을 다하는 서비스로 <br>고객 가치를 실현합니다</li>
				<%-- <li><img src="<c:url value='/images/valley/introSign.png'/>" alt=""></li> --%>
				<li>서원밸리컨트리클럽</li>
				<li>대표이사 <span style="font-family: 궁서; font-size: 20px;">이석호</span></li> 
			</ul>
		</div>

		
	</div><!-- contents End -->
</div>

<jsp:include page="../include/footer-quick.jsp" flush="true" />
<jsp:include page="../include/footer.jsp" flush="true" />