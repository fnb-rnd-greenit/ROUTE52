<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="../include/header.jsp" />
<jsp:include page="../include/subTop.jsp" />
<!--[animate]-->
<link rel="stylesheet" type="text/css" href="<c:url value='/css/hills/animate.css'/>">
<script src="<c:url value='/js/hills/wow.js'/>"></script>
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
		<img src="<c:url value='/images/hills/ico-home.png'/>" alt="">
		<p>코스안내 &nbsp;&nbsp;&nbsp; ＞ <span>코스공략도</span></p>
	</div>
</div>

<div id="wrap">
	<div class="contents">
		<div class="myzoneTabList2">
			<a href="<c:url value='/hills/course/courseIntro.do'/>" class="">코스안내</a>
			<a href="<c:url value='/hills/course/course_west.do'/>" class="on">코스공략도</a>
			<%-- <a href="<c:url value='/hills/board/list.do?bbsType=36'/>">코스갤러리</a> --%>
		</div>
		
		<div class="subTitle">
			<span class="title">코스공략도</span>
		</div>
		<div class="subLine"></div>
		
		<ul class="coursechoiceTab">
			<a href="<c:url value='/hills/course/course_east.do'/>" class="">이스트코스</a>
			<a href="<c:url value='/hills/course/course_west.do'/>" class="on">웨스트코스</a>
			<a href="<c:url value='/hills/course/course_south.do'/>" class="">사우스코스</a> 
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
						<li class="hole2">WEST COURSE</li>
					</ul>
			</div>

			<div class="courseImg"><img src="<c:url value='/images/hills/course/west1.png'/>" alt="웨스트 코스 이미지"></div>

			<ul class="courseInfoBox">
				<li class="videoBox">
					<video autoplay="" muted="true" loop="loop" id="bgvid" width="750" height="422">
						<source src="<c:url value='/video/hills/west_1.mp4'/>" type="video/mp4"> 
					</video>
				</li>
				<li class="dataTitle">코스공략/제원</li>
				<li class="holeExplainBox">
					<div class="couseBalloon"><img src="<c:url value='/images/hills/balloon.png'/>" alt=""></div>
					<div class="holeExplain">슬라이스 발생시 우측 해저드가 삼켜 버릴 수 있는 홀이다. 티샷 방향은 페어웨이 벙커 우측 끝을<br>
					공략 하는게 유리하며 세컨샷은 그린 방향으로 공략 할 것을 명심 하여야 한다.</div>
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
							<col width="*">
						</colgroup>
						<tbody>
							<tr>
								<th>PAR</th>
								<th>HANDCAP</th>
								<th class="black">BLACK</th>
								<th class="blue">BLUE</th>
								<th>WHITE</th>
								<th class="gold">GOLD</th>
								<th class="red">RED</th>
							</tr>
							<tr>
								<td>5</td>
								<td></td>
								<td>592</td>
								<td>569</td>
								<td>543</td>
								<td>518</td>
								<td>494</td>
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
						<li class="hole2">WEST COURSE</li>
					</ul>
			</div>

			<div class="courseImg"><img src="<c:url value='/images/hills/course/west2.png'/>" alt="웨스트 코스 이미지"></div>

			<ul class="courseInfoBox">
				<li class="videoBox">
					<video autoplay="" muted="true" loop="loop" id="bgvid" width="750" height="422">
						<source src="<c:url value='/video/hills/west_2.mp4'/>" type="video/mp4"> 
					</video>
				</li>
				<li class="dataTitle">코스공략/제원</li>
				<li class="holeExplainBox">
					<div class="couseBalloon"><img src="<c:url value='/images/hills/balloon.png'/>" alt=""></div>
					<div class="holeExplain">티잉 그라운드 방향이 약간 우측을 향하는 홀 이므로 좌측을 공략 하는게 부담 없을 것이다.<br>
					그린 공략시 그린 앞 벙커만 유의 한다면 전체적으로 만족스러운 스코어를 얻을 수 있을 것이다.</div>
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
							<col width="*">
						</colgroup>
						<tbody>
							<tr>
								<th>PAR</th>
								<th>HANDCAP</th>
								<th class="black">BLACK</th>
								<th class="blue">BLUE</th>
								<th>WHITE</th>
								<th class="gold">GOLD</th>
								<th class="red">RED</th>
							</tr>
							<tr>
								<td>4</td>
								<td></td>
								<td>479</td>
								<td>448</td>
								<td>422</td>
								<td>386</td>
								<td>345</td>
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
						<li class="hole2">WEST COURSE</li>
					</ul>
			</div>

			<div class="courseImg"><img src="<c:url value='/images/hills/course/west3.png'/>" alt="웨스트 코스 이미지"></div>

			<ul class="courseInfoBox">
				<li class="videoBox">
					<video autoplay="" muted="true" loop="loop" id="bgvid" width="750" height="422">
						<source src="<c:url value='/video/hills/west_3.mp4'/>" type="video/mp4"> 
					</video>
				</li>
				<li class="dataTitle">코스공략/제원</li>
				<li class="holeExplainBox">
					<div class="couseBalloon"><img src="<c:url value='/images/hills/balloon.png'/>" alt=""></div>
					<div class="holeExplain">우측으로 흐르는 페어웨이 경사만 유의 한다면 무난한 홀이 될 것이다.<br>
					그린 공략시 벙커와 우측 OB는 고민해봐야 할 것이다.</div>
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
							<col width="*">
						</colgroup>
						<tbody>
							<tr>
								<th>PAR</th>
								<th>HANDCAP</th>
								<th class="black">BLACK</th>
								<th class="blue">BLUE</th>
								<th>WHITE</th>
								<th class="gold">GOLD</th>
								<th class="red">RED</th>
							</tr>
							<tr>
								<td>4</td>
								<td></td>
								<td>432</td>
								<td>399</td>
								<td>361</td>
								<td>324</td>
								<td>324</td>
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
						<li class="hole2">WEST COURSE</li>
					</ul>
			</div>

			<div class="courseImg"><img src="<c:url value='/images/hills/course/west4.png'/>" alt="웨스트 코스 이미지"></div>

			<ul class="courseInfoBox">
				<li class="videoBox">
					<video autoplay="" muted="true" loop="loop" id="bgvid" width="750" height="422">
						<source src="<c:url value='/video/hills/west_4.mp4'/>" type="video/mp4"> 
					</video>
				</li>
				<li class="dataTitle">코스공략/제원</li>
				<li class="holeExplainBox">
					<div class="couseBalloon"><img src="<c:url value='/images/hills/balloon.png'/>" alt=""></div>
					<div class="holeExplain">그린을 바로 공략 할 수 있는 홀로서 좌측 산쪽에서 우측으로 흐르는 경사를 유의해야 할 것이다.<br>
					그린 좌측에서 우측 거리는 약 40yd이며, 그린 중심 뒤쪽으로 여유 공간이 있기 때문에 짧은 것보다 여유있게<br>
					공략 해도 될 것이다.</div>
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
							<col width="*">
						</colgroup>
						<tbody>
							<tr>
								<th>PAR</th>
								<th>HANDCAP</th>
								<th class="black">BLACK</th>
								<th class="blue">BLUE</th>
								<th>WHITE</th>
								<th class="gold">GOLD</th>
								<th class="red">RED</th>
							</tr>
							<tr>
								<td>3</td>
								<td></td>
								<td>165</td>
								<td>140</td>
								<td>120</td>
								<td>103</td>
								<td>103</td>
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
						<li class="hole2">WEST COURSE</li>
					</ul>
			</div>

			<div class="courseImg"><img src="<c:url value='/images/hills/course/west5.png'/>" alt="웨스트 코스 이미지"></div>

			<ul class="courseInfoBox">
				<li class="videoBox">
					<video autoplay="" muted="true" loop="loop" id="bgvid" width="750" height="422">
						<source src="<c:url value='/video/hills/west_5.mp4'/>" type="video/mp4"> 
					</video>
				</li>
				<li class="dataTitle">코스공략/제원</li>
				<li class="holeExplainBox">
					<div class="couseBalloon"><img src="<c:url value='/images/hills/balloon.png'/>" alt=""></div>
					<div class="holeExplain">손에 땀이 절로 나는 우측 도그렉홀로서 좌측 벙커와 그늘집 방향으로 공략하는게 유리 할 수 있다.<br>
					앞벙커를 넘기려면 200야드(180m) 이상이기 때문에 우측 무리한 공략은 자제 하는게 좋을 듯하다.<br>
					그린 공략시 우측 해저드만 유의 한다면 그린은 무난하게 정복 할 수 있을 것이다.</div>
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
							<col width="*">
						</colgroup>
						<tbody>
							<tr>
								<th>PAR</th>
								<th>HANDCAP</th>
								<th class="black">BLACK</th>
								<th class="blue">BLUE</th>
								<th>WHITE</th>
								<th class="gold">GOLD</th>
								<th class="red">RED</th>
							</tr>
							<tr>
								<td>4</td>
								<td></td>
								<td>421</td>
								<td>383</td>
								<td>347</td>
								<td>300</td>
								<td>300</td>
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
						<li class="hole2">WEST COURSE</li>
					</ul>
			</div>

			<div class="courseImg"><img src="<c:url value='/images/hills/course/west6.png'/>" alt="웨스트 코스 이미지"></div>

			<ul class="courseInfoBox">
				<li class="videoBox">
					<video autoplay="" muted="true" loop="loop" id="bgvid" width="750" height="422">
						<source src="<c:url value='/video/hills/west_6.mp4'/>" type="video/mp4"> 
					</video>
				</li>
				<li class="dataTitle">코스공략/제원</li>
				<li class="holeExplainBox">
					<div class="couseBalloon"><img src="<c:url value='/images/hills/balloon.png'/>" alt=""></div>
					<div class="holeExplain">비교적 짧은 Par 4 홀이다.<br>
					멀리보이는 우측 벙커를 공략한 후 그린 중심 좌측을 공략한다면 편안하게 몸을 풀 수 있는 홀이 될 것이다.</div>
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
							<col width="*">
						</colgroup>
						<tbody>
							<tr>
								<th>PAR</th>
								<th>HANDCAP</th>
								<th class="black">BLACK</th>
								<th class="blue">BLUE</th>
								<th>WHITE</th>
								<th class="gold">GOLD</th>
								<th class="red">RED</th>
							</tr>
							<tr>
								<td>4</td>
								<td></td>
								<td>362</td>
								<td>336</td>
								<td>301</td>
								<td>270</td>
								<td>270</td>
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
						<li class="hole2">WEST COURSE</li>
					</ul>
			</div>

			<div class="courseImg"><img src="<c:url value='/images/hills/course/west7.png'/>" alt="웨스트 코스 이미지"></div>

			<ul class="courseInfoBox">
				<li class="videoBox">
					<video autoplay="" muted="true" loop="loop" id="bgvid" width="750" height="422">
						<source src="<c:url value='/video/hills/west_7.mp4'/>" type="video/mp4"> 
					</video>
				</li>
				<li class="dataTitle">코스공략/제원</li>
				<li class="holeExplainBox">
					<div class="couseBalloon"><img src="<c:url value='/images/hills/balloon.png'/>" alt=""></div>
					<div class="holeExplain">티잉 그라운드 앞쪽으로 큰 해저드가 있기 때문에 심리적으로 불안한 홀이라고 생각할 수 있지만,<br>
					두려움만 떨쳐 버린다면 좋은 결과를 얻을 수 있는 홀이다. 그린은 좌측에서 우측으로 경사가 심하게 흐르는 <br>
					핀 좌측을 보고 샷을 하는 전략을 펼쳐야 할 것이다. </div>
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
							<col width="*">
						</colgroup>
						<tbody>
							<tr>
								<th>PAR</th>
								<th>HANDCAP</th>
								<th class="black">BLACK</th>
								<th class="blue">BLUE</th>
								<th>WHITE</th>
								<th class="gold">GOLD</th>
								<th class="red">RED</th>
							</tr>
							<tr>
								<td>3</td>
								<td></td>
								<td>201</td>
								<td>180</td>
								<td>153</td>
								<td>128</td>
								<td>128</td>
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
						<li class="hole2">WEST COURSE</li>
					</ul>
			</div>

			<div class="courseImg"><img src="<c:url value='/images/hills/course/west8.png'/>" alt="웨스트 코스 이미지"></div>

			<ul class="courseInfoBox">
				<li class="videoBox">
					<video autoplay="" muted="true" loop="loop" id="bgvid" width="750" height="422">
						<source src="<c:url value='/video/hills/west_8.mp4'/>" type="video/mp4"> 
					</video>
				</li>
				<li class="dataTitle">코스공략/제원</li>
				<li class="holeExplainBox">
					<div class="couseBalloon"><img src="<c:url value='/images/hills/balloon.png'/>" alt=""></div>
					<div class="holeExplain">전체적으로 오르막 홀이므로 티샷 후 클럽 선택시 여유 있게 한클럽 이상 잡으면 좋을 것이다.<br>
					그린 공략시 오르막 때문에 경사면이 보이지 않을 것이며 가까워 보일 것이나 엣지부터 그린 중앙 까지는<br>
					거리가 있다.</div>
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
							<col width="*">
						</colgroup>
						<tbody>
							<tr>
								<th>PAR</th>
								<th>HANDCAP</th>
								<th class="black">BLACK</th>
								<th class="blue">BLUE</th>
								<th>WHITE</th>
								<th class="gold">GOLD</th>
								<th class="red">RED</th>
							</tr>
							<tr>
								<td>5</td>
								<td></td>
								<td>640</td>
								<td>618</td>
								<td>595</td>
								<td>562</td>
								<td>529</td>
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
						<li class="hole2">WEST COURSE</li>
					</ul>
			</div>

			<div class="courseImg"><img src="<c:url value='/images/hills/course/west9.png'/>" alt="웨스트 코스 이미지"></div>

			<ul class="courseInfoBox">
				<li class="videoBox">
					<video autoplay="" muted="true" loop="loop" id="bgvid" width="750" height="422">
						<source src="<c:url value='/video/hills/west_9.mp4'/>" type="video/mp4"> 
					</video>
				</li>
				<li class="dataTitle">코스공략/제원</li>
				<li class="holeExplainBox">
					<div class="couseBalloon"><img src="<c:url value='/images/hills/balloon.png'/>" alt=""></div>
					<div class="holeExplain">비교적 짧은 Par 4홀로서 페어웨이 중앙 그린 방향으로 티샷 할 것을 추천 하며,<br>
					 그린 공략시 핀위치에 따라 공략이 많이 달라지는 홀이다. 마지막까지 긴장을 늦출 수 없는 홀이 될 것이다.</div>
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
							<col width="*">
						</colgroup>
						<tbody>
							<tr>
								<th>PAR</th>
								<th>HANDCAP</th>
								<th class="black">BLACK</th>
								<th class="blue">BLUE</th>
								<th>WHITE</th>
								<th class="gold">GOLD</th>
								<th class="red">RED</th>
							</tr>
							<tr>
								<td>4</td>
								<td></td>
								<td>393</td>
								<td>369</td>
								<td>345</td>
								<td>312</td>
								<td>283</td>
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