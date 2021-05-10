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
		<img src="<c:url value='/images/hills/ico-home.png'/>" alt="">
		<p>코스안내 &nbsp;&nbsp;&nbsp; ＞ <span>코스안내</span></p>
	</div>
</div>

<div id="wrap">
	<div class="contents">
		<div class="myzoneTabList2">
			<a href="<c:url value='/hills/course/courseIntro.do'/>" class="on">코스안내</a>
			<a href="<c:url value='/hills/course/course_west.do'/>" class="">코스공략도</a>
			<%-- <a href="<c:url value='/hills/board/list.do?bbsType=36'/>">코스갤러리</a> --%>
		</div>
		
		<div class="subTitle">
			<span class="title">코스안내</span>
		</div>
		<div class="subLine"></div>

		<div class="grayBg">
			<img src="<c:url value='/images/hills/course/courseIntro.png'/>" alt="" class="courseIntroImg" usemap="#Map">
			<map name="Map" id="Map">
  <area shape="poly" onfocus='blur()' coords="147,159,161,225,209,248,267,184,262,137,287,102,284,48,250,36,238,26,210,31,202,46,203,63,206,81,182,83,163,70,152,71,133,88,133,106,153,123,147,159" href="<c:url value='/hills/course/course_east.do'/>" >
  <area shape="poly" onfocus='blur()' coords="140,171,153,232,140,261,172,300,193,365,170,417,137,432,92,386,80,377,70,375,50,384,29,376,15,351,28,332,58,328,68,319,69,276" href="<c:url value='/hills/course/course_west.do'/>" >
  <area shape="poly" onfocus='blur()' coords="274,250,310,214,263,263,272,285,277,307,286,310,299,312,308,309,347,324,360,334,382,332,412,321,432,303,435,286,410,238,381,219,420,221,436,207,441,185,433,174,415,165,396,173,390,184,373,192,345,145,339,118,324,127,311,139,302,159,301,184,263,264" href="<c:url value='/hills/course/course_south.do'/>" />
