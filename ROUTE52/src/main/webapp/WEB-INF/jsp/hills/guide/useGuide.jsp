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
		<img src="<c:url value='/images/hills/ico-home.png'/>" alt="">
		<p>이용안내 &nbsp;&nbsp;&nbsp; ＞ <span>이용안내</span></p>
	</div>
</div>

<div id="wrap">
	<div class="contents">
		<div class="myzoneTabList4">
			<a href="<c:url value='/hills/guide/useGuide.do'/>" class="on">이용안내</a>
			<!-- <a href="javascript:alert('준비중입니다.');" class="">예약가이드</a> -->
			<%-- <a href="<c:url value='/hills/guide/reserGuide.do'/>" class="">예약가이드</a> --%>
			<a href="<c:url value='/hills/guide/charge.do'/>" class="">이용요금</a>
			<a href="<c:url value='/hills/guide/etiquette.do'/>" class="">골프에티켓</a>					
			<a href="<c:url value='/hills/guide/localRule.do'/>" class="">로컬룰</a>
		</div>
		
		<div class="subTitle">
			<span class="title">이용안내</span>
		</div>
		<div class="subLine"></div>

		<div class="reserGrayBox">
			<div class="commonDot guideTitle"> 예약방법: 온라인예약</div>
			<p>· 서원힐스의 라운드 예약을 위해서 반드시 온라인회원에 가입하셔야 합니다. <a class="guideJoin" href="<c:url value='/hills/member/join02.do'/>" target="_blank">회원가입 <img src="<c:url value='/images/hills/red_arrow.png'/>" alt=""></a></p>
		</div>

		<ul class="reserGuideText">
			<li>· 주말 라운드 : 4주전 오전 10:00~1일전 오후 23:59 까지 예약가능(선착순 예약) / 주중 라운드 : 3주전 오전 10:00~1일전 오후 23:59 까지 예약가능(선착순 예약)</li>
			<li>· 당일예약은 잔여타임에 한해 전화로 예약 가능</li>
			<li>· 예약횟수 제한 안내 : 주간 주중 3회 / 주말 월5회</li>
			<li>&nbsp;&nbsp;&nbsp;(예약횟수 초과시 홈페이지 예약은 제한되며, 추가 예약은 담당 부서로 문의 바랍니다.)</li>
			<li>· 예약문의 031) 940 - 9400 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; FAX 031) 957 - 2500</li>
			<li>· 조인문의 : 저희 골프장은 조인을 해드리는 별도의 조인방을 운영하지 않습니다.</li>
			<li>· 27홀 예약 문의 : 별도의 이벤트 진행 시에만 사전예약이 가능합니다.<br>
			 &nbsp;&nbsp;&nbsp;(9홀 추가는 18홀 예약 후 당일 다운드 도중 캐디분께 9홀 추가 가능여부 확인하셔야 합니다.)</li>
		</ul>
		<div class="reserUseGuide">
			<div class="commonDot guideTitle"> 주중/주말/공휴일 예약</div>
			<div class="weekGuide">
				<ul class="guideBox">
					<li class="orange gdTitle">STEP 01</li>
					<li class="gdTxt">회원 가입하기</li>
				</ul>
				<img src="<c:url value='/images/hills/guideArrow.png'/>" alt="" class="guideArrow">
				<ul class="guideBox">
					<li class="orange gdTitle">STEP 02</li>
					<li class="gdTxt">로그인</li>
				</ul>
				<img src="<c:url value='/images/hills/guideArrow.png'/>" alt="" class="guideArrow">
				<ul class="guideBox">
					<li class="orange gdTitle">STEP 03</li>
					<li class="gdTxt">실시간 예약</li>
				</ul>
				<img src="<c:url value='/images/hills/guideArrow.png'/>" alt="" class="guideArrow">
				<ul class="guideBox">
					<li class="orange gdTitle">STEP 04</li>
					<li class="gdTxt">예약타임 확정</li>
				</ul>
			</div>
			<div class="useGuideDetail">
				<ul>
				<li class="guideEmpty">&nbsp;</li>
				<li class="guideDetail">주말라운드 4주전/주중라운드 3주전 오전 10:00~ 1일전 오후 23:59 까지 선착순예약 가능</li>
				<li class="guideDetail text1">예약 완료시 <br>예약확정문자 발송</li>
				</ul>
			</div>
		</div>

		<div class="reserUseGuide">
			<div class="commonDot guideTitle"> 대기예약</div>
			<div class="weekGuide">
				<ul class="guideBox">
					<li class="orange gdTitle">STEP 01</li>
					<li class="gdTxt">회원 가입하기</li>
				</ul>
				<img src="<c:url value='/images/hills/guideArrow.png'/>" alt="" class="guideArrow">
				<ul class="guideBox">
					<li class="orange gdTitle">STEP 02</li>
					<li class="gdTxt">로그인</li>
				</ul>
				<img src="<c:url value='/images/hills/guideArrow.png'/>" alt="" class="guideArrow">
				<ul class="guideBox">
					<li class="orange gdTitle">STEP 03</li>
					<li class="gdTxt">대기예약신청</li>
				</ul>
				<img src="<c:url value='/images/hills/guideArrow.png'/>" alt="" class="guideArrow">
				<ul class="guideBox">
					<li class="orange gdTitle">STEP 04</li>
					<li class="gdTxt">예약당첨</li>
				</ul>
				<img src="<c:url value='/images/hills/guideArrow.png'/>" alt="" class="guideArrow">
				<ul class="guideBox">
					<li class="orange gdTitle">STEP 05</li>
					<li class="gdTxt">예약 통보</li>
				</ul>
			</div>
			<div class="useGuideDetail">
				<ul>
				<li class="guideEmpty">&nbsp;</li>
				<li class="guideDetail text5">대기 예약은 위약기간<br>(라운딩 3일전 17시 이후 -라운딩 하루전)에 해당되는 취소건에 대해 선착순으로 배정</li>
				<li class="guideDetail text2">신청한 날짜 시간대<br> 취소분 발생시<br> 즉시 당첨 (선착순 배정)</li>
				<li class="guideDetail text3">당첨 확인 후<br> 즉시 예약완료<br> 문자발송</li>
				</ul>
			</div>
		</div>

		<div class="reserUseGuide">
			<div class="commonDot guideTitle"> 로얄타임 패키지 예약</div>
			<div class="weekGuide">
				<ul class="guideBox2">
					<li class="orange gdTitle">STEP 01</li>
					<li class="gdTxt">예약신청</li>
				</ul>
				<img src="<c:url value='/images/hills/guideArrow.png'/>" alt="" class="guideArrow2">
				<ul class="guideBox2">
					<li class="orange gdTitle">STEP 02</li>
					<li class="gdTxt">예약안내<br>문자전달</li>
				</ul>
				<img src="<c:url value='/images/hills/guideArrow.png'/>" alt="" class="guideArrow2">
				<ul class="guideBox2">
					<li class="orange gdTitle">STEP 03</li>
					<li class="gdTxt">예약확정<br>대기</li>
				</ul>
				<img src="<c:url value='/images/hills/guideArrow.png'/>" alt="" class="guideArrow2">
				<ul class="guideBox2">
					<li class="orange gdTitle">STEP 04</li>
					<li class="gdTxt">예약금 <br>예치 완료</li>
				</ul>
				<img src="<c:url value='/images/hills/guideArrow.png'/>" alt="" class="guideArrow2">
				<ul class="guideBox2">
					<li class="orange gdTitle">STEP 05</li>
					<li class="gdTxt">예약<br>최종 확정</li>
				</ul>
				<img src="<c:url value='/images/hills/guideArrow.png'/>" alt="" class="guideArrow2">
				<ul class="guideBox2">
					<li class="orange gdTitle">STEP 06</li>
					<li class="gdTxt">라운드<br>이용</li>
				</ul>
			</div>
			<ul class="reserGuideText">
				<li>· 로얄타임 패키지 우선 예약은 해당일로부터 4~6주 전 타임이 우선적으로 오픈됩니다.</li>
				<li>· 로얄타임 패키지 우선 예약은 식사비가 포함된 패키지 상품으로 선 오픈된 이후 상황에 따라 0~3주 전 일반 타임 예약으로 전환됩니다.</li>
				<li>· 로얄타임 패키지 우선 예약은 신청 접수 후 총 금액의 10% 예약금을 예치하셔야만 예약이 확정됩니다.</li>
				<li>· 로얄타임 패키지 우선 예약은 예약 확정 이후에는 예약 타임 변경 및 이동이 불가합니다.</li>
				<li>· 예약 확정 이후 라운드 9~4일 전 취소 시 예약금의 50% 환불, 라운드 3~0일 전 취소 시 예약금 소멸(환불X)됩니다.</li>
					
			</ul>
		</div>

		<ul class="useGuideText">
			<li class="commonDot guideTitle"> 주중/주말/공휴일 예약</li>
			<li class="midTitle orange bold"> 01 예약 확인</li>
			<li class="guideContent">· 인터넷 예약은 일 1회 예약 가능합니다. (추가예약은 전화 문의 바랍니다.) <br>
			· 예약 고객은 반드시 본인이 내장하여야 하며, 신분증을 제시하여야 합니다.<br>
			· 대기예약 및 조인예약 배정 시 별도의 문자 메시지가 발송됩니다.<br>
			&nbsp;&nbsp;<span class="red">※ 고객님의 휴대폰 전원이 꺼져있거나 통신사의 장애로 발송되지 않을 수 있으니 반드시 홈페이지에서 확인하여 주시기 바랍니다.</span></li>
			<li class="midTitle orange bold">&lt;예약횟수 및 취소횟수 제한 안내&gt;</li>
			<li class="guideContent">· 예약 및 취소 : 주중 주간 3회 or 주말 월간 5회 제한 <br>
			· 예약횟수 초과 시 추가예약은 예약실로 문의(031-940-9400, 2번)<br>
			· 취소 횟수 해당 시 1개월 예약 정지 위약적용
			</li>	
			<li class="midTitle orange bold">02 예약취소 및 예약변경 위약 규정</li>
			<li class="guideContent">· 주중 라운딩 5일전 17:00까지 인터넷으로 취소가능하며, 예약취소 기한 이후의 취소는 전화로만 가능합니다.<br>
			· 주말/공휴일 라운딩 7일전 17:00까지 인터넷으로 취소가능하며, 예약취소 기한 이후의 취소는 전화로만 가능합니다.<br>
			· 예약취소 기한 이후 취소 또는 예약변경시 위약규정에 의해 페널티를 적용합니다.<br>
			· 라운드 시간에 임박하여(티업시간 2시간 이내)취소할 경우 당일미내장(No-Show)페널티를 적용합니다.<br>
			· 위약기간 내 예약변경은 기존타임을 취소하고 다른타임으로 재예약이 들어가기 때문에 페널티가 적용됩니다.<br>
			· 예약자명 변경관련 규정: 주중 주 1회/주말 월 2회 까지만 변경 가능하며, 초과 시 기존예약자 1개월 예약정지 페널티가 적용됩니다.
			</li>			
			<li class="midTitle orange bold">03 악천후(눈,비,낙뢰,태풍) 취소</li>
			<li class="guideContent">· 위약기간에 악천후 예보에 의한 취소는 페널티가 적용됩니다.<br>
			- 당일까지 기상예보가 수시로 바뀔 수 있어서 위약기간 취소 시 페널티 적용됩니다.<br>
			· 당일 악천후취소 요청시 현장 기상상황에 따라 페널티부여 여부가 달라질수 있습니다.<br>
			- 당일 1부 첫 티오프 2시간 전부터 전화문의 가능<br>
			- 고객님의 자택에서 출발하시기 전 현장상황 확인전화 요청<br>
			· 자세한 문의는 031-940-9400, 2번으로 연락주시기 바랍니다. </li>
		</ul> 
		<ul class="useGuideText">
			<li class="commonDot guideTitle"> 예약 위약 시 페널티 규정안내</li>
			<li>
				<div class="reserBreck">
					<div class="berckTitle" style="height:550px; line-height: 550px;">위약기준</div>
					<ul class="breckInfo">
						<li class="title">해당사항</li>
						<li>예약자 미내장</li>
						<li>예약자명 변경 횟수 초과<br>(주중 주 1회, 주말 월 2회)</li>
						<li>6~7일전 취소 및 예약변경</li>
						<li>4~5일전 취소 및 예약변경</li>
						<li>2~3일전 취소 및 예약변경</li>
						<li>1일전 취소 및 예약변경</li>
						<li>당일취소</li>
						<li class="twoLine">당일 미내장<br>(No-Show)</li>
						<li class="twoLine">TEE-OFF 시간 미준수<br>(20분 이상 지연도착)</li>
					</ul>
					<ul class="breckInfo">
						<li class="title">적용 페널티</li>
						<li>1개월 예약정지</li>
						<li>1개월 예약정지</li>
						<li>1개월 예약정지</li>
						<li>2개월 예약정지</li>
						<li>3개월 예약정지</li>
						<li>6개월 예약정지</li>
						<li>12개월 예약정지</li>
						<li>예약 및 내장불가</li>
						<li class="twoLine">라운드 불가 및 1개월 예약 정지<br>(홀 패스시 라운드 가능)</li>
					</ul>
					<ul class="breckInfo">
						<li class="title">페널티 구제방법</li>
						<li>-</li>
						<li>-</li>
						<li>-</li>
						<li>1인 그린피 대체</li>
						<li>1인 그린피 대체</li>
						<li>2인 그린피 대체</li>
						<li>3인 그린피 대체</li>
						<li>4인 그린피 대체</li>
						<li class="twoLine">라운드 불가 및 1개월 예약 정지<br>(홀 패스시 라운드 가능)</li>
					</ul>
					<ul class="breckInfo">
						<li class="title" style="border-right:0;">비 고</li>
						<li class="lastInfo" style="height:495px; padding:185px 0;">
							위약 그린피 결제는 <br>
							해당 예약 시간대<br>
							금액으로 대체<br>
							<span class="orange">당일취소 및 미내장시 <br>
							보유한 모든 쿠폰은</span><br>
							사용정지 됩니다.
						</li>
					</ul>
				</div>
			</li>
			<li class="guideContent"><span class="red">※ 예외규정(예약자가 다음 사항에 해당시 증빙을 당 클럽에 제출한 후 위약을 해지 할 수 있습니다)</span><br>
			1) 직계존속의 상을 당했을 경우 - 부고장, 사망진단서 등<br>
			2) 본인 및 직계존비속의 사고 또는 갑작스런 병변의 악화시 - 진단서, 진료확인서, 입원확인서, 보험회사 사고증명서 등<br>
			&nbsp;&nbsp;&nbsp;&nbsp;<span class="gray">( 위증빙서류로 페널티 해지 가능 횟수는 연2회에 한함 )</span></li>
		</ul>
		<ul class="useGuideText">
			<li class="commonDot guideTitle"> 라운드 준수사항 및 페널티 규정안내 </li>
			<li>
				<table class="chargeTable leftText">
					<caption>위약자 벌칙규정</caption>
					<colgroup>
						<col width="65%">
						<col width="35%">
					</colgroup>
					<tbody>
						<tr>
							<th class="title">위약구분</th>
							<th class="title">위약관리</th>
						</tr>
						<tr>
							<td>예약 시간보다 늦게 도착한 경우 (상습적)</td>
							<td class="center">상황별 홀 JUMP/라운드불가</td>
						</tr>
						<tr>
							<td>고의적인 경기진행 지연</td>
							<td rowspan="5" class="center">2회 경고후 퇴장조치</td>
						</tr>
						<tr>
							<td>상습적인 도박행위</td>
						</tr>
						<tr>
							<td>캐디농락(희롱), 과도한 음담패설, 욕설</td>
						</tr>
						<tr>
							<td>경기능력이 현저히 부족하여 다른 이용자에게 방해가 되는경우</td>
						</tr>
						<tr>
							<td>금연 지역 내에서의 흡연</td>
						</tr>
						<tr>
							<td>고의로 그린 훼손시</td>
							<td rowspan="2" class="center">변상조치및 퇴장</td>
						</tr>
						<tr>
							<td>기물파손</td>
						</tr>
						<tr>
							<td>기타 클럽의 품위를 손상시키는 행위</td>
							<td rowspan="3" class="center">사안별 예약제한</td>
						</tr>
						<tr>
							<td>음주, 방뇨, 고성방가</td>
						</tr>
						<tr>
							<td>지정티마크이외 임의티 사용자</td>
						</tr>
						<tr>
							<td>복장불량자</td>
							<td class="center">복장 교환 후 라운드</td>
						</tr>
						<tr>
							<td>상호 협의되지 않은 영상 촬영 행위(개인 유튜브 촬영 등)</td>
							<td class="center">2회 경고 후 퇴장조치 및 영구 예약·내장정지</td>
						</tr>
					</tbody>
				</table>
			</li>
		</ul>
		<ul class="useGuideText">
			<li class="guideContent">
				<h3 class="commonDot guideTitle"> 사전 동의되지 않은 코스 내 영상촬영 제한안내 </h3>
			- 경기 플레이 진행 시 사전 상호 협의되지 않은 영상물 촬영 시에는 관련법에 따라 처벌 받으실 수 있습니다.<br>
- 사전 협의되지 않은 개인 유튜브 등의 영상 촬영 및 업로드는 코스 저작권, 타인의 초상권 등에 관하여 위반되므로 해당 내용에 관한 규정사항을 준수 해주시길 당부 드립니다.<br>
- 사전 협의되지 않은 영상물 촬영 시 현장 경고 누적에 따라 해당 클럽에서 즉시 퇴장조치 되실 수 있습니다.(퇴장 조치 시점으로부터 영구 예약 및 내장 정지)
			</li>			
		</ul>
	</div><!-- contents End -->
</div>

<jsp:include page="../include/footer-quick.jsp" flush="true" />
<jsp:include page="../include/footer.jsp" flush="true" />