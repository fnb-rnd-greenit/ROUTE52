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

<!--[animate]-->
<link rel="stylesheet" type="text/css" href="<c:url value='/css/valley/animate.css'/>">
<script src="<c:url value='/js/valley/wow.js'/>"></script>
<script type="text/javascript">
	var defaultUrl = "";
	var _ENV = {};
		_ENV.ctx = '';
		_ENV.service = 'PC';
		_ENV.user = {};
		_ENV.user.isLogin = false;
	var _IS_MAIN = false;
	/* 컨텐츠 fade in */
	wow = new WOW(
	{
		boxClass: 'fadeBox',
		animateClass: 'animated',
		offset: 100,
		callback: function(box) {
			//console.log("WOW: animating <" + box.tagName.toLowerCase() + ">")
		}
	});
	wow.init();
	/*//컨텐츠 fade in */
</script>
<!--//[animate]-->

<div class="lnbBox">
	<div class="lnb">
		<img src="<c:url value='/images/valley/ico-home.png'/>" alt="">
		<p>코스안내 &nbsp;&nbsp;&nbsp; ＞ <span>코스공략도</span></p>
	</div>
</div>

<div id="wrap">
	<div class="contents">
		<div class="myzoneTabList3">
			<a href="<c:url value='/valley/course/courseIntro.do'/>" class="">코스안내</a>
			<a href="<c:url value='/valley/course/course_seowon.do'/>" class="on">코스공략도</a>
			<a href="<c:url value='/valley/board/list.do?bbsType=36'/>">코스갤러리</a>
		</div>

		<div class="subTitle">
			<span class="title">코스공략도</span>
		</div>
		<div class="subLine"></div>
		
		<ul class="coursechoiceTab">
			<a href="<c:url value='/valley/course/course_seowon.do'/>" class="on">서원코스</a>
			<a href="<c:url value='/valley/course/course_valley.do'/>" class="">밸리코스</a>
		</ul>

		<div class="courseSeach">
			<ul class="courseSearchBox">
				<li class="fadeBox bounceIn"><button type="button" class="month on" onclick="javascript:courseTab(1);" id="1hole">1홀</button></li>
				<li class="fadeBox bounceIn"><button type="button" class="month" onclick="javascript:courseTab(2);" id="2hole">2홀</button></li>
				<li class="fadeBox bounceIn"><button type="button" class="month" onclick="javascript:courseTab(3);" id="3hole">3홀</button></li>
				<li class="fadeBox bounceIn"><button type="button" class="month" onclick="javascript:courseTab(4);" id="4hole">4홀</button></li>
				<li class="fadeBox bounceIn"><button type="button" class="month" onclick="javascript:courseTab(5);" id="5hole">5홀</button></li>
				<li class="fadeBox bounceIn"><button type="button" class="month" onclick="javascript:courseTab(6);" id="6hole">6홀</button></li>
				<li class="fadeBox bounceIn"><button type="button" class="month" onclick="javascript:courseTab(7);" id="7hole">7홀</button></li>
				<li class="fadeBox bounceIn"><button type="button" class="month" onclick="javascript:courseTab(8);" id="8hole">8홀</button></li>
				<li class="fadeBox bounceIn"><button type="button" class="month" onclick="javascript:courseTab(9);" id="9hole">9홀</button></li>
			</ul>
		</div>

		<div class="course course1" style="display:block">
			<div class="holeNumBox">
					<div class="holeNum">1</div>
					<ul class="holeText">
						<li class="hole1">hole</li>
						<li class="hole2">SEOWON COURSE</li>
					</ul>
			</div>

			<div class="courseImg"><img src="<c:url value='/images/valley/course/seowon1.png'/>" alt="서원 코스 이미지"></div>

			<ul class="courseInfoBox">
				<li class="videoBox">
					<video autoplay="" muted="true" loop="loop" id="bgvid" width="750" height="422">
						<source src="<c:url value='/video/valley/seowon1(2).mp4'/>" type="video/mp4"> 
					</video>
				</li>
				<li class="dataTitle">코스공략/제원</li>
				<li class="holeExplainBox">
					<div class="couseBalloon"><img src="<c:url value='/images/valley/balloon.png'/>" alt=""></div>
					<div class="holeExplain">왼쪽 산자락의 화려한 관목과 그린 오른쪽의 연못이 한 눈에 내려다 보이는 홀로훅과 슬라이스가 모두<br> 
					염려되는 홀입니다. 티샷지점으로부터 210~250야드 거리의 페어웨이 오른쪽에 벙커가 있고 OB지역과 근접해<br>
					있으므로 왼쪽을 공략합니다. 세컨 샷은 그린 우측의 해저드를 주의해야 합니다. </div>
				</li>
				<li class="holeInfo">
					<table class="courseTable">
						<caption> 코스 제원 </caption>
						<colgroup>
							<col width="*">
							<col width="*">
							<col width="*">
							<col width="*">
							<col width="*">
							<col width="*">
						</colgroup>
						<tbody>
							<tr>
								<th>PAR</th>
								<th>HANDCAP</th>
								<th class="blue">BLUE</th>
								<th>WHITE</th>
								<th class="gold">GOLD</th>
								<th class="red">RED</th>
							</tr>
							<tr>
								<td>4</td>
								<td>15</td>
								<td>390</td>
								<td>362</td>
								<td>307</td>
								<td>284</td>
							</tr>
						</tbody>
					</table>
				</li>
			</ul>
		</div>
		<div class="course course2" style="display:none">
			<div class="holeNumBox">
					<div class="holeNum">2</div>
					<ul class="holeText">
						<li class="hole1">hole</li>
						<li class="hole2">SEOWON COURSE</li>
					</ul>
			</div>

			<div class="courseImg"><img src="<c:url value='/images/valley/course/seowon2.png'/>" alt="서원 코스 이미지"></div>

			<ul class="courseInfoBox">
				<li class="videoBox">
					<video autoplay="" muted="true" loop="loop" id="bgvid" width="750" height="422">
						<source src="<c:url value='/video/valley/seowon2(2).mp4'/>" type="video/mp4">
					</video>
				</li>
				<li class="dataTitle">코스공략/제원</li>
				<li class="holeExplainBox">
					<div class="couseBalloon"><img src="<c:url value='/images/valley/balloon.png'/>" alt=""></div>
					<div class="holeExplain">확 트인 전경이 시원스러운 홀로 3개의 연못과 계곡의 폭포가 한 눈에 들어옵니다. 레귤러 티에서는 260야드<br> 
					지점의 페어웨이 양쪽 벙커 사이를 겨냥해야 하며, 프론트티에서는 페어웨이 중간이 있는 280야드 개울지를<br>
					고려해야 합니다.</div>
				</li>
				<li class="holeInfo">
					<table class="courseTable">
						<caption> 코스 제원 </caption>
						<colgroup>
							<col width="*">
							<col width="*">
							<col width="*">
							<col width="*">
							<col width="*">
							<col width="*">
						</colgroup>
						<tbody>
							<tr>
								<th>PAR</th>
								<th>HANDCAP</th>
								<th class="blue">BLUE</th>
								<th>WHITE</th>
								<th class="gold">GOLD</th>
								<th class="red">RED</th>
							</tr>
							<tr>
								<td>5</td>
								<td>9</td>
								<td>548</td>
								<td>514</td>
								<td>471</td>
								<td>451</td>
							</tr>
						</tbody>
					</table>
				</li>
			</ul>
		</div>
		<div class="course course3" style="display:none">
			<div class="holeNumBox">
					<div class="holeNum">3</div>
					<ul class="holeText">
						<li class="hole1">hole</li>
						<li class="hole2">SEOWON COURSE</li>
					</ul>
			</div>

			<div class="courseImg"><img src="<c:url value='/images/valley/course/seowon3.png'/>" alt="서원 코스 이미지"></div>

			<ul class="courseInfoBox">
				<li class="videoBox">
					<video autoplay="" muted="true" loop="loop" id="bgvid" width="750" height="422">
						<source src="<c:url value='/video/valley/seowon3(2).mp4'/>" type="video/mp4">
					</video>
				</li>
				<li class="dataTitle">코스공략/제원</li>
				<li class="holeExplainBox">
					<div class="couseBalloon"><img src="<c:url value='/images/valley/balloon.png'/>" alt=""></div>
					<div class="holeExplain">슬라이스 홀로서 오른쪽 계곡 지점의 페어웨이가 좁아지기 때문에 티샷은 비거리와 함께 정확성이 요구된다.<br>
					세컨 샷 역시 그린 오른쪽으로 자연계곡이 형성되어 있고 모래 벙커와 그린 주변에 그라스 벙커가 포진해<br>
					방심을 용납하지 않습니다.</div>
				</li>
				<li class="holeInfo">
					<table class="courseTable">
						<caption> 코스 제원 </caption>
						<colgroup>
							<col width="*">
							<col width="*">
							<col width="*">
							<col width="*">
							<col width="*">
							<col width="*">
						</colgroup>
						<tbody>
							<tr>
								<th>PAR</th>
								<th>HANDCAP</th>
								<th class="blue">BLUE</th>
								<th>WHITE</th>
								<th class="gold">GOLD</th>
								<th class="red">RED</th>
							</tr>
							<tr>
								<td>4</td>
								<td>3</td>
								<td>411</td>
								<td>373</td>
								<td>343</td>
								<td>308</td>
							</tr>
						</tbody>
					</table>
				</li>
			</ul>
		</div>
		<div class="course course4" style="display:none">
		<div class="holeNumBox">
					<div class="holeNum">4</div>
					<ul class="holeText">
						<li class="hole1">hole</li>
						<li class="hole2">SEOWON COURSE</li>
					</ul>
			</div>

			<div class="courseImg"><img src="<c:url value='/images/valley/course/seowon4.png'/>" alt="서원 코스 이미지"></div>

			<ul class="courseInfoBox">
				<li class="videoBox">
					<video autoplay="" muted="true" loop="loop" id="bgvid" width="750" height="422">
						<source src="<c:url value='/video/valley/seowon4(2).mp4'/>" type="video/mp4">
					</video>
				</li>
				<li class="dataTitle">코스공략/제원</li>
				<li class="holeExplainBox">
					<div class="couseBalloon"><img src="<c:url value='/images/valley/balloon.png'/>" alt=""></div>
					<div class="holeExplain">티잉그라운드 오른쪽에서부터 거대한 연못이 펼쳐지고 영산홍이 아름다운 자태를 뽐내는 포근하고<br> 
					부드러운 느낌의 홀입니다. 코스의 풍경이 골퍼들을 유혹하기에 충분하므로 안정된 플레이가 요구됩니다.</div>
				</li>
				<li class="holeInfo">
					<table class="courseTable">
						<caption> 코스 제원 </caption>
						<colgroup>
							<col width="*">
							<col width="*">
							<col width="*">
							<col width="*">
							<col width="*">
							<col width="*">
						</colgroup>
						<tbody>
							<tr>
								<th>PAR</th>
								<th>HANDCAP</th>
								<th class="blue">BLUE</th>
								<th>WHITE</th>
								<th class="gold">GOLD</th>
								<th class="red">RED</th>
							</tr>
							<tr>
								<td>3</td>
								<td>5</td>
								<td>206</td>
								<td>174</td>
								<td>151</td>
								<td>128</td>
							</tr>
						</tbody>
					</table>
				</li>
			</ul>
		</div>
		<div class="course course5" style="display:none">
			<div class="holeNumBox">
					<div class="holeNum">5</div>
					<ul class="holeText">
						<li class="hole1">hole</li>
						<li class="hole2">SEOWON COURSE</li>
					</ul>
			</div>

			<div class="courseImg"><img src="<c:url value='/images/valley/course/seowon5.png'/>" alt="서원 코스 이미지"></div>

			<ul class="courseInfoBox">
				<li class="videoBox">
					<video autoplay="" muted="true" loop="loop" id="bgvid" width="750" height="422">
						<source src="<c:url value='/video/valley/seowon5(2).mp4'/>" type="video/mp4">
					</video>
				</li>
				<li class="dataTitle">코스공략/제원</li>
				<li class="holeExplainBox">
					<div class="couseBalloon"><img src="<c:url value='/images/valley/balloon.png'/>" alt=""></div>
					<div class="holeExplain">비교적 거리가 짧은 파 4홀입니다.<br> 
					페어웨이가 넓고 평탄해 좋은 성과를 기대할 수 있으므로 타수를 만회하는 전환의 계기로 활용할 수 있습니다.</div>
				</li>
				<li class="holeInfo">
					<table class="courseTable">
						<caption> 코스 제원 </caption>
						<colgroup>
							<col width="*">
							<col width="*">
							<col width="*">
							<col width="*">
							<col width="*">
							<col width="*">
						</colgroup>
						<tbody>
							<tr>
								<th>PAR</th>
								<th>HANDCAP</th>
								<th class="blue">BLUE</th>
								<th>WHITE</th>
								<th class="gold">GOLD</th>
								<th class="red">RED</th>
							</tr>
							<tr>
								<td>4</td>
								<td>17</td>
								<td>363</td>
								<td>331</td>
								<td>305</td>
								<td>278</td>
							</tr>
						</tbody>
					</table>
				</li>
			</ul>
		</div>
		<div class="course course6" style="display:none">
		<div class="holeNumBox">
					<div class="holeNum">6</div>
					<ul class="holeText">
						<li class="hole1">hole</li>
						<li class="hole2">SEOWON COURSE</li>
					</ul>
			</div>

			<div class="courseImg"><img src="<c:url value='/images/valley/course/seowon6.png'/>" alt="서원 코스 이미지"></div>

			<ul class="courseInfoBox">
				<li class="videoBox">
					<video autoplay="" muted="true" loop="loop" id="bgvid" width="750" height="422">
						<source src="<c:url value='/video/valley/seowon6(2).mp4'/>" type="video/mp4">
					</video>
				</li>
				<li class="dataTitle">코스공략/제원</li>
				<li class="holeExplainBox">
					<div class="couseBalloon"><img src="<c:url value='/images/valley/balloon.png'/>" alt=""></div>
					<div class="holeExplain">그린 오른쪽으로 넓은 연못과 비치 벙커가 자리해 청, 록, 백색의 아름다운 조화를 이루고 있습니다.<br> 
					티샷은 페어웨이 왼쪽의 벙커와 280야드 지점의 해저드 사이를 겨냥합니다. 페어웨이가 넓게 펼쳐저<br>
					골퍼들에게는 도전욕을 자극하지만 과욕은 금물입니다.</div>
				</li>
				<li class="holeInfo">
					<table class="courseTable">
						<caption> 코스 제원 </caption>
						<colgroup>
							<col width="*">
							<col width="*">
							<col width="*">
							<col width="*">
							<col width="*">
							<col width="*">
						</colgroup>
						<tbody>
							<tr>
								<th>PAR</th>
								<th>HANDCAP</th>
								<th class="blue">BLUE</th>
								<th>WHITE</th>
								<th class="gold">GOLD</th>
								<th class="red">RED</th>
							</tr>
							<tr>
								<td>4</td>
								<td>1</td>
								<td>413</td>
								<td>399</td>
								<td>340</td>
								<td>297</td>
							</tr>
						</tbody>
					</table>
				</li>
			</ul>
		</div>
		<div class="course course7" style="display:none">
			<div class="holeNumBox">
					<div class="holeNum">7</div>
					<ul class="holeText">
						<li class="hole1">hole</li>
						<li class="hole2">SEOWON COURSE</li>
					</ul>
			</div>

			<div class="courseImg"><img src="<c:url value='/images/valley/course/seowon7.png'/>" alt="서원 코스 이미지"></div>

			<ul class="courseInfoBox">
				<li class="videoBox">
					<video autoplay="" muted="true" loop="loop" id="bgvid" width="750" height="422">
						<source src="<c:url value='/video/valley/seowon7(2).mp4'/>" type="video/mp4">
					</video>
				</li>
				<li class="dataTitle">코스공략/제원</li>
				<li class="holeExplainBox">
					<div class="couseBalloon"><img src="<c:url value='/images/valley/balloon.png'/>" alt=""></div>
					<div class="holeExplain">코스가 전체적으로 왼쪽으로 굽은 도그렉홀로 점진적 변화가 있는 오르막 경사의 홀입니다.<br> 
					거리가 만만치 않은 홀로 적절한 기량을 발휘해야하며 세컨 샷은 페어웨이 왼쪽의 법면을 주의해야 합니다.</div>
				</li>
				<li class="holeInfo">
					<table class="courseTable">
						<caption> 코스 제원 </caption>
						<colgroup>
							<col width="*">
							<col width="*">
							<col width="*">
							<col width="*">
							<col width="*">
							<col width="*">
						</colgroup>
						<tbody>
							<tr>
								<th>PAR</th>
								<th>HANDCAP</th>
								<th class="blue">BLUE</th>
								<th>WHITE</th>
								<th class="gold">GOLD</th>
								<th class="red">RED</th>
							</tr>
							<tr>
								<td>5</td>
								<td>7</td>
								<td>553</td>
								<td>522</td>
								<td>490</td>
								<td>458</td>
							</tr>
						</tbody>
					</table>
				</li>
			</ul>
		</div>
		<div class="course course8" style="display:none">
			<div class="holeNumBox">
					<div class="holeNum">8</div>
					<ul class="holeText">
						<li class="hole1">hole</li>
						<li class="hole2">SEOWON COURSE</li>
					</ul>
			</div>

			<div class="courseImg"><img src="<c:url value='/images/valley/course/seowon8.png'/>" alt="서원 코스 이미지"></div>

			<ul class="courseInfoBox">
				<li class="videoBox">
					<video autoplay="" muted="true" loop="loop" id="bgvid" width="750" height="422">
						<source src="<c:url value='/video/valley/seowon8(2).mp4'/>" type="video/mp4">
					</video>
				</li>
				<li class="dataTitle">코스공략/제원</li>
				<li class="holeExplainBox">
					<div class="couseBalloon"><img src="<c:url value='/images/valley/balloon.png'/>" alt=""></div>
					<div class="holeExplain">레귤러 티에서부터 그린의 너머까지 홀의 왼쪽에 자리한 거대한 연못이 감탄을 자아내는 홀입니다.<br> 
					아일랜드 티에서의 느낌이 특별한 홀입니다.</div>
				</li>
				<li class="holeInfo">
					<table class="courseTable">
						<caption> 코스 제원 </caption>
						<colgroup>
							<col width="*">
							<col width="*">
							<col width="*">
							<col width="*">
							<col width="*">
							<col width="*">
						</colgroup>
						<tbody>
							<tr>
								<th>PAR</th>
								<th>HANDCAP</th>
								<th class="blue">BLUE</th>
								<th>WHITE</th>
								<th class="gold">GOLD</th>
								<th class="red">RED</th>
							</tr>
							<tr>
								<td>3</td>
								<td>11</td>
								<td>185</td>
								<td>153</td>
								<td>121</td>
								<td>98</td>
							</tr>
						</tbody>
					</table>
				</li>
			</ul>
		</div>
		<div class="course course9" style="display:none">
			<div class="holeNumBox">
					<div class="holeNum">9</div>
					<ul class="holeText">
						<li class="hole1">hole</li>
						<li class="hole2">SEOWON COURSE</li>
					</ul>
			</div>

			<div class="courseImg"><img src="<c:url value='/images/valley/course/seowon9.png'/>" alt="서원 코스 이미지"></div>

			<ul class="courseInfoBox">
				<li class="videoBox">
					<video autoplay="" muted="true" loop="loop" id="bgvid" width="750" height="422">
						<source src="<c:url value='/video/valley/seowon9(2).mp4'/>" type="video/mp4">
					</video>
				</li>
				<li class="dataTitle">코스공략/제원</li>
				<li class="holeExplainBox">
					<div class="couseBalloon"><img src="<c:url value='/images/valley/balloon.png'/>" alt=""></div>
					<div class="holeExplain">티샷에 따라 성공적인 세컨 샷을 기대할 수 있으므로 전략적이고 정확한 티샷이 요구됩니다.<br> 
					페어웨이 오른쪽으로 이어져 있으므로 세컨샷은 그린 왼쪽의 벙커를 보고 날려야 합니다.</div>
				</li>
				<li class="holeInfo">
					<table class="courseTable">
						<caption> 코스 제원 </caption>
						<colgroup>
							<col width="*">
							<col width="*">
							<col width="*">
							<col width="*">
							<col width="*">
							<col width="*">
						</colgroup>
						<tbody>
							<tr>
								<th>PAR</th>
								<th>HANDCAP</th>
								<th class="blue">BLUE</th>
								<th>WHITE</th>
								<th class="gold">GOLD</th>
								<th class="red">RED</th>
							</tr>
							<tr>
								<td>4</td>
								<td>13</td>
								<td>388</td>
								<td>356</td>
								<td>336</td>
								<td>291</td>
							</tr>
						</tbody>
					</table>
				</li>
			</ul>
		</div>
		
		
	</div><!-- contents End -->
</div>

<jsp:include page="../include/footer-quick.jsp" flush="true" />
<jsp:include page="../include/footer.jsp" flush="true" />