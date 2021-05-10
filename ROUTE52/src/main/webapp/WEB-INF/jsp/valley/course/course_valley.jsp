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
			<a href="<c:url value='/valley/course/course_seowon.do'/>" class="">서원코스</a>
			<a href="<c:url value='/valley/course/course_valley.do'/>" class="on">밸리코스</a>
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
						<li class="hole2">VALLEY COURSE</li>
					</ul>
			</div>

			<div class="courseImg"><img src="<c:url value='/images/valley/course/valley1.png'/>" alt="밸리 코스 이미지"></div>

			<ul class="courseInfoBox">
				<li class="videoBox">
					<video autoplay="" muted="true" loop="loop" id="bgvid" width="750" height="422">
						<source src="<c:url value='/video/valley/valley1(2).mp4'/>" type="video/mp4"> 
					</video>
				</li>
				<li class="dataTitle">코스공략/제원</li>
				<li class="holeExplainBox">
					<div class="couseBalloon"><img src="<c:url value='/images/valley/balloon.png'/>" alt=""></div>
					<div class="holeExplain">전체적으로 왼쪽으로 굽은 도그렉홀 티샷은 오른쪽의 큰 잣나무 부근을 겨냥합니다. 티샷 낙하지점의 페어웨이<br> 
					기복이 심해 주의해야 하지만 티샷에만 성공하면 세컨 샷 공략은 무난한 홀로 안정된 플레이가 가능합니다.</div>
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
								<td>14</td>
								<td>378</td>
								<td>353</td>
								<td>327</td>
								<td>301</td>
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
						<li class="hole2">VALLEY COURSE</li>
					</ul>
			</div>

			<div class="courseImg"><img src="<c:url value='/images/valley/course/valley2.png'/>" alt="밸리 코스 이미지"></div>

			<ul class="courseInfoBox">
				<li class="videoBox">
					<video autoplay="" muted="true" loop="loop" id="bgvid" width="750" height="422">
						<source src="<c:url value='/video/valley/valley2(2).mp4'/>" type="video/mp4"> 
					</video>
				</li>
				<li class="dataTitle">코스공략/제원</li>
				<li class="holeExplainBox">
					<div class="couseBalloon"><img src="<c:url value='/images/valley/balloon.png'/>" alt=""></div>
					<div class="holeExplain">그린과 왼쪽 연못 사이에 굽은 그라스벙커와 샌드벙커가 교대로 도사리고 있어 정확한 샷이 요구되는 홀입니다.<br> 
					티샷이 그린 왼쪽으로 가게되면 파 플레이도 어려워지므로 주의해야 합니다.</div>
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
								<td>10</td>
								<td>205</td>
								<td>179</td>
								<td>150</td>
								<td>124</td>
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
						<li class="hole2">VALLEY COURSE</li>
					</ul>
			</div>

			<div class="courseImg"><img src="<c:url value='/images/valley/course/valley3.png'/>" alt="밸리 코스 이미지"></div>

			<ul class="courseInfoBox">
				<li class="videoBox">
					<video autoplay="" muted="true" loop="loop" id="bgvid" width="750" height="422">
						<source src="<c:url value='/video/valley/valley3(2).mp4'/>" type="video/mp4"> 
					</video>
				</li>
				<li class="dataTitle">코스공략/제원</li>
				<li class="holeExplainBox">
					<div class="couseBalloon"><img src="<c:url value='/images/valley/balloon.png'/>" alt=""></div>
					<div class="holeExplain">약간 오른쪽으로 굽은 도그렉홀로 상당히 긴 홀입니다. 티샷은 300야드 거리의 왼쪽 느티나무 선상의 우측 언덕<br> 
					끝지점을 겨냥하되 왼쪽의 샌드벙커를 주의해야 합니다. 그린 앞에는 대형 벙커가 있으므로 세컨 샷과 서드 샷<br>
					모두 정확도가 요구됩니다.</div>
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
								<td>6</td>
								<td>589</td>
								<td>551</td>
								<td>507</td>
								<td>468</td>
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
						<li class="hole2">VALLEY COURSE</li>
					</ul>
			</div>

			<div class="courseImg"><img src="<c:url value='/images/valley/course/valley4.png'/>" alt="밸리 코스 이미지"></div>

			<ul class="courseInfoBox">
				<li class="videoBox">
					<video autoplay="" muted="true" loop="loop" id="bgvid" width="750" height="422">
						<source src="<c:url value='/video/valley/valley4(2).mp4'/>" type="video/mp4"> 
					</video>
				</li>
				<li class="dataTitle">코스공략/제원</li>
				<li class="holeExplainBox">
					<div class="couseBalloon"><img src="<c:url value='/images/valley/balloon.png'/>" alt=""></div>
					<div class="holeExplain">코스가 평탄해 부담감 없이 플레이할 수 있는 코스로 자작, 단풍, 느티나무 수림대가 형성되어 있어<br> 
					 편안한 분위기를 더합니다. 슬라이스를 주의해야 하며 세컨 샷은 카트도로 끝의 그늘집을 보고 날립니다.</div>
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
								<td>8</td>
								<td>401</td>
								<td>373</td>
								<td>341</td>
								<td>306</td>
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
						<li class="hole2">VALLEY COURSE</li>
					</ul>
			</div>

			<div class="courseImg"><img src="<c:url value='/images/valley/course/valley5.png'/>" alt="밸리 코스 이미지"></div>

			<ul class="courseInfoBox">
				<li class="videoBox">
					<video autoplay="" muted="true" loop="loop" id="bgvid" width="750" height="422">
						<source src="<c:url value='/video/valley/valley5(2).mp4'/>" type="video/mp4"> 
					</video>
				</li>
				<li class="dataTitle">코스공략/제원</li>
				<li class="holeExplainBox">
					<div class="couseBalloon"><img src="<c:url value='/images/valley/balloon.png'/>" alt=""></div>
					<div class="holeExplain">티잉그라운드 앞에서 내려다보이는 해저드가 다소 부담스러운 홀입니다. 그러나 기량에 따라 적절한 공략지점을<br> 
					선택하면 순조롭게 플레이할 수 있습니다. 티샷은 해저드의 오른쪽 끝지점을 보고 날리는 것이 좋고 해저드 뒤의<br>
					벙커를 주의해야 합니다.</div>
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
								<td>2</td>
								<td>428</td>
								<td>394</td>
								<td>363</td>
								<td>319</td>
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
						<li class="hole2">VALLEY COURSE</li>
					</ul>
			</div>

			<div class="courseImg"><img src="<c:url value='/images/valley/course/valley6.png'/>" alt="밸리 코스 이미지"></div>

			<ul class="courseInfoBox">
				<li class="videoBox">
					<video autoplay="" muted="true" loop="loop" id="bgvid" width="750" height="422">
						<source src="<c:url value='/video/valley/valley6(2).mp4'/>" type="video/mp4"> 
					</video>
				</li>
				<li class="dataTitle">코스공략/제원</li>
				<li class="holeExplainBox">
					<div class="couseBalloon"><img src="<c:url value='/images/valley/balloon.png'/>" alt=""></div>
					<div class="holeExplain">완만한 오르막 코스로 티샷과 세컨 샷 모두 정확해야 좋은 결과를 얻을 수 있으며 욕심을 부리면 낭패를<br> 
					 볼 수 있습니다. 티샷은 155~180야드 지점의 벙커 왼쪽 페어웨이를 공략하되 슬라이스를 조심해야 합니다.</div>
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
								<td>4</td>
								<td>420</td>
								<td>383</td>
								<td>348</td>
								<td>327</td>
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
						<li class="hole2">VALLEY COURSE</li>
					</ul>
			</div>

			<div class="courseImg"><img src="<c:url value='/images/valley/course/valley7.png'/>" alt="밸리 코스 이미지"></div>

			<ul class="courseInfoBox">
				<li class="videoBox">
					<video autoplay="" muted="true" loop="loop" id="bgvid" width="750" height="422">
						<source src="<c:url value='/video/valley/valley7(2).mp4'/>" type="video/mp4"> 
					</video>
				</li>
				<li class="dataTitle">코스공략/제원</li>
				<li class="holeExplainBox">
					<div class="couseBalloon"><img src="<c:url value='/images/valley/balloon.png'/>" alt=""></div>
					<div class="holeExplain">가장 긴 롱기스트 홀. 페어웨이가 넓고 완만하게 펼쳐져 있어 장타자에게 유리합니다.<br> 
					 골퍼들에게 마음껏 실력을 펼치고픈 도전 욕구를 불러 일으켜 역전의 기회가 있는 홀로 티샷은 페어웨이 중앙보다<br>
					 약간 왼쪽을 공략합니다.</div>
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
								<td>12</td>
								<td>569</td>
								<td>535</td>
								<td>492</td>
								<td>454</td>
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
						<li class="hole2">VALLEY COURSE</li>
					</ul>
			</div>

			<div class="courseImg"><img src="<c:url value='/images/valley/course/valley8.png'/>" alt="밸리 코스 이미지"></div>

			<ul class="courseInfoBox">
				<li class="videoBox">
					<video autoplay="" muted="true" loop="loop" id="bgvid" width="750" height="422">
						<source src="<c:url value='/video/valley/valley8(2).mp4'/>" type="video/mp4"> 
					</video>
				</li>
				<li class="dataTitle">코스공략/제원</li>
				<li class="holeExplainBox">
					<div class="couseBalloon"><img src="<c:url value='/images/valley/balloon.png'/>" alt=""></div>
					<div class="holeExplain">계단식으로 배치된 티잉그라운드와 메타세콰이아가 늘어선 풍경이 아름다우면서 도전욕을 자극합니다.<br> 
					왼쪽의 연못으로 인해 아일랜드 그린을 연상시키는 홀로 정확한 거리감이 필요하지만 오른쪽이 개방되어 있으므로 편안하게 공략하면
					좋은 결과를 기대할 수 있습니다.</div>
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
								<td>16</td>
								<td>184</td>
								<td>177</td>
								<td>137</td>
								<td>127</td>
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
						<li class="hole2">VALLEY COURSE</li>
					</ul>
			</div>

			<div class="courseImg"><img src="<c:url value='/images/valley/course/valley9.png'/>" alt="밸리 코스 이미지"></div>

			<ul class="courseInfoBox">
				<li class="videoBox">
					<video autoplay="" muted="true" loop="loop" id="bgvid" width="750" height="422">
						<source src="<c:url value='/video/valley/valley9(2).mp4'/>" type="video/mp4"> 
					</video>
				</li>
				<li class="dataTitle">코스공략/제원</li>
				<li class="holeExplainBox">
					<div class="couseBalloon"><img src="<c:url value='/images/valley/balloon.png'/>" alt=""></div>
					<div class="holeExplain">인코스의 마지막 홀로 평탄한 코스이므로 편안한 마음으로 파를 기록할 수 있습니다.<br> 
					티샷은 티잉그라운드에서 180야드 거리에 있는 벙커를 기준으로 날리되 필요 이상의 욕심을 부리기 보다<br> 
					차분한 마음으로 라운드를 마무리합니다.</div>
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
								<td>18</td>
								<td>379</td>
								<td>339</td>
								<td>311</td>
								<td>279</td>
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