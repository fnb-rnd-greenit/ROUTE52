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
	
	$(document).ready(function() { 
	    var offset = $(".myzoneTabList3").offset();
	    $('html, body').animate({scrollTop : offset.top}, 400);
	});
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
			<a href="<c:url value='/hills/course/course_east.do'/>" class="on">이스트코스</a>
			<a href="<c:url value='/hills/course/course_west.do'/>" class="">웨스트코스</a>
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
						<li class="hole2">EAST COURSE</li>
					</ul>
			</div>

			<div class="courseImg"><img src="<c:url value='/images/hills/course/east1.png'/>" alt="이스트 코스 이미지"></div>

			<ul class="courseInfoBox">
				<li class="videoBox">
					<video autoplay="" muted="true" loop="loop" id="bgvid" width="750" height="422">
						<source src="<c:url value='/video/hills/east_1.mp4'/>" type="video/mp4"> 
					</video>
				</li>
				<li class="dataTitle">코스공략/제원</li>
				<li class="holeExplainBox">
					<div class="couseBalloon"><img src="<c:url value='/images/hills/balloon.png'/>" alt=""></div>
					<div class="holeExplain">좌측에 기존 수림대가 홀끝까지 펼쳐져 있고 티 우측을 연못이 감싸고 있는 오르막 홀로 10m의 고저차가 있다. <br> 
					그린 뒤편에 소나무 병풍과 그늘의 아름다움이 한결 정교한 샷을 도와준다.</div>
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
								<td>4</td>
								<td>397</td>
								<td>372</td>
								<td>347</td>
								<td>318</td>
								<td>318</td>
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
						<li class="hole2">EAST COURSE</li>
					</ul>
			</div>

			<div class="courseImg"><img src="<c:url value='/images/hills/course/east2.png'/>" alt="이스트 코스 이미지"></div>

			<ul class="courseInfoBox">
				<li class="videoBox">
					<video autoplay="" muted="true" loop="loop" id="bgvid" width="750" height="422">
						<source src="<c:url value='/video/hills/east_2.mp4'/>" type="video/mp4"> 
					</video>
				</li>
				<li class="dataTitle">코스공략/제원</li>
				<li class="holeExplainBox">
					<div class="couseBalloon"><img src="<c:url value='/images/hills/balloon.png'/>" alt=""></div>
					<div class="holeExplain">왼쪽 산자락의 화려한 관목과 그린 오른쪽의 연못이 한 눈에 내려다보이는 파3홀로 여유롭게<br>
                    플레이 가능하다.</div>
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
								<td>6</td>
								<td>185</td>
								<td>160</td>
								<td>132</td>
								<td>132</td>
								<td>132</td>
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
						<li class="hole2">EAST COURSE</li>
					</ul>
			</div>

			<div class="courseImg"><img src="<c:url value='/images/hills/course/east3.png'/>" alt="이스트 코스 이미지"></div>

			<ul class="courseInfoBox">
				<li class="videoBox">
					<video autoplay="" muted="true" loop="loop" id="bgvid" width="750" height="422">
						<source src="<c:url value='/video/hills/east_3.mp4'/>" type="video/mp4"> 
					</video>
				</li>
				<li class="dataTitle">코스공략/제원</li>
				<li class="holeExplainBox">
					<div class="couseBalloon"><img src="<c:url value='/images/hills/balloon.png'/>" alt=""></div>
					<div class="holeExplain">파4홀로 14m의 고저차가 있다. 자연수림대가 홀 끝까지 감싸고 그린 우측까지 드리워져있다.<br>
					침목 계단 좌측에 철쭉 만발할 때는 황홀감에 빠져 8번 티로 그냥 빨려 올라간다.</div>
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
								<td>9</td>
								<td>362</td>
								<td>333</td>
								<td>317</td>
								<td>290</td>
								<td>290</td>
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
						<li class="hole2">EAST COURSE</li>
					</ul>
			</div>

			<div class="courseImg"><img src="<c:url value='/images/hills/course/east4.png'/>" alt="이스트 코스 이미지"></div>

			<ul class="courseInfoBox">
				<li class="videoBox">
					<video autoplay="" muted="true" loop="loop" id="bgvid" width="750" height="422">
						<source src="<c:url value='/video/hills/east_4.mp4'/>" type="video/mp4"> 
					</video>
				</li>
				<li class="dataTitle">코스공략/제원</li>
				<li class="holeExplainBox">
					<div class="couseBalloon"><img src="<c:url value='/images/hills/balloon.png'/>" alt=""></div>
					<div class="holeExplain">가장 높고 내리막이 심하며 우측으로 굽은 도그렉홀로 연못과 벙커가 심리적으로 부담이 있는 홀이다. <br>
					티 우측에 아름드리 잣나무가 수려한 경관을 더욱 돋보이게한다.</div>
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
								<td>7</td>
								<td>417</td>
								<td>391</td>
								<td>362</td>
								<td>323</td>
								<td>323</td>
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
						<li class="hole2">EAST COURSE</li>
					</ul>
			</div>

			<div class="courseImg"><img src="<c:url value='/images/hills/course/east5.png'/>" alt="이스트 코스 이미지"></div>

			<ul class="courseInfoBox">
				<li class="videoBox">
					<video autoplay="" muted="true" loop="loop" id="bgvid" width="750" height="422">
						<source src="<c:url value='/video/hills/east_5.mp4'/>" type="video/mp4"> 
					</video>
				</li>
				<li class="dataTitle">코스공략/제원</li>
				<li class="holeExplainBox">
					<div class="couseBalloon"><img src="<c:url value='/images/hills/balloon.png'/>" alt=""></div>
					<div class="holeExplain">약간 우측으로 굽은 도그렉홀이며 완만하여 길게 펼쳐져 있어 장타를 날리고 싶어진다.벙커 5개가 페어웨이<br> 
					우측과 그린 앞에 도사리고 있어 위협적으로 보이지만 중앙을 향해 샷을 하면 무난하게 그린을 공략 할 수 있다.</div>
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
								<td>1</td>
								<td>593</td>
								<td>572</td>
								<td>533</td>
								<td>485</td>
								<td>485</td>
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
						<li class="hole2">EAST COURSE</li>
					</ul>
			</div>

			<div class="courseImg"><img src="<c:url value='/images/hills/course/east6.png'/>" alt="이스트 코스 이미지"></div>

			<ul class="courseInfoBox">
				<li class="videoBox">
					<video autoplay="" muted="true" loop="loop" id="bgvid" width="750" height="422">
						<source src="<c:url value='/video/hills/east_6.mp4'/>" type="video/mp4"> 
					</video>
				</li>
				<li class="dataTitle">코스공략/제원</li>
				<li class="holeExplainBox">
					<div class="couseBalloon"><img src="<c:url value='/images/hills/balloon.png'/>" alt=""></div>
					<div class="holeExplain">부담감 없는 오르막 홀로 구성되어 있고, 오른쪽 절개지 사면의 경사를 완만하게 조성하여<br>
					Play 지역으로 활용함으로서 부담감을 덜어준다.</div>
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
								<td>5</td>
								<td>410</td>
								<td>389</td>
								<td>354</td>
								<td>310</td>
								<td>310</td>
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
						<li class="hole2">EAST COURSE</li>
					</ul>
			</div>

			<div class="courseImg"><img src="<c:url value='/images/hills/course/east7.png'/>" alt="이스트 코스 이미지"></div>

			<ul class="courseInfoBox">
				<li class="videoBox">
					<video autoplay="" muted="true" loop="loop" id="bgvid" width="750" height="422">
						<source src="<c:url value='/video/hills/east_7.mp4'/>" type="video/mp4"> 
					</video>
				</li>
				<li class="dataTitle">코스공략/제원</li>
				<li class="holeExplainBox">
					<div class="couseBalloon"><img src="<c:url value='/images/hills/balloon.png'/>" alt=""></div>
					<div class="holeExplain">파4홀로서 연못과 어우러져 경관이 수려한 홀이다. 페어웨이의 폭이 60m이상으로 넓게 조성되어 있어서<br>
					호쾌하게 티샷을 할 수 있고 세컨샷에서 그린 뒤로 조망되는 자연수림대와 살구 나무 군락이 한눈을 팔게한다.</div>
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
								<td>8</td>
								<td>375</td>
								<td>347</td>
								<td>313</td>
								<td>281</td>
								<td>281</td>
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
						<li class="hole2">EAST COURSE</li>
					</ul>
			</div>

			<div class="courseImg"><img src="<c:url value='/images/hills/course/east8.png'/>" alt="이스트 코스 이미지"></div>

			<ul class="courseInfoBox">
				<li class="videoBox">
					<video autoplay="" muted="true" loop="loop" id="bgvid" width="750" height="422">
						<source src="<c:url value='/video/hills/east_8.mp4'/>" type="video/mp4"> 
					</video>
				</li>
				<li class="dataTitle">코스공략/제원</li>
				<li class="holeExplainBox">
					<div class="couseBalloon"><img src="<c:url value='/images/hills/balloon.png'/>" alt=""></div>
					<div class="holeExplain">우측에 산벛꽃이 둘러져있어 봄철엔 아름다움에 한눈을 팔게하고 그린을 감싸안은 철쭉과 적송들이<br>
					아름다움을 더해준다. 내리막 홀로 10m의 고지차가 있고 거리측정은 캐디의 도움을 받는 편이좋다. </div>
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
								<td>2</td>
								<td>212</td>
								<td>189</td>
								<td>158</td>
								<td>123</td>
								<td>123</td>
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
						<li class="hole2">EAST COURSE</li>
					</ul>
			</div>

			<div class="courseImg"><img src="<c:url value='/images/hills/course/east9.png'/>" alt="이스트 코스 이미지"></div>

			<ul class="courseInfoBox">
				<li class="videoBox">
					<video autoplay="" muted="true" loop="loop" id="bgvid" width="750" height="422">
						<source src="<c:url value='/video/hills/east_9.mp4'/>" type="video/mp4"> 
					</video>
				</li>
				<li class="dataTitle">코스공략/제원</li>
				<li class="holeExplainBox">
					<div class="couseBalloon"><img src="<c:url value='/images/hills/balloon.png'/>" alt=""></div>
					<div class="holeExplain">넓은 페어웨이와 내리막 경사의 홀로 편안한 티샷을 할 수 있으며 세컨샷은 좌측 IP 지점과<br>
					벙커와 그린우측 연못을 피하는 까다로움이 있어 정확한 거리와 방향성이 요구된다.</div>
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
								<td>3</td>
								<td>572</td>
								<td>542</td>
								<td>508</td>
								<td>474</td>
								<td>474</td>
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