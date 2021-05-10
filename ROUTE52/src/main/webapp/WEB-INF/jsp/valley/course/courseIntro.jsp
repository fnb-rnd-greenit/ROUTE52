<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="../include/header.jsp" />
<jsp:include page="../include/subTop.jsp" />

<script type="text/javascript">
	
	$(document).ready(function() { 
	    var offset = $(".myzoneTabList3").offset();
	    $('html, body').animate({scrollTop : offset.top}, 400);
	});

</script>

<div class="lnbBox">
	<div class="lnb">
		<img src="<c:url value='/images/valley/ico-home.png'/>" alt="">
		<p>코스안내 &nbsp;&nbsp;&nbsp; ＞ <span>코스안내</span></p>
	</div>
</div>

<div id="wrap">
	<div class="contents">
		<div class="myzoneTabList3">
			<a href="<c:url value='/valley/course/courseIntro.do'/>" class="on">코스안내</a>
			<a href="<c:url value='/valley/course/course_seowon.do'/>" class="">코스공략도</a>
			<a href="<c:url value='/valley/board/list.do?bbsType=36'/>">코스갤러리</a>
		</div>


		
		<div class="subTitle">
			<span class="title">코스안내</span>
		</div>
		<div class="subLine"></div>

		<div class="grayBg">
			<img src="<c:url value='/images/valley/course/courseIntro.png'/>" alt="" class="courseIntroImg">
		</div>
		
		<div class="courseIntroBox">
			<img src="<c:url value='/images/valley/balloon.png'/>" alt="" class="balloon">
			<p class="courseIntroText">	
				대한민국 10대 명문 컨트리클럽! 아름다운 코스 속에 숨쉬고 있는 서원의 자부심을 느껴보세요. 전국 골프장 평가 3위(골프스카이)에 이어<br> 대한민국 BEST 코스 TOP 10(골프다이제트스), 한국 BEST 18홀(서원코스 2번, 6번홀[서울경제]), 친환경 BEST 골프장 TOP 8(레저신문), 한국 10대 코스 TOP 10(서울경제) 선정 등 수많은 수상경력을 보유한 서원의 코스들에는 우리나라를 대표하는 골프 클럽으로서의 자부심이 가득 담겨 있습니다.
			</p>
		</div>
		<div class="courseDataTitle">서원밸리코스</div>
		<div class="courseIntroBox">
			<img src="<c:url value='/images/valley/balloon.png'/>" alt="" class="balloon2">
			<p class="courseIntroText">		
			아기자기하고 화려한 서원코스와 시원스럽고 난이도가 높은 밸리코스로 구성되어, 전체적으로 공략이 쉬워보이지만 <br>
			정교한 샷을 요구합니다. 기복이 작으면서도 난이도가 높아 도전하는 쾌감을 만끽할 수 있는 코스입니다.
			</p>
		</div>

		<!-- seowon Course -->
		<div class="courseDataTable">
			<div class="dataTitle">Seowon Course</div>
			<ul class="dataListTitle title">
				<li>HOLE</li>
				<li>1</li>
				<li>2</li>
				<li>3</li>
				<li>4</li>
				<li>5</li>
				<li>6</li>
				<li>7</li>
				<li>8</li>
				<li>9</li>
				<li>TOTAL</li>
			</ul>
			<ul class="dataListTitle blueData">
				<li>BLUE</li>
				<li>390</li>
				<li>548</li>
				<li>411</li>
				<li>206</li>
				<li>363</li>
				<li>413</li>
				<li>553</li>
				<li>185</li>
				<li>388</li>
				<li>3,457</li>
			</ul>
			<ul class="dataListTitle">
				<li>WHITE</li>
				<li>362</li>
				<li>514</li>
				<li>373</li>
				<li>174</li>
				<li>331</li>
				<li>399</li>
				<li>522</li>
				<li>153</li>
				<li>356</li>
				<li>3,184</li>
			</ul>
			<ul class="dataListTitle yellowData">
				<li>YELLOW</li>
				<li>307</li>
				<li>471</li>
				<li>343</li>
				<li>151</li>
				<li>305</li>
				<li>340</li>
				<li>490</li>
				<li>121</li>
				<li>336</li>
				<li>2,864</li>
			</ul>
			<ul class="dataListTitle redData">
				<li>RED</li>
				<li>284</li>
				<li>451</li>
				<li>308</li>
				<li>128</li>
				<li>278</li>
				<li>297</li>
				<li>458</li>
				<li>98</li>
				<li>291</li>
				<li>2,593</li>
			</ul>
			<ul class="dataListTitle">
				<li>PAR</li>
				<li>4</li>
				<li>5</li>
				<li>4</li>
				<li>3</li>
				<li>4</li>
				<li>4</li>
				<li>5</li>
				<li>3</li>
				<li>4</li>
				<li>36</li>
			</ul>
			<ul class="dataListTitle">
				<li>HANDCAP</li>
				<li>15</li>
				<li>9</li>
				<li>3</li>
				<li>5</li>
				<li>17</li>
				<li>1</li>
				<li>7</li>
				<li>11</li>
				<li>13</li>
				<li>-</li>
			</ul>
		</div>

		<!-- valley Course-->
		<div class="courseDataTable">
			<div class="dataTitle">Valley Course</div>
			<ul class="dataListTitle title">
				<li>HOLE</li>
				<li>1</li>
				<li>2</li>
				<li>3</li>
				<li>4</li>
				<li>5</li>
				<li>6</li>
				<li>7</li>
				<li>8</li>
				<li>9</li>
				<li>TOTAL</li>
			</ul>
			<ul class="dataListTitle blueData">
				<li>BLUE</li>
				<li>378</li>
				<li>205</li>
				<li>589</li>
				<li>401</li>
				<li>428</li>
				<li>420</li>
				<li>569</li>
				<li>184</li>
				<li>379</li>
				<li>3,553</li>
			</ul>
			<ul class="dataListTitle">
				<li>WHITE</li>
				<li>353</li>
				<li>179</li>
				<li>551</li>
				<li>373</li>
				<li>394</li>
				<li>383</li>
				<li>535</li>
				<li>177</li>
				<li>339</li>
				<li>3,284</li>
			</ul>
			<ul class="dataListTitle yellowData">
				<li>YELLOW</li>
				<li>327</li>
				<li>150</li>
				<li>507</li>
				<li>341</li>
				<li>363</li>
				<li>348</li>
				<li>492</li>
				<li>137</li>
				<li>311</li>
				<li>2,976</li>
			</ul>
			<ul class="dataListTitle redData">
				<li>RED</li>
				<li>301</li>
				<li>124</li>
				<li>468</li>
				<li>306</li>
				<li>319</li>
				<li>327</li>
				<li>454</li>
				<li>127</li>
				<li>279</li>
				<li>2,705</li>
			</ul>
			<ul class="dataListTitle">
				<li>PAR</li>
				<li>4</li>
				<li>3</li>
				<li>5</li>
				<li>4</li>
				<li>4</li>
				<li>4</li>
				<li>5</li>
				<li>3</li>
				<li>4</li>
				<li>36</li>
			</ul>
			<ul class="dataListTitle">
				<li>HANDCAP</li>
				<li>14</li>
				<li>10</li>
				<li>6</li>
				<li>8</li>
				<li>2</li>
				<li>4</li>
				<li>12</li>
				<li>16</li>
				<li>18</li>			
				<li>-</li>
			</ul>
		</div>
		
		
	</div><!-- contents End -->
</div>

<jsp:include page="../include/footer-quick.jsp" flush="true" />
<jsp:include page="../include/footer.jsp" flush="true" />