</map>
		</div>

		<div class="courseIntroBox">
			<img src="<c:url value='/images/hills/balloon.png'/>" alt="" class="balloon" style="outline:none; border:none;">
			<p class="courseIntroText">		
				서원힐스의 코스는 7,367야드의 규모를 자랑합니다. <br>
				단일홀로 최장 홀인 웨스트 8번홀 ( 파5 최대 640야드 )는 골퍼들의 도전욕구를 한층 강하게 자극합니다. <br>
				다양하고 다이나믹해진 코스설계 및 사계절 푸른 잔디를 경험 할 수 있도록 페어웨이를 양 잔디로 조성하여 수준 높은 라운딩을 원하는 골퍼들의 욕구를 충족시켜 드리고<br> 있습니다. <br>
				명품코스의 라운드를 경험해 보십시오. <br>
			</p>
		</div>
		<div class="courseDataTitle">서원힐스코스</div>
		<div class="courseIntroBox">
			<img src="<c:url value='/images/hills/balloon.png'/>" alt="" class="balloon2">
			<p class="courseIntroText">		
			넒은 페어웨이를 자랑하는 이스트코스와 도전욕구를 자극시키는 환상적인 레이아웃을 품은 사우스코스, 긴 전장으로 시원하게 뻗어있는 웨스트 코스는 초보자부터 싱글골퍼까지 누구나 만족을 느낄 수 있는 코스로 조성되어 있습니다.<br>
			</p>
		</div>

		<!-- East Course -->
		<div class="courseDataTable">
			<div class="dataTitle">East Course</div>
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
			<ul class="dataListTitle blackData">
				<li>BLACK</li>
				<li>397</li>
				<li>185</li>
				<li>362</li>
				<li>417</li>
				<li>593</li>
				<li>410</li>
				<li>375</li>
				<li>212</li>
				<li>572</li>
				<li>3,523</li>
			</ul>
			<ul class="dataListTitle blueData">
				<li>BLUE</li>
				<li>372</li>
				<li>160</li>
				<li>333</li>
				<li>391</li>
				<li>572</li>
				<li>389</li>
				<li>347</li>
				<li>189</li>
				<li>542</li>
				<li>3,295</li>
			</ul>
			<ul class="dataListTitle">
				<li>WHITE</li>
				<li>347</li>
				<li>132</li>
				<li>317</li>
				<li>362</li>
				<li>533</li>
				<li>354</li>
				<li>313</li>
				<li>158</li>
				<li>508</li>
				<li>3,024</li>
			</ul>
			<ul class="dataListTitle goldData">
				<li>GOLD</li>
				<li>318</li>
				<li>132</li>
				<li>290</li>
				<li>323</li>
				<li>485</li>
				<li>310</li>
				<li>281</li>
				<li>123</li>
				<li>474</li>
				<li>2,736</li>
			</ul>
			<ul class="dataListTitle redData">
				<li>RED</li>
				<li>318</li>
				<li>132</li>
				<li>290</li>
				<li>323</li>
				<li>485</li>
				<li>310</li>
				<li>281</li>
				<li>123</li>
				<li>474</li>
				<li>2,736</li>
			</ul>
			<ul class="dataListTitle">
				<li>PAR</li>
				<li>4</li>
				<li>3</li>
				<li>4</li>
				<li>4</li>
				<li>5</li>
				<li>4</li>
				<li>4</li>
				<li>3</li>
				<li>5</li>
				<li>36</li>
			</ul>
			<ul class="dataListTitle">
				<li>HANDCAP</li>
				<li>7</li>
				<li>5</li>
				<li>8</li>
				<li>1</li>
				<li>4</li>
				<li>2</li>
				<li>6</li>
				<li>3</li>
				<li>9</li>
				<li></li>
			</ul>
		</div>

		<!-- West Course-->
		<div class="courseDataTable">
			<div class="dataTitle">West Course</div>
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
			<ul class="dataListTitle blackData">
				<li>BLACK</li>
				<li>592</li>
				<li>479</li>
				<li>432</li>
				<li>165</li>
				<li>421</li>
				<li>362</li>
				<li>201</li>
				<li>640</li>
				<li>393</li>
				<li>3,685</li>
			</ul>
			<ul class="dataListTitle blueData">
				<li>BLUE</li>
				<li>569</li>
				<li>448</li>
				<li>399</li>
				<li>140</li>
				<li>383</li>
				<li>336</li>
				<li>180</li>
				<li>618</li>
				<li>369</li>
				<li>3,442</li>
			</ul>
			<ul class="dataListTitle">
				<li>WHITE</li>
				<li>543</li>
				<li>422</li>
				<li>361</li>
				<li>120</li>
				<li>347</li>
				<li>301</li>
				<li>153</li>
				<li>595</li>
				<li>345</li>
				<li>3,187</li>
			</ul>
			<ul class="dataListTitle goldData">
				<li>GOLD</li>
				<li>518</li>
				<li>386</li>
				<li>324</li>
				<li>103</li>
				<li>300</li>
				<li>270</li>
				<li>128</li>
				<li>562</li>
				<li>312</li>
				<li>2,903</li>
			</ul>
			<ul class="dataListTitle redData">
				<li>RED</li>
				<li>494</li>
				<li>345</li>
				<li>324</li>
				<li>103</li>
				<li>300</li>
				<li>270</li>
				<li>128</li>
				<li>529</li>
				<li>283</li>
				<li>2,776</li>
			</ul>
			<ul class="dataListTitle">
				<li>PAR</li>
				<li>5</li>
				<li>4</li>
				<li>4</li>
				<li>3</li>
				<li>4</li>
				<li>4</li>
				<li>3</li>
				<li>5</li>
				<li>4</li>
				<li>36</li>
			</ul>
			<ul class="dataListTitle">
				<li>HANDCAP</li>
				<li>6</li>
				<li>1</li>
				<li>5</li>
				<li>7</li>
				<li>4</li>
				<li>8</li>
				<li>3</li>
				<li>2</li>
				<li>9</li>
				<li></li>
			</ul>
		</div>

		<!-- South Course-->
		<div class="courseDataTable">
			<div class="dataTitle">South Course</div>
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
			<ul class="dataListTitle blackData">
				<li>BLACK</li>
				<li>442</li>
				<li>594</li>
				<li>426</li>
				<li>394</li>
				<li>215</li>
				<li>554</li>
				<li>191</li>
				<li>450</li>
				<li>416</li>
				<li>3,682</li>
			</ul>
			<ul class="dataListTitle blueData">
				<li>BLUE</li>
				<li>416</li>
				<li>561</li>
				<li>397</li>
				<li>370</li>
				<li>196</li>
				<li>518</li>
				<li>171</li>
				<li>422</li>
				<li>388</li>
				<li>3,439</li>
			</ul>
			<ul class="dataListTitle">
				<li>WHITE</li>
				<li>391</li>
				<li>519</li>
				<li>365</li>
				<li>316</li>
				<li>164</li>
				<li>480</li>
				<li>138</li>
				<li>395</li>
				<li>345</li>
				<li>3,112</li>
			</ul>
			<ul class="dataListTitle goldData">
				<li>GOLD</li>
				<li>313</li>
				<li>473</li>
				<li>327</li>
				<li>264</li>
				<li>136</li>
				<li>437</li>
				<li>97</li>
				<li>356</li>
				<li>303</li>
				<li>2,706</li>
			</ul>
			<ul class="dataListTitle redData">
				<li>RED</li>
				<li>313</li>
				<li>473</li>
				<li>291</li>
				<li>264</li>
				<li>136</li>
				<li>437</li>
				<li>97</li>
				<li>356</li>
				<li>303</li>
				<li>2,670</li>
			</ul>
			<ul class="dataListTitle">
				<li>PAR</li>
				<li>4</li>
				<li>5</li>
				<li>4</li>
				<li>4</li>
				<li>3</li>
				<li>5</li>
				<li>3</li>
				<li>4</li>
				<li>4</li>
				<li>36</li>
			</ul>
			<ul class="dataListTitle">
				<li>HANDCAP</li>
				<li>2</li>
				<li>6</li>
				<li>5</li>
				<li>7</li>
				<li>4</li>
				<li>9</li>
				<li>3</li>
				<li>1</li>
				<li>8</li>
				<li></li>
			</ul>
		</div>
	</div><!-- contents End -->
</div>

<jsp:include page="../include/footer-quick.jsp" flush="true" />
<jsp:include page="../include/footer.jsp" flush="true" />