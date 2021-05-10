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
			<a href="<c:url value='/hills/course/course_west.do'/>" class="">웨스트코스</a>
			<a href="<c:url value='/hills/course/course_south.do'/>" class="on">사우스코스</a> 
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
						<li class="hole2">SOUTH COURSE</li>
					</ul>
			</div>

			<div class="courseImg"><img src="<c:url value='/images/hills/course/south1.png'/>" alt="사우스 코스 이미지"></div>

			<ul class="courseInfoBox">
				<li class="videoBox">
					<video autoplay="" muted="true" loop="loop" id="bgvid" width="750" height="422">
						<source src="<c:url value='/video/hills/south_1.mp4'/>" type="video/mp4"> 
					</video>
				</li>
				<li class="dataTitle">코스공략/제원</li>
				<li class="holeExplainBox">
					<div class="couseBalloon"><img src="<c:url value='/images/hills/balloon.png'/>" alt=""></div>
					<div class="holeExplain">티샷은 좌측벙커 우측끝을 보고 하면 좋겠다. 자칫하면 우측 OB가 발생 할 수도 있기 때문에<br>
					유의 하여야 할 것이다. 그린 공략시 우측 벙커만 유의 한다면 좋은 결과를 얻을 수 있을 것이다.</div>
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
								<td>442</td>
								<td>416</td>
								<td>391</td>
								<td>313</td>
								<td>313</td>
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
						<li class="hole2">SOUTH COURSE</li>
					</ul>
			</div>

			<div class="courseImg"><img src="<c:url value='/images/hills/course/south2.png'/>" alt="사우스 코스 이미지"></div>

			<ul class="courseInfoBox">
				<li class="videoBox">
					<video autoplay="" muted="true" loop="loop" id="bgvid" width="750" height="422">
						<source src="<c:url value='/video/hills/south_2.mp4'/>" type="video/mp4">
					</video>
				</li>
				<li class="dataTitle">코스공략/제원</li>
				<li class="holeExplainBox">
					<div class="couseBalloon"><img src="<c:url value='/images/hills/balloon.png'/>" alt=""></div>
					<div class="holeExplain">서원힐스 두번째로 긴 코스이므로 충분한 준비 운동을 한 후 티샷 하는게 좋을 것이다.<br>
					앞쪽 벙커 우측 끝을 보고 공략을 한다면 IP 지점까지 무난히 안착 할 것이다.<br> 
					세컨 샷은 그린 앞벙커를 유의 해서 공략해야 한다. 벙커를 넘기기 위해서는<br>
					우드사용이 자신이 없다면 아이언을 사용 하는게 그린 공략시 좋을 듯 하다.</div>
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
								<td>594</td>
								<td>561</td>
								<td>519</td>
								<td>473</td>
								<td>473</td>
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
						<li class="hole2">SOUTH COURSE</li>
					</ul>
			</div>

			<div class="courseImg"><img src="<c:url value='/images/hills/course/south3.png'/>" alt="사우스 코스 이미지"></div>

			<ul class="courseInfoBox">
				<li class="videoBox">
					<video autoplay="" muted="true" loop="loop" id="bgvid" width="750" height="422">
						<source src="<c:url value='/video/hills/south_3.mp4'/>" type="video/mp4">
					</video>
				</li>
				<li class="dataTitle">코스공략/제원</li>
				<li class="holeExplainBox">
					<div class="couseBalloon"><img src="<c:url value='/images/hills/balloon.png'/>" alt=""></div>
					<div class="holeExplain">우측 벙커만 유의 한다면 무난한 티샷이 될 것이다.<br>
					그린 주위 벙커가 부담을 주지만 그린 중심 공략만 잘 한다면 좋은 결과를 얻을 수 있을것이다.</div>
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
								<td>426</td>
								<td>397</td>
								<td>365</td>
								<td>327</td>
								<td>291</td>
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
						<li class="hole2">SOUTH COURSE</li>
					</ul>
			</div>

			<div class="courseImg"><img src="<c:url value='/images/hills/course/south4.png'/>" alt="사우스 코스 이미지"></div>

			<ul class="courseInfoBox">
				<li class="videoBox">
					<video autoplay="" muted="true" loop="loop" id="bgvid" width="750" height="422">
						<source src="<c:url value='/video/hills/south_4.mp4'/>" type="video/mp4">
					</video>
				</li>
				<li class="dataTitle">코스공략/제원</li>
				<li class="holeExplainBox">
					<div class="couseBalloon"><img src="<c:url value='/images/hills/balloon.png'/>" alt=""></div>
					<div class="holeExplain">그린 앞 벙커 방향으로 티샷 한다면 무난하게 IP 지점까지 도달 할 것이다.<br>
					페어웨이 좌측으로 공간이 넓기 때문에 편안하게 티샷을 한다면 좋은 스코어를 얻을 수 있을것이다.</div>
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
								<td>394</td>
								<td>370</td>
								<td>316</td>
								<td>264</td>
								<td>264</td>
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
						<li class="hole2">SOUTH COURSE</li>
					</ul>
			</div>

			<div class="courseImg"><img src="<c:url value='/images/hills/course/south5.png'/>" alt="사우스 코스 이미지"></div>

			<ul class="courseInfoBox">
				<li class="videoBox">
					<video autoplay="" muted="true" loop="loop" id="bgvid" width="750" height="422">
						<source src="<c:url value='/video/hills/south_5.mp4'/>" type="video/mp4">
					</video>
				</li>
				<li class="dataTitle">코스공략/제원</li>
				<li class="holeExplainBox">
					<div class="couseBalloon"><img src="<c:url value='/images/hills/balloon.png'/>" alt=""></div>
					<div class="holeExplain">기념 사진을 찍기에 손색이 없는 홀이다. 그린에 원온 하여야 좋은 스코어를 얻을 수 있을 것이다.<br>
					그린이 크다는 것을 항상 머리속에 생각한다면 공략이 편할 것이다.</div>
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
								<td>215</td>
								<td>196</td>
								<td>164</td>
								<td>136</td>
								<td>136</td>
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
						<li class="hole2">SOUTH COURSE</li>
					</ul>
			</div>

			<div class="courseImg"><img src="<c:url value='/images/hills/course/south6.png'/>" alt="사우스 코스 이미지"></div>

			<ul class="courseInfoBox">
				<li class="videoBox">
					<video autoplay="" muted="true" loop="loop" id="bgvid" width="750" height="422">
						<source src="<c:url value='/video/hills/south_6.mp4'/>" type="video/mp4">
					</video>
				</li>
				<li class="dataTitle">코스공략/제원</li>
				<li class="holeExplainBox">
					<div class="couseBalloon"><img src="<c:url value='/images/hills/balloon.png'/>" alt=""></div>
					<div class="holeExplain">Par5 홀이지만 장타자들은 투온도 노려 볼만한 홀이다.<br>
					우측 O.B와 그린 주변의 언듈레이션만 조심 한다면 좋은 스코어를 얻을 수 있을 것이다.</div>
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
								<td>554</td>
								<td>518</td>
								<td>480</td>
								<td>437</td>
								<td>437</td>
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
						<li class="hole2">SOUTH COURSE</li>
					</ul>
			</div>

			<div class="courseImg"><img src="<c:url value='/images/hills/course/south7.png'/>" alt="사우스 코스 이미지"></div>

			<ul class="courseInfoBox">
				<li class="videoBox">
					<video autoplay="" muted="true" loop="loop" id="bgvid" width="750" height="422">
						<source src="<c:url value='/video/hills/south_7.mp4'/>" type="video/mp4">
					</video>
				</li>
				<li class="dataTitle">코스공략/제원</li>
				<li class="holeExplainBox">
					<div class="couseBalloon"><img src="<c:url value='/images/hills/balloon.png'/>" alt=""></div>
					<div class="holeExplain">티잉 그라운드에서 내려다 보는 그린까지의 경치가 상당히 예쁠 것이다.<br>
					핀 뒤쪽 보다는 앞쪽 공략을 조금은 짧은 듯하게 공략하는게 좋은 결과를 얻을 수 있을 것이다.</div>
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
								<td>191</td>
								<td>171</td>
								<td>137</td>
								<td>97</td>
								<td>97</td>
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
						<li class="hole2">SOUTH COURSE</li>
					</ul>
			</div>

			<div class="courseImg"><img src="<c:url value='/images/hills/course/south8.png'/>" alt="사우스 코스 이미지"></div>

			<ul class="courseInfoBox">
				<li class="videoBox">
					<video autoplay="" muted="true" loop="loop" id="bgvid" width="750" height="422">
						<source src="<c:url value='/video/hills/south_8.mp4'/>" type="video/mp4">
					</video>
				</li>
				<li class="dataTitle">코스공략/제원</li>
				<li class="holeExplainBox">
					<div class="couseBalloon"><img src="<c:url value='/images/hills/balloon.png'/>" alt=""></div>
					<div class="holeExplain">사우스코스의 대표적인 홀이다. 우측의 워터 해저드는 플레이어의 심장박동수를 높일 것이다.<br>
					긴장을 가라 앉히고 전략적으로 플레이해야 실수가 없을 것이다. 좌측 벙커 우측 끝을 보며 티샷을 한다면<br>
					실수를 줄일 수 있을 것이다. 장타자의 경우 작은 벙커를 바로 넘겨도 유리 할 것이다.</div>
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
								<td>450</td>
								<td>422</td>
								<td>396</td>
								<td>356</td>
								<td>356</td>
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
						<li class="hole2">SOUTH COURSE</li>
					</ul>
			</div>

			<div class="courseImg"><img src="<c:url value='/images/hills/course/south9.png'/>" alt="사우스 코스 이미지"></div>

			<ul class="courseInfoBox">
				<li class="videoBox">
					<video autoplay="" muted="true" loop="loop" id="bgvid" width="750" height="422">
						<source src="<c:url value='/video/hills/south_9.mp4'/>" type="video/mp4">
					</video>
				</li>
				<li class="dataTitle">코스공략/제원</li>
				<li class="holeExplainBox">
					<div class="couseBalloon"><img src="<c:url value='/images/hills/balloon.png'/>" alt=""></div>
					<div class="holeExplain">우측 벙커의 좌측 끝을 보며 공략하는게 좋을듯하다.<br>
					많이 어렵지 않은 그린이므로 마무리만 잘한다면 최종 스코어를 좋게 얻을 수 있을 것이다.</div>
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
								<td>416</td>
								<td>388</td>
								<td>345</td>
								<td>303</td>
								<td>303</td>
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