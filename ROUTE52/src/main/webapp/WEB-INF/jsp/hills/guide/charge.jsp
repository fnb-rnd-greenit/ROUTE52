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

<!-- 
1. 화면 이동 - <a href="<c:url value='/hills/cource/sample.do'/>" class=""></a>
2. 이미지 - <img src="<c:url value='/images/hills/quickIcon01.png'/>">
-->

<div id="wrap">
	<div class="contents">
		<div class="myzoneTabList4">
			<a href="<c:url value='/hills/guide/useGuide.do'/>" class="">이용안내</a>
			<!-- <a href="javascript:alert('준비중입니다.');" class="">예약가이드</a> -->
			<%-- <a href="<c:url value='/hills/guide/reserGuide.do'/>" class="">예약가이드</a> --%>
			<a href="<c:url value='/hills/guide/charge.do'/>" class="on">이용요금</a>
			<a href="<c:url value='/hills/guide/etiquette.do'/>" class="">골프에티켓</a>					
			<a href="<c:url value='/hills/guide/localRule.do'/>" class="">로컬룰</a>
		</div>
		
		<div class="subTitle">
			<span class="title">이용요금</span>
		</div>
		<div class="subLine"></div>
		
		<ul class="useGuideText">
			<li class="commonDot guideTitle"> 주중/주말/공휴일 예약</li>
			<li>
				<table class="chargeTable">
				<caption> 주중/주말/공휴일 예약</caption>
				<colgroup>
					<col width="*">
					<col width="*">
					<col width="*">
					<col width="*">
					<col width="*">
				</colgroup>
				<tbody>
					<tr>
						<th class="title">구분</th>
						<th class="title">월</th>
						<th class="title">화~금</th>
						<th class="title">토요일</th>
						<th class="title">일요일/휴일</th>
					</tr>
					<tr>
						<th>그린피</th>
						<td colspan="4">서원힐스 그린피는 일자별, 시간대별, 코스별, 기후별 등에 따라 실시간 그린피시스템을 운영하고 있습니다.<br> 예약시점, 예약률 등에 따라 최적의 요금으로 운영되오니, 예약페이지에서 실시간 그린피를 확인 부탁드립니다.</td>
					</tr>
					<tr>
						<th>카트사용료</th>
						<td colspan="4">90,000원</td>
					</tr>
					<tr>
						<th>캐디피</th>
						<td colspan="4"><span style="font-size:14px; line-height:30px;">20년 7월 1일부터 130,000 / 팀 (외국어가능 160,000)로 인상 적용됩니다.</span></td>
					</tr>
				</tbody>
			</table> 
			</li>
			<li class="chargeContent">
			<span class="red">
			※ 그린피는 1팀 4인 기준으로 설정된 금액이며, 3인 내장시 4인 팀 요금이 적용됩니다.(5인플레이 불가)<br>
			※ 그린피는 매월, 시간대별 특별할인이 있으니 공지사항 "그린피 안내"를 참고하여 주십시오.<br>
			※ 당일 라운드 중 9홀 추가 시 추가된 해당타임 요금의 50% 적용됩니다.<br>
			※ 인터넷회원 지역주민(고양, 파주, 양주, 의정부) 혜택 15,000원 상당 식사류 제공됩니다.<br>
 			단, 서원힐스 인터넷예약 고객에 한하며, 내장 하루전까지 인터넷회원 가입, 최초 1회 신분증 확인 필수이며 타이벤트(팀확정그린피)와 중복되지 않습니다.</span>		
			<%-- ※ 조인을 원할 시 1팀 예약 후 예약확인 창에서 조인으로 변경 가능하십니다.</span><br>
			&nbsp;&nbsp;&nbsp;- 홈페이지 메뉴에서 ‘예약하기 <img src="<c:url value='/images/hills/r_a.png'/>" alt=""> 서원힐스 <img src="<c:url value='/images/hills/r_a.png'/>" alt=""> 조인예약’ 을 통해서도 신청가능하십니다.<br>
			&nbsp;&nbsp;&nbsp;- 조인신청은 2인만 가능하십니다.<br>
			&nbsp;&nbsp;&nbsp;- 조인예약이 성립되지 않을시 라운드 주중 3일전, 주말 5일전 유선으로 취소통보 됩니다.<br> --%>
			</li>
		</ul>
		<ul class="useGuideText">
			<li class="commonDot guideTitle"> 홀별정산 안내 (임시휴장, 악천후 등)</li>
			<li>
				<table class="chargeTable">
				<caption> 홀별정산 안내</caption>
				<colgroup>
					<col width="*">
					<col width="*">
					<col width="*">
					<col width="*">
				</colgroup>
				<tbody>
					<tr>
						<th class="title">구분</th>
						<th class="title">그린피</th>
						<th class="title">카트료</th>
						<th class="title">캐디피</th>
					</tr>
					<tr>
						<th>1홀티샷</th>
						<td rowspan="3">홀별 정산<br>(개별정산)</td>
						<td rowspan="2">45,000 </td>
						<td>20,000<br>(팀정산)</td>
					</tr>
					<tr>
						<th>1홀~9홀 종료</th>
						<td>70,000<br>(팀정산)</td>
					</tr>
					<tr>
						<th>10홀~18홀</th>
						<td>90,000</td>
						<td><span style="font-size:14px; line-height:22px;">20년 7월01일부터<br>130,000 적용</span></td>
					</tr>
				</tbody>
			</table>
			</li>
			<li class="chargeContent">
			<span class="red">※ 홀별정산 기준 : 시간대별 그린피에서 이용한 홀만큼의 코스 사용료 부과(18홀 그린피 ÷ 18홀)X 라운드홀 수<br>
			※ 본인 과실로 인한 사고 또는 개인사정으로 인한 홀아웃은 홀별정산이 불가 합니다. (18홀 그린피 정상결제)<br>
			※ 조인팀일 경우 악천후로 개인 홀정산 시 그린피만 개별정산 가능하며, 카트료 및 캐디피는 팀요금에서 정산 가능<br>
			※ 악천후 홀정산은 특가타임 및 이벤트, 할인쿠폰 이용시에도 정상적으로 홀정산 가능<br></span>
			</li>
		</ul>
		<ul class="useGuideText">
			<li class="commonDot guideTitle"> 기타요금</li>
			<li>
				<table class="chargeTable">
				<caption>기타요금</caption>
				<colgroup>
					<col width="*">
					<col width="*">
				</colgroup>
				<tbody>
					<tr>
						<th class="title">구분</th>
						<th class="title">금액</th>
					</tr>
					<tr>
						<th>풀셋 대여(18홀)</th>
						<td>30,000</td>
					</tr>
					<tr>
						<th>골프채 단품대여</th>
						<td>10,000</td>
					</tr>
				</tbody>
			</table>
			</li>
		</ul>
		

	</div><!-- contents End -->
</div>

<jsp:include page="../include/footer-quick.jsp" flush="true" />
<jsp:include page="../include/footer.jsp" flush="true" />