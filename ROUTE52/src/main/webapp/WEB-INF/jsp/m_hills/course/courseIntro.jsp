<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="../include/header.jsp" />

<link rel="stylesheet" type="text/css" href="<c:url value='/css/m_hills/content.css'/>">

<div id="wrap">
	<div class="mainTitle">
		<img src="<c:url value='/images/m_hills/titleDot.png'/>" alt=""> 코스안내 <img src="<c:url value='/images/m_hills/titleDot.png'/>" alt="">
	</div>
	<ul class="myzoneTabList3">			
		<li class="on"><a href="<c:url value='/m_hills/course/courseIntro.do'/>">코스안내</a></li>
		<li class=""><a href="<c:url value='/m_hills/course/east1.do'/>">코스공략도</a></li>
		<li class=""><a href="javascript:alert('준비중입니다')">코스갤러리</a></li>
		<%-- <li class=""><a href="<c:url value='/m_hills/course/courseGallery.do'/>">코스갤러리</a></li> --%>
	</ul>

	<div class="contents">
		<div class="midTitleBox">
			<span class="commonDot"> 코스안내</span>		
		</div>
		<div class="courseBg">
			<div class="introBox">
				<img src="<c:url value='/images/m_hills/course/courseIntro.png'/>" alt="" class="courseIntroImg">
			</div>
			<ul class="courseInfoBox">
				<li class="holeExplainBox">
					<div class="holeExplain"><img src="<c:url value='/images/m_hills/balloon.png'/>" alt="" class="balloon">&nbsp;왼쪽 산자락의 화려한 관목과 그린 오른쪽의 연못이 한 눈에 내려다 보이는 홀로훅과 슬라이스가 모두
					염려되는 홀입니다. 티샷지점으로부터 210~250야드 거리의 페어웨이 오른쪽에 벙커가 있고 OB지역과 근접해<br>
					있으므로 왼쪽을 공략합니다. 세컨 샷은 그린 우측의 해저드를 주의해야 합니다. </div>
				</li>
			</ul>

			<ul class="courseInfoBox">
				<li class="dataTitle">서원힐스코스</li>
				<li class="holeExplainBox">
					<div class="holeExplain"><img src="<c:url value='/images/m_hills/balloon.png'/>" alt="" class="balloon">&nbsp;넒은 페어웨이를 자랑하는 이스트코스와 도전욕구를 자극시키는 환상적인 레이아웃을 품은 사우스코스, 긴 전장으로 시원하게 뻗어있는 웨스트 코스는 초보자부터 싱글골퍼까지 누구나 만족을 느낄 수 있는 코스로 조성되어 있습니다. </div>
				</li>
			</ul>
			<!-- East Course -->
			<div class="dataTitle">East Course</div>
			<div class="courseDataTable">
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
					<li>B</li>
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
					<li>B</li>
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
					<li>W</li>
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
					<li>G</li>
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
					<li>R</li>
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
					<li>HDCP</li>
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
			<div class="dataTitle">West Course</div>
			<div class="courseDataTable">				
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
					<li>B</li>
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
					<li>B</li>
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
					<li>W</li>
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
					<li>G</li>
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
					<li>R</li>
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
					<li>HDCP</li>
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
			<div class="dataTitle">South Course</div>
			<div class="courseDataTable">				
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
					<li>B</li>
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
					<li>B</li>
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
					<li>W</li>
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
					<li>G</li>
					<li>313</li>
					<li>473</li>
					<li>327</li>
					<li>264</li>
					<li>136</li>
					<li>437</li>
					<li>97</li>
					<li>35</li>
					<li>303</li>
					<li>2,706</li>
				</ul>
				<ul class="dataListTitle redData">
					<li>R</li>
					<li>313</li>
					<li>473</li>
					<li>291</li>
					<li>264</li>
					<li>136</li>
					<li>437</li>
					<li>97</li>
					<li>35</li>
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
					<li>HDCP</li>
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
		</div><!-- courseBg -->
		
	</div><!-- contents End -->
	
	<jsp:include page="../include/footer.jsp" flush="true" />
</div>   

</body>
</html>